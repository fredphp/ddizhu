
----------------------------------------------------------------------------------------------------

USE QPAgencyDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_SetBringStatus]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_SetBringStatus]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_SetDrawStatus]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_SetDrawStatus]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NEW_PW_SetBringStatus]
	@dwRecordID int,
	@dwStatus int,
	@dwReason varchar(127),
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @RecordID int 
	DECLARE @dwAgencyID int
	DECLARE @DrawGold decimal
	DECLARE @Revenue decimal
	SELECT @RecordID=RecordID,@dwAgencyID=AgencyID,@DrawGold=DrawGold,@Revenue=RevenueGold FROM RecordBringGold WHERE RecordID=@dwRecordID
	IF @RecordID IS NULL
	BEGIN
		SET @strErrorDescribe=N'不存在该记录'
		return 1
	END
	
    DECLARE @AgencyID int
    SELECT @AgencyID=AgencyID FROM AgencyInfo WHERE AgencyID=@dwAgencyID
    IF @AgencyID IS NULL
    BEGIN
		SET @strErrorDescribe=N'该代理不存在'
		return 2
    END
    
    UPDATE RecordBringGold SET Result=@dwStatus,Remark=@dwReason WHERE RecordID=@RecordID
    
    IF @dwStatus=2
    BEGIN
		UPDATE AgencyInfo SET AgencyGold=AgencyGold+@DrawGold+@Revenue WHERE AgencyID=@AgencyID
    END
    
    SET @strErrorDescribe=N'设置成功'
    return 0
    
END

GO
----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NEW_PW_SetDrawStatus]
	@dwRecordID int,
	@dwStatus int,
	@dwReason varchar(127),
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @DrawID int
	DECLARE @AgencyID int
	DECLARE @UserID int
	DECLARE @DrawGold decimal
	DECLARE @RevenueGold decimal
	
	SELECT @DrawID=DrawID,@AgencyID=AgencyID,@UserID=UserID,@DrawGold=DrawGold,@RevenueGold=RevenueGold
	FROM RecordDraw WHERE DrawID=@dwRecordID
	IF @DrawID IS NULL
	BEGIN
		SET @strErrorDescribe=N'不存在该记录'
		return 1
	END
	
	UPDATE RecordDraw SET Result=@dwStatus,Remark=@dwReason WHERE DrawID=@dwRecordID
	
	IF @dwStatus=2
	BEGIN
		UPDATE AgencyInfo SET AgencyGold=AgencyGold+@DrawGold+@RevenueGold WHERE AgencyID=@AgencyID
	END
	
	IF @dwStatus=1
	BEGIN
		UPDATE QPTreasureDB.dbo.GameScoreInfo SET InsureScore=InsureScore+@DrawGold WHERE UserID=@UserID
	END
	
	SET @strErrorDescribe=N'设置成功'
	return 0
END

GO
----------------------------------------------------------------------------------------------------