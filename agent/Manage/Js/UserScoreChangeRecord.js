//玩家金币变化记录页面js文件
$(
    function()
    { //页面加载时隐藏遮罩层
       GlobalFunc.HideLoading();
        $(".date").attr("readonly","readonly").focus(
            function()
            {
                SelectDate(this,'yyyy-MM-dd');
                $("#calendarClear").hide();
            }
        );
        //点击查询按钮处理事件
        $("#btnQuery").click(
            function()
            {
               var startDate = $.trim($("#txtStartTime").val());
               var endDate = $.trim($("#txtEndTime").val());
               if(startDate>endDate)
               {
                 alert("查询起始日期不能大于截止日期！");
                 return false;
               }                
               return true;
            }
        );
    }
);