//间接下级玩家管理页面js文件
$(
    function()
    {   //页面加载时隐藏遮罩层
       GlobalFunc.HideLoading();
        //点击“金币变化”按钮时处理事件
        $("#gvPlayer .scoreChange").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");                
                var agentAccount = row.children("td:eq(1)").html();
                //得到要转向的url地址，传递相关参数
                var desUrl = "../Money/NodePlayerScoreChangeRecord.aspx?player="+encodeURI(agentAccount);
                window.location = desUrl;
            }            
        ); 
        //点击“银行金币变化”按钮时处理事件
        $("#gvPlayer .insureScoreChange").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");                
                var account = row.children("td:eq(1)").html();
                //得到要转向的url地址，传递相关参数
                var desUrl = "../Money/NodePlayerInsureScoreChangeRecord.aspx?player="+escape(account);
                window.location = desUrl;
            }
        );
        //点击“元宝变化”按钮时处理事件
        $("#gvPlayer .goldChange").click(
            function()
            {
                //得到操作的行
                var row = $(this).parents("tr");                
                var account = row.children("td:eq(1)").html();
                //得到要转向的url地址，传递相关参数
                var desUrl = "../Money/NodePlayerGoldChangeRecord.aspx?player="+escape(account);
                window.location = desUrl;
            }
        );       
    }
);