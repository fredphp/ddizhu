----------------------------------------------------------------------
-- 时间：2011-09-29
-- 用途：后台管理员添加用户信息
----------------------------------------------------------------------
USE QPGameMatchDB
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_InsertTimingMatch]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_InsertTimingMatch]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_InsertImmediateMatch]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_InsertImmediateMatch]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_UpdateTimingMatch]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_UpdateTimingMatch]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_UpdateImmediateMatch]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_UpdateImmediateMatch]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PM_InsertTimingMatch]
(
	@MatchID INT,						-- 比赛ID
	@MatchNo SMALLINT,					-- 比赛场次
	@MatchName NVARCHAR(50),			-- 比赛名称
	@MatchType TINYINT,					-- 比赛类型
	@MatchFeeType TINYINT,				-- 费用类型
	@MatchFee BIGINT,					-- 报名费用
	@MemberOrder TINYINT,				-- 会员要求
	@KindID	INT,						-- 类型标识

	@StartTime DATETIME,				-- 开始时间
	@EndTime DATETIME,					-- 结束时间
	@InitScore BIGINT,					-- 初始积分
	@CullScore BIGINT,					-- 淘汰积分
	@MinPlayCount INT,					-- 有效局数

	@MatchSummary NVARCHAR(256),		-- 比赛摘要
	@MatchContent NTEXT,				-- 比赛描述
	@IsRecommend BIT,					-- 是否推荐
	@SmallImageUrl NVARCHAR(512),		-- 展示小图	
	@BigImageUrl NVARCHAR(512),			-- 展示大图

	@RewardGold NVARCHAR(1000),			-- 奖励金豆
	@RewardMedal NVARCHAR(1000),		-- 奖励奖牌
	@RewardExperience NVARCHAR(1000),	-- 奖励经验	

	@strErrorDescribe NVARCHAR(127) OUTPUT		--输出信息
)
			
WITH ENCRYPTION AS

BEGIN
	IF EXISTS(SELECT MatchID FROM MatchPublic WHERE MatchName=@MatchName)
	BEGIN
		SET @strErrorDescribe='该比赛名称已存在，请更换另一个名称'
		RETURN -1
	END	

	-- 比赛ID
	IF @MatchID=0
	BEGIN
		SELECT @MatchID=Max(MatchID) FROM MatchPublic
		IF @MatchID IS NULL
			SET @MatchID=1
		ELSE 
			SET @MatchID=@MatchID+1
	END

	-- 开启事务回滚
	SET XACT_ABORT ON

	-- 开始事务
	BEGIN TRAN

	INSERT INTO MatchPublic(MatchID,MatchNo,KindID,MatchName,MatchType,MatchFeeType,MatchFee,MemberOrder,CollectDate)
	VALUES(@MatchID,@MatchNo,@KindID,@MatchName,@MatchType,@MatchFeeType,@MatchFee,@MemberOrder,GETDATE())

	INSERT INTO MatchLockTime(MatchID,MatchNo,StartTime,EndTime,InitScore,CullScore,MinPlayCount)
	VALUES(@MatchID,@MatchNo,@StartTime,@EndTime,@InitScore,@CullScore,@MinPlayCount)

	INSERT INTO MatchWebShow(MatchID,MatchNo,SmallImageUrl,BigImageUrl,MatchSummary,MatchContent,IsRecommend)
	VALUES(@MatchID,@MatchNo,@SmallImageUrl,@BigImageUrl,@MatchSummary,@MatchContent,@IsRecommend)

	-- 拆分奖励
	SELECT * INTO #tmpGold FROM dbo.WF_Split(@RewardGold,',')
	SELECT * INTO #tmpMedal FROM dbo.WF_Split(@RewardMedal,',')
	SELECT * INTO #tmpExperience FROM dbo.WF_Split(@RewardExperience,',')

	-- 插入奖励
	DECLARE @i INT,@Gold INT,@Medal INT,@Experience INT
	SELECT @i=COUNT(id) FROM #tmpGold
	WHILE @i>0
	BEGIN

		SELECT @Gold=rs FROM #tmpGold WHERE id=@i
		SELECT @Medal=rs FROM #tmpMedal WHERE id=@i
		SELECT @Experience=rs FROM #tmpExperience WHERE id=@i

		INSERT INTO MatchReward(MatchID,MatchNo,MatchRank,RewardGold,RewardMedal,RewardExperience,RewardDescibe)
		VALUES(@MatchID,@MatchNo,@i,@Gold,@Medal,@Experience,'')

		SET @i=@i-1
	END
	
	-- 删临时表
	DROP TABLE #tmpGold,#tmpMedal,#tmpExperience

	-- 提交事务
	COMMIT TRAN

	RETURN 0
END
GO

-------------------------------------------------------------------------
CREATE PROC [NET_PM_InsertImmediateMatch]
(
	@MatchNo SMALLINT,					-- 比赛场次
	@MatchName NVARCHAR(50),			-- 比赛名称
	@MatchType TINYINT,					-- 比赛类型
	@MatchFeeType TINYINT,				-- 费用类型
	@MatchFee BIGINT,					-- 报名费用
	@MemberOrder TINYINT,				-- 会员要求
	@KindID	INT,						-- 类型标识

	@StartUserCount INT,				-- 开始人数
	@AndriodUserCount INT,				-- 机器人数
	@InitialBase INT,					-- 游戏低分
	@InitialScore INT,					-- 开始积分
	@PlayCount INT,						-- 比赛局数
	@SwitchTableCount INT,				-- 换桌局数
	@PrecedeTimer INT,					-- 优先分配等待时间

	@MatchSummary NVARCHAR(256),		-- 比赛摘要
	@MatchContent NTEXT,				-- 比赛描述
	@IsRecommend BIT,					-- 是否推荐
	@SmallImageUrl NVARCHAR(512),		-- 展示小图	
	@BigImageUrl NVARCHAR(512),			-- 展示大图

	@RewardGold NVARCHAR(1000),			-- 奖励金豆
	@RewardMedal NVARCHAR(1000),		-- 奖励奖牌
	@RewardExperience NVARCHAR(1000),	-- 奖励经验	

	@strErrorDescribe NVARCHAR(127) OUTPUT		--输出信息
)

WITH ENCRYPTION AS
BEGIN

	IF EXISTS(SELECT MatchID FROM MatchPublic WHERE MatchName=@MatchName)
	BEGIN
		SET @strErrorDescribe='该比赛名称已存在，请更换另一个名称'
		RETURN -1
	END	

	DECLARE @MatchID INT
	SELECT @MatchID=Max(MatchID) FROM MatchPublic
	IF @MatchID IS NULL
		SET @MatchID=1
	ELSE 
		SET @MatchID=@MatchID+1

	-- 开启事务回滚
	SET XACT_ABORT ON

	-- 开始事务
	BEGIN TRAN

	INSERT INTO MatchPublic(MatchID,MatchNo,KindID,MatchName,MatchType,MatchFeeType,MatchFee,MemberOrder,CollectDate)
	VALUES(@MatchID,@MatchNo,@KindID,@MatchName,@MatchType,@MatchFeeType,@MatchFee,@MemberOrder,GETDATE())

	INSERT INTO MatchImmediate(MatchID,MatchNo,StartUserCount,AndroidUserCount,InitialBase,InitialScore,
		MinEnterGold,PlayCount,SwitchTableCount,PrecedeTimer)
	VALUES(@MatchID,@MatchNo,@StartUserCount,@AndriodUserCount,@InitialBase,@InitialScore,0,@PlayCount,
		@SwitchTableCount,@PrecedeTimer)

	INSERT INTO MatchWebShow(MatchID,MatchNo,SmallImageUrl,BigImageUrl,MatchSummary,MatchContent,IsRecommend)
	VALUES(@MatchID,@MatchNo,@SmallImageUrl,@BigImageUrl,@MatchSummary,@MatchContent,@IsRecommend)
	
	-- 拆分奖励
	SELECT * INTO #tmpGold FROM dbo.WF_Split(@RewardGold,',')
	SELECT * INTO #tmpMedal FROM dbo.WF_Split(@RewardMedal,',')
	SELECT * INTO #tmpExperience FROM dbo.WF_Split(@RewardExperience,',')

	-- 插入奖励
	DECLARE @i INT,@Gold INT,@Medal INT,@Experience INT
	SELECT @i=COUNT(id) FROM #tmpGold
	WHILE @i>0
	BEGIN

		SELECT @Gold=rs FROM #tmpGold WHERE id=@i
		SELECT @Medal=rs FROM #tmpMedal WHERE id=@i
		SELECT @Experience=rs FROM #tmpExperience WHERE id=@i

		INSERT INTO MatchReward(MatchID,MatchNo,MatchRank,RewardGold,RewardMedal,RewardExperience,RewardDescibe)
		VALUES(@MatchID,@MatchNo,@i,@Gold,@Medal,@Experience,'')

		SET @i=@i-1
	END
	
	-- 删临时表
	DROP TABLE #tmpGold,#tmpMedal,#tmpExperience

	-- 提交事务
	COMMIT TRAN

	RETURN 0
END
GO

-------------------------------------------------------------------------
CREATE PROC [NET_PM_UpdateTimingMatch]
(
	@MatchID INT,						-- 比赛ID
	@MatchNo SMALLINT,					-- 比赛场次
	@MatchName NVARCHAR(50),			-- 比赛名称
	@MatchType TINYINT,					-- 比赛类型
	@MatchFeeType TINYINT,				-- 费用类型
	@MatchFee BIGINT,					-- 报名费用
	@MemberOrder TINYINT,				-- 会员要求

	@StartTime DATETIME,				-- 开始时间
	@EndTime DATETIME,					-- 结束时间
	@InitScore BIGINT,					-- 初始积分
	@CullScore BIGINT,					-- 淘汰积分
	@MinPlayCount INT,					-- 有效局数

	@MatchSummary NVARCHAR(256),		-- 比赛摘要
	@MatchContent NTEXT,				-- 比赛描述
	@IsRecommend BIT,					-- 是否推荐
	@SmallImageUrl NVARCHAR(512),		-- 展示小图	
	@BigImageUrl NVARCHAR(512),			-- 展示大图

	@RewardGold NVARCHAR(1000),			-- 奖励金豆
	@RewardMedal NVARCHAR(1000),		-- 奖励奖牌
	@RewardExperience NVARCHAR(1000),	-- 奖励经验	
	
	@strErrorDescribe NVARCHAR(127) OUTPUT		--输出信息
)

WITH ENCRYPTION AS

BEGIN

	IF EXISTS(SELECT MatchID FROM MatchPublic WHERE MatchName=@MatchName AND MatchID!=@MatchID AND MatchNo!=@MatchNo)
	BEGIN
		SET @strErrorDescribe='该比赛名称已存在，请更换另一个名称'
		RETURN -1
	END	

	-- 开启事务回滚
	SET XACT_ABORT ON

	-- 开始事务
	BEGIN TRAN

	UPDATE MatchPublic SET MatchName=@MatchName,MatchType=@MatchType,MatchFeeType=@MatchFeeType,MatchFee=@MatchFee,MemberOrder=@MemberOrder
	WHERE MatchID=@MatchID AND MatchNo=@MatchNo

	UPDATE MatchLockTime SET StartTime=@StartTime,EndTime=@EndTime,InitScore=@InitScore,CullScore=@CullScore,MinPlayCount=@MinPlayCount
	WHERE MatchID=@MatchID AND MatchNo=@MatchNo

	UPDATE MatchWebShow SET SmallImageUrl=@SmallImageUrl,BigImageUrl=@BigImageUrl,MatchSummary=@MatchSummary,MatchContent=@MatchContent,IsRecommend=@IsRecommend
	WHERE MatchID=@MatchID AND MatchNo=@MatchNo

	-- 删除奖励
	DELETE MatchReward WHERE MatchID=@MatchID AND MatchNo=@MatchNo

	-- 拆分奖励
	SELECT * INTO #tmpGold FROM dbo.WF_Split(@RewardGold,',')
	SELECT * INTO #tmpMedal FROM dbo.WF_Split(@RewardMedal,',')
	SELECT * INTO #tmpExperience FROM dbo.WF_Split(@RewardExperience,',')

	-- 插入奖励
	DECLARE @i INT,@Gold INT,@Medal INT,@Experience INT
	SELECT @i=COUNT(id) FROM #tmpGold
	WHILE @i>0
	BEGIN

		SELECT @Gold=rs FROM #tmpGold WHERE id=@i
		SELECT @Medal=rs FROM #tmpMedal WHERE id=@i
		SELECT @Experience=rs FROM #tmpExperience WHERE id=@i

		INSERT INTO MatchReward(MatchID,MatchNo,MatchRank,RewardGold,RewardMedal,RewardExperience,RewardDescibe)
		VALUES(@MatchID,@MatchNo,@i,@Gold,@Medal,@Experience,'')

		SET @i=@i-1
	END
	
	-- 删临时表
	DROP TABLE #tmpGold,#tmpMedal,#tmpExperience

	-- 提交事务
	COMMIT TRAN

	RETURN 0
END
GO

----------------------------------------------------------------------
CREATE PROC [NET_PM_UpdateImmediateMatch]
(
	@MatchID INT,						-- 比赛标识
	@MatchNo SMALLINT,					-- 比赛场次
	@MatchName NVARCHAR(50),			-- 比赛名称
	@MatchType TINYINT,					-- 比赛类型
	@MatchFeeType TINYINT,				-- 费用类型
	@MatchFee BIGINT,					-- 报名费用
	@MemberOrder TINYINT,				-- 会员要求

	@StartUserCount INT,				-- 开始人数
	@AndriodUserCount INT,				-- 机器人数
	@InitialBase INT,					-- 游戏低分
	@InitialScore INT,					-- 开始积分
	@PlayCount INT,						-- 比赛局数
	@SwitchTableCount INT,				-- 换桌局数
	@PrecedeTimer INT,					-- 优先分配等待时间

	@MatchSummary NVARCHAR(256),		-- 比赛摘要
	@MatchContent NTEXT,				-- 比赛描述
	@IsRecommend BIT,					-- 是否推荐
	@SmallImageUrl NVARCHAR(512),		-- 展示小图	
	@BigImageUrl NVARCHAR(512),			-- 展示大图

	@RewardGold NVARCHAR(1000),			-- 奖励金豆
	@RewardMedal NVARCHAR(1000),		-- 奖励奖牌
	@RewardExperience NVARCHAR(1000),	-- 奖励经验	

	@strErrorDescribe NVARCHAR(127) OUTPUT		--输出信息
)

WITH ENCRYPTION AS
BEGIN

	IF EXISTS(SELECT MatchID FROM MatchPublic WHERE MatchName=@MatchName AND MatchID!=@MatchID)
	BEGIN
		SET @strErrorDescribe='该比赛名称已存在，请更换另一个名称'
		RETURN -1
	END	

	-- 开启事务回滚
	SET XACT_ABORT ON

	-- 开始事务
	BEGIN TRAN

	UPDATE MatchPublic SET MatchName=@MatchName,MatchType=@MatchType,MatchFeeType=@MatchFeeType,MatchFee=@MatchFee,MemberOrder=@MemberOrder
	WHERE MatchID=@MatchID AND MatchNo=@MatchNo

	UPDATE MatchImmediate SET StartUserCount=@StartUserCount,AndroidUserCount=@AndriodUserCount,InitialBase=@InitialBase,InitialScore=@InitialScore,
		PlayCount=@PlayCount,SwitchTableCount=@SwitchTableCount,PrecedeTimer=@PrecedeTimer
	WHERE MatchID=@MatchID AND MatchNo=@MatchNo

	UPDATE MatchWebShow SET SmallImageUrl=@SmallImageUrl,BigImageUrl=@BigImageUrl,MatchSummary=@MatchSummary,MatchContent=@MatchContent,IsRecommend=@IsRecommend
	WHERE MatchID=@MatchID AND MatchNo=@MatchNo

	-- 删除奖励
	DELETE MatchReward WHERE MatchID=@MatchID AND MatchNo=@MatchNo

	-- 拆分奖励
	SELECT * INTO #tmpGold FROM dbo.WF_Split(@RewardGold,',')
	SELECT * INTO #tmpMedal FROM dbo.WF_Split(@RewardMedal,',')
	SELECT * INTO #tmpExperience FROM dbo.WF_Split(@RewardExperience,',')

	-- 插入奖励
	DECLARE @i INT,@Gold INT,@Medal INT,@Experience INT
	SELECT @i=COUNT(id) FROM #tmpGold
	WHILE @i>0
	BEGIN

		SELECT @Gold=rs FROM #tmpGold WHERE id=@i
		SELECT @Medal=rs FROM #tmpMedal WHERE id=@i
		SELECT @Experience=rs FROM #tmpExperience WHERE id=@i

		INSERT INTO MatchReward(MatchID,MatchNo,MatchRank,RewardGold,RewardMedal,RewardExperience,RewardDescibe)
		VALUES(@MatchID,@MatchNo,@i,@Gold,@Medal,@Experience,'')

		SET @i=@i-1
	END
	
	-- 删临时表
	DROP TABLE #tmpGold,#tmpMedal,#tmpExperience

	-- 提交事务
	COMMIT TRAN

	RETURN 0
END
GO
