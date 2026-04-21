
----------------------------------------------------------------------------------------------------

USE QPTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_RecordDrawInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_RecordDrawInfo]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[GSP_GR_RecordDrawScore]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[GSP_GR_RecordDrawScore]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[proc_DataPagination]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[proc_DataPagination]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------

-- 游戏记录
CREATE PROC GSP_GR_RecordDrawInfo

	-- 房间信息
	@wKindID INT,								-- 游戏 I D
	@wServerID INT,								-- 房间 I D

	-- 桌子信息
	@wTableID INT,								-- 桌子号码
	@wUserCount INT,							-- 用户数目
	@wAndroidCount INT,							-- 机器数目

	-- 税收损耗
	@lWasteCount BIGINT,						-- 损耗数目
	@lRevenueCount BIGINT,						-- 游戏税收

	-- 统计信息
	@dwUserMemal BIGINT,						-- 损耗数目
	@dwPlayTimeCount INT,						-- 游戏时间

	-- 时间信息
	@SystemTimeStart DATETIME,					-- 开始时间
	@SystemTimeConclude DATETIME				-- 结束时间

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	if exists ( select  *  from QPPlatformDB.dbo.GameGameItem where IsWriteScore=1 and GameID =(    select GameID from QPPlatformDB.dbo.GameKindItem where KindID=@wKindID   ))
	begin
		 SELECT 0 AS DrawID
		 return 0
	end
	-- 插入记录
	INSERT RecordDrawInfo(KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,UserMedal,StartTime,ConcludeTime)
	VALUES (@wKindID,@wServerID,@wTableID,@wUserCount,@wAndroidCount,@lWasteCount,@lRevenueCount,@dwUserMemal,@SystemTimeStart,@SystemTimeConclude)
	
	-- 读取记录
	SELECT SCOPE_IDENTITY() AS DrawID

END

RETURN 0

GO

----------------------------------------------------------------------------------------------------

-- 游戏记录
CREATE PROC GSP_GR_RecordDrawScore

	-- 房间信息
	@dwDrawID INT,								-- 局数标识
	@dwUserID INT,								-- 用户标识
	@wChairID INT,								-- 椅子号码

	-- 用户信息
	@dwDBQuestID INT,							-- 请求标识
	@dwInoutIndex INT,							-- 进出索引

	-- 成绩信息
	@lScore BIGINT,								-- 用户积分
	@lGrade BIGINT,								-- 用户成绩
	@lRevenue BIGINT,							-- 用户税收
	@dwUserMedal BIGINT,							-- 奖牌数目
	@dwPlayTimeCount INT							-- 游戏时间

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN

	if (@dwDrawID=0)
	begin 
		 return 0
	end
	-- 插入记录
	INSERT RecordDrawScore(DrawID,UserID,ChairID,Score,Grade,Revenue,UserMedal,PlayTimeCount,DBQuestID,InoutIndex)
	VALUES (@dwDrawID,@dwUserID,@wChairID,@lScore,@lGrade,@lRevenue,@dwUserMedal,@dwPlayTimeCount,@dwDBQuestID,@dwInoutIndex)
	
END

RETURN 0

GO

----------------------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[proc_DataPagination]  

 @tblName     nvarchar(200),        ----要显示的表或多个表的连接  
 @fldName     nvarchar(500) = '*',    ----要显示的字段列表  
 @pageSize    int = 10,        ----每页显示的记录个数  
 @page        int = 1,        ----要显示那一页的记录  
 @fldSort    nvarchar(200) = null,    ----排序字段列表或条件  
 @Sort        bit = 0,        ----排序方法，1为升序，0为降序(如果是多字段排列Sort指代最后一个排序字段的排列顺序(最后一个排序字段不加排序标记)--程序传参如：' SortA Asc,SortB Desc,SortC ')  
 @strCondition    nvarchar(1000) = null,    ----查询条件,不需where  
 @ID        nvarchar(150),        ----主表的主键  
 @Dist      bit = 0,           ----是否添加查询字段的 DISTINCT 默认0不添加/1添加  
 @pageCount    int = 1 output,            ----查询结果分页后的总页数  
 @Counts    int = 1 output,              ----查询到的记录数
 @min char(50)='' output
  
WITH ENCRYPTION AS  
 SET NOCOUNT ON  
 Declare @sqlTmp nvarchar(1000)        ----存放动态生成的SQL语句  
 Declare @strTmp nvarchar(1000)        ----存放取得查询结果总数的查询语句  
 Declare @strID     nvarchar(1000)        ----存放取得查询开头或结尾ID的查询语句  
   
 Declare @strSortType nvarchar(10)    ----数据排序规则A  
 Declare @strFSortType nvarchar(10)    ----数据排序规则B  
   
 Declare @SqlSelect nvarchar(50)         ----对含有DISTINCT的查询进行SQL构造  
 Declare @SqlCounts nvarchar(50)          ----对含有DISTINCT的总数查询进行SQL构造  
 declare @begin datetime,@end datetime
 set @begin =getdate()  
   
 if @Dist  = 0  
 begin  
     set @SqlSelect = 'select '  
     set @SqlCounts = 'Count(0)'  
 end  
 else  
 begin  
     set @SqlSelect = 'select distinct '  
     set @SqlCounts = 'Count(DISTINCT '+@ID+')'  
 end  
   
   
 if @Sort=0  
 begin  
     set @strFSortType=' DESC '  
     set @strSortType=' DESC '  
 end  
 else  
 begin  
     set @strFSortType=' ASC '  
     set @strSortType=' ASC '  
 end  
   
if(@fldSort is not null and @fldSort<>'')
begin
    set @fldSort=','+@fldSort
end
else
begin
    set @fldSort=' '
end
   
 --------生成查询语句--------  
 --此处@strTmp为取得查询结果数量的语句  
 if @strCondition is null or @strCondition=''     --没有设置显示条件  
 begin  
     set @sqlTmp =  @fldName + ' From ' + @tblName  
     set @strTmp = @SqlSelect+' @Counts='+@SqlCounts+' FROM '+@tblName  
     set @strID = ' From ' + @tblName  
 end  
 else  
 begin  
     set @sqlTmp = + @fldName + 'From ' + @tblName + ' where (1>0) ' + @strCondition  
     set @strTmp = @SqlSelect+' @Counts='+@SqlCounts+' FROM '+@tblName + ' where (1>0) ' + @strCondition  
     set @strID = ' From ' + @tblName + ' where (1>0) ' + @strCondition  
 end  
   
 ----取得查询结果总数量-----  
 exec sp_executesql @strTmp,N'@Counts int out ',@Counts out  
 declare @tmpCounts int  
 if @Counts = 0  
     set @tmpCounts = 1  
 else  
     set @tmpCounts = @Counts  
   
     --取得分页总数  
     set @pageCount=(@tmpCounts+@pageSize-1)/@pageSize  
   
     /**//**当前页大于总页数 取最后一页**/  
     if @page>@pageCount  
         set @page=@pageCount  
   
     --/*-----数据分页2分处理-------*/  
     declare @pageIndex int --总数/页大小  
     declare @lastcount int --总数%页大小   
   
     set @pageIndex = @tmpCounts/@pageSize  
     set @lastcount = @tmpCounts%@pageSize  
     if @lastcount > 0  
         set @pageIndex = @pageIndex + 1  
     else  
         set @lastcount = @pagesize  
  
 --为配合显示  
 --set nocount off  
 --select @page curpage,@pageSize pagesize,@pageCount countpage,@tmpCounts [Rowcount]  
 --set nocount on  
  
  --//***显示分页  
     if @strCondition is null or @strCondition=''     --没有设置显示条件  
     begin  
         if @pageIndex<2 or @page<=@pageIndex / 2 + @pageIndex % 2   --前半部分数据处理  
             begin   
                 if @page=1  
                     set @strTmp=@SqlSelect+' top '+ CAST(@pageSize as VARCHAR(40))+' '+ @fldName+' from '+@tblName                          
                         +' order by '+ @ID+' '+ @strFSortType+@fldSort
                 else  
                 begin                      
                     set @strTmp=@SqlSelect+' top '+ CAST(@pageSize as VARCHAR(40))+' '+ @fldName+' from '+@tblName  
                         +' where '+@ID  
                     if @Sort=0  
                        set @strTmp = @strTmp + '<(select min('  
                     else  
                        set @strTmp = @strTmp + '>(select max('  
                     set @strTmp = @strTmp + 'TPID) from ('+ @SqlSelect+' top '+ CAST(@pageSize*(@page-1) as Varchar(20)) +' '+ @ID +' as TPID from '+@tblName  
                         +' order by '+ @ID+' '+ @strFSortType+@fldSort+') AS TBMinID)'  
                         +' order by '+ @ID+' '+ @strFSortType+@fldSort
                 end      
             end  
         else  
               
             begin  
             set @page = @pageIndex-@page+1 --后半部分数据处理  
                 if @page <= 1 --最后一页数据显示              
                     set @strTmp=@SqlSelect+' * from ('+@SqlSelect+' top '+ CAST(@lastcount as VARCHAR(40))+' '+ @fldName+' from '+@tblName  
                         +' order by '+ @ID +' '+ @strSortType+@fldSort+') AS TempTB'+' order by '+ @ID+' '+ @strFSortType+@fldSort 
                 else  
                     begin  
                     set @strTmp=@SqlSelect+' * from ('+@SqlSelect+' top '+ CAST(@pageSize as VARCHAR(40))+' '+ @fldName+' from '+@tblName  
                         +' where '+@ID  
                         if @Sort=0  
                            set @strTmp=@strTmp+' <(select min('  
                         else  
                            set @strTmp=@strTmp+' >(select max('  
  set @strTmp=@strTmp+'TPID) from('+ @SqlSelect+' top '+ CAST(@pageSize*(@page-2)+@lastcount as Varchar(20)) +' '+ @ID +'as TPID from '+@tblName  
                         +' order by '+ @ID +' '+ @strSortType+@fldSort+') AS TBMaxID)'  
                         +' order by '+ @ID +' '+ @strSortType+@fldSort+') AS TempTB'+' order by '+ @ID+' '+ @strFSortType+@fldSort 
                    end  
             end  
   
     end  
   
     else --有查询条件  
     begin  
         if @pageIndex<2 or @page<=@pageIndex / 2 + @pageIndex % 2   --前半部分数据处理  
         begin  
                 if @page=1  
                     set @strTmp=@SqlSelect+' top '+ CAST(@pageSize as VARCHAR(40))+' '+ @fldName+' from '+@tblName                          
                         +' where 1=1 ' + @strCondition + ' order by '+ @ID+' '+ @strFSortType+@fldSort
                 else  
                 begin                      
                     set @strTmp=@SqlSelect+' top '+ CAST(@pageSize as VARCHAR(40))+' '+ @fldName+' from '+@tblName  
                         +' where '+@ID  
                     if @Sort=0  
                        set @strTmp = @strTmp + '>(select max('  
                     else  
                        set @strTmp = @strTmp + '<(select min('  
   
                  set @strTmp = @strTmp + @ID +') from ('+ @SqlSelect+' top '+ CAST(@pageSize*(@page-1) as Varchar(20)) +' '+ @ID +' from '+@tblName  
                         +' where (1=1) ' + @strCondition +' order by '+ @ID+' '+ @strFSortType+@fldSort+') AS TBMinID)'  
                         +' '+ @strCondition +' order by '+ @ID+' '+ @strFSortType+@fldSort
                 end              
         end  
         else  
         begin   
             set @page = @pageIndex-@page+1 --后半部分数据处理  
             if @page <= 1 --最后一页数据显示  
                     set @strTmp=@SqlSelect+' * from ('+@SqlSelect+' top '+ CAST(@lastcount as VARCHAR(40))+' '+ @fldName+' from '+@tblName  
                         +' where (1=1) '+ @strCondition +' order by '+ @ID +' '+ @strSortType+@fldSort+') AS TempTB'+' order by '+ @ID+' '+ @strFSortType+@fldSort                     
             else  
                   begin  
                     set @strTmp=@SqlSelect+' * from ('+@SqlSelect+' top '+ CAST(@pageSize as VARCHAR(40))+' '+ @fldName+' from '+@tblName  
                         +' where '+@ID  
                     if @Sort=0  
                        set @strTmp = @strTmp + '<(select min('  
                     else  
                        set @strTmp = @strTmp + '>(select max('  
                set @strTmp = @strTmp + @ID +') from('+ @SqlSelect+' top '+ CAST(@pageSize*(@page-2)+@lastcount as Varchar(20)) +' '+ @ID +' from '+@tblName  
                         +' where (1=1) '+ @strCondition +' order by '+ @ID +' '+ @strSortType+@fldSort+') AS TBMaxID)'  
                         +' '+ @strCondition+' order by '+ @ID +' '+ @strSortType+@fldSort+') AS TempTB'+' order by '+ @ID+' '+ @strFSortType+@fldSort  
                  end                
         end      
     
     end  
   
set @end=getdate()
SEt @min=DATEDIFF(millisecond, @begin, @end)/1000.0
 ------返回查询结果-----  
SET NOCOUNT off  
 exec sp_executesql @strTmp  
print @strTmp
----------------------------------------------------------------------------------------------------
