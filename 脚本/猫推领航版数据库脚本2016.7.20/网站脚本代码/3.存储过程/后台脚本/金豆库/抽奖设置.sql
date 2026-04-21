USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[WEB_Game_Lottery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[WEB_Game_Lottery]

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[WEB_GameLottery]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[WEB_GameLottery]

GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------
CREATE PROCEDURE [dbo].[WEB_Game_Lottery]
	@dwUserID			INT,						--	用户					
	@strClientIP		NVARCHAR(15) = N'',			--  IP地址				
	@strErrorDescribe	NVARCHAR(127) OUTPUT		--	输出信息
WITH ENCRYPTION AS
  
-- 属性设置
SET NOCOUNT ON
--用户
DECLARE @SrcUserID			INT
DECLARE @SrcAccounts		NVARCHAR(31)
DECLARE @SrcNullity			TINYINT
DECLARE @SrcStunDown		TINYINT
DECLARE @MemberOrder              int   --会员等级
DECLARE @SysTimes		     int		--等级对应	系统设置的抽奖时间间隔 
DECLARE @WastTimes		     int		--等级对应	系统设置的抽奖时间花费

DECLARE @SysCounts		     int		--等级对应	系统设置的抽奖次数 
-- 抽奖条件
DECLARE @dwIsEnable	TINYINT							--	活动状态，0-开启，1-禁止
DECLARE @dwUseTimw  INT					            --	用户使用的时间
DECLARE @dwUseCount	INT							    --	每天最多摇奖的次数，为0表示不限制

DECLARE @CurrentDate DATETIME						--	摇奖日期
DECLARE @DateID INT    
DECLARE @dwMinLotterySect INT,@dwMaxLotterySect INT --	摇奖数字的范围
DECLARE @SrcScore INT,@SrcInsureScore INT --	摇奖数字的范围

-- 执行逻辑
BEGIN
	-- 初始变量
	SET @CurrentDate = GETDATE()		
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	SELECT @dwIsEnable=ISNULL(Field1,0) FROM QPPlatformDB.dbo.PublicConfig WHERE ConfigKey='GameLottery'
	
	SELECT @dwMinLotterySect=MinNum,@dwMaxLotterySect=MaxNum FROM GameLotteryConfig WHERE Code=0	
	declare @spreadinfo int 
	-- 查询用户	
	SELECT	@SrcUserID=UserID, @SrcAccounts=Accounts	,@MemberOrder=MemberOrder	
			,@SrcNullity=Nullity,@SrcStunDown=StunDown 
	FROM QPAccountsDB.dbo.AccountsInfo  WHERE UserID=@dwUserID

	SELECT  @SysCounts=[Times]   ,@SysTimes=[interval],@WastTimes=WastTime FROM 
	[QPTreasureDB].[dbo].[DayLotterMemberConfig] where member=@MemberOrder
   
   
   if(@spreadinfo is null or @spreadinfo=0)
    begin
    	SET @strErrorDescribe=N'请填写推广信息之后再抽奖！'
		--RETURN 100
    end

	-- 验证用户
	IF @SrcUserID IS NULL 
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在，请查证后再次尝试登录！'
		RETURN 100
	END

	-- 帐号封禁
	IF @SrcNullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 101
	END	

	-- 帐号关闭
	IF @SrcStunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 102
	END
	-- 活动状态，0-开启，1-禁止
	IF @dwIsEnable = 1
	BEGIN
		SET @strErrorDescribe=N'抱歉！抽奖活动暂停服务，开启时间请留意官方公告。'
		RETURN 200
	END
	-- lastest time 
	declare @DayPlayDate datetime
	DECLARE @dwCounts INT
	-- 摇奖次数
	IF  @SysCounts> 0
	BEGIN
		
		SELECT top 1 @dwCounts=isnull(playtime,0) ,@DayPlayDate=isnull( CollectDate,GETDATE()-1) FROM GameReLotteryRecord 
			WHERE UserID=@dwUserID AND CollectDate>=CONVERT(VARCHAR(10),GETDATE(),121) AND CollectDate<=GETDATE() order by CollectDate desc
			if(@dwCounts is null )set @dwCounts=0
		IF @dwCounts >= @SysCounts
		BEGIN
			SET @strErrorDescribe=N'抱歉！一天只能抽奖' + LTRIM(STR(@SysCounts)) + '次。'
			RETURN 201
		END 
	END
	--获取当天游戏时长
	declare @DayPlayTime int 
	select  @DayPlayTime=SUM(PlayTimeCount) FROM RecordDrawScore(NOLOCK) WHERE UserID=@dwUserID AND CAST(CAST(InsertTime AS FLOAT) AS INT)=@DateID
	if(@DayPlayTime is null )set @DayPlayTime=0
	if(@DayPlayTime=0 or @DayPlayTime<(@dwCounts+1)*@WastTimes)
	begin 
		SET @strErrorDescribe=N'抱歉！您今天的游戏时间不足。还差：'+CAST(((@dwCounts+1)*@WastTimes-@DayPlayTime )/60 as varchar) +'分'
		RETURN 700	
	end
	
	--限制就是 间隔时间  抽奖次数 抽奖时间达标
	if(DATEDIFF(s, @DayPlayDate,GETDATE())<@SysTimes )
	begin 
		SET @strErrorDescribe=N'抱歉！您抽奖太过频繁。'
		RETURN 701	
	end
	
	 
	
	 
	/*= 摇奖 begin
	-----------------------------------------------------------------------------------*/
	DECLARE @dwIsWin		INT				-- 是否中奖，0-未中，1-中奖
	DECLARE @dwRangeNum		INT				-- 摇奖数字范围内的值
	DECLARE @dwProbability	INT				-- 中奖范围的最大值
	
	DECLARE @ConfigID		INT				-- 奖项编号
	DECLARE @dcLotteryMoney DECIMAL(18,2)	-- 中奖金额
	DECLARE @dwBonusNum		INT				-- 奖金代号
	DECLARE @dwNumber		INT				-- 中奖号码
	DECLARE @dwRemark		VARCHAR(50)		-- 中奖内容
	DECLARE @dwTitle		VARCHAR(200)	-- 中奖描述
	DECLARE @dwRewardType	INT				-- 中奖类型 0 金币 1 话费 2 会员 3 手机 5 元宝
	DECLARE @dwOrderType	INT				-- 会员类型
	DECLARE @dwBonusCount	INT				-- 库存 
	SET @dwIsWin = 1
	-- 判断中奖的奖项
	
	SELECT @dwRangeNum=CAST(CEILING(RAND()*(@dwMaxLotterySect-@dwMinLotterySect) )AS INT)+@dwMinLotterySect
	--set @dwRangeNum=1
	IF @dwRangeNum >= @dwMinLotterySect AND @dwRangeNum <= @dwMaxLotterySect
	BEGIN
		IF EXISTS(SELECT COUNT(ConfigID) FROM GameLotteryConfig WHERE Code > 0 AND @dwRangeNum BETWEEN MinNum AND MaxNum)
		BEGIN
			SELECT @ConfigID=ConfigID,@dwProbability=Probability,@dwNumber=Number,@dwBonusNum=Code,@dcLotteryMoney=Bonus,@dwTitle=Title,@dwRewardType=RewardType,@dwOrderType=OrderType,@dwRemark=Remark,@dwBonusCount=BonusCount FROM GameLotteryConfig 
			WHERE Code > 0 AND @dwRangeNum BETWEEN MinNum AND MaxNum
		END
		ELSE
		BEGIN 
			SET @dcLotteryMoney = 0; 
			SET @dwIsWin = 0;
		END
	END
	
	-- 判断某一奖金项是否中奖
	DECLARE @p INT 
	SET @p = CAST(CEILING(RAND()*@dwProbability)AS INT)
	--set @p=1
	IF @dcLotteryMoney IS NULL OR @dcLotteryMoney <0 OR @dwNumber <> @p
	BEGIN
		SET @dcLotteryMoney = 0;SET @dwIsWin = 0	--'未中奖。谢谢参与'
	END	
	
	--如果库存为0则代表未中奖
	IF @dwBonusCount=0
	BEGIN
		SET @dcLotteryMoney = 0;SET @dwIsWin = 0	--'未中奖。谢谢参与'
	END
	
	-- 必须中奖------------
	if( @dwIsWin = 0 )
	begin  
		if (@p%2=0)
		begin
				IF NOT EXISTS(SELECT ConfigID FROM GameLotteryConfig WHERE RewardType=4)
				BEGIN
					SELECT 
@ConfigID=ConfigID,@dwBonusNum=Code,@dcLotteryMoney=Bonus,@dwTitle=Title,@dwRewardType=RewardType,@dwOrderType=OrderType,@dwRemark=Remark,@dwBonusCount=BonusCount FROM GameLotteryConfig 
						WHERE 	RewardType=0 AND Bonus=(SELECT MIN(Bonus) FROM GameLotteryConfig WHERE Bonus>0 AND RewardType=0)
						  SET @dwIsWin = 1
				END
				ELSE
				BEGIN
					SELECT 
@ConfigID=ConfigID,@dwBonusNum=Code,@dcLotteryMoney=Bonus,@dwTitle=Title,@dwRewardType=RewardType,@dwOrderType=OrderType,@dwRemark=Remark,@dwBonusCount=BonusCount FROM GameLotteryConfig 
						WHERE 	RewardType=4
						  SET @dwIsWin = 1
				END
		end
		else
		begin
			SELECT  
@ConfigID=ConfigID,@dwBonusNum=Code,@dcLotteryMoney=Bonus,@dwTitle=Title,@dwRewardType=RewardType,@dwOrderType=OrderType,@dwRemark=Remark,@dwBonusCount=BonusCount FROM GameLotteryConfig 
						WHERE 	RewardType=0 AND Bonus=(SELECT MIN(Bonus) FROM GameLotteryConfig WHERE Bonus>0 AND RewardType=0)
						  SET @dwIsWin = 1
		end
		
	end 
	-----------------
	/*= 摇奖 end
	-----------------------------------------------------------------------------------*/
	/*= 金币操作 begin
	-----------------------------------------------------------------------------------*/	
	SELECT @SrcScore=Score,@SrcInsureScore=InsureScore FROM GameScoreInfo WHERE UserID = @SrcUserID
	
	-- 插入日志
	INSERT INTO [QPTreasureDB].[dbo].[GameRELotteryRecord]
           ([UserID]
           ,[playtime]
           ,[MemberOrder]
           ,[hasplay]
           ,[BeforeScore]
           ,[BeforeInsureScore]
           ,[IsWin]
           ,[WinScore]
           ,[IPAddress]
           ,[CollectDate]
           ,[RewardType]
           ,[Remark])
     VALUES
           (@SrcUserID
           ,@dwCounts+1
           ,@MemberOrder
           ,  @DayPlayTime
           ,  @SrcScore , -- BeforeScore - decimal
	          @SrcInsureScore , -- BeforeInsureScore - decimal
	          @dwIsWin,-- is win 
	          @dcLotteryMoney , -- WinScore - decimal
	          @strClientIP , -- IPAddress - nvarchar(15)
	          @CurrentDate,  -- CollectDate - datetime
	          @dwRewardType,
	          @dwRemark
	        ) 
	        
	IF @dwRewardType=0
	BEGIN
		-- 金币变化记录
		--INSERT INTO RecordInsure(TargetUserID,TargetGold,TargetBank,
		--			SwapScore,IsGamePlaza,TradeType,ClientIP)
		--VALUES(@SrcUserID,@SrcScore,@SrcInsureScore,@dcLotteryMoney,1,10,@strClientIP)
		-- 更新金币
		UPDATE GameScoreInfo SET InsureScore=InsureScore+@dcLotteryMoney WHERE UserID=@dwUserID
	END
	
	IF @dwRewardType=5
	BEGIN
		UPDATE QPAccountsDB.dbo.AccountsInfo SET UserMedal=UserMedal+@dcLotteryMoney WHERE UserID=@dwUserID
	END
	
	
	--抽奖会员
	IF @dwRewardType=2
	BEGIN
		DECLARE @MemberOrderTake INT
		SET @MemberOrderTake=0
		DECLARE @MemberDays INT
		SET @MemberDays=@dcLotteryMoney
		SET @MemberOrderTake=@dwOrderType
		 
		 IF @MemberOrderTake<>0
		 BEGIN
			-- 会员资料
			DECLARE @MaxMemberOrder INT
			DECLARE @MaxUserRight INT
			DECLARE @MemberOverDate DATETIME
			DECLARE @MemberSwitchDate DATETIME
			DECLARE @UserRight INT

			-- 查询权限
			SELECT @UserRight=UserRight FROM QPTreasureDB.dbo.MemberType(nolock) WHERE MemberOrder=@MemberOrderTake
			
			-- 更新会员
			UPDATE QPAccountsDBLink.QPAccountsDB.dbo.AccountsMember SET MemberOverDate=MemberOverDate+@MemberDays,UserRight=@UserRight
			WHERE UserID=@SrcUserID AND MemberOrder=@MemberOrderTake
			
			IF @@ROWCOUNT=0
			BEGIN
				INSERT INTO QPAccountsDBLink.QPAccountsDB.dbo.AccountsMember(UserID,MemberOrder,UserRight,MemberOverDate)
				VALUES(@SrcUserID,@MemberOrderTake,@UserRight,GETDATE()+@MemberDays)
			END

			-- 绑定会员,(会员期限与切换时间)
			SELECT @MaxMemberOrder = MAX(MemberOrder),@MemberOverDate = MAX(MemberOverDate),@MemberSwitchDate=MIN(MemberOverDate)
			FROM QPAccountsDB.dbo.AccountsMember(nolock) WHERE UserID = @SrcUserID
			
			-- 会员权限
			SELECT @MaxUserRight = UserRight FROM QPAccountsDB.dbo.AccountsMember(nolock)
			WHERE UserID = @SrcUserID AND MemberOrder = @MaxMemberOrder

			-- 附加会员卡信息
			UPDATE QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo 
			SET MemberOrder=@MaxMemberOrder,UserRight=@MaxUserRight,MemberOverDate=@MemberOverDate,MemberSwitchDate=@MemberSwitchDate
			WHERE UserID = @SrcUserID
		 END
	END
	
	--减少库存
	IF @dwBonusCount>0
	BEGIN
		UPDATE GameLotteryConfig SET BonusCount=BonusCount-1 WHERE ConfigID=@ConfigID
	END
	
	IF @@ERROR<>0
	BEGIN
			
		-- 错误信息
		SET @strErrorDescribe=N'抱歉！抽奖失败，请联系客户服务中心了解详细情况。'
		RETURN 202
	END
	
	/*= 金币操作 end
	-----------------------------------------------------------------------------------*/
	-- 输出变量
	SELECT @dcLotteryMoney AS WinScore,		--奖金
		   @dwBonusNum AS PayUserMedal,		--奖金代号
		   @dwTitle AS Remark,				--中奖说明
		  (( @DayPlayTime-@dwCounts*@WastTimes)/@WastTimes) AS BeforeUserMedal	--剩余抽奖次数

END

RETURN 0

GO
----------------------------------------------------------------------
CREATE  PROCEDURE [dbo].[WEB_GameLottery]
	@dwUserID			INT,						--	用户					
	@strClientIP		NVARCHAR(15) = N'',			--  IP地址				
	@strErrorDescribe	NVARCHAR(127) OUTPUT		--	输出信息

WITH ENCRYPTION AS
 
-- 属性设置
SET NOCOUNT ON
--用户
DECLARE @SrcUserID			INT
DECLARE @SrcAccounts		NVARCHAR(31)
DECLARE @SrcNullity			TINYINT
DECLARE @SrcStunDown		TINYINT
DECLARE @dcUserMedal		DECIMAL(18,2)			--	现有幸运币
DECLARE @SrcScore			DECIMAL(18,2)
DECLARE @SrcInsureScore		DECIMAL(18,2)
-- 抽奖条件
DECLARE @dwIsEnable	TINYINT							--	活动状态，0-开启，1-禁止
DECLARE @dcMinMoney DECIMAL(18,2)					--	每次摇奖最低幸运币数量，即每次摇奖扣除的幸运币
DECLARE @dwLotteryCount	INT							--	每天最多摇奖的次数，为0表示不限制
DECLARE @CurrentDate DATETIME						--	摇奖日期
DECLARE @dwMinLotterySect INT,@dwMaxLotterySect INT --	摇奖数字的范围

-- 执行逻辑
BEGIN
	-- 初始变量
	SET @CurrentDate = GETDATE()	
	SELECT @dwIsEnable=ISNULL(Field1,0),@dcMinMoney=ISNULL(Field2,0),@dwLotteryCount=ISNULL(Field3,0) FROM QPPlatformDB.dbo.PublicConfig WHERE ConfigKey='Lottery'
	SELECT @dwMinLotterySect=MinNum,@dwMaxLotterySect=MaxNum FROM LotteryConfig WHERE Code=0	
	
	-- 查询用户	
	SELECT	@SrcUserID=UserID, @SrcAccounts=Accounts			
			,@SrcNullity=Nullity,@SrcStunDown=StunDown,@dcUserMedal=UserMedal
	FROM QPAccountsDB.dbo.AccountsInfo  WHERE UserID=@dwUserID

	-- 验证用户
	IF @SrcUserID IS NULL 
	BEGIN
		SET @strErrorDescribe=N'您的帐号不存在，请查证后再次尝试登录！'
		RETURN 100
	END

	-- 帐号封禁
	IF @SrcNullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 101
	END	

	-- 帐号关闭
	IF @SrcStunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 102
	END
	-- 活动状态，0-开启，1-禁止
	IF @dwIsEnable = 1
	BEGIN
		SET @strErrorDescribe=N'抱歉！抽奖活动暂停服务，开启时间请留意官方公告。'
		RETURN 200
	END
	-- 摇奖次数
	IF @dwLotteryCount > 0
	BEGIN
		DECLARE @dwCounts INT
		SELECT @dwCounts=COUNT(LotteryID) FROM GameLotteryRecord WHERE UserID=@dwUserID AND CollectDate>=CONVERT(VARCHAR(10),GETDATE(),121) AND CollectDate<=GETDATE()
		IF @dwCounts >= @dwLotteryCount
		BEGIN
			SET @strErrorDescribe=N'抱歉！一天只能抽奖' + LTRIM(STR(@dwLotteryCount)) + '次。'
			RETURN 201
		END 
	END
	-- 幸运币
	IF @dcUserMedal < @dcMinMoney
	BEGIN
		SET @strErrorDescribe=N'抱歉！您的幸运币不足。'
		RETURN 202
	END
	
	/*= 摇奖 begin
	-----------------------------------------------------------------------------------*/
	DECLARE @dwIsWin		INT				-- 是否中奖，0-未中，1-中奖
	DECLARE @dwRangeNum		INT				-- 摇奖数字范围内的值
	DECLARE @dwProbability	INT				-- 中奖范围的最大值
	
	DECLARE @dcLotteryMoney DECIMAL(18,2)	-- 中奖金额
	DECLARE @dwBonusNum		INT				-- 奖金代号
	DECLARE @dwNumber		INT				-- 中奖号码
	SET @dwIsWin = 1
	-- 判断中奖的奖项
	
	SELECT @dwRangeNum=CAST(CEILING(RAND()*(@dwMaxLotterySect-@dwMinLotterySect) )AS INT)+@dwMinLotterySect
	IF @dwRangeNum >= @dwMinLotterySect AND @dwRangeNum <= @dwMaxLotterySect
	BEGIN
		IF EXISTS(SELECT COUNT(ConfigID) FROM LotteryConfig WHERE Code > 0 AND @dwRangeNum BETWEEN MinNum AND MaxNum)
		BEGIN
			SELECT @dwProbability=Probability,@dwNumber=Number,@dwBonusNum=Code,@dcLotteryMoney=Bonus FROM LotteryConfig 
			WHERE Code > 0 AND @dwRangeNum BETWEEN MinNum AND MaxNum
		END
		ELSE
		BEGIN 
			SET @dcLotteryMoney = 0; SET @dwBonusNum = 12;	-- 谢谢参与	代号：12
		END
	END
	
	-- 判断某一奖金项是否中奖
	DECLARE @p INT 
	SET @p = CAST(CEILING(RAND()*@dwProbability)AS INT)
	IF @dcLotteryMoney IS NULL OR @dcLotteryMoney <=0 OR @dwNumber <> @p
	BEGIN
		SET @dcLotteryMoney = 0;SET @dwBonusNum = 12;SET @dwIsWin = 0	--'未中奖。谢谢参与'
	END	
	
	/*= 摇奖 end
	-----------------------------------------------------------------------------------*/
	/*= 金豆操作 begin
	-----------------------------------------------------------------------------------*/
	-- 开始事务
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	BEGIN TRAN		
	SELECT @SrcScore=Score,@SrcInsureScore=InsureScore FROM GameScoreInfo WHERE UserID = @SrcUserID
	-- 插入日志
	INSERT GameLotteryRecord
	        ( UserID ,
	          PayUserMedal ,
	          BeforeUserMedal ,
	          IsWin ,
	          BeforeScore ,
	          BeforeInsureScore ,
	          WinScore ,
	          IPAddress ,
	          CollectDate
	        )
	VALUES  ( @SrcUserID , -- UserID - int
	          @dcMinMoney , -- PayUserMedal - int
	          @dcUserMedal , -- BeforeUserMedal - int
	          @dwIsWin , -- IsWin - int
	          @SrcScore , -- BeforeScore - decimal
	          @SrcInsureScore , -- BeforeInsureScore - decimal
	          @dcLotteryMoney , -- WinScore - decimal
	          @strClientIP , -- IPAddress - nvarchar(15)
	          @CurrentDate  -- CollectDate - datetime
	        )
	-- 金豆变化记录
	INSERT INTO RecordInsure(TargetUserID,TargetGold,TargetBank,
				SwapScore,IsGamePlaza,TradeType,ClientIP)
	VALUES(@SrcUserID,@SrcScore,@SrcInsureScore,@dcLotteryMoney,1,9,@strClientIP)
	-- 更新金豆
	UPDATE GameScoreInfo SET InsureScore=InsureScore+@dcLotteryMoney WHERE UserID=@dwUserID
	--更新幸运币
	UPDATE QPAccountsDB.dbo.AccountsInfo SET UserMedal=UserMedal-@dcMinMoney WHERE UserID=@dwUserID
	
	IF @@ERROR<>0
	BEGIN
		-- 结束事务
		ROLLBACK TRAN
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
			
		-- 错误信息
		SET @strErrorDescribe=N'抱歉！抽奖失败，请联系客户服务中心了解详细情况。'
		RETURN 202
	END

	-- 结束事务
	COMMIT TRAN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	
	/*= 金豆操作 end
	-----------------------------------------------------------------------------------*/
	-- 输出变量
	SELECT @dcLotteryMoney AS WinScore,		--奖金
		   @dwBonusNum AS PayUserMedal,		--奖金代号
		   @dcUserMedal-@dcMinMoney AS BeforeUserMedal	--剩余幸运币

END

RETURN 0

GO