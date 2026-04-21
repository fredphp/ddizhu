----------------------------------------------------------------------
-- 时间：2015-10-20
-- 用途：数据汇总统计。
----------------------------------------------------------------------
USE QPTreasureDB
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PM_StatInfo') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PM_StatInfo
GO

----------------------------------------------------------------------
CREATE PROC NET_PM_StatInfo
			
WITH ENCRYPTION AS

BEGIN
	-- 属性设置
	SET NOCOUNT ON;	
	--用户统计
	DECLARE @OnLineCount INT		--在线人数
	DECLARE @DisenableCount INT		--停权用户
	DECLARE @AllCount INT			--注册总人数
	SELECT  TOP 1 @OnLineCount=ISNULL(OnLineCountSum,0) FROM QPPlatformDBLink.QPPlatformDB.dbo.OnLineStreamInfo ORDER BY InsertDateTime DESC
	SELECT  @DisenableCount=COUNT(UserID) FROM QPAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE Nullity = 1 AND IsAndroid=0
	SELECT  @AllCount=COUNT(UserID) FROM QPAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE IsAndroid=0

	--金豆统计
	DECLARE @Score BIGINT		--身上金豆总量
	DECLARE @InsureScore BIGINT	--银行总量
	DECLARE @AllScore BIGINT
	SELECT  @Score=ISNULL(SUM(Score),0),@InsureScore=ISNULL(SUM(InsureScore),0),@AllScore=ISNULL(SUM(Score+InsureScore),0) 
	FROM GameScoreInfo(NOLOCK) WHERE UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE IsAndroid=0)
	
	--赠送统计
	DECLARE @RegGrantScore BIGINT		--注册赠送
	DECLARE @PresentScore BIGINT		--泡分赠送
	DECLARE @ManagerGrantScore BIGINT	--管理员后台手动赠送
	SELECT @RegGrantScore=SUM(GrantScore) FROM QPAccountsDBLink.QPAccountsDB.dbo.SystemGrantCount
	SELECT @PresentScore=ISNULL(SUM(PresentScore),0) FROM StreamPlayPresent(NOLOCK) WHERE UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE IsAndroid=0)
	SELECT @ManagerGrantScore=ISNULL(SUM(CONVERT(BIGINT,AddGold)),0) FROM QPRecordDBLink.QPRecordDB.dbo.RecordGrantTreasure WHERE UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE IsAndroid=0)
	
	--魅力统计
	DECLARE @LoveLiness BIGINT		--魅力总量
	DECLARE @Present BIGINT			--已兑换魅力总量
	DECLARE @ConvertPresent BIGINT	--已兑换金豆量
	SELECT @LoveLiness=SUM(CONVERT(BIGINT,LoveLiness)),@Present=SUM(CONVERT(BIGINT,Present)) FROM QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0
	SELECT @ConvertPresent=SUM(CONVERT(BIGINT,ConvertPresent)*ConvertRate) FROM QPRecordDBLink.QPRecordDB.dbo.RecordConvertPresent WHERE UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE IsAndroid=0)

	--税收统计
	DECLARE @Revenue BIGINT			--税收总量
	DECLARE @TransferRevenue BIGINT	--转账税收
	SELECT @Revenue=ISNULL(SUM(Revenue),0) FROM GameScoreInfo(NOLOCK) WHERE UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE IsAndroid=0)
	SELECT @TransferRevenue=ISNULL(SUM(Revenue),0) FROM RecordInsure(NOLOCK) WHERE SourceUserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE IsAndroid=0)

	--损耗统计
	DECLARE @Waste BIGINT   --损耗总量
	SELECT @Waste=ISNULL(SUM(Waste),0) FROM QPRecordDBLink.QPRecordDB.dbo.RecordEveryDayData

	--点卡统计
	DECLARE @CardCount INT			--生成张数
	DECLARE @CardGold BIGINT		--金豆总量
	DECLARE @CardPrice DECIMAL(18,2)--面额总量
	SELECT  @CardCount=COUNT(CardID),@CardGold=ISNULL(SUM(Currency),0),@CardPrice=SUM(CardPrice) FROM LivcardAssociator(NOLOCK)

	DECLARE @CardPayCount INT 		--充值张数
	DECLARE @CardPayGold BIGINT		--充值金豆
	DECLARE @CardPayPrice DECIMAL(18,2)--充值人民币总数
	SELECT @CardPayCount=COUNT(CardID),@CardPayGold=ISNULL(SUM(Currency),0),@CardPayPrice=SUM(CardPrice) FROM LivcardAssociator(NOLOCK) WHERE ApplyDate IS NOT NULL

	DECLARE @MemberCardCount INT	--实卡张数
	SELECT @MemberCardCount=COUNT(CardID) FROM LivcardAssociator(NOLOCK)


	-- 变量设置
	IF @OnLineCount IS NULL SET @OnLineCount=0
	IF @DisenableCount IS NULL SET @DisenableCount=0
	IF @AllCount IS NULL SET @AllCount=0
	IF @Score IS NULL SET @Score=0
	IF @InsureScore IS NULL SET @InsureScore=0
	IF @AllScore IS NULL SET @AllScore=0
	IF @RegGrantScore IS NULL SET @RegGrantScore=0
	IF @PresentScore IS NULL SET @PresentScore=0
	IF @ManagerGrantScore IS NULL SET @ManagerGrantScore=0
	IF @LoveLiness IS NULL SET @LoveLiness=0
	IF @Present IS NULL SET @Present=0
	IF @ConvertPresent IS NULL SET @ConvertPresent=0
	IF @Revenue IS NULL SET @Revenue=0
	IF @TransferRevenue IS NULL SET @TransferRevenue=0
	IF @Waste IS NULL SET @Waste=0
	IF @CardCount IS NULL SET @CardCount=0
	IF @CardGold IS NULL SET @CardGold=0
	IF @CardPrice IS NULL SET @CardPrice=0
	IF @CardPayCount IS NULL SET @CardPayCount=0
	IF @CardPayGold IS NULL SET @CardPayGold=0
	IF @CardPayPrice IS NULL SET @CardPayPrice=0
	IF @MemberCardCount IS NULL SET @MemberCardCount=0

	--返回
	SELECT  @OnLineCount AS	OnLineCount,				--在线人数
			@DisenableCount AS DisenableCount,			--停权用户
			@AllCount AS AllCount,						--注册总人数
			@Score AS Score,							--身上金豆总量
			@InsureScore AS InsureScore,				--银行总量
			@AllScore AS AllScore,						--金豆总数
			@RegGrantScore AS RegGrantScore,			--注册赠送
			@PresentScore AS PresentScore,				--泡分赠送
			@ManagerGrantScore AS ManagerGrantScore,	--管理员后台手动赠送
			@LoveLiness AS LoveLiness,					--魅力总量
			@Present AS Present,						--已兑换魅力总量
			(@LoveLiness-@Present) AS RemainLove,		--未兑换魅力总量
			@ConvertPresent AS ConvertPresent,			--已兑换金豆量
			@Revenue AS Revenue,						--税收总量
			@TransferRevenue AS TransferRevenue,		--转账税收	
			@Waste AS Waste,							--损耗总量
	
			@CardCount AS CardCount,					--生成张数
			@CardGold AS CardGold,						--金豆总量
			@CardPrice AS CardPrice,					--面额总量
			@CardPayCount AS CardPayCount, 				--充值张数
			@CardPayGold AS CardPayGold,				--充值金豆
			@CardPayPrice AS CardPayPrice,				--充值人民币总数
			@MemberCardCount AS MemberCardCount			--会员卡张数
END































