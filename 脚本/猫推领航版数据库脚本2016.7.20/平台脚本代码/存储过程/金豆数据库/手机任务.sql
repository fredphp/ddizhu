
----------------------------------------------------------------------------------------------------

USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PW_GetUserCanLotteryNum]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PW_GetUserCanLotteryNum]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_GetUserPayFirst]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_GetUserPayFirst]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_GetRedPackage]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_GetRedPackage]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_GrabRedPackage]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_GrabRedPackage]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
CREATE PROC NET_PW_GetUserCanLotteryNum
	-- Add the parameters for the stored procedure here
	@dwUserID INT
WITH ENCRYPTION AS
BEGIN

	DECLARE @MemberOrder	int   --会员等级
	DECLARE @SysCounts	int		--等级对应	系统设置的抽奖次数 
	DECLARE @WastTimes	int		--等级对应	系统设置的抽奖时间花费
	DECLARE @DayPlayCount int			--今天摇奖次数
	DECLARE @DayPlayTime int	--今天游戏时间
	DECLARE @dCounts INT

	DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)

	-- 查询会员等级	
	SELECT	@MemberOrder=MemberOrder FROM QPAccountsDB.dbo.AccountsInfo  WHERE UserID=@dwUserID
	
	-- 一天可以摇奖次数
	SELECT  @SysCounts=Times,@WastTimes=WastTime FROM DayLotterMemberConfig where member=@MemberOrder
	
	-- 今天摇奖次数
	SELECT @DayPlayCount=COUNT(*) FROM GameRELotteryRecord WHERE UserID=@dwUserID AND CAST(CAST(CollectDate AS FLOAT) AS INT)=@DateID
	IF @DayPlayCount IS NULL
		SET @DayPlayCount=0
		
	-- 今天游戏时间
	SELECT @DayPlayTime = SUM(PlayTimeCount) FROM RecordDrawScore(NOLOCK) WHERE UserID=@dwUserID AND CAST(CAST(InsertTime AS FLOAT) AS INT)=@DateID
	--SELECT  @DayPlayTime=isnull(PlayTime ,0) FROM DayPlayTimeInfo where DTid=@DateID and UserID =@dwUserID
	IF @DayPlayTime IS NULL
		SET @DayPlayTime=0
	
	
	-- 摇奖次数已经等于一天可以摇奖次数
	IF @SysCounts<=@DayPlayCount
	BEGIN
		SET @dCounts=0
		SELECT @dCounts AS Counts,@DayPlayTime AS DayPlayTime
		RETURN 0
	END
	
	-- 游戏时间不足以再抽一次奖
	IF (@WastTimes+1)*@DayPlayCount>=@DayPlayTime
	BEGIN
		SET @dCounts=0
		SELECT @dCounts AS Counts,@DayPlayTime AS DayPlayTime
		RETURN 0
	END
	
	-- 游戏时间超过最多抽奖次数所需时间
	IF (@WastTimes*@SysCounts)<=@DayPlayTime
	BEGIN
		SET @dCounts=@SysCounts-@DayPlayCount
		SELECT @dCounts AS Counts,@DayPlayTime AS DayPlayTime
		RETURN 0
	END
	
	-- 游戏时间不超过最多抽奖次数
	DECLARE @hasTime INT
	SET @hasTime=@DayPlayTime-@WastTimes*@DayPlayCount
	SET @dCounts = @hasTime/@WastTimes
	SELECT @dCounts AS Counts,@DayPlayTime AS DayPlayTime
	RETURN 0
END
go
----------------------------------------------------------------------------------------------------
CREATE PROC GSP_MB_GetUserPayFirst
	@dwUserID INT
WITH ENCRYPTION AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @HasTime BIGINT -- 活动还剩多少天
	DECLARE @UserPayFirst INT	-- 该用户是否可以享受首充活动 0 不能 1 可以

    -- 判断是否首充
	DECLARE @ActivityID INT
	SELECT @ActivityID=ActivityID FROM PayFirst WHERE BeginTime<GETDATE() AND EndTime>=GETDATE() AND Status=0
	IF @ActivityID IS NOT NULL AND @ActivityID>0
	BEGIN
		DECLARE @BeginTime DATETIME
		DECLARE @EndTime DATETIME
		DECLARE @DetailID INT
		SELECT @BeginTime=BeginTime,@EndTime=EndTime FROM PayFirst WHERE ActivityID=@ActivityID
		SET @HasTime=DATEDIFF(SECOND,GETDATE(),@EndTime)
		SELECT @DetailID=DetailID FROM ShareDetailInfo WHERE UserID=@dwUserID AND ApplyDate>@BeginTime AND ApplyDate<@EndTime
		IF @DetailID IS NOT NULL
			SET @UserPayFirst=0
		ELSE
			SET @UserPayFirst=1
	END
	ELSE
	BEGIN
		SET @HasTime=0
		SET @UserPayFirst=0
	END
	
	SELECT @HasTime AS HasTime,@UserPayFirst AS Statu
END

GO
----------------------------------------------------------------------------------------------------
CREATE PROC GSP_MB_GetRedPackage
	@dwUserID INT, -- 用户编号
	@returnStr NVARCHAR(127) OUTPUT
WITH ENCRYPTION AS
BEGIN
	DECLARE @DayNow DATETIME
	DECLARE @dwHasTime NVARCHAR(127)
	SET @DayNow=GETDATE()
	
	IF @DayNow>=cast(convert(varchar(10),getdate(),120)+' 10:00:00' as datetime) AND @DayNow<cast(convert(varchar(10),getdate(),120)+' 22:00:00' as datetime)
	BEGIN
		SET @dwHasTime=Convert(NVARCHAR(127),DATEDIFF(Second,GETDATE(),cast(convert(varchar(10),getdate(),120)+' 22:00:00' as datetime)))
	END
	ELSE
	BEGIN
		IF @DayNow>cast(convert(varchar(10),getdate(),120)+' 00:00:00' as datetime)
		BEGIN
			SET @dwHasTime=Convert(NVARCHAR(127),DATEDIFF(Second,GETDATE(),cast(convert(varchar(10),getdate(),120)+' 10:00:00' as datetime)))
		END
		ELSE
		BEGIN
			SET @dwHasTime=Convert(NVARCHAR(127),DATEDIFF(Second,GETDATE(),cast(convert(varchar(10),DATEADD(d,1,getdate()),120)+' 10:00:00' as datetime)))
		END
	END
	
	SET @returnStr=@dwHasTime
	
	CREATE TABLE Temp_A
	(
		ID INT,
		HasScore DECIMAL(18,2),
		Statu INT DEFAULT(0) -- 0 不能抢  1 可以抢
	)
	
	INSERT INTO Temp_A(ID,HasScore) SELECT RedPackageID,HasScore FROM RedPackage
	
	DECLARE @RID INT
	DECLARE @RScore DECIMAL(18,2)
	DECLARE @Statu INT
	
	IF @DayNow>=cast(convert(varchar(10),getdate(),120)+' 10:00:00' as datetime) AND @DayNow<cast(convert(varchar(10),getdate(),120)+' 22:00:00' as datetime)
	BEGIN
		WHILE EXISTS(SELECT ID FROM Temp_A)
		BEGIN
			SET ROWCOUNT 1
			SELECT @RID=ID,@RScore=HasScore FROM Temp_A
			SET ROWCOUNT 0
			DELETE FROM Temp_A WHERE ID=@RID

			SET @Statu=1			

			IF Exists(SELECT RedPackageID FROM RecordRedPackage WHERE RedPackageID=@RID AND UserID=@dwUserID AND InsertTime>=cast(convert(varchar(10),getdate(),120)+' 10:00:00' as datetime) AND InsertTime<=cast(convert(varchar(10),getdate(),120)+' 22:00:00' as datetime))
			BEGIN
				SET @Statu=0
			END
			
			IF @RScore<=0
			BEGIN
				SET @Statu=0
			END
			
			SET @returnStr=@returnStr+'|'+CONVERT(NVARCHAR(100),@RID)+','+CONVERT(NVARCHAR(100),@RScore)+','+CONVERT(NVARCHAR(100),@Statu)
		END
	END
	ELSE
	BEGIN
		WHILE EXISTS(SELECT ID FROM Temp_A)
		BEGIN
			SET ROWCOUNT 1
			SELECT @RID=ID,@RScore=HasScore FROM Temp_A
			SET ROWCOUNT 0
			DELETE FROM Temp_A WHERE ID=@RID
			
			SET @Statu=1

			IF @DayNow>cast(convert(varchar(10),getdate(),120)+' 00:00:00' as datetime)
			BEGIN
				IF Exists(SELECT RedPackageID FROM RecordRedPackage WHERE RedPackageID=@RID AND UserID=@dwUserID AND InsertTime>=cast(convert(varchar(10),DATEADD(d,-1,getdate()),120)+' 22:00:00' as datetime) AND InsertTime<=cast(convert(varchar(10),getdate(),120)+' 10:00:00' as datetime))
				BEGIN
					SET @Statu=0
				END
			END
			ELSE
			BEGIN
				IF Exists(SELECT RedPackageID FROM RecordRedPackage WHERE RedPackageID=@RID AND UserID=@dwUserID AND InsertTime>=cast(convert(varchar(10),DATEADD(d,-1,getdate()),120)+' 22:00:00' as datetime) AND InsertTime<=cast(convert(varchar(10),getdate(),120)+' 10:00:00' as datetime))
				BEGIN
					SET @Statu=0
				END
			END
			
			IF @RScore<=0
			BEGIN
				SET @Statu=0
			END
			
			SET @returnStr=@returnStr+'|'+CONVERT(NVARCHAR(100),@RID)+','+CONVERT(NVARCHAR(100),@RScore)+','+CONVERT(NVARCHAR(100),@Statu)
		END
	END
	
	SET @returnStr=@returnStr+'#'
	
	SELECT @returnStr AS StrReturn
	
	DROP TABLE Temp_A
END

GO
----------------------------------------------------------------------------------------------------
CREATE PROC GSP_MB_GrabRedPackage
	@dwUserID INT,
	@strPassword nchar(32),
	@dwRedPackageID INT,
	@strErrorDescribe NVARCHAR(127) OUTPUT
WITH ENCRYPTION AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- 变量定义
	DECLARE @UserID INT
	DECLARE @Accounts NVARCHAR(31)
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
	DECLARE @LogonPass AS NCHAR(32)
	
	-- 查询用户
	SELECT @UserID=UserID, @Accounts=Accounts, @LogonPass=LogonPass, @Nullity=Nullity, @StunDown=StunDown
	FROM QPAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE UserID=@dwUserID

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
	
	
	DECLARE @RedPackageID INT
	DECLARE @TotalScore DECIMAL(18,2)
	DECLARE @UseScore DECIMAL(18,2)
	DECLARE @HasScore DECIMAL(18,2)
	
	--红包查询
	SELECT @RedPackageID=RedPackageID,@TotalScore=TotalScore,@UseScore=UseScore,@HasScore=HasScore FROM RedPackage WHERE RedPackageID=@dwRedPackageID
	IF @RedPackageID IS NULL OR @RedPackageID<0
	BEGIN
		SET @strErrorDescribe=N'系统错误！'
		RETURN 4
	END
	IF @HasScore<=0
	BEGIN
		SET @strErrorDescribe=N'抱歉，该红包已被抢完！'
		RETURN 5
	END
	
	DECLARE @DayNow DATETIME
	SET @DayNow=GETDATE()
	
	IF @DayNow>=cast(convert(varchar(10),getdate(),120)+' 10:00:00' as datetime) AND @DayNow<cast(convert(varchar(10),getdate(),120)+' 22:00:00' as datetime)
	BEGIN
		IF Exists(SELECT RedPackageID FROM RecordRedPackage WHERE RedPackageID=@RedPackageID AND UserID=@dwUserID AND InsertTime>=cast(convert(varchar(10),getdate(),120)+' 10:00:00' as datetime) AND InsertTime<=cast(convert(varchar(10),getdate(),120)+' 22:00:00' as datetime))
		BEGIN
			SET @strErrorDescribe=N'您在该时间段内已经抢过红包了！'
			RETURN 6
		END
	END
	ELSE
	BEGIN
		IF @DayNow>cast(convert(varchar(10),getdate(),120)+' 00:00:00' as datetime)
		BEGIN
			IF Exists(SELECT RedPackageID FROM RecordRedPackage WHERE RedPackageID=@RedPackageID AND UserID=@dwUserID AND InsertTime>=cast(convert(varchar(10),DATEADD(d,-1,getdate()),120)+' 22:00:00' as datetime) AND InsertTime<=cast(convert(varchar(10),getdate(),120)+' 10:00:00' as datetime))
			BEGIN
				SET @strErrorDescribe=N'您在该时间段内已经抢过红包了！'
				RETURN 6
			END
		END
		ELSE
		BEGIN
			IF Exists(SELECT RedPackageID FROM RecordRedPackage WHERE RedPackageID=@RedPackageID AND UserID=@dwUserID AND InsertTime>=cast(convert(varchar(10),DATEADD(d,-1,getdate()),120)+' 22:00:00' as datetime) AND InsertTime<=cast(convert(varchar(10),getdate(),120)+' 10:00:00' as datetime))
			BEGIN
				SET @strErrorDescribe=N'您在该时间段内已经抢过红包了！'
				RETURN 6
			END
		END
	END
	
	DECLARE @MinScore DECIMAL(18,2)
	DECLARE @MaxScore DECIMAL(18,2)
	SET @MinScore=@TotalScore*0.3/100
	SET @MaxScore=@TotalScore*1/100
	
	DECLARE @GetScore DECIMAL(18,2)
	SET @GetScore = CAST(FLOOR(RAND()*(@MaxScore-@MinScore)) AS DECIMAL(18,2))
	SET @GetScore = @GetScore+@MinScore
	
	IF @GetScore>@HasScore
	BEGIN
		SET @GetScore=@HasScore
	END
	
	-- 金豆查询
	DECLARE @CurScore BIGINT
	DECLARE @CurInsure BIGINT
	SELECT @CurScore=Score,@CurInsure=InsureScore FROM GameScoreInfo WHERE UserID=@UserID
	
	-- 写入记录
	INSERT INTO RecordRedPackage(RedPackageID,UserID,TotalScore,HasScore,Score,InsureScore,Grade,InsertTime)
	VALUES(@RedPackageID,@UserID,@TotalScore,@HasScore,@CurScore,@CurInsure,@GetScore,GETDATE())
	
	-- 修改红包
	UPDATE RedPackage SET UseScore=UseScore+@GetScore,HasScore=HasScore-@GetScore WHERE RedPackageID=@RedPackageID
	
	-- 加金豆
	UPDATE GameScoreInfo SET Score=Score+@GetScore WHERE UserID=@UserID
	
	SELECT @CurScore=Score FROM GameScoreInfo WHERE UserID=@UserID
	
	SELECT @GetScore AS GetScore ,@CurScore AS Score
END
RETURN 0

GO

----------------------------------------------------------------------------------------------------
