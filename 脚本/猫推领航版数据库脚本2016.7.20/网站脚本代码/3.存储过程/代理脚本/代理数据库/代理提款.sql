
----------------------------------------------------------------------------------------------------

USE QPAgencyDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_ApplyBring]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_ApplyBring]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
--代理提款
CREATE PROCEDURE [dbo].[NEW_PW_ApplyBring] 
	
	@dwAgencyID int,
	@dwBankName varchar(50),
	@dwBankAgencyName varchar(20),
	@dwBankNum varchar(50),
	@dwBankAddr varchar(50),
	@dwDrawGold decimal(18,2),
	@dwSafePwdFirst varchar(50),
	@dwSafePwdSecond varchar(50),
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;

	DECLARE @AgencyID int
	DECLARE @Gold decimal(18,2)
	DECLARE @SafeFirst varchar(50)
	DECLARE @SafeSecond varchar(50)
	DECLARE @Flag int
	DECLARE @DrawRev int
	DECLARE @LessDraw decimal(18,2)
	
	SELECT @AgencyID=AgencyID,@Gold=AgencyGold,@SafeFirst=SafePwdFirst,@SafeSecond=SafePwdSecond,@Flag=AgencyFlag 
	FROM AgencyInfo WHERE AgencyID=@dwAgencyID
	
	IF @AgencyID IS NULL
	BEGIN
		SET @strErrorDescribe=N'该代理帐号不存在，请重新登录'
		return -1
	END
	
	IF @SafeFirst='' OR @SafeSecond=''
	BEGIN
		SET @strErrorDescribe=N'请先完善个人资料'
		return 1
	END
	
	IF @Flag=1 
	BEGIN
		SET @strErrorDescribe=N'该代理帐号已被冻结,请联系客服！'
		return -2
	END
	
	IF @SafeFirst<>@dwSafePwdFirst
	BEGIN
		SET @strErrorDescribe=N'一级安全密码错误'
		return -3
	END
	
	IF @SafeSecond<>@dwSafePwdSecond
	BEGIN
		SET @strErrorDescribe=N'二级安全密码错误'
		return -4
	END
	
	SELECT @DrawRev=Revenue,@LessDraw=DrawMoney FROM AgencyConfig WHERE AgencyConfigName=N'AgencyCofig'
	
	IF @dwDrawGold<@LessDraw
	BEGIN
		SET @strErrorDescribe=N'一次提款最少为: '+@LessDraw+N' 金币'
		return -5
	END
	
	DECLARE @DrawGold1 decimal(18,2)
	SET @DrawGold1 = @dwDrawGold*(100+@DrawRev)/100
	IF @Gold<@DrawGold1
	BEGIN
		SET @strErrorDescribe=N'您的金币不够！'
		return -6
	END
	
	INSERT INTO RecordBringGold(AgencyID,BankName,BankAgencyName,BankNum,BankAddr,CurGold,DrawGold,RevenueGold,Result,ApplyTime)
	VALUES(@AgencyID,@dwBankName,@dwBankAgencyName,@dwBankNum,@dwBankAddr,@Gold,@dwDrawGold,@dwDrawGold*@DrawRev/100,0,GETDATE())
	
	UPDATE AgencyInfo SET AgencyGold=AgencyGold-@DrawGold1 WHERE AgencyID=@AgencyID
	
	SET @strErrorDescribe=N'申请成功'
	return 0
	
END

GO
----------------------------------------------------------------------------------------------------
