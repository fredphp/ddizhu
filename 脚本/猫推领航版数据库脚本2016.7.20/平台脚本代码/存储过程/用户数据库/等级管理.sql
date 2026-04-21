
----------------------------------------------------------------------------------------------------

USE QPAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_QueryGrowLevel]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_QueryGrowLevel]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GP_QueryGrowLevelRewardReq]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GP_QueryGrowLevelRewardReq]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 查询等级
CREATE PROC [dbo].[GSP_GP_QueryGrowLevel]
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码	
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strUpgradeDescribe NVARCHAR(127) OUTPUT	-- 输出信息

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 财富变量
DECLARE @Score BIGINT
DECLARE @Ingot BIGINT

-- 执行逻辑
BEGIN
	
	-- 变量定义
	DECLARE @Experience BIGINT
	DECLARE	@GrowlevelID INT	

	-- 查询用户
	SELECT @Experience=Experience,@GrowlevelID=GrowLevelID FROM AccountsInfo 
	WHERE UserID=@dwUserID AND LogonPass=@strPassword

	-- 存在判断
	IF @Experience IS NULL OR @GrowlevelID IS NULL
	BEGIN
		return 1
	END

	-- 升级判断
	DECLARE @NowGrowLevelID INT
	SELECT TOP 1 @NowGrowLevelID=LevelID FROM QPPlatformDBLink.QPPlatformDB.dbo.GrowLevelConfig
	WHERE @Experience>=Experience ORDER BY LevelID DESC

	-- 调整变量
	IF @NowGrowLevelID IS NULL
	BEGIN
		SET @NowGrowLevelID=@GrowlevelID														
	END

	-- 升级处理
	IF @NowGrowLevelID>@GrowlevelID
	BEGIN
		DECLARE @UpgradeLevelCount INT
		DECLARE	@RewardGold BIGINT
		DECLARE	@RewardIngot BIGINT
		
		-- 升级增量
		SET @UpgradeLevelCount=@NowGrowLevelID-@GrowlevelID
		
		-- 查询奖励
		SELECT @RewardGold=SUM(RewardGold),@RewardIngot=SUM(RewardMedal) FROM QPPlatformDBLink.QPPlatformDB.dbo.GrowLevelConfig
		WHERE LevelID>@GrowlevelID AND LevelID<=@NowGrowLevelID

		-- 调整变量
		IF @RewardGold IS NULL SET @RewardGold=0				
		IF @RewardIngot IS NULL SET @RewardIngot=0
		DECLARE @CurGold decimal(18,2)
		DECLARE @CurMedal int
		
		SELECT @CurGold = Score FROM QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo with (nolock) WHERE UserID=@dwUserID
		SELECT @CurMedal = UserMedal FROM QPAccountsDB.dbo.AccountsInfo with (nolock) WHERE UserID=@dwUserID
		-- 更新金豆
		UPDATE QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo SET Score=Score+@RewardGold WHERE UserID=@dwUserID
		IF @@rowcount = 0
		BEGIN
			-- 插入资料
			INSERT INTO QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo (UserID,Score,LastLogonIP, LastLogonMachine, RegisterIP, RegisterMachine)
			VALUES (@dwUserID, @RewardGold, @strClientIP, @strMachineID, @strClientIP, @strMachineID)		
		END	
		UPDATE QPAccountsDB.dbo.AccountsInfo set  ExperienceScore= @RewardGold where UserID=@dwUserID

		-- 更新等级
		UPDATE AccountsInfo SET UserMedal=UserMedal+@RewardIngot,GrowLevelID=@NowGrowLevelID WHERE UserID=@dwUserID

		-- 升级提示
		SET @strUpgradeDescribe = N'恭喜您升为'+CAST(@NowGrowLevelID AS NVARCHAR)+N'级，系统奖励金豆 '+CAST(@RewardGold AS NVARCHAR)+N' ,元宝 '+CAST(@RewardIngot AS NVARCHAR)
		
		--插入记录
		INSERT INTO QPRecordDB.dbo.RecordLevelPresent(UserID,LevelGold,CurGold,CurMedal,Medal,GetTime)
		VALUES(@dwUserID,@RewardGold,@CurGold,@CurMedal,@RewardIngot,getdate())

		-- 设置变量
		SET @GrowlevelID=@NowGrowLevelID		
	END

	-- 下一等级	
	DECLARE	@UpgradeRewardGold BIGINT
	DECLARE	@UpgradeRewardMedal BIGINT
	DECLARE @UpgradeExperience BIGINT	
	SELECT @UpgradeExperience=Experience,@UpgradeRewardGold=RewardGold,@UpgradeRewardMedal=RewardMedal FROM QPPlatformDBLink.QPPlatformDB.dbo.GrowLevelConfig
	WHERE LevelID=@GrowlevelID+1
	
	-- 调整变量
	IF @UpgradeExperience IS NULL SET @UpgradeExperience=0
	IF @UpgradeRewardGold IS NULL SET @UpgradeRewardGold=0
	IF @UpgradeRewardMedal IS NULL SET @UpgradeRewardMedal=0

	-- 查询金豆
	SELECT @Score=Score FROM QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID
	
	-- 查询元宝	
	SELECT @Ingot=UserMedal FROM AccountsInfo WHERE UserID=@dwUserID

	-- 抛出数据
	SELECT @GrowlevelID AS CurrLevelID,@Experience AS Experience,@UpgradeExperience AS UpgradeExperience, @UpgradeRewardGold AS RewardGold,
		   @UpgradeRewardMedal AS RewardMedal,@Score AS Score,@Ingot AS Ingot
END

RETURN 0


GO


----------------------------------------------------------------------------------------------------
-- 查询等级
CREATE PROC [dbo].[GSP_GP_QueryGrowLevelRewardReq]
	@dwUserID INT,								-- 用户 I D
	@strPassword NCHAR(32),						-- 用户密码	
	@strClientIP NVARCHAR(15),					-- 连接地址
	@strMachineID NVARCHAR(32),					-- 机器标识
	@strUpgradeDescribe NVARCHAR(127) OUTPUT	-- 输出信息
	 

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 财富变量
DECLARE @Score BIGINT
DECLARE @Ingot BIGINT

-- 执行逻辑
BEGIN
	declare @RewardGold int 
	select @RewardGold= ExperienceScore from QPAccountsDB.dbo.AccountsInfo   where UserID=@dwUserID
	if(@RewardGold>0)
		begin
		-- 更新金豆
					DECLARE @CurGold decimal(18,2)
					DECLARE @CurMedal int
					
					SELECT @CurGold = Score FROM QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo with (nolock) WHERE UserID=@dwUserID
					SELECT @CurMedal = UserMedal FROM QPAccountsDB.dbo.AccountsInfo with (nolock) WHERE UserID=@dwUserID
					
		         	UPDATE QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo SET Score=Score+@RewardGold WHERE UserID=@dwUserID 
					update    QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo set  ExperienceScore=0  where UserID=@dwUserID 
			 		SELECT 	@strUpgradeDescribe	='成功领取奖励！' 
			 		
			 		--插入记录
					INSERT INTO QPRecordDB.dbo.RecordLevelPresent(UserID,LevelGold,CurGold,CurMedal,Medal,GetTime)
					VALUES(@dwUserID,@RewardGold,@CurGold,@CurMedal,0,getdate())
		end
	 else 
		 begin
	 		SELECT 	@strUpgradeDescribe	='暂无奖励领取！'
		 end
	-- 查询金豆
	SELECT @Score=Score FROM QPTreasureDBLink.QPTreasureDB.dbo.GameScoreInfo WHERE UserID=@dwUserID
	
	-- 查询元宝	
	SELECT @Ingot=UserMedal FROM AccountsInfo WHERE UserID=@dwUserID

	-- 抛出数据
	SELECT @Score AS Score,@Ingot AS Ingot
END

RETURN 0


GO
----------------------------------------------------------------------------------------------------
