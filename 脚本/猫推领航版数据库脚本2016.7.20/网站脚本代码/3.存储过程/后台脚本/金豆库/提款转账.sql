----------------------------------------------------------------------
-- 时间：2015-01-28
-- 用途：提款转账
----------------------------------------------------------------------

USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[usp_transfer_accounts]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[usp_transfer_accounts]

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[usp_withdrawal_monermy]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[usp_withdrawal_monermy]

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_GrantWith]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_GrantWith]

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_GrantTransfer]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_GrantTransfer]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
CREATE proc [dbo].[usp_transfer_accounts]
(
 @Monmey bigint, --增加银行金豆
 @addUserID int,
 @delUserID int
)
WITH ENCRYPTION AS

begin transaction --开始事务
 
declare @addcheck int  --定义错误计数器
 
set @addcheck=0
 
update QPTreasureDB..GameScoreInfo  set InsureScore=InsureScore+@Monmey where UserID=@addUserID
  
update QPTreasureDB..GameScoreInfo  set InsureScore=InsureScore-@Monmey where UserID=@delUserID and InsureScore>=@Monmey
set @addcheck=@@ROWCOUNT
 
if  @addcheck<>1

begin

 rollback transaction --事务回滚语句
 
end

else

begin

commit transaction --事务提交语句

end

RETURN 0

GO
----------------------------------------------------------------------

CREATE proc [dbo].[usp_withdrawal_monermy]
(
 @Monmey bigint, --增加银行金豆
 @UserID int
 )
 
WITH ENCRYPTION AS

begin transaction --开始事务
declare @errorSun int --定义错误计数器
set @errorSun=0
update QPTreasureDB..GameScoreInfo  set Score=Score-@Monmey where UserID=@UserID and Score>=@Monmey 
set @errorSun=@errorSun+@@ROWCOUNT

update QPTreasureDB..GameScoreInfo  set InsureScore=InsureScore+@Monmey where UserID=@UserID
 
if @errorSun<>1
begin
 
rollback transaction --事务回滚语句
end
else
begin
 
commit transaction --事务提交语句
end

RETURN 0

GO
----------------------------------------------------------------------

CREATE proc [dbo].[NET_PM_GrantWith]
(
	@dwMasterID int, --管理员标识
	@dwithFront int,--提款前
	@dwithMoney int,--提款金额
	@dwClientIP varchar(15),--操作ip
	@dwUserID int,--提款帐号ID
	@dwCollectDate datetime--操作时间
)

WITH ENCRYPTION AS

declare @insurecore int 
 select @insurecore=isnull(InsureScore ,0)from GameScoreInfo where userid=@dwUserID
insert into QPRecordDB.dbo.RecordGrantWith
values(@dwMasterID,@dwithFront,@dwithMoney,@dwClientIP,@dwUserID,@dwCollectDate,@insurecore)

GO
----------------------------------------------------------------------

CREATE proc [dbo].[NET_PM_GrantTransfer]
(
	@dwMasterID int ,--管理员标识
	@dwTransferFront bigint , --转账前
	@dwTransferMoney bigint ,--转账金额
	@dwaddUserID int ,--汇款用户
	@dwdelUserID int ,--收款用户
	@dwCollectDate datetime,--操作时间
	@dwClientIP varchar(15)--操作ip
)
WITH ENCRYPTION AS
insert into QPRecordDB.dbo.RecordGrantTransfer 
values(@dwMasterID,@dwTransferFront,@dwTransferMoney,@dwaddUserID,@dwdelUserID,@dwCollectDate,@dwClientIP)

GO
---------------------------------------------------------------------

