
----------------------------------------------------------------------------------------------------

USE QPAgencyDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_DrawGold]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_DrawGold]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
--代理转账
CREATE PROCEDURE [dbo].[NEW_PW_DrawGold]
	@AgencyID int,
	@Accounts varchar(50),
	@DrawGold decimal(18,2),
	@SafePwdFirst varchar(50),
	@safePwdSecond varchar(50),
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @Gold decimal(18,2)
	DECLARE @SafeFirst varchar(50)
	DECLARE @SafeSecond varchar(50)
	DECLARE @Flag int
	DECLARE @DrawRev int
	DECLARE @LessDraw decimal(18,2)
	
	SELECT @Gold=AgencyGold,@SafeFirst=SafePwdFirst,@SafeSecond=SafePwdSecond,@Flag=AgencyFlag 
	FROM AgencyInfo WHERE AgencyID=@AgencyID
	
	IF @SafeFirst='' OR @SafeSecond=''
	BEGIN
		SET @strErrorDescribe=N'请先设置安全密码'
		return 0
	END
	
	IF @Gold IS NULL
	BEGIN
		SET @strErrorDescribe=N'该代理帐号不存在，请重新登录'
		return -1
	END
	
	IF @Flag=1 
	BEGIN
		SET @strErrorDescribe=N'该代理帐号已被冻结,请联系客服！'
		return -2
	END
	
	IF @SafeFirst<>@SafePwdFirst
	BEGIN
		SET @strErrorDescribe=N'一级安全密码错误'
		return -3
	END
	
	IF @SafeSecond<>@safePwdSecond
	BEGIN
		SET @strErrorDescribe=N'二级安全密码错误'
		return -4
	END
	
	SELECT @DrawRev=Revenue,@LessDraw=DrawMoney FROM AgencyConfig WHERE AgencyConfigName=N'AgencyCofig'
	
	IF @DrawGold<@LessDraw
	BEGIN
		SET @strErrorDescribe=N'一次转账最少为: '+@LessDraw+N' 金币'
		return -5
	END
	
	DECLARE @DrawGold1 decimal(18,2)
	SET @DrawGold1 = @DrawGold*(100+@DrawRev)/100
	IF @Gold<@DrawGold1
	BEGIN
		SET @strErrorDescribe=N'您的金币不够！'
		return -6
	END
	
	DECLARE @UserID int
	SELECT @UserID=UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE Accounts=@Accounts
	
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'该玩家不存在！'
		return -7
	END
	
	UPDATE AgencyInfo SET AgencyGold=@Gold-@DrawGold1 WHERE AgencyID=@AgencyID
	
	--UPDATE QPTreasureDB.dbo.GameScoreInfo SET InsureScore=InsureScore+@DrawGold WHERE UserID=@UserID
	
	INSERT INTO RecordDraw(AgencyID,UserID,CurGold,DrawGold,EndGold,RevenueGold,DrewTime)
	VALUES(@AgencyID,@UserID,@Gold,@DrawGold,@Gold-@DrawGold1,@DrawGold*@DrawRev/100,GETDATE())
	
	SET @strErrorDescribe=N'转账成功'
	return 0
END

GO
----------------------------------------------------------------------------------------------------
