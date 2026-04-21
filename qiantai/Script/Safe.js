$(function () {
    $("#btnUpLogonPwd").click(function () {
        if ($("#txtOldPwd").val() == "") {
            alert("请输入原密码！");
            return false;
        }
        if ($("#txtNewPwd").val() == "") {
            alert("请输入新密码！");
            return false;
        }
        if ($("#txtNewPwdRe").val() == "") {
            alert("请输入确认密码！");
            return false;
        }
        if ($("#txtNewPwd").val() != $("#txtNewPwdRe").val()) {
            alert("两次密码不一致！");
            return false;
        }
        if ($("#txtInsurePwd").val() == "") {
            alert("请输入银行密码！");
            return false;
        }
    });

    $("#btnUpInsurePwd").click(function () {
        if ($("#txtOldInsurePwd").val() == "") {
            alert("请输入原银行密码！");
            return false;
        }
        if ($("#txtNewInsurePwd").val() == "") {
            alert("请输入新银行密码！");
            return false;
        }
        if ($("#txtPhone").val() == "") {
            alert("请输入手机号！");
            return false;
        }
    });

    $("#btnUpEmail").click(function () {
        if ($("#txtOldEmail").val() == "") {
            alert("请输入原邮箱！");
            return false;
        }
        if ($("#txtNewEmail").val() == "") {
            alert("请输入新邮箱！");
            return false;
        }
        if ($("#txtNewEmailRe").val() == "") {
            alert("请再次输入新邮箱!");
            return false;
        }
        if ($("#txtNewEmail").val() != $("#txtNewEmailRe").val()) {
            alert("两次邮箱输入不一致！");
            return false;
        }
    });

    $("#btnUpPhone").click(function () {
        if ($("#txtOldPhone").val() == "") {
            alert("请输入原绑定手机号码！");
            return false;
        }
        if ($("#txtNewPhone").val() == "") {
            alert("请输入新绑定手机号码！");
            return false;
        }
    });
});