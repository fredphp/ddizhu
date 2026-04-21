
----------------------------------------------------------------------------------------------------

USE QPAgencyDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_TakeAgencyGold]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_TakeAgencyGold]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NEW_PW_TakeAgencyGold] 
	
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;

    DECLARE @YesteDayId int
    SET @YesteDayId=CAST(CAST(DateAdd(d,-1, GETDATE()) AS FLOAT) AS INT)
    
    UPDATE AgencyInfo SET AgencyGold=AgencyGold+CanUserCounts*UserPrice FROM UserPlay WHERE UserPlay.AgencyID=AgencyInfo.AgencyID AND DateID=@YesteDayId AND UserPlay.IsEnd=0 AND AgencyFlag=0
    
    UPDATE UserPlay SET IsEnd=1 FROM AgencyInfo WHERE DateID=@YesteDayId AND UserPlay.AgencyID=AgencyInfo.AgencyID AND AgencyFlag=0 
    
    
END

GO
----------------------------------------------------------------------------------------------------
