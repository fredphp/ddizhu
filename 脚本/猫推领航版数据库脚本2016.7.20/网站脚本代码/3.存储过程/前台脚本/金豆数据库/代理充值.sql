----------------------------------------------------------------------
-- 版权：2016
-- 时间：2016-03-1
-- 用途：代理充值
----------------------------------------------------------------------

USE [QPTreasureDB]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PW_pGetMoneyStatSum]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PW_pGetMoneyStatSum]
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------
-- 根据年月来统计代理充值情况
CREATE proc [dbo].[NET_PW_pGetMoneyStatSum]
(
    @strNew varchar(20),  --开始年份
    @strMonth varchar(20)   --开始月份
)
WITH ENCRYPTION AS
begin
	/*---
	declare @strNew varchar(20) 
	declare @strMonth varchar(20) 

	set @strNew = '2012'
	set @strMonth ='3'
	--*/

	select A.DetailID, A.UserID, A.GameID, A.Accounts, A.SerialID, A.OrderID, A.CardTypeID, A.PayAmount, A.ApplyDate,
	CONVERT(varchar(100), A.ApplyDate, 111) as nday into #ShareDetailInfo from ShareDetailInfo A ,QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo B 
    where A.UserID = B.UserID and year(A.ApplyDate) = @strNew and Month(A.ApplyDate) =  @strMonth 

	--select * from #ShareDetailInfo
	select  nday into #Date from #ShareDetailInfo group by nday order by nday asc
	--select * from #Date
	/*--------------  赠送点卡--------------  */
	select A.nday, B.DkzsMoney into #temp_dkzs from #Date A 
	left join ( select nday,sum(PayAmount) as DkzsMoney from #ShareDetailInfo where CardTypeID in (5) group by nday ) B on A.nday = B.nday 	order by A.nday
	
	/*--------------  点卡--------------  */
	select A.nday, B.DkMoney into #temp_dk from #Date A 
	left join ( select nday,sum(PayAmount) as DkMoney from #ShareDetailInfo where (orderID is Null or OrderID = '' ) and  CardTypeID not in (5) group by nday ) B on A.nday = B.nday  -- 
	order by A.nday
	--select * from #temp_dk

	/*--------------  网银 -------------- 
	select A.nday, B.WYMoney into #temp_WY from #Date A 
	left join ( select nday,sum(PayAmount) as WYMoney from #ShareDetailInfo where (CardTypeID=10000 or  CardTypeID = 9999)  group by nday ) B on A.nday = B.nday  -- 
	order by A.nday
	 */

	/*--------------  网银 --------------  */
	select A.nday, B.WYMoney into #temp_WY from #Date A 
	left join ( select nday,sum(PayAmount) as WYMoney from #ShareDetailInfo where (orderID <> '')  group by nday ) B on A.nday = B.nday  -- 
	order by A.nday

	--select * from #temp_dk
	--select * from #temp_WY

	/*------------------------------汇总----------------------------------------*/

	select CONVERT(varchar(10), dk.nday, 120 ) as strDate,isNull(dkzs.DkzsMoney,0) as DkzsMoney,isNull(dk.DkMoney,0) as DkMoney,isNull(wy.WYMoney,0) as WYMoney,(isNull(dkzs.DkzsMoney,0) + isNull(dk.DkMoney,0) + isNull(wy.WYMoney,0)) as dayMoney 
    into #temp_hz	from #temp_dk dk 
    left join #temp_wy wy on wy.nday = dk.nday 
    left join #temp_dkzs dkzs on dkzs.nday = dk.nday 

	select * from #temp_hz
	select IsNull(sum(DkzsMoney),0) as DkzsMoney,IsNull(sum(DkMoney),0) as DkMoney,isNull(sum(WYMoney),0) as WYMoney,isNull(sum(dayMoney),0) as hzMoney from #temp_hz

	drop table #ShareDetailInfo
	drop table #Date
    drop table #temp_dkzs
	drop table #temp_dk
	drop table #temp_WY
    drop table #temp_hz
END

RETURN 0

GO
-------------------------------------------------------------------------------------------------------------------------