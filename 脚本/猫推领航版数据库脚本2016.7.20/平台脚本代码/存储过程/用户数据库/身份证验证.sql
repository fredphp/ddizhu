USE [QPAccountsDB]
GO
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_PC_CheckShenFen]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_PC_CheckShenFen]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 身份证验证
CREATE PROCEDURE [dbo].[GSP_PC_CheckShenFen]
	 --机器码，身份证号 以及 UserID到服务端
			@dwUserID  int ,					--userid 
			@szIDNOWord NVARCHAR(18),			-- 身份证号			
			@szMachineID NVARCHAR(32),			--机器码
		    @strClientIP NVARCHAR(15),			-- 连接地址
			@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS
-- 属性设置
SET NOCOUNT ON

BEGIN
	-- 变量定义
	DECLARE @UserID INT						-- userid 
	DECLARE @IDNOWord NVARCHAR(18)			-- 身份证号
	DECLARE @MachineID NVARCHAR(32)			-- 机器码
	
	-- 查询用户
	SELECT @UserID=UserID, @IDNOWord=PassPortID, @MachineID=LastLogonMachine
	FROM QPAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE UserID=@dwUserID
 
	-- 查询用户
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在或者密码输入有误！'
		RETURN 1
	END	
	
	-- 查询用户
	IF @IDNOWord IS NULL
	BEGIN
		SET @strErrorDescribe=N'您没绑定身份证号！'
		RETURN 2
	END	
	
	-- 查询用户
	IF @IDNOWord<>@szIDNOWord
	BEGIN
		SET @strErrorDescribe=N'您的身份证与注册时的不一致！'
		RETURN 3
	END	
	
	-- 机器码查询
	--IF @MachineID<>@szMachineID
	--BEGIN
	--	SET @strErrorDescribe=N'您的机器码有错！'
	--	RETURN 4
	--END
 
	
    UPDATE AccountsInfo SET LastLogonDate=GETDATE(), LastLogonMachine= @szMachineID WHERE UserID=@dwUserID
 
	
	IF @@ERROR=0 SET @strErrorDescribe=N'0'
	return 0;
END

GO


