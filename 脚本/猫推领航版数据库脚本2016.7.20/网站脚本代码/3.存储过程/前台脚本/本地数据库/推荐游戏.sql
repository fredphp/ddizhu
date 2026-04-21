----------------------------------------------------------------------------------------------------
-- 版权：2013
-- 时间：2013-07-31
-- 用途：问题反馈
----------------------------------------------------------------------------------------------------
USE QPNativeWebDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].WSP_PW_GetRecommendGame') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].WSP_PW_GetRecommendGame
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 问题反馈
CREATE PROCEDURE WSP_PW_GetRecommendGame
	@Count	INT					-- 查询数量
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	IF @Count=0 OR @Count = NULL
	BEGIN
		SELECT * FROM GameRulesInfo 
		WHERE KindID IN (SELECT KindID FROM QPPlatformDBLink.QPPlatformDB.dbo.GameKindItem WHERE JoinID=0)
	END
	ELSE	
	BEGIN
		SELECT TOP(@Count) * FROM GameRulesInfo 
		WHERE KindID IN (SELECT KindID FROM QPPlatformDBLink.QPPlatformDB.dbo.GameKindItem WHERE JoinID=0)
	END
	RETURN 0
END
RETURN 0
GO