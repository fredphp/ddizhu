
----------------------------------------------------------------------------------------------------

USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteGameScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteGameScore]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteGameEndScore4Fish]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteGameEndScore4Fish]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteGameOneUserScore4Fish]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteGameOneUserScore4Fish]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteGameAllScore4Fish]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteGameAllScore4Fish]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 游戏写分
CREATE PROC GSP_GR_WriteGameScore
	-- 用户信息
	@dwUserID INT,								-- 用户 I D
	@dwDBQuestID INT,							-- 请求标识
	@dwInoutIndex INT,							-- 进出索引

	-- 变更成绩
	@lVariationScore BIGINT,					-- 用户分数
	@lVariationGrade BIGINT,					-- 用户成绩
	@lVariationInsure BIGINT,					-- 用户银行
	@lVariationRevenue BIGINT,					-- 游戏税收
	@lVariationWinCount INT,					-- 胜利盘数
	@lVariationLostCount INT,					-- 失败盘数
	@lVariationDrawCount INT,					-- 和局盘数
	@lVariationFleeCount INT,					-- 逃跑数目
	@lVariationUserMedal BIGINT,					-- 用户奖牌
	@lVariationExperience INT,					-- 用户经验
	@lVariationLoveLiness INT,					-- 用户魅力
	@dwVariationPlayTimeCount INT,					-- 游戏时间

	-- 附加信息
	@cbTaskForward TINYINT,						-- 任务跟进

	-- 属性信息	
	@wKindID INT,								-- 游戏 I D
	@wServerID INT,								-- 房间 I D
	@strClientIP NVARCHAR(15)					-- 连接地址
	,@isWriteEndScore int = 0					-- 捕鱼类型写分 0 只是插入记录不操作分数
												-- 捕鱼类型写分 1 对插入记录记录进行总合写分
												-- 程序捕鱼结束 2 写分特殊标示

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
  declare @Nowdate datetime=GETDATE()
  if exists(select 1 from QPAccountsDB.dbo.AccountsInfo where UserID=@dwUserID and IsAndroid=1)
    return 0
 
  if exists(select 1 from QPPlatformDB.dbo.GameGameItem where IsWriteScore=1 and GameID=(select GameID from QPPlatformDB.dbo.GameKindItem where KindID=@wKindID))
  BEGIN
	if @isWriteEndScore<>1
	begin
	  if(@isWriteEndScore<>2)
		set @dwVariationPlayTimeCount=0		 
	--SET XACT_ABORT ON--key
		INSERT INTO RecordFishInfo(UserID,KindID,ServerID,DBQuestID,InoutIndex,Score,Grade,Revenue,UserMedal,PlayTimeCount,RequestDate)
        VALUES(@dwUserID,@wKindID,@wServerID,@dwDBQuestID,@dwInoutIndex,@lVariationScore,@lVariationGrade ,@lVariationRevenue,0,@dwVariationPlayTimeCount,SYSDATETIME())
	--SET XACT_ABORT OFF 
		if(@isWriteEndScore=2)--离开房间清理 捕鱼类型写分类型数据
		exec GSP_GR_WriteGameEndScore4Fish @dwUserID,@wKindID,@wServerID,@strClientIP,@dwDBQuestID,@dwInoutIndex
		return 0
	end
  END


--////////////////////////////////////////////////////
	-- 请求次数
	IF EXISTS(SELECT 1 FROM RequestWriteRecord(NOLOCK) WHERE UserID=@dwUserID AND ServerID=@wServerID AND DBQuestID=@dwDBQuestID AND InoutIndex=@dwInoutIndex)
		RETURN 0
------------------------------------------------------11----------------------------------------------
------------------------------------------------------22----------------------------------------------
if(@isWriteEndScore=1 and @lVariationScore<>0 and exists(select 1 from QPPlatformDB.dbo.GameGameItem(nolock) where IsWriteScore=1 and GameID=(select GameID from QPPlatformDB.dbo.GameKindItem where KindID=@wKindID)))
begin
	declare @SystemTimeStart datetime ,@wDrawID int
	select @SystemTimeStart=EnterTime from RecordUserInout where UserID=@dwUserID and KindID=@wKindID and ServerID=@wServerID and ID=@dwInoutIndex
	--插入捕鱼类型写分类型 记录
	INSERT RecordDrawInfo(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime) 
	VALUES(@wKindID,@wServerID,0,1,1,-@lVariationScore,@lVariationRevenue,0,@SystemTimeStart,@Nowdate)

	-- 读取记录
	SELECT @wDrawID=SCOPE_IDENTITY()
	exec GSP_GR_RecordDrawScore @wDrawID,@dwUserID,100,0,@dwInoutIndex,@lVariationScore,0 ,@lVariationRevenue,0,@dwVariationPlayTimeCount
end 
---------------------------------------------------11-------------------------------------------------
---------------------------------------------------22-------------------------------------------------

	---------------------------------- 增加错误记录----------------------------------------------------
	DECLARE @Score BIGINT
	SELECT @Score=Score FROM GameScoreInfo(NOLOCK) WHERE UserID=@dwUserID
	IF @Score+@lVariationScore<0
	BEGIN
		INSERT INTO RecordWriteScoreError(UserID,KindID,ServerID,UserScore,Score)
		VALUES(@dwUserID,@wKindID,@wServerID,@Score,@lVariationScore)
	END
	---------------------------------------------------------------------------------------------------
 
	DECLARE @CurPlayTime int
	SELECT @CurPlayTime=PlayTimeCount FROM GameScoreInfo WHERE UserID=@dwUserID

	-- 用户积分
	UPDATE GameScoreInfo SET Score=Score+@lVariationScore, Revenue=Revenue+@lVariationRevenue, InsureScore=InsureScore+@lVariationInsure,
		WinCount=WinCount+@lVariationWinCount, LostCount=LostCount+@lVariationLostCount, DrawCount=DrawCount+@lVariationDrawCount,
		FleeCount=FleeCount+@lVariationFleeCount, PlayTimeCount=PlayTimeCount+@dwVariationPlayTimeCount
	WHERE UserID=@dwUserID
	
	-- 记录请求次数
	INSERT RequestWriteRecord(UserID,ServerID,DBQuestID,InoutIndex,RequestDate)
	VALUES (@dwUserID,@wServerID,@dwDBQuestID,@dwInoutIndex,sysdatetime())

	-- 全局信息
	IF @lVariationExperience>0 OR @lVariationLoveLiness<>0 OR @lVariationUserMedal>0
	BEGIN
		UPDATE QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo SET Experience=Experience+@lVariationExperience, LoveLiness=LoveLiness+@lVariationLoveLiness,UserMedal=UserMedal+@lVariationUserMedal
		WHERE UserID=@dwUserID
	END

	-- 变更记录
	DECLARE @DateID INT
    SELECT @DateID=CAST(CAST(GetDate() AS FLOAT) AS INT) 
	
	-- 存在判断
	IF NOT EXISTS(SELECT * FROM StreamScoreInfo WHERE DateID=@DateID AND UserID=@dwUserID) 
	BEGIN
		-- 插入记录
		INSERT INTO StreamScoreInfo(DateID, UserID, WinCount, LostCount, Revenue, PlayTimeCount, OnlineTimeCount, FirstCollectDate, LastCollectDate)
		VALUES(@DateID, @dwUserID, @lVariationWinCount, @lVariationLostCount, @lVariationRevenue, @dwVariationPlayTimeCount, 0, GetDate(), GetDate())		
	END ELSE
	BEGIN
		-- 更新记录
		UPDATE StreamScoreInfo SET WinCount=WinCount+@lVariationWinCount, LostCount=LostCount+@lVariationLostCount, Revenue=Revenue+@lVariationRevenue,PlayTimeCount=PlayTimeCount+@dwVariationPlayTimeCount, LastCollectDate=GetDate()
		WHERE DateID=@DateID AND UserID=@dwUserID		
	END
		
	-- 任务跟进
	IF @cbTaskForward=1
	BEGIN
		exec QPPlatformDBLink.QPPlatformDB.dbo.GSP_GR_TaskForward @dwUserID,@wKindID,0,@lVariationWinCount,@lVariationLostCount,@lVariationDrawCount	
	END

	--代理下级玩家成为有效会员
	DECLARE @AgencyID1 int
	SELECT @AgencyID1=AgencyID FROM QPAgencyDB.dbo.Agency_User WHERE UserID=@dwUserID
	IF @AgencyID1 IS NOT NULL
	BEGIN
		DECLARE @DateId1 int
		DECLARE @CanUserTime int
		DECLARE @PlayTimeNew int
		SELECT @PlayTimeNew = PlayTimeCount FROM GameScoreInfo WHERE UserID=@dwUserID
		SELECT @CanUserTime=UserPlayTime FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@AgencyID1
		SET @DateId1 = CAST(CAST(GETDATE() AS FLOAT) AS INT)
		
		IF @CurPlayTime<@CanUserTime AND @PlayTimeNew>=@CanUserTime
		BEGIN
			UPDATE QPAgencyDB.dbo.UserPlay SET CanUserCounts=CanUserCounts+1 WHERE DateID=@DateId1 AND AgencyID=@AgencyID1
			IF @@ROWCOUNT=0
			BEGIN
				INSERT INTO QPAgencyDB.dbo.UserPlay(DateID,AgencyID,RegisterCounts,CanUserCounts)
					VALUES(@DateId1,@AgencyID1,0,1)
			END
			
			DECLARE @CanUserGrantGold decimal(18,2)
			SELECT @CanUserGrantGold=UserPrice FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@AgencyID1
			UPDATE QPAgencyDB.dbo.AgencyInfo SET AgencyGold=AgencyGold+@CanUserGrantGold WHERE AgencyID=@AgencyID1
		END 
	END
	
	
	--代理
	IF @lVariationRevenue>0
	BEGIN
		DECLARE @AgencyID int
		SELECT @AgencyID=AgencyID FROM QPAgencyDB.dbo.Agency_User WHERE UserID=@dwUserID
		IF @AgencyID IS NOT NULL
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
			SELECT @selfRoty=AgencyRoyalty  FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
			SELECT @selfFlag=AgencyFlag FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
			
			IF @selfFlag=0
			BEGIN
				INSERT INTO QPAgencyDB.dbo.RecordRoyalty(AgencyID,UserID,UserWin,RoyaltyTotal,RoyaltyRatio,RoyaltyTime,RoyaltyGold,Remark)
					VALUES(@AgencyID,@dwUserID,@lVariationScore,@lVariationRevenue,@selfRoty,GETDATE(),@lVariationRevenue*@selfRoty/100,N'游戏抽水')
				UPDATE QPAgencyDB.dbo.AgencyInfo SET AgencyGold=AgencyGold+@lVariationRevenue*@selfRoty/100 WHERE AgencyID=@AgencyID
			END
			
			SET @Son=@self
			
			WHILE @Count<5
			BEGIN	
				SELECT @self=AgencyParentID FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@Son
				IF @self<>0
				BEGIN
					IF @self IS NOT NULL
					BEGIN
						SELECT @SonRoty=AgencyRoyalty  FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@Son
						SELECT @selfRoty=AgencyRoyalty  FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
						SELECT @selfFlag=AgencyFlag FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
						SET @selfRoty=@selfRoty-@SonRoty
						IF @selfFlag=0
						BEGIN
							INSERT INTO QPAgencyDB.dbo.RecordRoyalty(AgencyID,UserID,UserWin,RoyaltyTotal,RoyaltyRatio,RoyaltyTime,RoyaltyGold,Remark,RoyaltyType)
								VALUES(@self,@dwUserID,@lVariationScore,@lVariationRevenue,@selfRoty,GETDATE(),@lVariationRevenue*@selfRoty/100,N'游戏抽水',0)
							UPDATE QPAgencyDB.dbo.AgencyInfo SET AgencyGold=AgencyGold+@lVariationRevenue*@selfRoty/100 WHERE AgencyID=@self
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
	END
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 捕魚游戏退出時写分
CREATE PROC GSP_GR_WriteGameEndScore4Fish
	-- 系统信息
	@dwUserID int,								-- 用户 I D
	-- 属性信息
	@wKindID int,								-- 游戏 I D
	@wServerID int,								-- 房间 I D
	@strClientIP varchar(15),					-- 连接地址
	@dwDBQuestID int,							-- 请求标识
	@dwInoutIndex  int							-- 进出标识
WITH ENCRYPTION AS
-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	declare @RC int,
			@lVariationScore bigint,			-- 用户分数
			@lVariationInsure bigint,			-- 用户银行
			@lVariationRevenue bigint,			-- 游戏税收
			@lVariationUserMedal bigint,		-- 用户奖牌 
			@lVariationWinCount int,			-- 胜利盘数
			@lVariationLostCount int,			-- 失败盘数
			@lVariationDrawCount int,			-- 和局盘数
			@lVariationFleeCount int,			-- 断线数目
			@lVariationExperience int,			-- 用户经验
			@dwVariationPlayTimeCount int;		-- 游戏时间
			
	select * into #temp_tx from RecordFishInfo where UserID=@dwUserID and KindID=@wKindID and ServerID=@wServerID;
	
	select @lVariationScore=sum(Score),@lVariationRevenue=sum(Revenue),@lVariationUserMedal=0,
		@lVariationWinCount=case when sum(Score)>0 then 1 else  0 end,@lVariationLostCount=case when sum(Score)<0 then 1 else  0 end,
		@lVariationDrawCount=case when sum(Score)=0 then 1 else  0 end,@lVariationFleeCount=0,
		@dwVariationPlayTimeCount=sum(PlayTimeCount)
	from #temp_tx group by UserID,KindID,ServerID;
 
	delete r from RecordFishInfo r join #temp_tx t on r.UserID=t.UserID and r.KindID=t.KindID and r.ServerID=t.ServerID and r.DBQuestID=t.DBQuestID and r.InoutIndex=t.InoutIndex;
	if(@@ROWCOUNT>0)
	  exec @RC=GSP_GR_WriteGameScore @dwUserID,@dwDBQuestID,@dwInoutIndex,@lVariationScore,@lVariationInsure,@lVariationRevenue,@lVariationUserMedal,@lVariationWinCount,@lVariationLostCount,@lVariationDrawCount,@lVariationFleeCount,@lVariationExperience,@dwVariationPlayTimeCount,@wKindID,@wServerID,@strClientIP,1;
	return @RC;
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------
CREATE PROC GSP_GR_WriteGameOneUserScore4Fish
@dwUserID INT
WITH ENCRYPTION AS
-- 属性设置
SET NOCOUNT ON
-- 执行逻辑
BEGIN
	declare-- @dwUserID int,							-- 用户 I D
			-- 属性信息
			@wKindID int,								-- 游戏 I D
			@wServerID int,								-- 房间 I D
			@strClientIP binary(4),						-- 连接地址
			@dwDBQuestID int,							-- 请求标识
			@dwInoutIndex  int,							-- 进出标识
			-- 变更成绩
			@lVariationScore bigint,					-- 用户分数
			@lVariationInsure bigint,					-- 用户银行
			@lVariationRevenue bigint,					-- 游戏税收
			@lVariationUserMedal bigint,				-- 用户奖牌 
			@lVariationWinCount int,					-- 胜利盘数
			@lVariationLostCount int,					-- 失败盘数
			@lVariationDrawCount int,					-- 和局盘数
			@lVariationFleeCount int,					-- 断线数目
			@lVariationExperience int,					-- 用户经验
			@dwVariationPlayTimeCount int;				-- 游戏时间
			
	--;with t_x as(select * from GameRecord4Fish)
	select * into #Temp from RecordFishInfo where UserID=@dwUserID
	
	declare g_cursor cursor for select UserID,KindID,ServerID,sum(Score),0,sum(Revenue),0,case when sum(Score)>0 then 1 else  0 end,case when sum(Score)<0 then 1 else  0 end,case when sum(Score)=0 then 1 else  0 end,0,0,sum(PlayTimeCount),max(DBQuestID),max(InoutIndex)
								  from #Temp
						 	  group by UserID,KindID,ServerID
							    having datediff(mi,max(RequestDate),sysdatetime())>3;
	open g_cursor;
	
	fetch next from g_cursor into @dwUserID,@wKindID,@wServerID,@lVariationScore,@lVariationInsure,@lVariationRevenue,@lVariationUserMedal,@lVariationWinCount,@lVariationLostCount,@lVariationDrawCount,@lVariationFleeCount,@lVariationExperience,@dwVariationPlayTimeCount,@dwDBQuestID,@dwInoutIndex;
	while @@FETCH_STATUS=0
	begin
		delete r from RecordFishInfo r join #Temp t on r.UserID=t.UserID and r.KindID=t.KindID and r.ServerID=t.ServerID and r.DBQuestID=t.DBQuestID and r.InoutIndex=t.InoutIndex where r.UserID=@dwUserID and r.KindID=@wKindID and r.ServerID=@wServerID;
		if(@@ROWCOUNT>0)
		  exec GSP_GR_WriteGameScore @dwUserID,@dwDBQuestID,@dwInoutIndex,@lVariationScore,@lVariationInsure,@lVariationRevenue,@lVariationUserMedal,@lVariationWinCount,@lVariationLostCount,@lVariationDrawCount,@lVariationFleeCount,@lVariationExperience,@dwVariationPlayTimeCount,@wKindID,@wServerID,@strClientIP,1;

		fetch next from g_cursor into @dwUserID,@wKindID,@wServerID,@lVariationScore,@lVariationInsure,@lVariationRevenue,@lVariationUserMedal,@lVariationWinCount,@lVariationLostCount,@lVariationDrawCount,@lVariationFleeCount,@lVariationExperience,@dwVariationPlayTimeCount,@dwDBQuestID,@dwInoutIndex;
  	end
	close g_cursor;
	deallocate g_cursor;
	delete #Temp
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------
CREATE PROC GSP_GR_WriteGameAllScore4Fish
WITH ENCRYPTION AS
-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	declare @dwUserID int,								-- 用户 I D
			-- 属性信息
			@wKindID int,								-- 游戏 I D
			@wServerID int,								-- 房间 I D
			@strClientIP binary(4),						-- 连接地址
			@dwDBQuestID int,							-- 请求标识
			@dwInoutIndex  int,							-- 进出标识
			-- 变更成绩
			@lVariationScore bigint,					-- 用户分数
			@lVariationInsure bigint,					-- 用户银行
			@lVariationRevenue bigint,					-- 游戏税收
			@lVariationUserMedal bigint,				-- 用户奖牌 
			@lVariationWinCount int,					-- 胜利盘数
			@lVariationLostCount int,					-- 失败盘数
			@lVariationDrawCount int,					-- 和局盘数
			@lVariationFleeCount int,					-- 断线数目
			@lVariationExperience int,					-- 用户经验
			@dwVariationPlayTimeCount int;				-- 游戏时间
			
	--;with t_x as(select * from GameRecord4Fish)
	select * into #Temp from RecordFishInfo
	
	declare g_cursor cursor for select UserID,KindID,ServerID,
		sum(Score),0,sum(Revenue),0,
		case when sum(Score)>0 then 1 else  0 end,
		case when sum(Score)<0 then 1 else  0 end,
		case when sum(Score)=0 then 1 else  0 end,
		0,
		0,sum(PlayTimeCount),
		max(DBQuestID),max(InoutIndex)
		from #Temp
	group by UserID,KindID,ServerID
	  having datediff(mi,max(RequestDate),sysdatetime())>3;
		 

	open g_cursor;
		fetch next from g_cursor into @dwUserID,@wKindID,@wServerID,@lVariationScore,@lVariationInsure,@lVariationRevenue,
		@lVariationUserMedal,@lVariationWinCount,@lVariationLostCount,@lVariationDrawCount,@lVariationFleeCount,@lVariationExperience,@dwVariationPlayTimeCount,@dwDBQuestID,@dwInoutIndex;
	while @@FETCH_STATUS=0
	begin
		delete r from RecordFishInfo r join #Temp t on r.UserID=t.UserID and r.KindID=t.KindID and r.ServerID=t.ServerID and r.DBQuestID=t.DBQuestID and r.InoutIndex=t.InoutIndex where r.UserID=@dwUserID and r.KindID=@wKindID and r.ServerID=@wServerID;
		if(@@ROWCOUNT>0)
			exec GSP_GR_WriteGameScore @dwUserID,@dwDBQuestID,@dwInoutIndex,@lVariationScore,@lVariationInsure,@lVariationRevenue,@lVariationUserMedal,@lVariationWinCount,@lVariationLostCount,@lVariationDrawCount,@lVariationFleeCount,@lVariationExperience,@dwVariationPlayTimeCount,@wKindID,@wServerID,@strClientIP,1;

		fetch next from g_cursor into @dwUserID,@wKindID,@wServerID,@lVariationScore,@lVariationInsure,@lVariationRevenue,
		@lVariationUserMedal,@lVariationWinCount,@lVariationLostCount,@lVariationDrawCount,@lVariationFleeCount,@lVariationExperience,@dwVariationPlayTimeCount,@dwDBQuestID,@dwInoutIndex;
 
	  	end
		close g_cursor;
	deallocate g_cursor;
	delete #Temp
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------