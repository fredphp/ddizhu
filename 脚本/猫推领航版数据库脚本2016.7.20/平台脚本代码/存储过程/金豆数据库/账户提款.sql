
----------------------------------------------------------------------------------------------------

USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[usp_transfer_accounts]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[usp_transfer_accounts]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[usp_withdrawal_monermy]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[usp_withdrawal_monermy]
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
GO
----------------------------------------------------------------------------------------------------
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

GO
----------------------------------------------------------------------------------------------------
