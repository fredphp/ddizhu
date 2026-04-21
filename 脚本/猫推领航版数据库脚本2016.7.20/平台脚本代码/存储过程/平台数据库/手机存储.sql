
----------------------------------------------------------------------------------------------------

USE QPPlatformDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_LoadCheckInCountReward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_LoadCheckInCountReward]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_LoadCheckInReward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_LoadCheckInReward]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_MB_LoadTelRecharge]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_MB_LoadTelRecharge]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[GSP_GP_LoadCheckInCountReward]

WITH ENCRYPTION AS

SET NOCOUNT ON;

BEGIN
	SELECT * FROM SigninConfigCount
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[GSP_MB_LoadCheckInReward] 
	
WITH ENCRYPTION AS
BEGIN
	
	SELECT * FROM SigninConfigMB
	
END
RETURN 0


GO
----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[GSP_MB_LoadTelRecharge] 
	
WITH ENCRYPTION AS

SET NOCOUNT ON;

BEGIN
	
	SELECT * FROM RechargeTelConfigMB
END



GO

----------------------------------------------------------------------------------------------------