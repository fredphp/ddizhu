USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[getRoomPlayerWin]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[getRoomPlayerWin]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_ClearLocker]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_ClearLocker]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

-------------------------------------------------------------------------
CREATE PROCEDURE   [dbo].[getRoomPlayerWin]
	   @index int =1,
       @count  int =20,
	   @where varchar(200),
	   @table varchar(30),
	   @fils varchar(200),
	   @orderby varchar(20),
	   @having varchar(200)
	   ,@allnum int output 

WITH ENCRYPTION AS
BEGIN
		SET NOCOUNT ON; 
declare @minc int
declare @maxc int
set @minc=(@index-1)*@count
set @maxc=(@index)*@count

declare @filter nvarchar(max)
		set @filter ='
		with c as(
		SELECT   row_number() over( order by '+@orderby+') as row,'+@fils+'    
		  FROM '+ @table+' '+@where +' 		
		group by '+ @orderby+' 
		'+@having+'	)
		select   @allnums=count (* )from c  '
		
	declare @ParmDefinition nvarchar(max)
	SET @ParmDefinition = N' @allnums int OUTPUT'
	EXEC sp_executesql @filter ,@ParmDefinition,@allnums=@allnum  OUTPUT; 				
		set @filter='with c as(
		SELECT   row_number() over( order by '+@orderby+') as row,'+@fils+'    
		  FROM '+ @table+' '+@where +' 		
		group by '+ @orderby+' 
		'+@having+'	)
		select * from c where c.row between '+cast(@minc as varchar)+' and '+cast (@maxc as varchar)+''
		exec (@filter)

END

GO

---------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE GSP_GR_ClearLocker
	-- Add the parameters for the stored procedure here
	@strUserIds varchar(127)	--卡线用户ID
WITH ENCRYPTION AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- 锁定解除
	EXEC('DELETE GameScoreLocker WHERE GameScoreLocker.UserID IN ('+@strUserIds+')')
	
	
END


GO
-------------------------------------------------------------------------



