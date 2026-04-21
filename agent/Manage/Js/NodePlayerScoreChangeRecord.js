//下级玩家金币变化记录页js文件
$(
    function()
    { //页面加载时隐藏遮罩层
       GlobalFunc.HideLoading();
        $(".tool .date").attr("readonly","readonly").focus(
            function()
            {
                SelectDate(this,'yyyy-MM-dd');
                $("#calendarClear").hide();
            }
        );
        //查询按钮点击处理事件
        $("#btnQuery").click(
            function()
            {
               var pattern = /^[1-9]\d{0,10}$/;
               var startDate = $("#txtStartDate").val();
               var endDate = $("#txtEndDate").val();  
               if(startDate>endDate)
               {
                   alert("查询起始时间不能大于截止时间！");
                   return false;
               } 
               return true;
            }
        );
    }
);