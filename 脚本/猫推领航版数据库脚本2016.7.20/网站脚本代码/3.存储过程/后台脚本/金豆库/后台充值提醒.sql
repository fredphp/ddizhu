USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_GetUserPayRemind]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_GetUserPayRemind]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------
-- 时间：2015-04-03
-- 用途：充值提醒
----------------------------------------------------------------------

CREATE PROCEDURE [dbo].[NET_PM_GetUserPayRemind] 
	
WITH ENCRYPTION AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT UserID,Accounts,PayAmount,Currency FROM ShareDetailInfo WHERE IsAmind=0

END

GO

