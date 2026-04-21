function hintMessage(hintObj, error, message) {
    if (error == "error") {
        $("#" + hintObj + "").removeClass("onSuccess");
        $("#" + hintObj + "").removeClass("konError");
        $("#" + hintObj + "").addClass("onError");
    } else if (error == "right") {
        $("#" + hintObj + "").removeClass("onError");
        $("#" + hintObj + "").removeClass("konError");
        $("#" + hintObj + "").addClass("onSuccess");
    } else if (error == "info") {
        $("#" + hintObj + "").removeClass("onError");
        $("#" + hintObj + "").addClass("onSuccess");
        $("#" + hintObj + "").removeClass("konError");
    }
    $("#" + hintObj + "").html(message);
}

//验证用户名是否存在
function checkUserName() {
    $.ajax({
        async: false,
        contentType: "application/json",
        url: "WS/WSAccount.asmx/CheckName",
        data: "{userName:'" + $("#txtAccounts").val() + "'}",
        type: "POST",
        dataType: "json",
        success: function (json) {
            json = eval("(" + json.d + ")");

            if (json.success == "error") {
                hintMessage("txtAccountsTips", "error", json.msg);
            } else if (json.success == "success") {
                hintMessage("txtAccountsTips", "right", "此用户名可以注册!");
            }
        }
    });
}

//用户名的正确性
function checkAccounts() {
    if ($.trim($("#txtAccounts").val()) == "") {
        hintMessage("txtAccountsTips", "error", "请输入您的用户名");
        return false;
    }
    var reg = /^[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
    if (!reg.test($("#txtAccounts").val())) {
        hintMessage("txtAccountsTips", "error", "由字母、数字、下划线和汉字的组合！");
        return false;
    }
    var len = $("#txtAccounts").val().replace(/(^\s*)|(\s*$)/g, "").replace(/[^\x00-\xff]/g, "**").length
    if (len<6 || $("#txtAccounts").length>15) {
        hintMessage("txtAccountsTips", "error", "用户名的长度为6-15个字符");
        return false;
    }
    hintMessage("txtAccountsTips", "right", "此用户名可以注册!");
    return true;
}

//真实名字的合法性
function checkCompellation() {
    if ($.trim($("#txtRealname").val()) != "") {
        if ($("#txtRealname").val().length > 20) {
            hintMessage("txtRealnameTips", "error", "真实姓名长度不能大于20个字符");
            return false;
        }
    }
    else {
        hintMessage("txtRealnameTips", "error", "请输入真实姓名");
        return false;
    }
    hintMessage("txtRealnameTips", "right", "输入正确");
    return true;
}

//检查登录密码是否合法
function checkLoginPass() {
    if ($("#txtPwd").val() == "") {
        hintMessage("txtPwdTips", "error", "请输入您的登录密码");
        return false;
    }
    if ($("#txtPwd").val().length < 6 || $("#txtPwd").val().length > 32) {
        hintMessage("txtPwdTips", "error", "登录密码长度为6到32个字符");
        return false;
    }
    hintMessage("txtPwdTips", "right", "输入正确");
    return true;
}
//确认登陆密码是否合法
function checkLoginConPass() {
    if ($("#txtRepwd").val() == "") {
        hintMessage("txtRepwdTips", "error", "请输入登录确认密码");
        return false;
    }
    if ($("#txtRepwd").val() != $("#txtPwd").val()) {
        hintMessage("txtRepwdTips", "error", "登录确认密码与原密码不同，请重新输入");
        return false;
    }
    hintMessage("txtRepwdTips", "right", "输入正确");
    return true;
}
//检查银行卡密码
function checkInsurePass() {
    if ($("#txtBankpwd").val() == "") {
        hintMessage("txtBankpwdTips", "error", "请输入您的银行密码");
        return false;
    }
    if ($("#txtBankpwd").val().length < 6 || $("#txtBankpwd").val().length > 32) {
        hintMessage("txtBankpwdTips", "error", "银行密码长度为6到32个字符");
        return false;
    }
    hintMessage("txtBankpwdTips", "right", "输入正确");
    return true;
}
//确认银行卡密码
function checkInsureConPass() {
    if ($("#txtRebankpwd").val() == "") {
        hintMessage("txtRebankpwdTips", "error", "请输入您的银行确认密码");
        return false;
    }
    if ($("#txtRebankpwd").val() != $("#txtBankpwd").val()) {
        hintMessage("txtRebankpwdTips", "error", "登录确认密码与原密码不同，请重新输入");
        return false;
    }
    hintMessage("txtRebankpwdTips", "right", "输入正确");
    return true;
}
//验证手机号
function checkPhone() {
    if ($("#txtPhone").val() == "") {
        hintMessage("txtPhoneTips", "error", "请输入手机号码");
        return false;
    }
    if (!phone("txtPhone")) {
        hintMessage("txtPhoneTips", "error", "手机号码格式有误，请重新输入");
        return false;
    }
    hintMessage("txtPhoneTips", "right", "输入正确");
    return true;
}
//验证码
function checkVerifyCode() {
    if ($("#txtValidate").val() == "") {
        hintMessage("txtValidateTips", "error", "请输入验证码");
        return false;
    }
    hintMessage("txtValidateTips", "right", "输入正确");
    return true;
}
//单击确定按钮时验证各文本框
function checkInput() {
    if (!checkAccounts()) { $("#txtAccounts").focus(); return false; }
    if (!checkCompellation()) { $("#txtRealname").focus(); return false; }
    if (!checkLoginPass()) { $("#txtPwd").focus(); return false; }
    if (!checkLoginConPass()) { $("#txtRepwd").focus(); return false; }
    if (!checkInsurePass()) { $("#txtBankpwd").focus(); return false; }
    if (!checkInsureConPass()) { $("#txtRebankpwd").focus(); return false; }
    if (!checkPhone()) { $("#txtPhone").focus(); return false; }
    if (!checkVerifyCode()) { $("#txtValidate").focus(); return false; }
}

$(document).ready(function () {
    $("#txtAccounts").blur(function () {
        if (checkAccounts()) {
            checkUserName();
        }
    });
    $("#txtRealname").blur(function () { checkCompellation(); });
    $("#txtPwd").blur(function () { checkLoginPass(); });
    $("#txtRepwd").blur(function () { checkLoginConPass(); });
    $("#txtBankpwd").blur(function () { checkInsurePass(); });
    $("#txtRebankpwd").blur(function () { checkInsureConPass(); });
    $("#txtPhone").blur(function () { checkPhone(); });
    $("#txtValidate").blur(function () { checkVerifyCode(); });
});

function UpdateImage() {
    document.getElementById("picVerifyCode").src = "/ValidateImage.aspx?r=" + Math.random();
}

function phone(id) {
    var phonebool = true;
    var message = $.trim($("#" + id).val());
    if (message.length > 0) {
        var regTel = /((\d{11})|^((\d{7,8})|(\d{4}|\d{3})-(\d{7,8})|(\d{4}|\d{3})-(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1})|(\d{7,8})-(\d{4}|\d{3}|\d{2}|\d{1}))$)/;
        if (!regTel.test(message)) {
            phonebool = false;
        }
    }
    return phonebool;
}