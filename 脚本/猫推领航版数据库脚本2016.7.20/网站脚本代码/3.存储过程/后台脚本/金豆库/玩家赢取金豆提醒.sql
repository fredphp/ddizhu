USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_GetUserInfoByWin]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_GetUserInfoByWin]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------
-- 时间：2015-04-03
-- 用途：玩家赢取金豆提醒
----------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NET_PM_GetUserInfoByWin] 

WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;
	DECLARE @remindScore bigint
	SELECT @remindScore=StatusValue FROM QPAccountsDB.dbo.SystemStatusInfo WHERE StatusName='WinRemind'
	IF @remindScore IS NULL OR @remindScore<0
	BEGIN
		SET @remindScore=10000000
	END
	
	SELECt a.UserID,Accounts,b.Score FROM QPAccountsDB.dbo.AccountsInfo a,(SELECT UserID,SUM(Score) Score FROM RecordDrawScore GROUP BY UserID Having SUM(Score)>@remindScore) b 
	WHERE a.UserID=b.UserID
	
END

GO

