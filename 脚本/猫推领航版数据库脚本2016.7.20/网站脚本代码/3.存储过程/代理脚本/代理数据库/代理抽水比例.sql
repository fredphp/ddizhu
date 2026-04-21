
----------------------------------------------------------------------------------------------------

USE QPAgencyDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_UpdateAgency]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_UpdateAgency]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_UpdateAgencyPayRoty]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_UpdateAgencyPayRoty]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_UpdateAgencyRoty]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_UpdateAgencyRoty]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_UpdateSafePassWord]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_UpdateSafePassWord]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NEW_PW_UpdateAgency]
	@dwAgencyID int,
	@dwLogonName varchar(50),
	@dwAgencyName varchar(20),
	@dwLogonPwd varchar(50),
	@dwSafePass varchar(50),
	@dwSafePass2 varchar(50),
	@dwRoyalty int,
	@dwUserPrice decimal(18,2),
	@dwAgencyParentID int,
	@dwUserPlayTime int,
	@dwAgencyEmail varchar(100),
	@dwAgencyPhone varchar(20),
	@dwAgencyQQ varchar(15),
	@dwBankName varchar(127),
	@dwBankNum varchar(127),
	@dwBankAddr varchar(127),
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
	DECLARE @SafePass varchar(50)
	DECLARE @SafePass2 varchar(50)
	DECLARE @AgencyEmail varchar(100)
	DECLARE @AgencyPhone varchar(20)
	DECLARE @AgencyQQ varchar(15)
	DECLARE @AgencyRoyalty int
	DECLARE @UserPrice decimal
	DECLARE @UserPlayTime int
	DECLARE @Parent int
	DECLARE @BankName varchar(127)
	DECLARE @BankNum varchar(127)
	DECLARE @BankAddr varchar(127)
	DECLARE @CanUse int
	
	select @AgencyID=AgencyID,@LoginPwd=LoginPwd,@SafePass=SafePwdFirst,@SafePass2=SafePwdSecond,@Parent=AgencyParentID,@BankName=BankName,@BankNum=BankNum,@BankAddr=BankAddr from AgencyInfo WHERE AgencyID=@dwAgencyID
	IF @AgencyID IS NULL
	BEGIN
		set @strErrorDescribe=N'该代理不存在'
		return 1
	END
	
	select @LoginName=LoginName FROM AgencyInfo WHERE LoginName=@dwLogonName AND AgencyID!=@AgencyID
	IF @LoginName IS NOT NULL
	BEGIN
		set @strErrorDescribe=N'该用户名已存在'
		return 2
	END
	
	IF @dwLogonPwd=''
	BEGIN
		SET @dwLogonPwd=@LoginPwd
	END
	
	IF @dwSafePass=''
	BEGIN
		SET @dwSafePass=@SafePass
	END
	
	IF @dwSafePass2=''
	BEGIN
		SET @dwSafePass2=@SafePass2
	END
	
	IF @dwBankName=''
	BEGIN
		SET @dwBankName=@BankName	
	END
	
	IF @dwBankNum=''
	BEGIN
		SET @dwBankNum=@BankNum
	END
	
	IF @dwBankAddr=''
	BEGIN
		SET @dwBankAddr=@BankAddr
	END
	
	IF @Parent<>0
	BEGIN
		DECLARE @SuperRotyal int
		DECLARE @SuperPayRevenue int
		SELECT @SuperRotyal=AgencyRoyalty,@SuperPayRevenue=PayRevenue From AgencyInfo WHERE AgencyID=@Parent
		IF @SuperRotyal<@dwRoyalty
		BEGIN
			SET @strErrorDescribe=N'代理抽水比例不能大于上级代理的抽水比例'
			return 2
		END
		
		IF @SuperPayRevenue<@dwPayRevenue
		BEGIN
			SET @strErrorDescribe=N'代理充值分成比例不能大于上级代理的抽水比例'
			return 2
		END
	END
	
	DECLARE @MaxAgencyRoty int
	DECLARE @MaxPayRoty int
	SELECT @MaxAgencyRoty=MAX(AgencyRoyalty),@MaxPayRoty=MAX(PayRevenue) FROM AgencyInfo WHERE AgencyParentID=@AgencyId
	IF @MaxAgencyRoty>@dwRoyalty
	BEGIN
		SET @strErrorDescribe=N'代理抽水比例不能小于下级代理的抽水比例'
		return 3
	END
	IF @MaxPayRoty>@dwPayRevenue
	BEGIN
		SET @strErrorDescribe=N'代理的充值分成比例不能小于下级代理的分成比例'
		return 3
	END
	
	UPDATE AgencyInfo SET AgencyName=@dwAgencyName,LoginName=@dwLogonName,LoginPwd=@dwLogonPwd,SafePwdFirst=@dwSafePass,SafePwdSecond=@dwSafePass2,
		AgencyRoyalty=@dwRoyalty,UserPrice=@dwUserPrice,UserPlayTime=@dwUserPlayTime,AgencyEmail=@dwAgencyEmail,
		AgencyPhone=@dwAgencyPhone,AgencyQQ=@dwAgencyQQ,BankName=@dwBankName,BankNum=@dwBankNum,BankAddr=@dwBankAddr,CanUse=@dwCanUse,PayRevenue=@dwPayRevenue
		WHERE AgencyID=@AgencyID	
END

GO

----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NEW_PW_UpdateAgencyPayRoty]
	@AgencyId int,
	@Roty int,
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;

    DECLARE @MaxAgencyPayRoty int
    DECLARE @MinAgencyPayRoty int
	SELECT @MaxAgencyPayRoty=MAX(PayRevenue) FROM AgencyInfo WHERE AgencyParentID=@AgencyId
	IF @MaxAgencyPayRoty>@Roty
	BEGIN
		SET @strErrorDescribe=N'代理充值分成比例不能小于下级代理充值分成比例'
		return -1
	END
	
	SELECT @MinAgencyPayRoty=PayRevenue FROM AgencyInfo WHERE AgencyID=(SELECT AgencyParentID FROM AgencyInfo WHERE AgencyID=@AgencyId)
	IF @MinAgencyPayRoty<@Roty
	BEGIN
		SET @strErrorDescribe=N'代理充值分成比例不能大于上级代理充值分成比例'
		return -1
	END
	
	UPDATE AgencyInfo SET PayRevenue=@Roty WHERE AgencyID=@AgencyId
	SET @strErrorDescribe=N'修改成功'
	return 0
END

GO
----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NEW_PW_UpdateAgencyRoty]
	@AgencyId int,
	@Roty int,
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @MaxAgencyRoty int
	DECLARE @MinAgencyRoty int
	SELECT @MaxAgencyRoty=MAX(AgencyRoyalty) FROM AgencyInfo WHERE AgencyParentID=@AgencyId
	IF @MaxAgencyRoty>@Roty
	BEGIN
		SET @strErrorDescribe=N'代理抽水比例不能小于下级代理抽水比例'
		return -1
	END
	
	SELECT @MinAgencyRoty=AgencyRoyalty FROM AgencyInfo WHERE AgencyID=(SELECT AgencyParentID FROM AgencyInfo WHERE AgencyID=@AgencyId)
	IF @MinAgencyRoty<@Roty
	BEGIN
		SET @strErrorDescribe=N'代理抽水比例不能大于上级代理抽水比例'
		return -1
	END
	
	UPDATE AgencyInfo SET AgencyRoyalty=@Roty WHERE AgencyID=@AgencyId
	SET @strErrorDescribe=N'修改成功'
	return 0
	
END

GO
----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NEW_PW_UpdateSafePassWord]
	@AgencyID int,
	@SafePwdFirstOld varchar(50),
	@SafePwdFirstNew varchar(50),
	@SafePwdSecondOld varchar(50),
	@SafePwdSecondNew varchar(50),
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @SafePwdFirst varchar(50)
	DECLARE @SafePwdSecond Varchar(50)
	DECLARE @UserId int
	DECLARE @Flag int
	
	SELECT @UserId=AgencyID,@SafePwdFirst=SafePwdFirst,@SafePwdSecond=SafePwdSecond,@Flag=AgencyFlag
	FROM AgencyInfo WHERE AgencyID=@AgencyID
	
	IF @UserId IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在';
		RETURN 1
	END
	
	IF @Flag<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END
    
    IF @SafePwdFirst<>@SafePwdFirstOld
    BEGIN
		SET @strErrorDescribe=N'原一级密码输入错误'
		RETURN 3
    END
    
    IF @SafePwdSecond<>@SafePwdSecondOld
    BEGIN
		SET @strErrorDescribe=N'原二级密码输入错误'
		RETURN 4
    END
    
	UPDATE AgencyInfo SET SafePwdFirst=@SafePwdFirstNew,SafePwdSecond=@SafePwdSecondNew WHERE AgencyID=@AgencyID

    IF @@ERROR=0
    BEGIN
		SET @strErrorDescribe=N'安全密码修改成功'
    END
    RETURN 0
END

GO
----------------------------------------------------------------------------------------------------