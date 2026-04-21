/// <reference path="jquery-1.4.1.min.js" />
$(function () {
    $("#payCardTypeBox").hide();
//    $("#payCardNum").hide();
//    $("#payCardPwd").hide();
    $("#payType3").attr("checked", "checked");
    $("#payType0").removeAttr("checked");
    $("#payBankTypeBox").show();

    $("#lblMinCharge").html($("#minPay").val());

    $("input[name='payType']").click(function () {
        if ($(this).val() == "0") {
            $("#payBankTypeBox").hide();
            $("#payCardTypeBox").show();
//            $("#payCardNum").show();
//            $("#payCardPwd").show();
        }
        else {
            $("#payBankTypeBox").show();
            $("#payCardTypeBox").hide();
//            $("#payCardNum").hide();
//            $("#payCardPwd").hide();
        }
    });

    $("#payBtn").click(function () {
        if ($("#txtPayMoney").val() == "") {
            alert("请输入充值金额");
            $("#txtPayMoney").focus();
            return false;
        }
        var re = /\d/;
        if (!re.test($("#txtPayMoney").val())) {
            alert("充值金额必须为数字");
            $("#txtPayMoney").focus();
            return false;
        }
        if (parseInt($("#txtPayMoney").val()) < parseInt($("#minPay").val())) {
            alert("请输入大于等于" + $("#minPay").val() + "的数字");
            $("#txtPayMoney").focus();
            return false;
        }


        if ($("#txtPayAccount").val() == "") {
            alert("请输入游戏账号");
            $("#txtPayAccount").focus();
            return false;
        }

        if ($("#payType0").attr("checked")) {
//            if ($("#txtCardNum").val() == "") {
//                alert("请输入点卡卡号");
//                $("#txtCardNum").focus();
//                return false;
//            }
//            if ($("#txtCardPwd").val() == "") {
//                alert("请输入点卡密码");
//                $("#txtCardPwd").focus();
//                return false;
//            }
        }

    });
});