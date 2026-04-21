USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[DayPlayTimeInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[DayPlayTimeInfo]

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_WriteGameScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_WriteGameScore]

GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

--------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE [dbo].[DayPlayTimeInfo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[DTid] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[PlayTime] [bigint] NOT NULL,
	[inserttime] [datetime] NOT NULL,
	[updatetime] [datetime] NOT NULL,
 CONSTRAINT [PK_DayPlayTimeInfo] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'每天标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DayPlayTimeInfo', @level2type=N'COLUMN',@level2name=N'DTid'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用户标志' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DayPlayTimeInfo', @level2type=N'COLUMN',@level2name=N'UserID'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'游戏时长' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DayPlayTimeInfo', @level2type=N'COLUMN',@level2name=N'PlayTime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'记录时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DayPlayTimeInfo', @level2type=N'COLUMN',@level2name=N'inserttime'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'更新时间' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DayPlayTimeInfo', @level2type=N'COLUMN',@level2name=N'updatetime'
GO

ALTER TABLE [dbo].[DayPlayTimeInfo] ADD  CONSTRAINT [DF_Table_1_recordtiem]  DEFAULT (getdate()) FOR [inserttime]
GO

ALTER TABLE [dbo].[DayPlayTimeInfo] ADD  CONSTRAINT [DF_DayPlayTimeInfo_updatetime]  DEFAULT (getdate()) FOR [updatetime]
GO

--------------------------------------------------------------------------------------------------------------------------------------------

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
	@dwVariationPlayTimeCount INT,				-- 游戏时间

	-- 附加信息
	@cbTaskForward TINYINT,						-- 任务跟进

	-- 属性信息	
	@wKindID INT,								-- 游戏 I D
	@wServerID INT,								-- 房间 I D
	@strClientIP NVARCHAR(15)					-- 连接地址

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	-- 用户积分
	UPDATE GameScoreInfo SET Score=Score+@lVariationScore, Revenue=Revenue+@lVariationRevenue, InsureScore=InsureScore+@lVariationInsure,
		WinCount=WinCount+@lVariationWinCount, LostCount=LostCount+@lVariationLostCount, DrawCount=DrawCount+@lVariationDrawCount,
		FleeCount=FleeCount+@lVariationFleeCount, PlayTimeCount=PlayTimeCount+@dwVariationPlayTimeCount
	WHERE UserID=@dwUserID

	-- 全局信息
	IF @lVariationExperience>0 OR @lVariationLoveLiness<>0 OR @lVariationUserMedal>0
	BEGIN
		UPDATE QPAccountsDB.dbo.AccountsInfo SET Experience=Experience+@lVariationExperience, LoveLiness=LoveLiness+@lVariationLoveLiness,
			UserMedal=UserMedal+@lVariationUserMedal
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
		UPDATE StreamScoreInfo SET WinCount=WinCount+@lVariationWinCount, LostCount=LostCount+@lVariationLostCount, Revenue=Revenue+@lVariationRevenue,
			   PlayTimeCount=PlayTimeCount+@dwVariationPlayTimeCount, LastCollectDate=GetDate()
		WHERE DateID=@DateID AND UserID=@dwUserID		
	END
	
	UPDATE DayPlayTimeInfo SET PlayTime=PlayTime+@dwVariationPlayTimeCount WHERE DTid=@DateID AND UserID=@dwUserID
	IF @@ROWCOUNT=0
	BEGIN
		INSERT INTO DayPlayTimeInfo(DTid,UserID,PlayTime,inserttime,updatetime)
		VALUES(@DateID,@dwUserID,@dwVariationPlayTimeCount,GETDATE(),GETDATE())
	END
	
	-- 任务跟进
	IF @cbTaskForward=1
	BEGIN
		exec QPPlatformDBLink.QPPlatformDB.dbo.GSP_GR_TaskForward @dwUserID,@wKindID,0,@lVariationWinCount,@lVariationLostCount,@lVariationDrawCount	
	END
END

RETURN 0

GO