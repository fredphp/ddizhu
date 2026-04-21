USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_GrantWith]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_GrantWith]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_GrantTransfer]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_GrantTransfer]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

-------------------------------------------------------------------------
CREATE proc [dbo].[NET_PM_GrantWith]
(
	@dwMasterID int, --管理员标识
	@dwithFront bigint,--提款前
	@dwithMoney bigint,--提款金额
	@dwClientIP varchar(15),--操作ip
	@dwUserID int,--提款帐号ID
	@dwCollectDate varchar(36)--操作时间
)
WITH ENCRYPTION AS
declare @insurecore bigint 
 select @insurecore=isnull(InsureScore ,0)from GameScoreInfo where userid=@dwUserID
insert into QPRecordDB.dbo.RecordGrantWith
values(@dwMasterID,@dwithFront,@dwithMoney,@dwClientIP,@dwUserID,Convert(datetime,@dwCollectDate),@insurecore)
GO

-------------------------------------------------------------------------
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
-------------------------------------------------------------------------