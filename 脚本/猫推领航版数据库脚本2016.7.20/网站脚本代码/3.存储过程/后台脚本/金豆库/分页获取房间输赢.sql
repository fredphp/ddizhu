----------------------------------------------------------------------
-- 时间：2015-03-7
-- 用途：分页获取房间输赢
----------------------------------------------------------------------

USE QPTreasureDB
GO
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PM_GetRoomLostWin]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PM_GetRoomLostWin]
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------
CREATE PROCEDURE dbo.NET_PM_GetRoomLostWin
	@TableName		NVARCHAR(200),			-- 表名
	@ReturnFields	NVARCHAR(1000) = '*',	-- 查询列数
	@PageSize		INT = 10,				-- 每页数目
	@PageIndex		INT = 1,				-- 当前页码
	@Where			NVARCHAR(1000) = '',	-- 查询条件
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
		SET @countSql='SELECT @TotalRecord=Count(*) From (SELECT COUNT(*) t FROM '+@TableName+' '+@Where + ') AS Temp'
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
			FROM (SELECT TOP '+@TotalRecordForPageIndex+' '+@ReturnFields+', ROW_NUMBER() OVER ('+@OrderBy+') AS PageView_RowNo
			FROM '+@TableName+ ' ' + @Where +' ) AS TempPageViewTable
			WHERE TempPageViewTable.PageView_RowNo > 
			'+@CurrentPageSize)
	
END
RETURN 0

--------------------------------------------------------------------------------------------------------------------
			

