----------------------------------------------------------------------------------------------------
-- 版权：2013
-- 时间：2013-07-31
-- 用途：问题反馈
----------------------------------------------------------------------------------------------------
USE QPNativeWebDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[WSP_PW_BuyAward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[WSP_PW_BuyAward]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[WSP_PW_BuyMember]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[WSP_PW_BuyMember]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 商城管理
CREATE PROCEDURE WSP_PW_BuyAward
	@UserID	INT,					-- 用户标识
	@AwardID INT,					-- 奖品标识
	@AwardPrice INT,				-- 奖品价格
	@AwardCount INT,				-- 购买数量
	@TotalAmount INT,				-- 总金额
	@Compellation NVARCHAR(16),		-- 真实姓名
	@MobilePhone NVARCHAR(16),		-- 手机号码
	@QQ NVARCHAR(32),				-- QQ号码
	@Province INT,					-- 省份
	@City INT,						-- 城市
	@Area INT,						-- 地区
	@DwellingPlace NVARCHAR(128),	-- 详细地址
	@PostalCode	NVARCHAR(8),		-- 邮编号码
	@BuyIP NVARCHAR(15),			-- 购买IP                     
	@OrderID INT OUTPUT,			-- 订单号码	
	@strErrorDescribe NVARCHAR(127) OUTPUT	-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 账户信息
DECLARE @UserMedal bigint

-- 执行逻辑
BEGIN
	-- 验证用户
	SELECT @UserMedal=UserMedal,@UserID=UserID FROM QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo 
	WHERE UserID=@UserID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe='用户不存在'
		RETURN 101
	END

	-- 验证奖牌
	IF @TotalAmount>@UserMedal
	BEGIN
		SET @strErrorDescribe='兑换失败，奖牌数不足'
		RETURN 101
	END
	
	-- 更新奖牌
	--BEGIN TRAN
	UPDATE QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo SET UserMedal=UserMedal-@TotalAmount
	WHERE UserID=@UserID
	
	-- 插入订单
	INSERT INTO AwardOrder(UserID,AwardID,AwardPrice,AwardCount,TotalAmount,Compellation,
		MobilePhone,QQ,Province,City,Area,DwellingPlace,PostalCode,BuyIP)
	VALUES(@UserID,@AwardID,@AwardPrice,@AwardCount,@TotalAmount,@Compellation,
		@MobilePhone,@QQ,@Province,@City,@Area,@DwellingPlace,@PostalCode,@BuyIP)

	SET @OrderID=@@IDENTITY 
	SELECT @OrderID AS OrderID
		
	--更新奖品
	UPDATE AwardInfo SET BuyCount=BuyCount+1,Inventory=Inventory-@AwardCount WHERE AwardID=@AwardID
	--COMMIT TRAN
	
	RETURN 0
END
RETURN 0
GO
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- 会员商城管理
CREATE PROCEDURE [dbo].[WSP_PW_BuyMember]
	@UserID	INT,					-- 用户标识
	@AwardID INT,					-- 会员标识
	@AwardCount INT,				-- 购买天数
	@BuyIP NVARCHAR(15),			-- 购买IP        
	@strErrorDescribe NVARCHAR(127) OUTPUT	-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 账户信息
DECLARE @UserMedal INT

-- 会员信息
DECLARE @MemberType INT
DECLARE @MemberName NVARCHAR(32)
DECLARE @Price INT

-- 执行逻辑
BEGIN
	IF @AwardCount<=0 OR @AwardCount>365
	BEGIN
		SET @strErrorDescribe='请输入正确的天数（0~365）'
		RETURN 100
	END

	-- 查询会员
	SELECT @MemberType=MemberType,@MemberName=MemberName,@Price=Price FROM MemberShopConfig WHERE AwardID=@AwardID AND Nullity=0
	
	IF @MemberType IS NULL
	BEGIN
		SET @strErrorDescribe='该会员不存在或已下架，请刷新网页重新购买！'
		RETURN 100
	END

	-- 验证用户
	SELECT @UserMedal=UserMedal,@UserID=UserID FROM QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo 
	WHERE UserID=@UserID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe='用户不存在'
		RETURN 101
	END
	
	DECLARE @TotalAmount INT 
	SET @TotalAmount=@Price*@AwardCount

	--验证总额
	IF @TotalAmount<=0
	BEGIN
		SET @strErrorDescribe='购买失败，元宝总额错误'
		RETURN 101
	END

	-- 验证奖牌
	IF @TotalAmount>@UserMedal
	BEGIN
		SET @strErrorDescribe='购买失败，元宝不足'
		RETURN 101
	END
	
	-- 更新奖牌
	UPDATE QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo SET UserMedal=UserMedal-@TotalAmount
	WHERE UserID=@UserID
	
	-- 插入记录
	INSERT INTO MemberShopRecord(UserID,MemberID,MemberName,Price,BuyDays,TotalAmount,InsertTime)
     VALUES(@UserID,@MemberType,@MemberName,@Price,@AwardCount,@TotalAmount,GETDATE())

	-- 增加会员信息
	DECLARE @UserRight INT
	DECLARE @MaxMemberOrder INT
	DECLARE @MemberOverDate DATETIME
	DECLARE @MemberSwitchDate DATETIME
	DECLARE @MaxUserRight INT
	
	-- 查询权限
	SELECT @UserRight=UserRight FROM QPTreasureDBLink.QPTreasureDB.dbo.MemberType WHERE MemberOrder=@MemberType
	
	-- 更新会员
	UPDATE QPAccountsDBLink.QPAccountsDB.dbo.AccountsMember SET MemberOverDate=MemberOverDate+@AwardCount,UserRight=@UserRight
	WHERE UserID=@UserID AND MemberOrder=@MemberType
	
	IF @@ROWCOUNT=0
	BEGIN
		INSERT INTO QPAccountsDBLink.QPAccountsDB.dbo.AccountsMember(UserID,MemberOrder,UserRight,MemberOverDate)
		VALUES(@UserID,@MemberType,@UserRight,GETDATE()+@AwardCount)
	END

	-- 绑定会员,(会员期限与切换时间)
	SELECT @MaxMemberOrder = MAX(MemberOrder),@MemberOverDate = MAX(MemberOverDate),@MemberSwitchDate=MIN(MemberOverDate)
	FROM QPAccountsDBLink.QPAccountsDB.dbo.AccountsMember WHERE UserID = @UserID
	
	-- 会员权限
	SELECT @MaxUserRight = UserRight FROM QPAccountsDBLink.QPAccountsDB.dbo.AccountsMember
	WHERE UserID = @UserID AND MemberOrder = @MaxMemberOrder

	-- 附加会员卡信息
	UPDATE QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo 
	SET MemberOrder=@MaxMemberOrder,UserRight=@MaxUserRight,MemberOverDate=@MemberOverDate,MemberSwitchDate=@MemberSwitchDate
	WHERE UserID = @UserID

	RETURN 0
END
RETURN 0

GO

----------------------------------------------------------------------------------------------------