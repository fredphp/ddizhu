//代理资料修改页js文件
$(
    function()
    { //页面加载时隐藏遮罩层
       GlobalFunc.HideLoading();
        //点击“修改基本资料”时校验数据
//        $("#btnUpdateBaseInfo").click(
//            function()
//            {
//                var realName = $.trim($("#txtRealName").val());         //真实姓名
//                var bankName = $.trim($("#txtBankName").val());         //开户行
//                var bankDetail = $.trim($("#txtBankDetail").val());     //开户行详细地址
//                var bankNum = $.trim($("#txtBankNum").val());           //银行卡号
//                var patternInt = /^[1-9]\d{0,9}$/;
//                var patternBankNum = /^\d{16,19}$/;  
//                if(realName == "")
//                {
//                    alert("请填写真实姓名！")
//                    return false;
//                }
//                if(bankName == "")
//                {
//                    alert("请填写开户行！");
//                    return false;
//                }
//                if(bankDetail=="")
//                {
//                    alert("请填写开户行详细地址！");
//                    return false;
//                }
//                if(bankNum == "")
//                {
//                    alert("请填写银行卡号！");
//                    return false;
//                }                
//                //银行卡号
//                if(!patternBankNum.test(bankNum))
//                {
//                    alert("19位工行/农行/建行账号或16位招行账号！");
//                    return false;
//                }                
//                return true;
//            }
//        );
        //点击“修改密码”时校验数据
        $("#btnUpdatePwd").click(
            function()
            {
                var pwd = $("#txtPwd").val();
                var pwdcon = $("#txtPwdCon").val();
                
                if(pwd.length<6)
                {
                    alert("为了您的账户安全，密码最少6位！");
                    return false;
                }
                if(pwd!=pwdcon)
                {
                    alert("两次输入的密码不一致！");
                    return false;
                }
                return true;
            }
        );
    }
);