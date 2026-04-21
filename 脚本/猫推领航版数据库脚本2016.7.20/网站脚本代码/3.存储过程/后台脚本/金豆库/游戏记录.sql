----------------------------------------------------------------------
-- 时间：2016-03-16
-- 用途：赠送经验
----------------------------------------------------------------------

USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[WSP_PM_GetRecordDrawScoreByDrawID]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[WSP_PM_GetRecordDrawScoreByDrawID]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_GetUserDrawList]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_GetUserDrawList]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------
CREATE PROCEDURE WSP_PM_GetRecordDrawScoreByDrawID
		@dwDrawID		INT			-- 局ID
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 用户经验
DECLARE @CurExperience INT
	
-- 执行逻辑
BEGIN
	SELECT A.*,B.Accounts,B.Accounts,B.NickName,B.GameID,B.IsAndroid FROM RecordDrawScore AS A 
	Left JOIN QPAccountsDBLink.QPAccountsDB.dbo.AccountsInfo AS B
	ON A.UserID=B.UserID
	WHERE DrawID=@dwDrawID
END

RETURN 0

GO
--------------------------------------------------------------------

CREATE  PROCEDURE NET_PM_GetUserDrawList
	@TableName		NVARCHAR(200),			-- 表名
	@ReturnFields	NVARCHAR(1000),	-- 查询列数
	@PageSize		INT = 10,				-- 每页数目
	@PageIndex		INT = 1,				-- 当前页码
	@Where			NVARCHAR(1000),	-- 查询条件
	@OrderBy		NVARCHAR(1000),			-- 排序字段
	@PageCount		INT OUTPUT,				-- 页码总数
	@RecordCount	INT OUTPUT	        	-- 记录总数

WITH ENCRYPTION AS

--设置属性
SET NOCOUNT ON

-- 变量定义
DECLARE @TotalRecord INT
DECLARE @TotalPage INT
DECLARE @CurrentPageSize INT
DECLARE @TotalRecordForPageIndex INT

BEGIN
	IF @Where IS NULL SET @Where=N''
	
	-- 记录总数
	DECLARE @countSql NVARCHAR(4000)  
	
	IF @RecordCount IS NULL
	BEGIN
		SET @countSql='SELECT @TotalRecord=Count(*) From '+@TableName+' '+@Where
		EXECUTE sp_executesql @countSql,N'@TotalRecord int out',@TotalRecord OUT
	END
	ELSE
	BEGIN
		SET @TotalRecord=@RecordCount
	END		
	
	SET @RecordCount=@TotalRecord
	SET @TotalPage=(@TotalRecord-1)/@PageSize+1	
	SET @CurrentPageSize=(@PageIndex-1)*@PageSize

	-- 返回总页数和总记录数
	SET @PageCount=@TotalPage
	SET @RecordCount=@TotalRecord
		
	-- 返回记录
	SET @TotalRecordForPageIndex=@PageIndex*@PageSize

	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tableTemp]') AND type in (N'U'))
	DROP TABLE [dbo].[tableTemp]	

	CREATE TAble tableTemp(
		[DrawID] [int] NULL,
		[KindID] [int] NULL,
		[ServerID] [int] NULL,
		[TableID] [int] NULL,
		[UserCount] [int] NULL,
		[AndroidCount] [int] NULL,
		[Waste] [bigint] NULL,
		[Revenue] [bigint] NULL,
		[UserMedal] [int] NULL,
		[StartTime] [datetime] NULL,
		[ConcludeTime] [datetime] NULL,
		[InsertTime] [datetime] NULL,
		[DrawCourse] [image] NULL,
		[KindName] [nvarchar](200),
		[ServerName] [nvarchar](200),
		[PageView_RowNo] [INT]
	)
	
	EXEC	('insert into tableTemp([DrawID]
		   ,[KindID]
           ,[ServerID]
           ,[TableID]
           ,[UserCount]
           ,[AndroidCount]
           ,[Waste]
           ,[Revenue]
           ,[UserMedal]
           ,[StartTime]
           ,[ConcludeTime]
           ,[InsertTime]
           ,[DrawCourse]
           ,[KindName]
           ,[ServerName]
           ,[PageView_RowNo]) SELECT *
			FROM (SELECT TOP '+@TotalRecordForPageIndex+' '+@ReturnFields+', ROW_NUMBER() OVER ('+@OrderBy+') AS PageView_RowNo
			FROM '+@TableName+ ' ' + @Where +' ) AS TempPageViewTable 
			WHERE TempPageViewTable.PageView_RowNo > 
			'+@CurrentPageSize)
			
	SELECT * FROM tableTemp
	
	SELECT a.*,b.Accounts FROM RecordDrawScore  a,QPAccountsDB.dbo.AccountsInfo b WHERE a.UserID=b.UserID AND DrawID IN (SELECT DrawID FROM tableTemp)
	
	drop table tableTemp
		
END

RETURN 0

GO

--------------------------------------------------------------------------------------------------------------------------------------------
