$(
    function()
    {
        $("#manageName").text(GlobalSetting.ManageName);
        //如果当前页面不是在最顶级窗口打开，则让其在最顶级窗口打开
        if(top.location != self.location)
        {
            top.location = self.location;
        }
        //设置点击验证码图片时刷新验证码
        $("#imgCheckCode").click(
            function()
            {
                var rnd = Math.random();
                $(this).attr("src","Service/CheckCode.ashx?"+rnd);
            }
        );
        //点击登录按钮处理事件
        $("#ibtnLogin").click(
            function()
            {
                var account = $.trim($("#txtAccount").val());
                var pwd = $("#txtPassword").val();
                var checkCode = $.trim($("#txtCheckCode").val());
                if(account == "")
                {
                    alert("请输入账号！");
                    $("#txtAccount").focus();
                    return false;
                }
                if(pwd == "")
                {
                    alert("请输入密码！");
                    $("#txtPassword").focus();
                    return false;
                }
                if(checkCode == "")
                {
                    alert("请输入验证码！");
                    $("#txtCheckCode").focus();
                    return false;
                }
                if(checkCode.length!=4)
                {
                    alert("验证码长度不正确！");
                    $("#txtCheckCode").focus();
                    return false;
                }
                return true;
            }
        );                 
    }
);