USE QPRecordDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_TotalDayDate]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_TotalDayDate]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[Web_GetGoldStatistical]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[Web_GetGoldStatistical]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------
-- 时间：2015-04-03
-- 用途：每日统计
----------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NEW_PW_TotalDayDate]
	-- Add the parameters for the stored procedure here
WITH ENCRYPTION AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @PayBankGold decimal(18,2)=0
	DECLARE @PayCardGold decimal(18,2)=0
	DECLARE @PayTureGold decimal(18,2)=0
	DECLARE @PayNewUserGold decimal(18,2)=0
	DECLARE @PreMatchGold decimal(18,2)=0
	DECLARE @PreLevelGold decimal(18,2)=0
	DECLARE @PreFideGold decimal(18,2)=0
	DECLARE @PreTaskGold decimal(18,2)=0
	DECLARE @PreReferGold decimal(18,2)=0
	DECLARE @PreMealGold decimal(18,2)=0
	DECLARE @PreRegstGold decimal(18,2)=0
	DECLARE @PreTurnGold decimal(18,2)=0
	DECLARE @PreSignGold decimal(18,2)=0
	DECLARE @TotalInsure decimal(18,2)=0
	DECLARE @TotalScore decimal(18,2)=0

	DECLARE @PayBankMedal int=0
	DECLARE @PayCardMedal int=0
	DECLARE @PayTureMedal int=0
	DECLARE @PreMatchMedal int=0
	DECLARE @PreLevelMedal int=0
	DECLARE @PreFideMedal int=0
	DECLARE @PreTaskMedal int=0
	DECLARE @PreReferMedal int=0
	DECLARE @PreMealMedal int=0
	DECLARE @PreRegstMedal int=0
	DECLARE @PreTurnMedal int=0
	DECLARE @PreSignMedal int=0
	DECLARE @TotalMedal int=0
	
	DECLARE @LostWin decimal=0
	
	DECLARE @BankRevenue decimal(18,2)=0
	DECLARE @GameRevenue decimal(18,2)=0
	DECLARE @BuyPro decimal(18,2)=0
	DECLARE @BuyPro1 decimal(18,2)=0
	DECLARE @BuyPro2 decimal(18,2)=0
	DECLARE @MedalToScore decimal(18,2)=0
	DECLARE @AdminGrant decimal(18,2)=0
	
	DECLARE @DateID int
	SET @DateID=CAST(CAST(DateAdd(d,-1, GETDATE()) AS FLOAT) AS INT)
	
	SELECT @PayBankMedal=ISNULL(SUM(ISNULL(Currency,0)),0) FROM QPTreasureDB.dbo.ShareDetailInfo WHERE CAST(CAST(ApplyDate AS FLOAT) AS INT)=@DateID AND ShareID=3 AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PayCardMedal=ISNULL(SUM(ISNULL(Currency,0)),0) FROM QPTreasureDB.dbo.ShareDetailInfo WHERE CAST(CAST(ApplyDate AS FLOAT) AS INT)=@DateID AND ShareID<>3 AND ShareID<>1 AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PayTureGold=ISNULL(SUM(ISNULL(Currency,0)),0) FROM QPTreasureDB.dbo.ShareDetailInfo WHERE CAST(CAST(ApplyDate AS FLOAT) AS INT)=@DateID AND ShareID=1 AND CardTypeID<>5 AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PayNewUserGold=ISNULL(SUM(ISNULL(Currency,0)),0) FROM QPTreasureDB.dbo.ShareDetailInfo WHERE CAST(CAST(ApplyDate AS FLOAT) AS INT)=@DateID AND ShareID=1 AND CardTypeID=5 AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PreMatchGold=ISNULL(SUM(ISNULL(RewardGold,0)),0) FROM QPGameMatchDB.dbo.StreamMatchHistory WHERE CAST(CAST(RecordDate AS FLOAT) AS INT)=@DateID AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PreLevelGold=ISNULL(SUM(ISNULL(LevelGold,0)),0),@PreLevelMedal=ISNULL(SUM(Medal),0) FROM QPRecordDB.dbo.RecordLevelPresent WHERE CAST(CAST(GetTime AS FLOAT) AS INT)=@DateID AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PreFideGold=ISNULL(SUM(ISNULL(BaseEnsureGold,0)),0) FROM QPRecordDB.dbo.RecordBaseEnsure WHERE CAST(CAST(TakeTime AS FLOAT) AS INT)=@DateID AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PreTaskGold=ISNULL(SUM(ISNULL(AwardGold,0)),0) FROM QPRecordDB.dbo.RecordTask WHERE DateID=@DateID AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PreReferGold=ISNULL(SUM(ISNULL(Score,0)),0) FROM QPTreasureDB.dbo.RecordSpreadInfo WHERE CAST(CAST(CollectDate AS FLOAT) AS INT)=@DateID AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PreMealGold=ISNULL(SUM(ISNULL(PresentScore,0)),0) FROM QPTreasureDB.dbo.StreamPlayPresent WHERE CAST(CAST(FirstDate AS FLOAT) AS INT)=@DateID AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PreRegstGold=ISNULL(SUM(ISNULL(GrantScore,0)),0) FROM QPAccountsDB.dbo.SystemGrantCount WHERE DateID=@DateID 
	SELECT @PreTurnGold=ISNULL(SUM(ISNULL(WinScore,0)),0) FROM QPTreasureDB.dbo.GameRELotteryRecord WHERE CAST(CAST(CollectDate AS FLOAT) AS INT)=@DateID AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PreSignGold=ISNULL(SUM(ISNULL(RewardGold,0)),0) FROM QPRecordDB.dbo.RecordSignin WHERE CAST(CAST(InputDate AS FLOAT) AS INT)=@DateID AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @TotalInsure=ISNULL(SUM(ISNULL(InsureScore,0)),0),@TotalScore=ISNULL(SUM(Score),0) FROM QPTreasureDB.dbo.GameScoreInfo WHERE UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @TotalMedal=ISNULL(SUM(ISNULL(UserMedal,0)),0) FROM QPAccountsDB.dbo.AccountsInfo WHERE UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @PreTaskMedal=ISNULL(SUM(ISNULL(AwardMedal,0)),0) FROM QPRecordDB.dbo.RecordTask WHERE DateID=@DateID AND UserID IN (SELECT UserID FROM QPAccountsDB.dbo.AccountsInfo WHERE IsAndroid=0 AND Nullity=0 )
	SELECT @LostWin=ISNULL(SUM(ISNULL(Waste,0)),0) FROM QPTreasureDB.dbo.RecordDrawInfo WHERE CAST(CAST(InsertTime AS FLOAT) AS INT)=@DateID
	SELECT @BankRevenue = ISNULL(SUM(ISNULL(Revenue,0)),0) FROM QPTreasureDB.dbo.RecordInsure WHERE CAST(CAST(CollectDate AS FLOAT) AS INT)=@DateID
	SELECT @GameRevenue = ISNULL(SUM(ISNULL(Revenue,0)),0) FROM QPTreasureDB.dbo.RecordDrawScore WHERE CAST(CAST(InsertTime AS FLOAT) AS INT)=@DateID
	SELECT @BuyPro1 = ISNULL(SUM(ISNULL(PropPrice,0)),0) FROM QPRecordDB.dbo.RecordSendProperty WHERE CAST(CAST(SendTime AS FLOAT) AS INT)=@DateID
	SELECT @BuyPro2 = ISNULL(SUM(ISNULL(PresentPrice,0)),0) FROM QPRecordDB.dbo.RecordSendPresent WHERE CAST(CAST(SendTime AS FLOAT) AS INT) = @DateID
	SET @BuyPro = @BuyPro1+@BuyPro2
	SELECT @MedalToScore=ISNULL(SUM(ISNULL(ConvertUserMEdal,0)*ConvertRate),0) FROM QPRecordDB.dbo.RecordConvertUserMedal WHERE CAST(CAST(CollectDate AS FLOAT) AS INT)=@DateID
	SELECT @AdminGrant=ISNULL(SUM(ISNULL(AddGold,0)),0) FROM QPRecordDB.dbo.RecordGrantTreasure WHERE CAST(CAST(CollectDate AS FLOAT) AS INT)=@DateID
	
	INSERT INTO [QPRecordDB].[dbo].[RecordDayData]
           ([DateID]
           ,[PayBankGold]
           ,[PayCardGold]
           ,[PayTureGold]
           ,[PayNewUserGold]
           ,[PayBankMedal]
           ,[PayCardMedal]
           ,[PayTureMedal]
           ,[PayNewUserMedal]
           ,[PreMatchGold]
           ,[PreMatchMedal]
           ,[PreLevelGold]
           ,[PreLevelMedal]
           ,[PreFideGold]
           ,[PreFideMedal]
           ,[PreTaskGold]
           ,[PreTaskMedal]
           ,[PreReferGold]
           ,[PreReferMedal]
           ,[PreMealGold]
           ,[PreMealMedal]
           ,[PreRegstGold]
           ,[PreRegstMedal]
           ,[PreTurnGold]
           ,[PreTurnMedal]
           ,[PreSignGold]
           ,[PreSignMedal]
           ,[TotalInsure]
           ,[TotalScore]
           ,[TotalMedal]
           ,[Time]
           ,[LostWin]
           ,[BankRevenue]
           ,[GameRevenue]
           ,[BuyPro]
           ,[MedalToScore]
           ,[AdminGrant])
     VALUES
           (@DateID
           ,@PayBankGold
           ,@PayCardGold
           ,@PayTureGold
           ,@PayNewUserGold
           ,@PayBankMedal
           ,@PayCardMedal
           ,@PayTureMedal
           ,@PreMatchMedal
           ,@PreMatchGold
           ,@PreMatchMedal
           ,@PreLevelGold
           ,@PreLevelMedal
           ,@PreFideGold
           ,@PreFideMedal
           ,@PreTaskGold
           ,@PreTaskMedal
           ,@PreReferGold
           ,@PreReferMedal
           ,@PreMealGold
           ,@PreMealMedal
           ,@PreRegstGold
           ,@PreRegstMedal
           ,@PreTurnGold
           ,@PreTurnMedal
           ,@PreSignGold
           ,@PreSignMedal
           ,@TotalInsure
           ,@TotalScore
           ,@TotalMedal
           ,dateadd(ss,-1,dateadd(d, datediff(d, 0, GETDATE()), 0))
           ,@LostWin
           ,@BankRevenue
           ,@GameRevenue
           ,@BuyPro
           ,@MedalToScore
           ,@AdminGrant)
		
END


GO
----------------------------------------------------------------------------------------------------
CREATE Proc [dbo].[Web_GetGoldStatistical]
(
   @StrYear nvarchar(20),
   @strMonth nvarchar(20)
)
WITH ENCRYPTION AS


select A.* into #web_GoldStatIstical from (
	select Tm, Score,InsureScore,ScoreSum,dianka, wangyin, yikatong, zaixian, isnull(qiandao,0) as qiandao, zhuanpan, jinduan, 
	isNull(tuiguang,0) as tuiguang, jifentojinbi, isnull(bisai,0) as bisai, zhuce,
	isnull(zengsong,0) as zengsong,isNull(xinshoulingqu,0) as xinshoulingqu,isNull(shoujilingqu,0) as shoujilingqu,isNull(ziliaolingqu,0) as ziliaolingqu,isNull(chongzhilingqu,0) as chongzhilingqu,ISNULL(renwulingqu,0) as renwulingqu,
	 jinbitojifen, (0-zhuanzhangshuishou) as zhuanzhangshuishou,(0-shuishou) as shuishou,xitong, ( 0-daoju) as daoju, (0-isNull(lipin,0)) as lipin, (0 -shangcheng) as shangcheng ,
	strDay =(dianka + wangyin + yikatong+ zaixian+ isnull(qiandao,0)+ zhuanpan+ jinduan+ isNull(tuiguang,0)+ jifentojinbi+ isnull(bisai,0)
	+ zhuce +  zengsong + xinshoulingqu + shoujilingqu + ziliaolingqu + chongzhilingqu + renwulingqu+ jinbitojifen+ (0-zhuanzhangshuishou) + 
	xitong + ( 0-isNull(daoju,0)) + (0-isNull(lipin,0)) + (0-isNull(shangcheng,0)))  
from web_GoldStatIstical ) A where Year(A.tm) = @StrYear and Month(A.Tm) = @strMonth order by A.tm asc
--select * from #web_GoldStatIstical order by tm asc


select Tm, Score,InsureScore,ScoreSum,dianka, wangyin, yikatong, zaixian, qiandao, zhuanpan, jinduan, tuiguang, jifentojinbi, bisai, zhuce
,zengsong,xinshoulingqu,shoujilingqu,ziliaolingqu,chongzhilingqu,renwulingqu,
jinbitojifen,zhuanzhangshuishou, shuishou, floor(xitong) as xitong, daoju, lipin, shangcheng,strDay from #web_GoldStatIstical
union all
select null, null,null,null,sum(dianka), sum(wangyin), sum(yikatong), sum(zaixian), sum(isnull(qiandao,0)), sum(zhuanpan), sum(jinduan), sum(isNull(tuiguang,0)), sum(jifentojinbi), sum(isnull(bisai,0)), sum(zhuce)
,sum(zengsong),sum(xinshoulingqu),sum(shoujilingqu),sum(ziliaolingqu),sum(chongzhilingqu),sum(renwulingqu),
 sum(jinbitojifen),sum(zhuanzhangshuishou), sum((shuishou)) as shuishou, floor(sum(xitong)), sum(( 0-daoju)) as daoju, sum(0-isNull(lipin,0)) as lipin, sum(shangcheng),sum(strDay) from #web_GoldStatIstical

drop table #web_GoldStatIstical 

GO
----------------------------------------------------------------------------------------------------