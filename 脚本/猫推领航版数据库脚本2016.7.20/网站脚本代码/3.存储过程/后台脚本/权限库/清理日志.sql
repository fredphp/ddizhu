
----------------------------------------------------------------------------------------------------

USE  QPPlatformManagerDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_Cleaning_log]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_Cleaning_log]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
CREATE PROC GSP_GR_Cleaning_log
	
WITH ENCRYPTION AS
BEGIN
ALTER DATABASE  QPPlatformManagerDB SET RECOVERY SIMPLE WITH NO_WAIT

ALTER DATABASE  QPPlatformManagerDB SET RECOVERY SIMPLE --简单模式

DBCC SHRINKDATABASE(N'QPPlatformManagerDB' ) 

ALTER DATABASE  QPPlatformManagerDB SET RECOVERY FULL WITH NO_WAIT

ALTER DATABASE  QPPlatformManagerDB SET RECOVERY FULL --还原为完全模式

END

GO

----------------------------------------------------------------------------------------------------