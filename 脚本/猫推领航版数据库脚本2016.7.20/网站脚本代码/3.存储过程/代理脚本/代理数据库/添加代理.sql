
----------------------------------------------------------------------------------------------------

USE QPAgencyDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_AddAgency]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_AddAgency]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_AddAgencyUser]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_AddAgencyUser]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
--添加代理
CREATE PROCEDURE [dbo].[NEW_PW_AddAgency]
	@dwLogonName varchar(50),
	@dwAgencyName varchar(20),
	@dwLogonPwd varchar(50),
	@dwRoyalty int,
	@dwUserPrice decimal(18,2),
	@dwAgencyParentID int,
	@dwUserPlayTime int,
	@dwAgencyEmail varchar(100),
	@dwAgencyPhone varchar(20),
	@dwAgencyQQ varchar(15),
	@dwCanUse int,
	@dwPayRevenue int,
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @AgencyID int
	DECLARE @AgencyName varchar(20)
	DECLARE @LoginName varchar(50)
	DECLARE @LoginPwd varchar(50)
	DECLARE @AgencyEmail varchar(100)
	DECLARE @AgencyPhone varchar(20)
	DECLARE @AgencyQQ varchar(15)
	DECLARE @AgencyRoyalty int
	DECLARE @UserPrice decimal
	DECLARE @UserPlayTime int
	DECLARE @Status int
	DECLARE @PayRevenue int
	
	IF @dwAgencyParentID<>0
	BEGIN
		SELECT @Status=Status FROM AgencyConfig WHERE AgencyConfigName='AgencyCofig'
		IF @Status=1
		BEGIN
			SET @strErrorDescribe=N'代理新增下级代理功能已关闭'
			return 1
		END
		
		DECLARE @CanAdd int
		SELECT @CanAdd=CanUse FROM AgencyInfo WHERE AgencyID=@dwAgencyParentID
		IF @CanAdd=1
		BEGIN
			SET @strErrorDescribe=N'您已被代理禁止添加下级代理'
			return 1
		END
		
		IF @dwUserPlayTime=0
		BEGIN
			SELECT @dwUserPlayTime=UserPlayTime  FROM AgencyConfig WHERE AgencyConfigName='AgencyCofig'
		END
		
		IF @dwUserPrice=0
		BEGIN
			SELECT @dwUserPrice=UserPrice FROM AgencyConfig WHERE AgencyConfigName='AgencyCofig'
		END
		
		SELECT @AgencyRoyalty=AgencyRoyalty,@PayRevenue=PayRevenue FROM AgencyInfo WHERE AgencyID=@dwAgencyParentID
		IF @AgencyRoyalty<@dwRoyalty
		BEGIN
			SET @strErrorDescribe=N'下级代理抽水比例不能大于自己'
			return 1
		END
		IF @PayRevenue<@dwPayRevenue
		BEGIN
			SET @strErrorDescribe=N'下级代理的充值分成比例不能大于自己'
			return 1
		END
	END
	
	SELECT @AgencyID=AgencyID FROM AgencyInfo WHERE LoginName=@dwLogonName
	IF @AgencyID IS NOT NULL
	BEGIN
		SET @strErrorDescribe=N'该代理已经存在'
		return 1
	END
		
	INSERT INTO AgencyInfo(AgencyName,LoginName,LoginPwd,AgencyEmail,AgencyPhone,AgencyQQ,AgencyRoyalty,AgencyParentID,UserPrice,UserPlayTime,RegisterDate,CanUse,PayRevenue)
		VALUES(@dwAgencyName,@dwLogonName,@dwLogonPwd,@dwAgencyEmail,@dwAgencyPhone,@dwAgencyQQ,@dwRoyalty,@dwAgencyParentID,@dwUserPrice,@dwUserPlayTime,GETDATE(),@dwCanUse,@dwPayRevenue)
		
	SELECT @AgencyID=AgencyID,@AgencyName=AgencyName,@LoginName=LoginName,
		@AgencyEmail=AgencyEmail,@AgencyPhone=AgencyPhone,@AgencyQQ=AgencyQQ,
		@AgencyRoyalty=AgencyRoyalty,@UserPrice=UserPrice,@UserPlayTime=UserPlayTime
		FROM AgencyInfo WHERE LoginName=@dwLogonName
		
	SET @strErrorDescribe=N'添加成功'
	
	SELECT AgencyID=@AgencyID
	RETURN 0
    
END

GO
----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NEW_PW_AddAgencyUser] 
	
	@dwAgencyID int,
	@dwUserID int
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;

	INSERT INTO Agency_User(AgencyID,UserID) VALUES(@dwAgencyID,@dwUserID)
	
	UPDATE UserPlay SET RegisterCounts=RegisterCounts+1 WHERE AgencyID=@dwAgencyID AND DateID=CAST(CAST(GETDATE() AS FLOAT ) AS INT)
	IF @@ROWCOUNT=0
	BEGIN
		INSERT INTO UserPlay(DateID,AgencyID,RegisterCounts,CanUserCounts,IsEnd)
		VALUES(CAST(CAST(GETDATE() AS FLOAT) AS INT),@dwAgencyID,1,0,0)
	END
	
END

GO
----------------------------------------------------------------------------------------------------