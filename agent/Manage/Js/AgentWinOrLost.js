//代理商输赢记录页面js文件
$(
    function()
    {        //页面加载时隐藏遮罩层
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
        //查看下级代理输赢详情
        $("#gvAgent .agentDetail").click(
            function()
            {
                var tr = $(this).parents("tr");
                var agentid = $.trim(tr.find(".agentid").val());
                var agentaccount = $.trim(tr.children("td").eq(1).html());
                var desUrl = "AgentWinOrLost.aspx?id="+agentid+"&account="+encodeURI(agentaccount);
                window.location = desUrl;
                return false;
            }
        );
        //查看下级玩家输赢详情
        $("#gvAgent .playerDetail").click(
            function()
            {
                var tr = $(this).parents("tr");
                var agentid = $.trim(tr.find(".agentid").val());
                var agentaccount = $.trim(tr.children("td").eq(1).html());
                var desUrl = "PlayerWinOrLost.aspx?id="+agentid+"&account="+encodeURI(agentaccount);
                window.location = desUrl;
                return false;
            }
        );
    }
);