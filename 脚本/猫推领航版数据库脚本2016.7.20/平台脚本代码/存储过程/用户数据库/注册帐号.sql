
----------------------------------------------------------------------------------------------------

USE QPAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_RegisterAccounts]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_RegisterAccounts]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_RegisterAccounts]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_RegisterAccounts]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 帐号注册
CREATE PROC [dbo].[GSP_GP_RegisterAccounts]
	@strAccounts NVARCHAR(31),					-- 用户帐号
	@strNickName NVARCHAR(31),					-- 用户昵称
	@strSpreader NVARCHAR(31),					-- 推荐帐号
	@strLogonPass NCHAR(32),					-- 登录密码
	@strInsurePass NCHAR(32),					-- 银行密码
	@wFaceID SMALLINT,							-- 头像标识
	@cbGender TINYINT,							-- 用户性别
	@strPassPortID NVARCHAR(18),				-- 身份证号
	@strCompellation NVARCHAR(16),				-- 真实名字
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NCHAR(32),					-- 机器标识
	@strQQ				NVARCHAR(16),				-- QQ号码
	@strMobileNum NCHAR(32),					-- 手机号码
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @Gender TINYINT
DECLARE @FaceID SMALLINT
DECLARE @CustomID INT
DECLARE @MoorMachine TINYINT
DECLARE @Accounts NVARCHAR(31)
DECLARE @NickName NVARCHAR(31)
DECLARE @DynamicPass NCHAR(32)
DECLARE @UnderWrite NVARCHAR(63)

-- 积分变量
DECLARE @Score BIGINT
DECLARE @Insure BIGINT
DECLARE @Beans decimal(18, 2)

-- 附加信息
DECLARE @GameID INT
DECLARE @UserMedal BIGINT
DECLARE @Experience INT
DECLARE @LoveLiness INT
DECLARE @SpreaderID INT
DECLARE @MemberOrder SMALLINT
DECLARE @MemberOverDate DATETIME

-- 辅助变量
DECLARE @EnjoinLogon AS INT
DECLARE @EnjoinRegister AS INT

DECLARE @AgencyID INT

-- 执行逻辑
BEGIN
	-- 注册暂停
	SELECT @EnjoinRegister=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinRegister'
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinRegister'
		RETURN 1
	END

	-- 登录暂停
	SELECT @EnjoinLogon=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
		RETURN 2
	END

	-- 效验名字
	IF EXISTS (SELECT [String] FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strAccounts)>0 AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL))
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，您所输入的登录帐号名含有限制字符串，请更换帐号名后再次申请帐号！'
		RETURN 4
	END

	-- 效验昵称
	IF EXISTS (SELECT [String] FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strNickname)>0 AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL))
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，您所输入的游戏昵称名含有限制字符串，请更换昵称名后再次申请帐号！'
		RETURN 4
	END
	 -- MAC地址限制注册
	DECLARE @IPCount AS BIGINT
	
	SELECT @IPCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'IPCount'
	IF @IPCount IS NOT NULL AND @IPCount>0
	IF( (  SELECT  count (0) FROM [QPAccountsDB].[dbo].[AccountsInfo] where datediff(d,getdate(),[RegisterDate])=0 and [RegisterMachine]=@strMachineID)>@IPCount)
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，您今天已达到最高注册量，请明天再来！'
		RETURN 5
	END
	-- 效验地址
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您所在的 IP 地址的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 5
	END
	
	-- 效验机器
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineID AND (EnjoinOverDate>GETDATE() OR EnjoinOverDate IS NULL)
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您的机器的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 6
	END
 
	-- 查询帐号
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts)
	BEGIN
		SET @strErrorDescribe=N'此帐号已被注册，请换另一帐号尝试再次注册！'
		RETURN 7
	END

	-- 查询昵称
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE NickName=@strNickName)
	BEGIN
		SET @strErrorDescribe=N'此昵称已被注册，请换另一昵称尝试再次注册！'
		RETURN 7
	END

	-- 查代理
	IF @strSpreader<>''
	BEGIN
		
		SELECT @AgencyID=AgencyID FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@strSpreader
		IF @AgencyID IS NULL
		BEGIN
			SET @strErrorDescribe=N'您所填写的代理不存在或者填写错误，请检查后再次注册！'
			RETURN 4
		END
	END
	ELSE SET @AgencyID=0
	
	SET @SpreaderID=0

	-- 注册用户
	INSERT AccountsInfo (Accounts,NickName,RegAccounts,LogonPass,InsurePass,DynamicPass,DynamicPassTime,SpreaderID,PassPortID,Compellation,Gender,FaceID,
		GameLogonTimes,LastLogonIP,LastLogonMachine,RegisterIP,RegisterMachine)
	VALUES (@strAccounts,@strNickName,@strAccounts,@strLogonPass,@strLogonPass,CONVERT(nvarchar(32),REPLACE(newid(),'-','')),GetDate(),@SpreaderID,
		@strPassPortID,@strCompellation,@cbGender,@wFaceID,1,@strClientIP,@strMachineID,@strClientIP,@strMachineID)


	-- 错误判断
	IF @@ERROR<>0
	BEGIN
		SET @strErrorDescribe=N'帐号已存在，请换另一帐号名字尝试再次注册！'
		RETURN 11
	END

	-- 查询用户
	SELECT @UserID=UserID, @GameID=GameID, @Accounts=Accounts, @NickName=NickName,@DynamicPass=DynamicPass,@UnderWrite=UnderWrite, @FaceID=FaceID,
		@CustomID=CustomID, @Gender=Gender, @UserMedal=UserMedal, @Experience=Experience, @LoveLiness=LoveLiness, @MemberOrder=MemberOrder,
		@MemberOverDate=MemberOverDate, @MoorMachine=MoorMachine
	FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	UPDATE IndividualDatum SET UserID=@UserID  WHERE UserID=@UserID
	IF @@ROWCOUNT=0
		INSERT INTO IndividualDatum(UserID,QQ,EMail,MobilePhone,BindingMobile) VALUES(@UserID,'','','',0)

	-- 代理
	IF @AgencyID<>0
	BEGIN
		INSERT INTO QPAgencyDB.dbo.Agency_User(UserID,AgencyID) VALUES(@UserID,@AgencyID)
		UPDATE QPAgencyDB.dbo.UserPlay SET RegisterCounts=RegisterCounts+1 WHERE AgencyID=@AgencyID AND DateID=CAST(CAST(GETDATE() AS FLOAT ) AS INT)
		IF @@ROWCOUNT=0
		BEGIN
			INSERT INTO QPAgencyDB.dbo.UserPlay(DateID,AgencyID,RegisterCounts,CanUserCounts,IsEnd)
			VALUES(CAST(CAST(GETDATE() AS FLOAT) AS INT),@AgencyID,1,0,0)
		END
	END

	
	-- 分配标识
	SELECT @GameID=GameID FROM GameIdentifier(NOLOCK) WHERE UserID=@UserID
	IF @GameID IS NULL 
	BEGIN
		SET @GameID=0
		SET @strErrorDescribe=N'用户注册成功，但未成功获取游戏 ID 号码，系统稍后将给您分配！'
	END
	ELSE UPDATE AccountsInfo SET GameID=@GameID WHERE UserID=@UserID


-- 插入表 
	IF not EXISTS (SELECT * FROM IndividualDatum WHERE UserID=@UserID) 
		INSERT INTO[IndividualDatum]([UserID],[QQ],[EMail],[SeatPhone],[MobilePhone],[DwellingPlace],[PostalCode]       ,[CollectDate],[UserNote])
		 VALUES     ( @UserID ,@strQQ ,'' ,'' ,@strMobileNum   ,'' ,''  ,GETDATE()  ,'') 
     
		
		
	-- 推广提成
	IF @SpreaderID<>0
	BEGIN
		DECLARE @RegisterGrantScore INT
		DECLARE @Note NVARCHAR(512)
		SET @Note = N'注册'
		SELECT @RegisterGrantScore = RegisterGrantScore FROM QPTreasureDBLink.QPTreasureDB.dbo.GlobalSpreadInfo
		IF @RegisterGrantScore IS NULL
		BEGIN
			SET @RegisterGrantScore=5000
		END
		INSERT INTO QPTreasureDBLink.QPTreasureDB.dbo.RecordSpreadInfo(
			UserID,Score,TypeID,ChildrenID,CollectNote)
		VALUES(@SpreaderID,@RegisterGrantScore,1,@UserID,@Note)		
	END

	-- 记录日志
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET GameRegisterSuccess=GameRegisterSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, GameRegisterSuccess) VALUES (@DateID, 1)

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	-- 注册赠送

	-- 读取变量
	DECLARE @GrantIPCount AS BIGINT
	DECLARE @GrantScoreCount AS BIGINT
	SELECT @GrantIPCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantIPCount'
	SELECT @GrantScoreCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantScoreCount'

	-- 赠送限制
	IF @GrantScoreCount IS NOT NULL AND @GrantScoreCount>0 AND @GrantIPCount IS NOT NULL AND @GrantIPCount>0
	BEGIN
		-- 赠送次数
		DECLARE @GrantCount AS BIGINT
		DECLARE @GrantMachineCount AS BIGINT
		SELECT @GrantCount=GrantCount FROM SystemGrantCount(NOLOCK) WHERE DateID=@DateID AND RegisterMachine=@strClientIP
		SELECT @GrantMachineCount=GrantCount FROM SystemMachineGrantCount(NOLOCK) WHERE DateID=@DateID AND RegisterMachine=@strMachineID
	
		-- 次数判断
		IF (@GrantCount IS NOT NULL AND @GrantCount>=@GrantIPCount) OR (@GrantMachineCount IS NOT NULL AND @GrantMachineCount>=@GrantIPCount)
		BEGIN
			SET @GrantScoreCount=0
		END
	END

	-- 赠送金豆
	IF @GrantScoreCount IS NOT NULL AND @GrantScoreCount>0
	BEGIN
		-- 更新记录
		UPDATE SystemGrantCount SET GrantScore=GrantScore+@GrantScoreCount, GrantCount=GrantCount+1 WHERE DateID=@DateID AND RegisterIP=@strClientIP

		-- 插入记录
		IF @@ROWCOUNT=0
		BEGIN
			INSERT SystemGrantCount (DateID, RegisterIP, RegisterMachine, GrantScore, GrantCount) VALUES (@DateID, @strClientIP, @strMachineID, @GrantScoreCount, 1)
		END

		-- 更新记录
		UPDATE SystemMachineGrantCount SET GrantScore=GrantScore+@GrantScoreCount, GrantCount=GrantCount+1 WHERE DateID=@DateID AND RegisterMachine=@strMachineID

		-- 插入记录
		IF @@ROWCOUNT=0
		BEGIN
			INSERT SystemMachineGrantCount (DateID, RegisterIP, RegisterMachine, GrantScore, GrantCount) VALUES (@DateID, @strClientIP, @strMachineID, @GrantScoreCount, 1)
		END

		-- 赠送金豆
		INSERT QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo (UserID, Score, RegisterIP, LastLogonIP) VALUES (@UserID, @GrantScoreCount, @strClientIP, @strClientIP) 
	END

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------

	-- 查询金豆
	SELECT @Score=Score, @Insure=InsureScore FROM QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo WHERE UserID=@UserID

	-- 查询游戏豆
	SELECT @Beans=Currency FROM QPTreasureDBLink.QPTreasureDB.dbo.UserCurrencyInfo WHERE UserID=@UserID	

	-- 数据调整
	IF @Score IS NULL SET @Score=0
	IF @Insure IS NULL SET @Insure=0
    IF @Beans IS NULL SET @Beans=0

	-- 输出变量
	SELECT @UserID AS UserID, @GameID AS GameID, @Accounts AS Accounts, @NickName AS NickName,@DynamicPass AS DynamicPass,@UnderWrite AS UnderWrite,
		@FaceID AS FaceID, @CustomID AS CustomID, @Gender AS Gender, @UserMedal AS Ingot, @Beans AS Beans, @Experience AS Experience,
		@Score AS Score, @Insure AS Insure, @LoveLiness AS LoveLiness, @MemberOrder AS MemberOrder, @MemberOverDate AS MemberOverDate,
		@MoorMachine AS MoorMachine,0 AS InsureEnabled

END

RETURN 0


GO
----------------------------------------------------------------------------------------------------

-- 帐号注册
CREATE PROC GSP_MB_RegisterAccounts
	@strAccounts NVARCHAR(31),					-- 用户帐号
	@strNickName NVARCHAR(31),					-- 用户昵称
	@strLogonPass NCHAR(32),					-- 登录密码
	@wFaceID SMALLINT,							-- 头像标识
	@cbGender TINYINT,							-- 用户性别
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NCHAR(32),					-- 机器标识
	@strMobilePhone NVARCHAR(11),				-- 手机号码
	@strSpreader NVARCHAR(31),					-- 推荐帐号
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @UserID INT
DECLARE @Gender TINYINT
DECLARE @FaceID SMALLINT
DECLARE @CustomID INT
DECLARE @MoorMachine TINYINT
DECLARE @Accounts NVARCHAR(31)
DECLARE @NickName NVARCHAR(31)
DECLARE @DynamicPass NCHAR(32)
DECLARE @UnderWrite NVARCHAR(63)

-- 积分变量
DECLARE @Score BIGINT
DECLARE @Insure BIGINT
DECLARE @Beans decimal(18, 2)

-- 扩展信息
DECLARE @GameID INT
DECLARE @UserMedal BIGINT
DECLARE @Experience INT
DECLARE @LoveLiness INT
DECLARE @SpreaderID INT
DECLARE @MemberOrder SMALLINT
DECLARE @MemberOverDate DATETIME

-- 辅助变量
DECLARE @EnjoinLogon AS INT
DECLARE @EnjoinRegister AS INT

DECLARE @AgencyID INT

-- 执行逻辑
BEGIN
	-- 注册暂停
	SELECT @EnjoinRegister=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinRegister'
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinRegister'
		RETURN 1
	END

	-- 登录暂停
	SELECT @EnjoinLogon=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
	IF @EnjoinLogon IS NOT NULL AND @EnjoinLogon<>0
	BEGIN
		SELECT @strErrorDescribe=StatusString FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'EnjoinLogon'
		RETURN 2
	END

	-- 效验名字
	IF (SELECT COUNT(*) FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strAccounts)>0)>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，您所输入的登录帐号名含有限制字符串，请更换帐号名后再次申请帐号！'
		RETURN 4
	END

	-- 效验昵称
	IF (SELECT COUNT(*) FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strNickName)>0)>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，您所输入的游戏昵称名含有限制字符串，请更换昵称名后再次申请帐号！'
		RETURN 4
	END

	-- 效验地址
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineAddress(NOLOCK) WHERE AddrString=@strClientIP AND GETDATE()<EnjoinOverDate
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您所在的 IP 地址的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 5
	END
	
	-- 效验机器
	SELECT @EnjoinRegister=EnjoinRegister FROM ConfineMachine(NOLOCK) WHERE MachineSerial=@strMachineID AND GETDATE()<EnjoinOverDate
	IF @EnjoinRegister IS NOT NULL AND @EnjoinRegister<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉地通知您，系统禁止了您的机器的注册功能，请联系客户服务中心了解详细情况！'
		RETURN 6
	END

	-- 查询帐号
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts)
	BEGIN
		SET @strErrorDescribe=N'此帐号已被注册，请换另一帐号尝试再次注册！'
		RETURN 7
	END

	-- 查询昵称
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE NickName=@strNickName)
	BEGIN
		SET @strErrorDescribe=N'此昵称已被注册，请换另一昵称尝试再次注册！'
		RETURN 7
	END
	
	-- 查代理
	IF @strSpreader<>''
	BEGIN
		
		SELECT @AgencyID=AgencyID FROM QPAgencyDB.dbo.AgencyInfo WHERE LoginName=@strSpreader
		IF @AgencyID IS NULL
		BEGIN
			SET @strErrorDescribe=N'您所填写的代理不存在或者填写错误，请检查后再次注册！'
			RETURN 4
		END
	END
	ELSE SET @AgencyID=0
	
	SET @SpreaderID=0

	-- 注册用户
	INSERT AccountsInfo (Accounts,NickName,RegAccounts,LogonPass,InsurePass,DynamicPass,Gender,FaceID,GameLogonTimes,LastLogonIP,LastLogonMobile,LastLogonMachine,RegisterIP,RegisterMobile,RegisterMachine)
	VALUES (@strAccounts,@strNickName,@strAccounts,@strLogonPass,@strLogonPass,CONVERT(nvarchar(32),REPLACE(newid(),'-','')),@cbGender,@wFaceID,1,@strClientIP,@strMobilePhone,@strMachineID,@strClientIP,@strMobilePhone,@strMachineID)

	-- 错误判断
	IF @@ERROR<>0
	BEGIN
		SET @strErrorDescribe=N'由于意外的原因，帐号注册失败，请尝试再次注册！'
		RETURN 11
	END

	-- 查询用户
	SELECT @UserID=UserID, @GameID=GameID, @Accounts=Accounts, @NickName=NickName,@DynamicPass=DynamicPass,@UnderWrite=UnderWrite, @FaceID=FaceID,
		@CustomID=CustomID, @Gender=Gender, @UserMedal=UserMedal, @Experience=Experience, @LoveLiness=LoveLiness, @MemberOrder=MemberOrder,
		@MemberOverDate=MemberOverDate, @MoorMachine=MoorMachine
	FROM AccountsInfo(NOLOCK) WHERE Accounts=@strAccounts

	UPDATE IndividualDatum SET UserID=@UserID,MobilePhone=@strMobilePhone  WHERE UserID=@UserID
	IF @@ROWCOUNT=0
		INSERT INTO IndividualDatum(UserID,QQ,EMail,MobilePhone,BindingMobile) VALUES(@UserID,'','',@strMobilePhone,0)
	
	-- 代理
	IF @AgencyID<>0
	BEGIN
		INSERT INTO QPAgencyDB.dbo.Agency_User(UserID,AgencyID) VALUES(@UserID,@AgencyID)
		UPDATE QPAgencyDB.dbo.UserPlay SET RegisterCounts=RegisterCounts+1 WHERE AgencyID=@AgencyID AND DateID=CAST(CAST(GETDATE() AS FLOAT ) AS INT)
		IF @@ROWCOUNT=0
		BEGIN
			INSERT INTO QPAgencyDB.dbo.UserPlay(DateID,AgencyID,RegisterCounts,CanUserCounts,IsEnd)
			VALUES(CAST(CAST(GETDATE() AS FLOAT) AS INT),@AgencyID,1,0,0)
		END
	END

	-- 分配标识
	SELECT @GameID=GameID FROM GameIdentifier(NOLOCK) WHERE UserID=@UserID
	IF @GameID IS NULL 
	BEGIN
		SET @GameID=0
		SET @strErrorDescribe=N'用户注册成功，但未成功获取游戏 ID 号码，系统稍后将给您分配！'
	END
	ELSE UPDATE AccountsInfo SET GameID=@GameID WHERE UserID=@UserID

	-- 推广提成
	set @SpreaderID=0
	IF @SpreaderID<>0
	BEGIN
		DECLARE @RegisterGrantScore INT
		DECLARE @Note NVARCHAR(512)
		SET @Note = N'注册'
		SELECT @RegisterGrantScore = RegisterGrantScore FROM QPTreasureDBLink.QPTreasureDB.dbo.GlobalSpreadInfo
		IF @RegisterGrantScore IS NULL
		BEGIN
			SET @RegisterGrantScore=5000
		END
		INSERT INTO QPTreasureDBLink.QPTreasureDB.dbo.RecordSpreadInfo(
			UserID,Score,TypeID,ChildrenID,CollectNote)
		VALUES(@SpreaderID,@RegisterGrantScore,1,@UserID,@Note)		
	END

	-- 记录日志
	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET GameRegisterSuccess=GameRegisterSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo (DateID, GameRegisterSuccess) VALUES (@DateID, 1)

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------
	-- 注册赠送

	-- 读取变量
	DECLARE @GrantIPCount AS BIGINT
	DECLARE @GrantScoreCount AS BIGINT
	SELECT @GrantIPCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantIPCount'
	SELECT @GrantScoreCount=StatusValue FROM SystemStatusInfo(NOLOCK) WHERE StatusName=N'GrantScoreCount'

	-- 赠送限制
	IF @GrantScoreCount IS NOT NULL AND @GrantScoreCount>0 AND @GrantIPCount IS NOT NULL AND @GrantIPCount>0
	BEGIN
		-- 赠送次数
		DECLARE @GrantCount AS BIGINT
		DECLARE @GrantMachineCount AS BIGINT
		SELECT @GrantCount=GrantCount FROM SystemGrantCount(NOLOCK) WHERE DateID=@DateID AND RegisterIP=@strClientIP
		SELECT @GrantMachineCount=GrantCount FROM SystemMachineGrantCount(NOLOCK) WHERE DateID=@DateID AND RegisterMachine=@strMachineID
	
		-- 次数判断
		IF (@GrantCount IS NOT NULL AND @GrantCount>=@GrantIPCount) OR (@GrantMachineCount IS NOT NULL AND @GrantMachineCount>=@GrantIPCount)
		BEGIN
			SET @GrantScoreCount=0
		END
	END

	-- 赠送金豆
	IF @GrantScoreCount IS NOT NULL AND @GrantScoreCount>0
	BEGIN
		-- 更新记录
		UPDATE SystemGrantCount SET GrantScore=GrantScore+@GrantScoreCount, GrantCount=GrantCount+1 WHERE DateID=@DateID AND RegisterIP=@strClientIP

		-- 插入记录
		IF @@ROWCOUNT=0
		BEGIN
			INSERT SystemGrantCount (DateID, RegisterIP, RegisterMachine, GrantScore, GrantCount) VALUES (@DateID, @strClientIP, @strMachineID, @GrantScoreCount, 1)
		END

		-- 更新记录
		UPDATE SystemMachineGrantCount SET GrantScore=GrantScore+@GrantScoreCount, GrantCount=GrantCount+1 WHERE DateID=@DateID AND RegisterMachine=@strMachineID

		-- 插入记录
		IF @@ROWCOUNT=0
		BEGIN
			INSERT SystemMachineGrantCount (DateID, RegisterIP, RegisterMachine, GrantScore, GrantCount) VALUES (@DateID, @strClientIP, @strMachineID, @GrantScoreCount, 1)
		END

		-- 赠送金豆
		INSERT QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo (UserID, Score, RegisterIP, LastLogonIP) VALUES (@UserID, @GrantScoreCount, @strClientIP, @strClientIP) 
	END
	ELSE
	BEGIN
		INSERT QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo (UserID, Score, RegisterIP, LastLogonIP) VALUES (@UserID, 0, @strClientIP, @strClientIP) 
	END

	----------------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------

	-- 查询游戏豆
	SELECT @Beans=Currency FROM QPTreasureDBLink.QPTreasureDB.dbo.UserCurrencyInfo WHERE UserID=@UserID	

	SELECT @Score=Score,@Insure=InsureScore FROM QPTreasureDB.dbo.GameScoreInfo WHERE UserID=@UserID

	-- 数据调整
	IF @Score IS NULL SET @Score=0
	IF @Beans IS NULL SET @Beans=0
	IF @Insure IS NULL SET @Insure=0    

	-- 输出变量
	SELECT @UserID AS UserID, @GameID AS GameID, @Accounts AS Accounts, @NickName AS NickName,@DynamicPass AS DynamicPass,@UnderWrite AS UnderWrite,
		@FaceID AS FaceID, @CustomID AS CustomID, @Gender AS Gender, @UserMedal AS Ingot, @Beans AS Beans, @Experience AS Experience,
		@Score AS Score, @Insure AS Insure, @LoveLiness AS LoveLiness, @MemberOrder AS MemberOrder, @MemberOverDate AS MemberOverDate,
		@MoorMachine AS MoorMachine,0 AS InsureEnabled

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
