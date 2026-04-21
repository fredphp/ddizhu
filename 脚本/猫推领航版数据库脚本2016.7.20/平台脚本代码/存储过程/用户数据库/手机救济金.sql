
----------------------------------------------------------------------------------------------------

USE QPAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_QueryWelFare]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_QueryWelFare]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_ModifyUserIndividual]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_ModifyUserIndividual]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_GetWelfare]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_GetWelfare]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_CheckInQueryInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_CheckInQueryInfo]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_CheckInDone]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_CheckInDone]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
CREATE PROC GSP_MB_QueryWelFare
	@dwUserID INT,
	@strClientIP NVARCHAR(15),
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

SET NOCOUNT ON;

BEGIN
	-- 领取条件
	DECLARE @ScoreCondition AS BIGINT
	SELECT @ScoreCondition=StatusValue FROM SystemStatusInfo WHERE StatusName=N'SubsistenceAllowancesConditionMB'
	IF @ScoreCondition IS NULL SET @ScoreCondition=0

	-- 可以领取次数
	DECLARE @TakeTimes AS SMALLINT
	SELECT @TakeTimes=StatusValue FROM SystemStatusInfo WHERE StatusName=N'SubsistenceAllowancesNumberMB'
	IF @TakeTimes IS NULL SET @TakeTimes=0
	
	-- 领取记录
	DECLARE @TodayDateID INT
	DECLARE @TodayTakeTimes INT		
	SET @TodayDateID=CAST(CAST(GetDate() AS FLOAT) AS INT)	
	SELECT @TodayTakeTimes=TakeTimes FROM AccountsBaseEnsureMB WHERE UserID=@dwUserID AND TakeDateID=@TodayDateID
	IF @TodayTakeTimes IS NULL SET @TodayTakeTimes=0	
	
	-- 剩余领取次数
	DECLARE @HasTimes INT 
	SET @HasTimes=@TakeTimes-@TodayTakeTimes
	IF @HasTimes<0 SET @HasTimes=0

	-- 领取数量
	DECLARE @ScoreAmount AS BIGINT
	SELECT @ScoreAmount=StatusValue FROM SystemStatusInfo WHERE StatusName=N'SubsistenceAllowancesGoldMB'
	IF @ScoreAmount IS NULL SET @ScoreAmount=0
	
	-- 领取时间间隔
	DECLARE @TakeNeedTime AS BIGINT
	SELECT @TakeNeedTime=StatusValue FROM SystemStatusInfo WHERE StatusName=N'SubsistenceAllowancesTimeMB'
	IF @TakeNeedTime IS NULL SET @TakeNeedTime=3600

	-- 今天上一次领取时间
	DECLARE @LastTakeTime DATETIME
	SELECT @LastTakeTime=TakeTime FROM QPRecordDB.dbo.RecordBaseEnsureMB WHERE UserID=@dwUserID AND CAST(CAST(TakeTime AS FLOAT) AS INT)=@TodayDateID
	
	-- 还剩多长时间可以领取（秒）
	DECLARE @NeedTime BIGINT
	IF @LastTakeTime IS NULL
	BEGIN
		SET @NeedTime=0
	END
	ELSE
	BEGIN
		SET @NeedTime=@TakeNeedTime-DATEDIFF(SECOND,@LastTakeTime,GETDATE())
	END
	

	-- 抛出数据
	SELECT @ScoreCondition AS LimitScore,@HasTimes AS HowLong,@NeedTime AS LeaveTime,@ScoreAmount AS Score
END
GO
----------------------------------------------------------------------------------------------------
CREATE PROC GSP_MB_ModifyUserIndividual
	@dwUserID INT,					--用户编号
	@strPassword NCHAR(32),			--用户密码
	@strNickName NVARCHAR(32),		--用户昵称
	@cbGender TINYINT,				--性别
	@dwFaceID SMALLINT,				--头像
	@strClientIp VARCHAR(11),		--客户端IP
	@strErrorDescribe NVARCHAR(127) OUTPUT --输出参数
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

BEGIN
	-- 变量定义
	DECLARE @UserID INT
	DECLARE @NickName NVARCHAR(31)
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @LogonPass AS NCHAR(32)
	
	-- 查询用户
	SELECT @UserID=UserID, @NickName=NickName, @LogonPass=LogonPass, @Nullity=Nullity, @StunDown=StunDown
	FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在，请查证后再次尝试！'
		RETURN 1
	END	

	-- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END	
	
	-- 密码判断
	IF @LogonPass<>@strPassword
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误，请查证后再次尝试登录！'
		RETURN 3
	END

	-- 效验昵称
	IF (SELECT COUNT(*) FROM ConfineContent(NOLOCK) WHERE CHARINDEX(String,@strNickName)>0)>0
	BEGIN
		SET @strErrorDescribe=N'您所输入的游戏昵称名含有限制字符串，请更换昵称名后再次修改！'
		RETURN 4
	END

	-- 存在判断
	IF EXISTS (SELECT UserID FROM AccountsInfo(NOLOCK) WHERE NickName=@strNickName AND UserID<>@dwUserID)
	BEGIN
		SET @strErrorDescribe=N'此昵称已被其他玩家使用了，请更换昵称名后再次修改！'
		RETURN 4
	END

	-- 修改资料
	UPDATE AccountsInfo SET NickName=@strNickName,Gender=@cbGender,FaceID=@dwFaceID,CustomID=0
	WHERE UserID=@dwUserID
	
	-- 修改昵称记录
	IF @NickName<>@strNickName
	BEGIN
		INSERT INTO QPRecordDBLink.QPRecordDB.dbo.RecordAccountsExpend(UserID,ReAccounts,ClientIP)
		VALUES(@dwUserID,@strNickName,@strClientIP)
	END
	
	-- 设置信息
	IF @@ERROR=0 SET @strErrorDescribe=N'服务器已经接受了您的新资料！'

	DECLARE @reNickName VARCHAR(31)
	DECLARE @reFaceID SMALLINT
	DECLARE	@reGender TINYINT
	
	SELECT @UserID=UseriD,@reNickName=NickName,@reFaceID=FaceID,@reGender=Gender FROM QPAccountsDB.dbo.AccountsInfo where UserID=@dwUserID
	
	SELECT @UserID AS UserID, @reNickName AS NickName,@reFaceID AS FaceID,@reGender AS Gender

	RETURN 0
END

RETURN 0
GO
----------------------------------------------------------------------------------------------------
CREATE PROC GSP_MB_GetWelfare
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 提示内容
WITH ENCRYPTION AS

SET NOCOUNT ON;

BEGIN
	-- 查询用户
	IF not exists(SELECT * FROM AccountsInfo WHERE UserID=@dwUserID AND LogonPass=@strPassword)
	BEGIN
		SET @strErrorDescribe = N'抱歉，你的用户信息不存在或者密码不正确！'
		return 1
	END

	-- 领取条件
	DECLARE @ScoreCondition AS BIGINT
	SELECT @ScoreCondition=StatusValue FROM SystemStatusInfo WHERE StatusName=N'SubsistenceAllowancesConditionMB'
	IF @ScoreCondition IS NULL SET @ScoreCondition=0

	-- 可以领取次数
	DECLARE @TakeTimes AS SMALLINT
	SELECT @TakeTimes=StatusValue FROM SystemStatusInfo WHERE StatusName=N'SubsistenceAllowancesNumberMB'
	IF @TakeTimes IS NULL SET @TakeTimes=0

	-- 领取数量
	DECLARE @ScoreAmount AS BIGINT
	SELECT @ScoreAmount=StatusValue FROM SystemStatusInfo WHERE StatusName=N'SubsistenceAllowancesGoldMB'
	IF @ScoreAmount IS NULL SET @ScoreAmount=0
	
	-- 领取时间间隔
	DECLARE @TakeNeedTime AS BIGINT
	SELECT @TakeNeedTime=StatusValue FROM SystemStatusInfo WHERE StatusName=N'SubsistenceAllowancesTimeMB'
	IF @TakeNeedTime IS NULL SET @TakeNeedTime=3600

	-- 今天上一次领取时间
	DECLARE @LastTakeTime DATETIME
	SELECT @LastTakeTime=TakeTime FROM QPRecordDB.dbo.RecordBaseEnsureMB WHERE UserID=@dwUserID AND CAST(CAST(TakeTime AS FLOAT) AS INT)=CAST(CAST(GETDATE() AS FLOAT) AS INT)

	-- 读取金豆
	DECLARE @Score BIGINT
	DECLARE @InsureScore BIGINT
	SELECT @Score=Score,@InsureScore=InsureScore FROM QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID
	IF @@rowcount = 0
	BEGIN
		-- 插入资料
		INSERT INTO QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo (UserID,Score,LastLogonIP, RegisterIP)
		VALUES (@dwUserID, 0, @strClientIP, @strClientIP)

		-- 设置金豆
		SELECT @Score=0,@InsureScore=0
	END

	DECLARE @OldScore BIGINT
	SET @OldScore=@Score

	-- 调整金豆	
	SET @Score = @Score + @InsureScore

	-- 领取判断
	IF @Score >= @ScoreCondition
	BEGIN
		SET @strErrorDescribe = N'您的金豆高于 '+CAST(@ScoreCondition AS NVARCHAR)+N'，不可领取！'	
		RETURN 1	
	END	

	-- 领取记录
	DECLARE @TodayDateID INT
	DECLARE @TodayTakeTimes INT		
	SET @TodayDateID=CAST(CAST(GetDate() AS FLOAT) AS INT)	
	SELECT @TodayTakeTimes=TakeTimes FROM AccountsBaseEnsureMB WHERE UserID=@dwUserID AND TakeDateID=@TodayDateID
	IF @TodayTakeTimes IS NULL SET @TodayTakeTimes=0	

	-- 次数判断
	IF @TodayTakeTimes >= @TakeTimes
	BEGIN
		SET @strErrorDescribe = N'您今日已领取 '+CAST(@TodayTakeTimes AS NVARCHAR)+N' 次，领取失败！'
		return 3		
	END
	
	-- 间隔时间判断
	IF DATEDIFF(SECOND,@LastTakeTime,GETDATE())<@TakeNeedTime
	BEGIN
		SET @strErrorDescribe=N'领取太过频繁，请过'+CAST(@TakeNeedTime-DATEDIFF(SECOND,@LastTakeTime,GETDATE()) AS NVARCHAR)+N'秒后领取'
		return 4
	END

	-- 更新记录
	IF @TodayTakeTimes=0
	BEGIN
		SET @TodayTakeTimes = 1
		INSERT INTO AccountsBaseEnsureMB(UserID,TakeDateID,TakeTimes) VALUES(@dwUserID,@TodayDateID,@TodayTakeTimes)		
	END ELSE
	BEGIN
		SET @TodayTakeTimes = @TodayTakeTimes+1
		UPDATE AccountsBaseEnsureMB SET TakeTimes = @TodayTakeTimes WHERE UserID = @dwUserID AND TakeDateID=@TodayDateID		
	END	

	-- 领取金豆	
	UPDATE QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo SET Score = Score + @ScoreAmount WHERE UserID = @dwUserID

	-- 查询金豆
	SELECT @Score=Score FROM QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo WHERE UserID = @dwUserID 	

	--插入记录
	INSERT INTO QPRecordDBLink.QPRecordDB.dbo.RecordBaseEnsureMB(UserID,BaseEnsureGold,ClientID,TakeTime,OldGold,NewGold,OldInsureGold,NewInsureGold)
		VALUES(@dwUserID,@ScoreAmount,'',GetDate(),@OldScore,@Score,@InsureScore,@InsureScore)

	-- 输出提示
	SET @strErrorDescribe = N'恭喜您，低保领取成功！您今日还可领取 '+CAST(@TakeTimes-@TodayTakeTimes AS NVARCHAR)+N' 次！'
	
	-- 抛出数据
	SELECT @Score AS lTotalScore,@ScoreAmount AS lGainScore
END
GO
----------------------------------------------------------------------------------------------------
CREATE PROC GSP_MB_CheckInQueryInfo
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

SET NOCOUNT ON;

BEGIN

   -- 查询用户
	IF not exists(SELECT * FROM AccountsInfo WHERE UserID=@dwUserID AND LogonPass=@strPassword)
	BEGIN
		SET @strErrorDescribe = N'抱歉，你的用户信息不存在或者密码不正确！'
		return 1
	END
	
	DECLARE @wSeriesDate INT
	DECLARE @TodayCheckIned TINYINT
	
	SELECT @wSeriesDate=COUNT(*) FROM QPRecordDB.dbo.RecordsigninMB WHERE DATEDIFF(WEEK,InputDate,GETDATE())=0 AND UserID=@dwUserID
	SELECT @TodayCheckIned=COUNT(*) FROM QPRecordDB.dbo.recordsigninMB WHERE CAST(CAST(InputDate AS FLOAT)AS INT)=CAST(CAST(GETDATE() AS FLOAT) AS INT) AND UserID=@dwUserID
	
  
	-- 抛出数据
	SELECT @wSeriesDate AS SeriesDate,@TodayCheckIned AS TodayCheckIned
END
RETURN 0
GO
----------------------------------------------------------------------------------------------------
CREATE PROC GSP_MB_CheckInDone
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

SET NOCOUNT ON;

BEGIN
-- 查询用户
	IF not exists(SELECT * FROM AccountsInfo WHERE UserID=@dwUserID AND LogonPass=@strPassword)
	BEGIN
		SET @strErrorDescribe = N'抱歉，你的用户信息不存在或者密码不正确！'
		return 1
	END

	DECLARE @wSeriesDate INT
	DECLARE @TodayCheckIned TINYINT
	
	SELECT @wSeriesDate=COUNT(*) FROM QPRecordDB.dbo.RecordsigninMB WHERE DATEDIFF(WEEK,InputDate,GETDATE())=0 AND UserID=@dwUserID
	SELECT @TodayCheckIned=COUNT(*) FROM QPRecordDB.dbo.RecordsigninMB WHERE CAST(CAST(InputDate AS FLOAT)AS INT)=CAST(CAST(GETDATE() AS FLOAT) AS INT) AND UserID=@dwUserID
	
	IF @TodayCheckIned>0
	BEGIN
		SET @strErrorDescribe=N'抱歉，您今天已经签到了！'
		RETURN 3
	END
	
	
	
	-- 查询奖励
	SET @wSeriesDate=@wSeriesDate+1
	DECLARE @lRewardGold BIGINT
	SELECT @lRewardGold=RewardGold FROM QPPlatformDBLink.QPPlatformDB.dbo.SigninConfigMB WHERE DayID=@wSeriesDate
	IF @lRewardGold IS NULL 
	BEGIN
		SET @lRewardGold = 0
	END	

	-- 查询签到前金豆
	DECLARE @OldScore BIGINT
	SELECT @OldScore=Score FROM QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo WHERE UserID = @dwUserID
	IF @OldScore=0 OR @OldScore IS NULL
		SET @OldScore=0
	

	-- 奖励金豆	
	UPDATE QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo SET Score = Score + @lRewardGold WHERE UserID = @dwUserID
	IF @@rowcount = 0
	BEGIN
		-- 插入资料
		INSERT INTO QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo (UserID,Score, LastLogonIP, LastLogonMachine, RegisterIP, RegisterMachine)
		VALUES (@dwUserID, @lRewardGold, @strClientIP, @strMachineID, @strClientIP, @strMachineID)
	END
	
	-- 得到签到后金豆
	DECLARE @NewScore BIGINT
	SELECT @NewScore=Score FROM QPTreasureDB.dbo.GameScoreInfo WHERE UserID = @dwUserID
	IF @NewScore=0 OR @NewScore IS NULL
		SET @NewScore=0

	-- 写入记录
	
	INSERT INTO QPTreasureDBLink.QPRecordDB.dbo.RecordSigninMB (UserID,RewardGold, ClientID, InputDate,OldGold,NewGold)
	VALUES (@dwUserID, @lRewardGold,'',GetDate(),@OldScore,@NewScore)
	
	
	-- 抛出数据
	SELECT @NewScore AS Score	
END
RETURN 0
GO
----------------------------------------------------------------------------------------------------
