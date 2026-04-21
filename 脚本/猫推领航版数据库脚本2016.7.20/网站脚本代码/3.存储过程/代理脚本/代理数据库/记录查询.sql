
----------------------------------------------------------------------------------------------------

USE QPAgencyDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_GetAgencyReport]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_GetAgencyReport]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NEW_PW_GetStopAgencyList]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NEW_PW_GetStopAgencyList]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NEW_PW_GetAgencyReport]
	@PageSize		INT = 10,				-- 每页记录数
	@PageIndex		INT = 1,				-- 当前页码
	@Where			NVARCHAR(1000) = '',	-- 查询条件
	@OrderBy		NVARCHAR(1000),			-- 排序字段名 最好为唯一主键	
	@PageCount		INT OUTPUT,				-- 页码总数
	@RecordCount	INT OUTPUT	        	-- 记录总数
WITH ENCRYPTION AS

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
		SET @countSql='SELECT @TotalRecord=Count(*) From AgencyInfo a '+' '+@Where
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
			
	EXEC	('SELECT * 
			FROM(SELECT TOP '+@TotalRecordForPageIndex+' a.AgencyID,a.LoginName,
			(SELECT Count(*) FROM ( SELECT DISTINCT UserID FROM QPTreasureDB.dbo.ShareDetailInfo WHERE UserID IN (SELECT UserID FROM QPAgencyDB.dbo.Agency_User WHERE AgencyID=a.AgencyID)) temp ) AS PayCount,
			AgencyName,
			(SELECT LoginName FROM AgencyInfo WHERE AgencyID=a.AgencyParentID) AgencyParent,
			ISNULL((SELECT SUM(RegisterCounts) FROM QPAgencyDB.dbo.UserPlay WHERE AgencyID=a.AgencyID),0) RegisterCount,
			ISNULL((SELECT SUM(CanUserCounts) FROM QPAgencyDB.dbo.UserPlay WHERE AgencyID=a.AgencyID),0) UserCount,
			UserPrice,
			ISNULL(SUM(RoyaltyGold),0) RoyaltyGold,
			AgencyGold,
			ISNULL((SELECT SUM(DrawGold) FROM RecordDraw WHERE AgencyID=a.AgencyID),0) DrawGold,
			ISNULL((SELECT SUM(DrawGold) FROM RecordBringGold WHERE AgencyID=a.AgencyID),0) BringGold,
			ROW_NUMBER() OVER ('+@OrderBy+') AS PageView_RowNo
			FROM AgencyInfo a left join RecordRoyalty on a.AgencyID=RecordRoyalty.AgencyID '
			+ @Where +'
			Group by a.AgencyID,a.LoginName,a.AgencyName,a.AgencyParentID,a.UserPrice,a.AgencyGold,RoyaltyGold ) AS TEMP
			WHERE TEMP.PageView_RowNo>'+@CurrentPageSize)
	
END
RETURN 0

GO
----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[NEW_PW_GetStopAgencyList] 
	
	@TableName		NVARCHAR(200),			-- 表名
	@ReturnFields	NVARCHAR(1000) = '*',	-- 需要返回的列 
	@PageSize		INT = 10,				-- 每页记录数
	@PageIndex		INT = 1,				-- 当前页码
	@Where			NVARCHAR(1000) = '',	-- 查询条件
	@OrderBy		NVARCHAR(1000),			-- 排序字段名 最好为唯一主键	
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
	IF @ReturnFields IS NULL OR @ReturnFields=''
		SET @ReturnFields=N'*'
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
	DECLARE @CanUserCount int
	DECLARE @RegisterCount int
	SELECT @CanUserCount=UserCount,@RegisterCount=RegisterCount FROM AgencyConfig WHERE AgencyConfigName='AgencyCofig'
	DECLARE @days int
	SELECT @days=OverdueDay FROM AgencyConfig WHERE AgencyConfigName='AgencyCofig'
	DECLARE @CanDateID int
	SET @CanDateID=CAST(CAST(DateAdd(d,-@days, GETDATE()) AS FLOAT) AS INT)
	DECLARE @RegisterDate int
	
	EXEC	('SELECT *
			FROM (SELECT TOP '+@TotalRecordForPageIndex+' '+@ReturnFields+', ROW_NUMBER() OVER ('+@OrderBy+') AS PageView_RowNo
			FROM '+@TableName+ ' ' + @Where +' AND CAST(CAST(RegisterDate AS FLOAT) AS INT)<'+@CandateID+' AND AgencyID NOT IN (SELECT AgencyID FROM UserPlay WHERE DateID>'+@CanDateID+' GROUP BY AgencyID HAVING SUM(CanUserCounts)>'+@CanUserCount+' AND SUM(RegisterCounts)>'+@RegisterCount+') ) AS TempPageViewTable
			WHERE TempPageViewTable.PageView_RowNo > 
			'+@CurrentPageSize)
	
END
RETURN 0

GO

----------------------------------------------------------------------------------------------------