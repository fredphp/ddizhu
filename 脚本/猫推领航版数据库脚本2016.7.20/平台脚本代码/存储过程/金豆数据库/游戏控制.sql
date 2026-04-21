
----------------------------------------------------------------------------------------------------

USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_LoadIPMacControl]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_LoadIPMacControl]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_LoadUserControl]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_LoadUserControl]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_OperateIPMacControl]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_OperateIPMacControl]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].GSP_GR_OperateUserControl') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].GSP_GR_OperateUserControl
GO
 
SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[GSP_GR_LoadIPMacControl]
	@wKindID SMALLINT,							-- 游戏 I D
	@wServerID SMALLINT							-- 房间 I D
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;

    -- 加在控制
	SELECT KeyID,KindID,ServerID,lTargetScore AS TargetScore,MainCtrlType,SubCtrlType0,IPOrMac 
	FROM ControlIPMac WHERE KindID=@wKindID AND ServerID=@wServerID
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[GSP_GR_LoadUserControl]
	
WITH ENCRYPTION AS
BEGIN

	SET NOCOUNT ON;

	SELECT * FROM ControlUsers
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[GSP_GR_OperateIPMacControl] 
	@dwUserID INT,
	@dwKeyID INT,
	@dwKindID INT,
	@dwServerID INT,
	@dwMainCtrlType INT,
	@dwCtrlProb INT,
	@lTargetScore BIGINT,
	@dwSubCtrlType0 INT,
	@strIPOrMac NVARCHAR(50),
	@wOperateType INT, -- 操作类型 1 增加   2 删除 3 修改
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @Accounts NVARCHAR(32) -- 操作员账号
	SELECT @Accounts=Accounts FROM QPAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	
	-- 判断权限
	
	
	
	DECLARE @OperName NVARCHAR(500) -- 操作信息
	
	--操作
	IF @wOperateType=1
	BEGIN
		INSERT INTO ControlIPMac(KindID,ServerID,MainCtrlType,CtrlProb,lTargetScore,SubCtrlType0,IPOrMac)
			VALUES(@dwKindID,@dwServerID,@dwMainCtrlType,@dwCtrlProb,@lTargetScore,@dwSubCtrlType0,@strIPOrMac)
	
		SET @OperName=LTRIM(STR(@Accounts))+'插入IP或Mac控制 游戏ID='+LTRIM(STR(@dwKindID))+'房间ID='+LTRIM(STR(@dwServerID))+',控制类型='
		+LTRIM(STR(@dwMainCtrlType))+',控制难度='+LTRIM(STR(@dwCtrlProb))+',目标分数='+LTRIM(STR(@lTargetScore))+',IP或MAC='+LTRIM(STR(@strIPOrMac))
			
	END
	ELSE IF @wOperateType=2
	BEGIN
		DELETE FROM ControlIPMac WHERE KeyID=@dwKeyID
		
		SET @OperName=LTRIM(STR(@Accounts))+'删除IP或Mac控制 游戏ID='+LTRIM(STR(@dwKindID))+'房间ID='+LTRIM(STR(@dwServerID))+',控制类型='
		+LTRIM(STR(@dwMainCtrlType))+',控制难度='+LTRIM(STR(@dwCtrlProb))+',目标分数='+LTRIM(STR(@lTargetScore))+',IP或MAC='+LTRIM(STR(@strIPOrMac))
	END
	ELSE IF @wOperateType=3
	BEGIN
		UPDATE ControlIPMac SET KindID=@dwKindID,ServerID=@dwServerID,MainCtrlType=@dwMainCtrlType,CtrlProb=@dwCtrlProb,
			lTargetScore=@lTargetScore,SubCtrlType0=@dwSubCtrlType0,IPOrMac=@strIPOrMac
			WHERE KeyID=@dwKeyID
			
		SET @OperName=LTRIM(STR(@Accounts))+'更新IP或Mac控制 游戏ID='+LTRIM(STR(@dwKindID))+'房间ID='+LTRIM(STR(@dwServerID))+',控制类型='
		+LTRIM(STR(@dwMainCtrlType))+',控制难度='+LTRIM(STR(@dwCtrlProb))+',目标分数='+LTRIM(STR(@lTargetScore))+',IP或MAC='+LTRIM(STR(@strIPOrMac))
	END
	
	-- 插入操作记录
	INSERT INTO ControlOperRecord(OperUserID,OperTime,OperName)
		VALUES(@dwUserID,GETDATE(),@OperName)
	
	SET @strErrorDescribe='操作成功'
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[GSP_GR_OperateUserControl]
	@dwOperUserID INT,  -- 操作员ID
	@dwKeyID INT,
	@dwUserID INT,
	@dwKindID INT,
	@dwServerID INT,
	@dwMainCtrlType INT,
	@dwCtrlProb	INT,
	@lTargetScore BIGINT,
	@dwSubCtrlType0 INT,
	@strNote NVARCHAR(32), -- 玩家备注
	@wOperateType INT, -- 操作类型 1 增加   2 删除 3 修改
	@strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息
WITH ENCRYPTION AS
BEGIN

	SET NOCOUNT ON;
	DECLARE @Accounts NVARCHAR(32) -- 操作员账号
	SELECT @Accounts=Accounts FROM QPAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID
	-- 权限判断
	
	
	DECLARE @OperName NVARCHAR(500) -- 操作信息
	-- 操作
	IF @wOperateType=1
	BEGIN
	
		IF EXISTS(SELECT KeyID FROM ControlUsers WHERE UserID=@dwUserID AND KindID=@dwKindID AND ServerID=@dwServerID)
		BEGIN
			SET @strErrorDescribe=N'抱歉，该玩家在该房间已经设置过控制！'
			RETURN 1
		END
	
		INSERT INTO ControlUsers(UserID,KindID,ServerID,MainCtrlType,CtrlProb,lTargetScore,SubCtrlType0,Note)
			VALUES(@dwUserID,@dwKindID,@dwServerID,@dwMainCtrlType,@dwCtrlProb,@lTargetScore,@dwSubCtrlType0,@strNote)
			
		SET @OperName=LTRIM(STR(@Accounts))+'插入玩家控制 玩家ID='+LTRIM(STR(@dwUserID))+'游戏ID='+LTRIM(STR(@dwKindID))+'房间ID='+LTRIM(STR(@dwServerID))+',控制类型='
		+LTRIM(STR(@dwMainCtrlType))+',控制难度='+LTRIM(STR(@dwCtrlProb))+',目标分数='+LTRIM(STR(@lTargetScore))+',控制类型='+LTRIM(STR(@dwSubCtrlType0))
	END
	IF @wOperateType=2
	BEGIN
		IF NOT EXISTS(SELECT KeyID FROM ControlUsers WHERE UserID=@dwUserID AND KindID=@dwKindID AND ServerID=@dwServerID)
		BEGIN
			SET @strErrorDescribe=N'抱歉，该控制信息不存在，请重新加载！'
			RETURN 2
		END
	
		DELETE FROM ControlUsers WHERE KeyID=@dwKeyID
		
		SET @OperName=LTRIM(STR(@Accounts))+'删除玩家控制 玩家ID='+LTRIM(STR(@dwUserID))+'游戏ID='+LTRIM(STR(@dwKindID))+'房间ID='+LTRIM(STR(@dwServerID))+',控制类型='
		+LTRIM(STR(@dwMainCtrlType))+',控制难度='+LTRIM(STR(@dwCtrlProb))+',目标分数='+LTRIM(STR(@lTargetScore))+',控制类型='+LTRIM(STR(@dwSubCtrlType0))
	END
	IF @wOperateType=3
	BEGIN
		IF NOT EXISTS(SELECT KeyID FROM ControlUsers WHERE UserID=@dwUserID AND KindID=@dwKindID AND ServerID=@dwServerID)
		BEGIN
			SET @strErrorDescribe=N'抱歉，该控制信息不存在，请重新加载！'
			RETURN 3
		END
	
		UPDATE ControlUsers SET UserID=@dwUserID,KindID=@dwKindID,ServerID=@dwServerID,MainCtrlType=@dwMainCtrlType,CtrlProb=@dwCtrlProb,lTargetScore=@lTargetScore,SubCtrlType0=@dwSubCtrlType0
			WHERE KeyID=@dwKeyID
			
			SET @OperName=LTRIM(STR(@Accounts))+'修改玩家控制 玩家ID='+LTRIM(STR(@dwUserID))+'游戏ID='+LTRIM(STR(@dwKindID))+'房间ID='+LTRIM(STR(@dwServerID))+',控制类型='
		+LTRIM(STR(@dwMainCtrlType))+',控制难度='+LTRIM(STR(@dwCtrlProb))+',目标分数='+LTRIM(STR(@lTargetScore))+',控制类型='+LTRIM(STR(@dwSubCtrlType0))
	END
	
	-- 插入操作记录
	INSERT INTO ControlOperRecord(OperUserID,OperTime,OperName)
		VALUES(@dwOperUserID,GETDATE(),@OperName)
	
	SET @strErrorDescribe='操作成功'
END

RETURN 0

GO
----------------------------------------------------------------------------------------------------