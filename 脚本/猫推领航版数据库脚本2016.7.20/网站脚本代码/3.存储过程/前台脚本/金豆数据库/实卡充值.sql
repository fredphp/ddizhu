----------------------------------------------------------------------
-- 版权：2011
-- 时间：2011-09-1
-- 用途：实卡充值
----------------------------------------------------------------------

USE [QPTreasureDB]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_FilledLivcard') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_FilledLivcard
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------
-- 实卡充值
CREATE PROC NET_PW_FilledLivcard
	@dwOperUserID		INT,						--	操作用户

	@strSerialID		NVARCHAR(32),				--	会员卡号
	@strPassword		NCHAR(32),					--	会员卡密	
	@strAccounts		NVARCHAR(31),				--	充值玩家帐号

	@strClientIP		NVARCHAR(15),				--	充值地址
	@strErrorDescribe	NVARCHAR(127) OUTPUT		--	输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 实卡信息
DECLARE @CardID INT
DECLARE @SerialID NVARCHAR(15)
DECLARE @Password NCHAR(32)
DECLARE @CardTypeID INT
DECLARE @CardPrice DECIMAL(18,2)
DECLARE @Score INT
DECLARE @ValidDate DATETIME
DECLARE @ApplyDate DATETIME
DECLARE @UseRange INT

-- 帐号资料
DECLARE @Accounts NVARCHAR(31)
DECLARE @GameID INT
DECLARE @UserID INT
DECLARE @SpreaderID INT
DECLARE @Nullity TINYINT
DECLARE @StunDown TINYINT
DECLARE @WebLogonTimes INT
DECLARE @GameLogonTimes INT
DECLARE @BeforeCurrency DECIMAL(18,2)

-- 执行逻辑
BEGIN
	DECLARE @ShareID INT
	SET @ShareID=1		-- 1 实卡
	
	-- 卡号查询
	SELECT	@CardID=CardID,@SerialID=SerialID,@Password=[Password],@CardTypeID=CardTypeID,
			@CardPrice=CardPrice,@Score=Currency,@ValidDate=ValidDate,@ApplyDate=ApplyDate,
			@UseRange=UseRange,@Nullity=Nullity
	FROM LivcardAssociator WHERE SerialID = @strSerialID

	-- 验证卡信息
	IF @CardID IS NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉！您要充值的卡号不存在。如有疑问请联系客服中心。'
		RETURN 101
	END	

	IF @strPassword=N'' OR @strPassword IS NULL OR @Password<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值失败，请检查卡号或密码是否填写正确。如有疑问请联系客服中心。'
		RETURN 102
	END

	IF @ApplyDate IS NOT NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉！该充值卡已被使用，请换一张再试。如有疑问请联系客服中心。'
		RETURN 103
	END

	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'抱歉！该会员卡已被禁用。'
		RETURN 104
	END

	IF @ValidDate < GETDATE()
	BEGIN
		SET @strErrorDescribe=N'抱歉！该会员卡已经过期。'
		RETURN 105
	END
	
	-- 验证用户
	SELECT @UserID=UserID,@GameID=GameID,@Accounts=Accounts,@Nullity=Nullity,@StunDown=StunDown,@SpreaderID=SpreaderID,
		   @WebLogonTimes=WebLogonTimes,@GameLogonTimes=GameLogonTimes
	FROM QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo
	WHERE Accounts=@strAccounts

	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉！您要充值的用户账号不存在。'
		RETURN 201
	END

	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'抱歉！您要充值的用户账号暂时处于冻结状态，请联系客户服务中心了解详细情况。'
		RETURN 202
	END

	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉！您要充值的用户账号使用了安全关闭功能，必须重新开通后才能继续使用。'
		RETURN 203
	END

	-- 实卡使用范围
	-- 新注册用户
	IF @UseRange = 1
	BEGIN
		IF @WebLogonTimes+@GameLogonTimes>1
		BEGIN
			SET @strErrorDescribe=N'抱歉！该会员卡只适合新注册的用户使用。'
			RETURN 301
		END 
	END
	-- 第一次充值用户
	IF @UseRange = 2
	BEGIN
		DECLARE @FILLCOUNT INT
		SELECT @FillCount=COUNT(USERID) FROM ShareDetailInfo WHERE UserID=@UserID
		IF @FillCount>0
		BEGIN
			SET @strErrorDescribe=N'抱歉！该会员卡只适合第一次充值的用户使用。'
			RETURN 302
		END
	END
	
	IF @UseRange = 3
	BEGIN
		DECLARE @PayCount int
		SELECT @PayCount=MAX(CardTypeID) FROM ShareDetailInfo WHERE UserID=@UserID
		IF @PayCount>=3
		BEGIN
			SET @strErrorDescribe=N'该充值卡为新手卡,每个帐号只能用一次。'
			RETURN 303
		END
	END

	-- 充值金币	
	SELECT @BeforeCurrency=Score FROM GameScoreInfo WHERE UserID=@UserID
	IF @BeforeCurrency IS NULL
	BEGIN
		SET @BeforeCurrency=0
		INSERT GameScoreInfo(UserID,Score,RegisterIP,LastLogonIP)
		VALUES (@UserID,@Currency,@strClientIP,@strClientIP)
	END
	ELSE
	BEGIN
		UPDATE GameScoreInfo SET InsureScore=InsureScore+@Currency WHERE UserID=@UserID
	END
	--------------------------------------------------------------------------------

	--代理系统
	DECLARE @AgencyID int
	DECLARE @DateID INT
	DECLARE @PayRevenueRate DECIMAL(18,2)
	DECLARE @PayRevenue DECIMAL(18,2)
	SELECT @AgencyID=AgencyID FROM QPAgencyDB.dbo.Agency_User WHERE UserID=@UserID
	SELECT @PayRevenueRate=PayRevenue FROM QPAgencyDB.dbo.AgencyConfig WHERE AgencyConfigName='AgencyCofig'
	IF @PayRevenueRate IS NULL
		SET @PayRevenueRate=4.5
	SET @PayRevenue=@Currency*@PayRevenueRate/100
	IF @AgencyID IS NOT NULL AND @PayRevenue>0
	BEGIN
		SET @DateId = CAST(CAST(GETDATE() AS FLOAT) AS INT)
		DECLARE @Son int
		DECLARE @self int
		DECLARE @SonRoty int
		DECLARE @selfRoty int
		DECLARE @selfFlag int
		DECLARE @Count int
		SET @Count=1
		SET @self=@AgencyID
		SELECT @selfRoty=PayRevenue  FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
		SELECT @selfFlag=AgencyFlag FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
		
		IF @selfFlag=0 AND @PayRevenue*@selfRoty/100>0
		BEGIN
			INSERT INTO QPAgencyDB.dbo.RecordRoyalty(AgencyID,UserID,UserWin,RoyaltyTotal,RoyaltyRatio,RoyaltyTime,RoyaltyGold,Remark,RoyaltyType)
				VALUES(@AgencyID,@UserID,@Currency,@PayRevenue,@selfRoty,GETDATE(),@PayRevenue*@selfRoty/100,N'充值分成',1)
			UPDATE QPAgencyDB.dbo.AgencyInfo SET AgencyGold=AgencyGold+@PayRevenue*@selfRoty/100 WHERE AgencyID=@AgencyID
		END
		
		SET @Son=@self
		
		WHILE @Count<5
		BEGIN	
			SELECT @self=AgencyParentID FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@Son
			IF @self<>0
			BEGIN
				IF @self IS NOT NULL
				BEGIN
					SELECT @SonRoty=PayRevenue  FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@Son
					SELECT @selfRoty=PayRevenue  FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
					SELECT @selfFlag=AgencyFlag FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
					SET @selfRoty=@selfRoty-@SonRoty
					IF @selfFlag=0 AND @PayRevenue*@selfRoty/100>0
					BEGIN
						INSERT INTO QPAgencyDB.dbo.RecordRoyalty(AgencyID,UserID,UserWin,RoyaltyTotal,RoyaltyRatio,RoyaltyTime,RoyaltyGold,Remark,RoyaltyType)
							VALUES(@self,@UserID,@Currency,@PayRevenue,@selfRoty,GETDATE(),@PayRevenue*@selfRoty/100,N'充值分成',1)
						UPDATE QPAgencyDB.dbo.AgencyInfo SET AgencyGold=AgencyGold+@PayRevenue*@selfRoty/100 WHERE AgencyID=@self
					END
					
					SET @Son=@self
					SET @Count=@Count+1
				END
				ELSE
				BEGIN
					SET @Count = 5
				END
			END
			ELSE
			BEGIN
				SET @Count = 5
			END
		END
		
	END

	-- 推广系统
	IF @SpreaderID<>0
	BEGIN
		DECLARE @Rate DECIMAL(18,2)
		DECLARE @GrantScore BIGINT
		DECLARE @Note NVARCHAR(512)
		SELECT @Rate=FillGrantRate FROM GlobalSpreadInfo
		IF @Rate IS NULL
		BEGIN
			SET @Rate=0.1
		END
		-- 货币与金币的汇率
		DECLARE @GoldRate INT
		SELECT @GoldRate=StatusValue FROM QPAccountsDBLink.QPAccountsDB.dbo.SystemStatusInfo WHERE StatusName='RateGold'
		IF @GoldRate=0 OR @GoldRate IS NULL
			SET @GoldRate=1

		SET @GrantScore = @Score*@GoldRate
		SET @Note = N'充值'+LTRIM(STR(@Score))+'元'
		INSERT INTO RecordSpreadInfo(
			UserID,Score,TypeID,ChildrenID,CollectNote)
		VALUES(@SpreaderID,@GrantScore,3,@UserID,@Note)		
	END

	-- 设置卡已使用
	UPDATE LivcardAssociator SET ApplyDate=GETDATE() WHERE CardID=@CardID

	-- 写卡充值记录
	INSERT INTO ShareDetailInfo(
		OperUserID,ShareID,UserID,GameID,Accounts,SerialID,CardTypeID,OrderAmount,Currency,BeforeCurrency,PayAmount,IPAddress,ApplyDate)
	VALUES(@dwOperUserID,@ShareID,@UserID,@GameID,@Accounts,@SerialID,@CardTypeID,@CardPrice,@Score,@BeforeCurrency,@CardPrice,@strClientIP,GETDATE())

	-- 记录日志
	DECLARE @DateID1 INT
	SET @DateID1=CAST(CAST(GETDATE() AS FLOAT) AS INT)	
	
	UPDATE StreamShareInfo
	SET ShareTotals=ShareTotals+1
	WHERE DateID=@DateID1 AND ShareID=@ShareID

	IF @@ROWCOUNT=0
	BEGIN
		INSERT StreamShareInfo(DateID,ShareID,ShareTotals)
		VALUES (@DateID1,@ShareID,1)
	END	 

	SET @strErrorDescribe=N'实卡充值成功。'
END 

RETURN 0
GO



