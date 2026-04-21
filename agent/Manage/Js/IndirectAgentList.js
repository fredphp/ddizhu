//直接下级代理管理页面js文件
$(
    function()
    {   //页面加载时隐藏遮罩层
       GlobalFunc.HideLoading();
        //点击“推广的代理”按钮时处理事件
        $("#gvAgentList .nodeAgent").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");
                //得到要操作的代理ID与代理账号
                var agentID = row.children("td:eq(0)").html();
                var agentAccount = row.children("td:eq(1)").html();
                //得到要转向的url地址，传递相关参数
                var desUrl = "IndirectAgentList.aspx?super="+agentAccount;
                window.location = desUrl;
            }
        );
        //点击“推广的玩家”按钮时处理事件
        $("#gvAgentList .nodePlayer").click(
            function()
            {
                 //得到操作的行
                var row = $(this).parents("tr");
                //得到要操作的代理ID与代理账号
                var agentID = row.children("td:eq(0)").html();
                var agentAccount = row.children("td:eq(1)").html();
                //得到要转向的url地址，传递相关参数
                var desUrl = "../Player/IndirectPlayerList.aspx?super="+agentAccount;
                window.location = desUrl;
            }
        ); 
        //点击“金币变化”按钮时处理事件
        $("#gvAgentList .scoreChange").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");                
                var agentAccount = row.children("td:eq(1)").html();
                //得到要转向的url地址，传递相关参数
                var desUrl = "../Money/NodeAgentScoreChangeRecord.aspx?agent="+encodeURI(agentAccount);
                window.location = desUrl;
            }            
        );       
    }
);