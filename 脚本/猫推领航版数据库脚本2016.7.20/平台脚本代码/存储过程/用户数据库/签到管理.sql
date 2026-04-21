
----------------------------------------------------------------------------------------------------

USE QPAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_CheckInQueryInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_CheckInQueryInfo]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_CheckInDone]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_CheckInDone]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 查询签到
CREATE PROC GSP_GR_CheckInQueryInfo
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 查询用户
	IF not exists(SELECT * FROM AccountsInfo WHERE UserID=@dwUserID AND LogonPass=@strPassword)
	BEGIN
		SET @strErrorDescribe = N'抱歉，你的用户信息不存在或者密码不正确！'
		return 1
	END

	-- 签到记录
	DECLARE @wSeriesDate INT	
	DECLARE @StartDateTime DateTime
	DECLARE @LastDateTime DateTime
	SELECT @StartDateTime=StartDateTime,@LastDateTime=LastDateTime,@wSeriesDate=SeriesDate FROM AccountsSignin 	
	WHERE UserID=@dwUserID
	IF @StartDateTime IS NULL OR @LastDateTime IS NULL OR @wSeriesDate IS NULL
	BEGIN
		SELECT @StartDateTime=GetDate(),@LastDateTime=GetDate(),@wSeriesDate=0
		INSERT INTO AccountsSignin VALUES(@dwUserID,@StartDateTime,@LastDateTime,0)		
	END

	-- 调整日期
	IF @wSeriesDate > 7 SET @wSeriesDate = 7

	-- 日期判断
	DECLARE @TodayCheckIned TINYINT
	SET @TodayCheckIned = 0
	IF DateDiff(dd,@LastDateTime,GetDate()) = 0 	
	BEGIN
		IF @wSeriesDate > 0 SET @TodayCheckIned = 1
	END ELSE
	BEGIN		
		IF DateDiff(dd,@StartDateTime,GetDate()) <> @wSeriesDate OR @wSeriesDate >= 7 
		BEGIN
			SET @wSeriesDate = 0
			UPDATE AccountsSignin SET StartDateTime=GetDate(),LastDateTime=GetDate(),SeriesDate=0 WHERE UserID=@dwUserID									
		END
	END
	
	-- 本月签到日期
	DECLARE @MonthSignDate VARCHAR(100)
	
	SET @MonthSignDate=(SELECT DISTINCT  STUFF(
                        (
                              SELECT '-'+SUBSTRING(CONVERT(VARCHAR(100),InputDate,21),9,2)
                              FROM QPRecordDB.dbo.RecordSignin
                              WHERE DATEDIFF(MONTH,InputDate,GETDATE())=0 AND UserID=@dwUserID
                              FOR XML PATH('')
                        )
                        ,1,1,''
                  )AS MonthSignDate
  FROM QPRecordDB.dbo.RecordSignin AS A)
  
	-- 抛出数据
	SELECT @wSeriesDate AS SeriesDate,@TodayCheckIned AS TodayCheckIned,@MonthSignDate AS MonthSignDate
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------

-- 查询奖励
CREATE PROC GSP_GR_CheckInDone
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 查询用户
	IF not exists(SELECT * FROM AccountsInfo WHERE UserID=@dwUserID AND LogonPass=@strPassword)
	BEGIN
		SET @strErrorDescribe = N'抱歉，你的用户信息不存在或者密码不正确！'
		return 1
	END

	-- 签到记录
	DECLARE @wSeriesDate INT	
	DECLARE @StartDateTime DateTime
	DECLARE @LastDateTime DateTime
	SELECT @StartDateTime=StartDateTime,@LastDateTime=LastDateTime,@wSeriesDate=SeriesDate FROM AccountsSignin 
	WHERE UserID=@dwUserID
	IF @StartDateTime IS NULL OR @LastDateTime IS NULL OR @wSeriesDate IS NULL
	BEGIN
		SELECT @StartDateTime = GetDate(),@LastDateTime = GetDate(),@wSeriesDate = 0
		INSERT INTO AccountsSignin VALUES(@dwUserID,@StartDateTime,@LastDateTime,0)		
	END

	-- 签到判断
	IF DateDiff(dd,@LastDateTime,GetDate()) = 0 AND @wSeriesDate > 0
	BEGIN
		SET @strErrorDescribe = N'抱歉，您今天已经签到了！'
		return 3		
	END

	-- 日期越界
	IF @wSeriesDate > 7
	BEGIN
		SET @strErrorDescribe = N'您的签到信息出现异常，请与我们的客服人员联系！'
		return 2				
	END

	-- 更新记录
	SET @wSeriesDate = @wSeriesDate+1
	UPDATE AccountsSignin SET LastDateTime = GetDate(),SeriesDate = @wSeriesDate WHERE UserID = @dwUserID

	-- 查询奖励
	DECLARE @lRewardGold BIGINT
	SELECT @lRewardGold=RewardGold FROM QPPlatformDBLink.QPPlatformDB.dbo.SigninConfig WHERE DayID=@wSeriesDate
	IF @lRewardGold IS NULL 
	BEGIN
		SET @lRewardGold = 0
	END	
	
	-- 查询本月累积签到天数
	DECLARE @dwMonthSignDates INT
	SELECT @dwMonthSignDates=COUNT(*) FROM QPRecordDB.dbo.RecordSignin WHERE DATEDIFF(MONTH,InputDate,GETDATE())=0
	
	-- 查询累积签到奖励
	DECLARE @lSignCountReward BIGINT
	SELECT @lSignCountReward=RewardGold FROM QPPlatformDB.dbo.SigninConfigCount WHERE DayID=@dwMonthSignDates+1
	IF @lSignCountReward IS NULL SET @lSignCountReward=0
	
	-- 查询签到前金豆
	DECLARE @OldScore BIGINT
	SELECT @OldScore=Score FROM QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo WHERE UserID = @dwUserID
	IF @OldScore=0 OR @OldScore IS NULL
		SET @OldScore=0
	

	-- 奖励金豆	
	UPDATE QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo SET Score = Score + @lRewardGold + @lSignCountReward WHERE UserID = @dwUserID
	IF @@rowcount = 0
	BEGIN
		-- 插入资料
		INSERT INTO QPTreasureDB.dbo.GameScoreInfo (UserID,Score, LastLogonIP, LastLogonMachine, RegisterIP, RegisterMachine)
		VALUES (@dwUserID, @lRewardGold+@lSignCountReward, @strClientIP, @strMachineID, @strClientIP, @strMachineID)
	END

	-- 得到签到后金豆
	DECLARE @NewScore BIGINT
	SELECT @NewScore=Score FROM QPTreasureDB.dbo.GameScoreInfo WHERE UserID = @dwUserID
	IF @NewScore=0 OR @NewScore IS NULL
		SET @NewScore=0
	

	-- 写入记录
	
	INSERT INTO QPRecordDB.dbo.RecordSignin (UserID,RewardGold, ClientID, InputDate,OldGold,NewGold)
	VALUES (@dwUserID, @lRewardGold,'',GetDate(),@OldScore,@NewScore)
	
	-- 累积签到记录
	IF @lSignCountReward<>0
	BEGIN
		INSERT INTO QPRecordDB.dbo.RecordSigninRewardCount(UserID,RewardGold,CountDate,ClientID,InputDate,OldGold,NewGold)
		VALUES(@dwUserID,@lSignCountReward,@dwMonthSignDates+1,'',GETDATE(),@OldScore,@NewScore)
	END
	
	-- 查询金豆
	DECLARE @lScore BIGINT	
	SELECT @lScore=Score FROM QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo WHERE UserID = @dwUserID 	
	IF @lScore IS NULL SET @lScore = 0
	
	-- 抛出数据
	SELECT @lScore AS Score	
END

RETURN 0


GO

----------------------------------------------------------------------------------------------------
