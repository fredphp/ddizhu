----------------------------------------------------------------------------------------------------
-- 版权：2011
-- 时间：2011-08-31
-- 用途：帐号登录
----------------------------------------------------------------------------------------------------

USE QPGameMatchDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetRecentlyMatchRank') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetRecentlyMatchRank
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 帐号登录
CREATE PROCEDURE NET_PW_GetRecentlyMatchRank
	@MatchID	INT,		-- 比赛标识
	@MatchNo	INT,		-- 比赛场次
	@MatchType	INT			-- 比赛类型	
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 辅助变量
DECLARE @EnjoinLogon AS INT

-- 执行逻辑
BEGIN
	DECLARE @MaxRecordDate DATETIME
	
	IF @MatchType=0
	BEGIN
		SELECT @MaxRecordDate=MAX(RecordDate) FROM StreamMatchHistory WHERE MatchID=@MatchID AND MatchNo=@MatchNo
		SELECT A.*,B.NickName AS NickName,B.GameID AS GameID FROM StreamMatchHistory AS A LEFT JOIN QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo AS B ON A.UserID=B.UserID
		WHERE MatchID=@MatchID AND MatchNo=@MatchNo AND RecordDate=@MaxRecordDate AND (RewardGold>0 OR RewardMedal>0 OR RewardExperience>0) ORDER BY RankID ASC
	END
	ELSE
	BEGIN
		SELECT @MaxRecordDate=MAX(RecordDate) FROM StreamMatchHistory WHERE MatchID=@MatchID
		SELECT A.*,B.NickName AS NickName,B.GameID AS GameID FROM StreamMatchHistory AS A LEFT JOIN QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo AS B ON A.UserID=B.UserID
		WHERE MatchID=@MatchID AND RecordDate=@MaxRecordDate AND (RewardGold>0 OR RewardMedal>0 OR RewardExperience>0) ORDER BY RankID ASC
	END
END

RETURN 0
GO