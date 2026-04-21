/*====================================================
 * FileName:Register.js
 * Author:冯越
 * CreateDate:2011-12-23
 * Desc:用于用户注册验证(静态页调用)
====================================================*/

$(function(){   
 //页面加载时隐藏遮罩层
       GlobalFunc.HideLoading();     
        var RealNamereg = /^([a-zA-Z\u4e00-\u9fa5]* ?)*[a-zA-Z\u4e00-\u9fa5]*$/; 
        var Accountreg=/^[a-zA-Z_0-9]+$/;    
        $("#btnSaveAdd").click(
            function()
            {
                var account = $.trim($("#txtUserAccount").val());         //账号
                var realName = $.trim($("#txtRealName").val());           //真实姓名
                var password = $.trim($("#txtPassword").val());           //密码
                var passworda = $.trim($("#txtPasswordCon").val());
                if(account == "")
                {
                    alert("玩家账号不能为空！")
                    return false;
                }
                if(account.length<6 ||account.length>11)
                {
                alert("用户名由6-10个英文字母或数字组成！");
                return false;
                }
                
                if(!Accountreg.test(account))
                {
                alert("用户名由6-10个英文字母或数字组成！");
                return false;
                }
                
                if(realName == "")
                {
                    alert("真实姓名不能为空！");
                    return false;
                }
                if(!RealNamereg.test(realName))
                {
                alert("真实姓名填写不正确！");
                return false;
                }
                if(password == "")
                {
                    alert("密码不能为空！");
                    return false;
                }
                if(password.length<5 ||password.length>15)
                {
                alert("密码位数应为5-15位！");
                return false;
                } 
                   if(passworda == "")
                {
                    alert("确认密码不能为空！");
                    return false;
                } 
                   if(password!=passworda)
                   {
                   alert("两次密码输入不一致！");
                   return false;
                   }            
                return true;
            }
        );     
});


