USE [QPTreasureDB]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_EMailRead]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_EMailRead]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_RecordEMail]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_RecordEMail]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_AddRecordEMail]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_AddRecordEMail]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
--修改阅读标识
CREATE PROC [dbo].[GSP_GR_EMailRead]
	@dwRecordID INT,			--邮件ID
    @dwUserID INT			    -- 用户 I D
  

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @RecordID INT

-- 执行逻辑
BEGIN
	SELECT  @RecordID=@RecordID from RecordUser  where UserId=@dwUserID AND RecordID= @dwRecordID
	if(@RecordID is null)
		UPDATE RecordUser SET HaveRead=1 where UserId=@dwUserID AND RecordID= @dwRecordID
END

SET NOCOUNT OFF
RETURN 0

GO

----------------------------------------------------------------------------------------------------
CREATE PROC [dbo].[GSP_GR_RecordEMail]

    @dwUserID INT,						   -- 用户 I D
    @cbAll TINYINT,							--查询所有邮件
	@stTransferTime DATETIME,					-- 指定查询某天的邮件    
    @strErrorDescribe NVARCHAR(127) OUTPUT		-- 输出信息

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON
--基本信息
	DECLARE @RecordID INT
	DECLARE @FromUserID NVARCHAR
	DECLARE @FromUserName INT
	DECLARE @HaveRead BIGINT
	DECLARE @EMailTitle NVARCHAR(500)
	DECLARE @EMailContent NVARCHAR(500)
	DECLARE @CollectDate DATETIMe
-- 执行逻辑
BEGIN
    DECLARE @UserID INT
	DECLARE @Nullity BIT
	DECLARE @StunDown BIT
    DECLARE @SourceMemberOrder SMALLINT
	DECLARE @SourceMemberOverDate DATETIME
	DECLARE @SourceMemberSwitchDate DATETIME
 
    SELECT @UserID=UserID, @Nullity=Nullity, @StunDown=StunDown, @SourceMemberOrder=MemberOrder, @SourceMemberOverDate=MemberOverDate, @SourceMemberSwitchDate=MemberSwitchDate 
	FROM QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo WHERE UserID=@dwUserID

    -- 帐号禁止
	IF @Nullity<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号暂时处于冻结状态，请联系客户服务中心了解详细情况！'
		RETURN 2
	END	

	-- 帐号关闭
	IF @StunDown<>0
	BEGIN
		SET @strErrorDescribe=N'您的帐号使用了安全关闭功能，必须重新开通后才能继续使用！'
		RETURN 2
	END	

    DECLARE @TransferTime DATETIME
	IF @cbAll=1
	BEGIN
       -- SET @stTransferTime=DATEADD(day,-7,CONVERT(DATETIME,LEFT(GETDATE(),10)+' 00:00:00.000'))
		SELECT TOP 2000 a.RecordID as RecordID,a.FromUserID as FromUserID,a.FromUserName as FromUserName,
		a.EMailTitle as EMailTitle,a.EMailContent as EMailContent,a.CollectDate as CollectDate,b.HaveRead as HaveRead
		from 
		(SELECT RecordID,FromUserID,FromUserName,EMailTitle,EMailContent,CollectDate FROM 
		QPTreasureDB.dbo.RecordEMail) AS a   
		INNER JOIN (SELECT userid,recordid,haveread FROM QPTreasureDB.dbo.RecordUser  WHERE USERID = @dwUserID) AS b ON a.RecordID=b.RecordID 
        ORDER BY RecordID DESC
	END
    ELSE
    BEGIN
      DECLARE @stTransferTimeStart DATETIME
      DECLARE @stTransferTimeEnd DATETIME
      SET @stTransferTimeStart=CONVERT(DATETIME,LEFT(@stTransferTime,10)+' 00:00:00.000')
      SET @stTransferTimeEnd=DATEADD(day,1,@stTransferTimeStart)
	  SELECT TOP 2000 a.RecordID as RecordID,a.FromUserID as FromUserID,a.FromUserName as FromUserName,
	  a.EMailTitle as EMailTitle,a.EMailContent as EMailContent,a.CollectDate as CollectDate,b.HaveRead as HaveRead
	  from 
	  (SELECT RecordID,FromUserID,FromUserName,EMailTitle,EMailContent,CollectDate FROM 
	  RecordEMail WHERE CollectDate>=@stTransferTimeStart AND CollectDate<@stTransferTimeEnd ) AS a   
	 INNER JOIN (SELECT userid,recordid,haveread FROM QPTreasureDB.dbo.RecordUser  WHERE USERID = @dwUserID) AS b ON a.RecordID=b.RecordID 
	  ORDER BY RecordID DESC
    END

SELECT @RecordID AS RecordID,@FromUserID AS FromUserID,@FromUserName AS FromUserName,@HaveRead AS HaveRead,@EMailTitle AS EMailTitle,@EMailContent AS EMailContent,@CollectDate AS CollectDate
END

SET NOCOUNT OFF
RETURN 0

GO
-----------------------------------------------------------------------------------------------------------------------------
CREATE PROC [dbo].[GSP_GR_AddRecordEMail]
	 @FromUserID INT,
	 @FromUserName NVARCHAR(50),
	 @EMailTitle NVARCHAR(500),
	 @EMailContent NVARCHAR(Max)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON
--基本信息
	DECLARE @RecordID INT
    DECLARE @UserID INT
	DECLARE @UserIDCount bigint
	-- 执行逻辑
	BEGIN
	    -- 增加邮件
		INSERT RecordEMail (FromUserID,FromUserName,EMailTitle,EMailContent)
		VALUES (@FromUserID,@FromUserName,@EMailTitle,@EMailContent)
		
		select top 1 @RecordID = RecordID from RecordEMail order by RecordID DESC
		insert into dbo.RecordUser (UserID) (select userid from QPAccountsDB.dbo.AccountsInfo where IsAndroid=0)
		update dbo.RecordUser set RecordID = @RecordID where RecordID=0
	END

SET NOCOUNT OFF
RETURN 0

GO
--------------------------------------------------------------------------------------------------------------------------------------
