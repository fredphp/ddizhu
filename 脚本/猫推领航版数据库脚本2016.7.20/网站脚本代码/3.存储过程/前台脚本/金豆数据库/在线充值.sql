----------------------------------------------------------------------
-- 版权：2011
-- 时间：2011-09-1
-- 用途：在线充值
----------------------------------------------------------------------

USE [QPTreasureDB]
GO

-- 在线充值
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_FilledOnLine') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_FilledOnLine
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

---------------------------------------------------------------------------------------
-- 在线充值
CREATE PROCEDURE NET_PW_FilledOnLine
	@strOrdersID		NVARCHAR(50),			--	订单编号
	@PayAmount			DECIMAL(18,2),			--  支付金额
	@isVB				INT,					--	是否电话充值
	@strIPAddress		NVARCHAR(31),			--	用户帐号	
	@strErrorDescribe	NVARCHAR(127) OUTPUT	--	输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 订单信息
DECLARE @OperUserID INT
DECLARE @ShareID INT
DECLARE @UserID INT
DECLARE @GameID INT
DECLARE @Accounts NVARCHAR(31)
DECLARE @OrderAmount DECIMAL(18,2)
DECLARE @DiscountScale DECIMAL(18,2)
DECLARE @IPAddress NVARCHAR(15)
DECLARE @Currency DECIMAL(18,2)
DECLARE @OrderID NVARCHAR(50)

-- 用户信息
DECLARE @Score BIGINT

-- 其他信息
DECLARE @Rate INT

-- 执行逻辑
BEGIN
	-- 订单查询
	SELECT @OperUserID=OperUserID,@ShareID=ShareID,@UserID=UserID,@GameID=GameID,@Accounts=Accounts,
		@OrderID=OrderID,@OrderAmount=OrderAmount,@DiscountScale=DiscountScale
	FROM OnLineOrder WHERE OrderID=@strOrdersID

	-- 订单存在
	IF @OrderID IS NULL 
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值订单不存在。'
		RETURN 1
	END

	-- 订单重复
	IF EXISTS(SELECT OrderID FROM ShareDetailInfo WHERE OrderID=@strOrdersID) 
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值订单重复。'
		RETURN 2
	END

	SELECT @Rate=StatusValue FROM QPAccountsDBLink.QPAccountsDB.dbo.SystemStatusInfo WHERE StatusName='RateCurrency'
		IF @Rate=0 OR @Rate IS NULL
			SET @Rate=1

	-- 货币汇率
	IF @isVB=1
	BEGIN
		SELECT @Rate=StatusValue FROM QPAccountsDBLink.QPAccountsDB.dbo.SystemStatusInfo WHERE StatusName='RateCard'
		IF @Rate=0 OR @Rate IS NULL
			SET @Rate = 1
	END
	IF @isVB=3
	BEGIN
		SELECT @Rate=StatusValue FROM QPAccountsDBLink.QPAccountsDB.dbo.SystemStatusInfo WHERE StatusName='RateCurrency'
		IF @Rate=0 OR @Rate IS NULL
			SET @Rate=1
		SET @Rate=@Rate*1
	END
	IF @isVB=5
	BEGIN
		SELECT @Rate=StatusValue FROM QPAccountsDBLink.QPAccountsDB.dbo.SystemStatusInfo WHERE StatusName='RateCurrency'
		IF @Rate=0 OR @Rate IS NULL
			SET @Rate=1
	END
	IF @isVB=7
	BEGIN
		SELECT @Rate=StatusValue FROM QPAccountsDBLink.QPAccountsDB.dbo.SystemStatusInfo WHERE StatusName='RateCurrency'
		IF @Rate=0 OR @Rate IS NULL
			SET @Rate=1
	END
	IF @isVB=9
	BEGIN
		SELECT @Rate=StatusValue FROM QPAccountsDBLink.QPAccountsDB.dbo.SystemStatusInfo WHERE StatusName='RateCurrency'
		IF @Rate=0 OR @Rate IS NULL
			SET @Rate=1
		SET @Rate=@Rate*1
	END
	IF @isVB=11
	BEGIN
		SELECT @Rate=StatusValue FROM QPAccountsDBLink.QPAccountsDB.dbo.SystemStatusInfo WHERE StatusName='RateCurrency'
		IF @Rate=0 OR @Rate IS NULL
			SET @Rate=1
	END
	IF @isVB=12
	BEGIN
		SELECT @Rate=StatusValue FROM QPAccountsDBLink.QPAccountsDB.dbo.SystemStatusInfo WHERE StatusName='RateCurrency'
		IF @Rate=0 OR @Rate IS NULL
			SET @Rate=1
	END
	-- 货币查询
	DECLARE @BeforeCurrency DECIMAL(18,2)
	SELECT @BeforeCurrency=Score+InsureScore FROM QPTreasureDB.dbo.GameScoreInfo WHERE UserID=@UserID
	IF @BeforeCurrency IS NULL
		SET @BeforeCurrency=0

	-- 充值金豆	
	SET @Currency = @PayAmount*@Rate
	
	-- 充值金豆

	UPDATE GameScoreInfo SET InsureScore=InsureScore+@Currency WHERE UserID=@UserID
	IF @@ROWCOUNT=0	
	BEGIN
		INSERT GameScoreInfo(UserID,Score,RegisterIP,LastLogonIP)
		VALUES (@UserID,@Currency,'0.0.0.0','0.0.0.0')
	END	
	

	

	-- 产生记录
	INSERT INTO ShareDetailInfo(
		OperUserID,ShareID,UserID,GameID,Accounts,OrderID,OrderAmount,DiscountScale,PayAmount,
		Currency,BeforeCurrency,IPAddress)
	VALUES(
		@OperUserID,@ShareID,@UserID,@GameID,@Accounts,@OrderID,@OrderAmount,@DiscountScale,@PayAmount,
		@Currency,@BeforeCurrency,@strIPAddress)

	-- 更新订单状态
	UPDATE OnLineOrder SET OrderStatus=2,Currency=@Currency,PayAmount=@PayAmount
	WHERE OrderID=@OrderID

	--代理系统
	DECLARE @AgencyID int
	DECLARE @DateID INT
	DECLARE @PayRevenueRate DECIMAL(18,2)
	DECLARE @PayRevenue DECIMAL(18,2)
	SELECT @AgencyID=AgencyID FROM QPAgencyDB.dbo.Agency_User WHERE UserID=@UserID
	SELECT @PayRevenueRate=PayRevenue FROM QPAgencyDB.dbo.AgencyConfig WHERE AgencyConfigName='AgencyCofig'
	IF @PayRevenueRate IS NULL
		SET @PayRevenueRate=4.5
	SET @PayRevenue=@Currency*@PayRevenueRate/100
	IF @AgencyID IS NOT NULL AND @PayRevenue>0
	BEGIN
		SET @DateId = CAST(CAST(GETDATE() AS FLOAT) AS INT)
		DECLARE @Son int
		DECLARE @self int
		DECLARE @SonRoty int
		DECLARE @selfRoty int
		DECLARE @selfFlag int
		DECLARE @Count int
		SET @Count=1
		SET @self=@AgencyID
		SELECT @selfRoty=PayRevenue  FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
		SELECT @selfFlag=AgencyFlag FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
		
		IF @selfFlag=0 AND @PayRevenue*@selfRoty/100>0
		BEGIN
			INSERT INTO QPAgencyDB.dbo.RecordRoyalty(AgencyID,UserID,UserWin,RoyaltyTotal,RoyaltyRatio,RoyaltyTime,RoyaltyGold,Remark,RoyaltyType)
				VALUES(@AgencyID,@UserID,@Currency,@PayRevenue,@selfRoty,GETDATE(),@PayRevenue*@selfRoty/100,N'充值分成',1)
			UPDATE QPAgencyDB.dbo.AgencyInfo SET AgencyGold=AgencyGold+@PayRevenue*@selfRoty/100 WHERE AgencyID=@AgencyID
		END
		
		SET @Son=@self
		
		WHILE @Count<5
		BEGIN	
			SELECT @self=AgencyParentID FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@Son
			IF @self<>0
			BEGIN
				IF @self IS NOT NULL
				BEGIN
					SELECT @SonRoty=PayRevenue  FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@Son
					SELECT @selfRoty=PayRevenue  FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
					SELECT @selfFlag=AgencyFlag FROM QPAgencyDB.dbo.AgencyInfo WHERE AgencyID=@self
					SET @selfRoty=@selfRoty-@SonRoty
					IF @selfFlag=0  AND @PayRevenue*@selfRoty/100>0
					BEGIN
						INSERT INTO QPAgencyDB.dbo.RecordRoyalty(AgencyID,UserID,UserWin,RoyaltyTotal,RoyaltyRatio,RoyaltyTime,RoyaltyGold,Remark,RoyaltyType)
							VALUES(@self,@UserID,@Currency,@PayRevenue,@selfRoty,GETDATE(),@PayRevenue*@selfRoty/100,N'充值分成',1)
						UPDATE QPAgencyDB.dbo.AgencyInfo SET AgencyGold=AgencyGold+@PayRevenue*@selfRoty/100 WHERE AgencyID=@self
					END
					
					SET @Son=@self
					SET @Count=@Count+1
				END
				ELSE
				BEGIN
					SET @Count = 5
				END
			END
			ELSE
			BEGIN
				SET @Count = 5
			END
		END
		
	END

	

	--------------------------------------------------------------------------------
	-- 推广系统
	DECLARE @SpreaderID INT	
	SELECT @SpreaderID=SpreaderID FROM QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo
	WHERE UserID = @UserID
	IF @SpreaderID<>0
	BEGIN
		DECLARE @SpreadRate DECIMAL(18,2)
		DECLARE @GrantScore BIGINT
		DECLARE @Note NVARCHAR(512)
		-- 推广分成
		SELECT @SpreadRate=FillGrantRate FROM GlobalSpreadInfo
		IF @SpreadRate IS NULL
		BEGIN
			SET @SpreadRate=0.1
		END
		
		SET @GrantScore = @Currency*@SpreadRate
		SET @Note = N'充值'+LTRIM(STR(@PayAmount))+'元'
		INSERT INTO RecordSpreadInfo(UserID,Score,TypeID,ChildrenID,CollectNote)
		VALUES(@SpreaderID,@GrantScore,3,@UserID,@Note)	
		
		-- 推广分成，金豆
		UPDATE GameScoreInfo SET Score=Score+@GrantScore WHERE UserID=@SpreaderID
		IF @@ROWCOUNT=0	
		BEGIN
			INSERT GameScoreInfo(UserID,Score,RegisterIP,LastLogonIP)
			VALUES (@SpreaderID,@GrantScore,'0.0.0.0','0.0.0.0')
		END
			
	END

	-- 记录日志
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)

	UPDATE StreamShareInfo
	SET ShareTotals=ShareTotals+1
	WHERE DateID=@DateID AND ShareID=@ShareID

	IF @@ROWCOUNT=0
	BEGIN
		INSERT StreamShareInfo(DateID,ShareID,ShareTotals)
		VALUES (@DateID,@ShareID,1)
	END	 
	
END 
RETURN 0
GO



