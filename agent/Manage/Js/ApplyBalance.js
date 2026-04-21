//申请结算页js文件

$(

    function () {
        //页面加载时隐藏遮罩层
        GlobalFunc.HideLoading();
    }
);

function doApply() {
    var contentSel;          //真实姓名
    var sellScore = $.trim($("#txtSellScore").val());       //结算金币额
    var canSellScore = $.trim($("#lblAgentScore").html());    //允许结算的金额
    var minSellScore = $.trim($("#lblLessMoney").html());    //每次最小结算金额
    var patternInt = /^[1-9]\d{0,9}$/;
    var patternBankNum = /^\d{16,19}$/;

    if (sellScore == "") {
        alert("请填写结算的金币数额！");
        return false;
    }
    if (parseFloat(sellScore) < parseFloat(minSellScore)) {
        alert("每次最小结算金额为" + minSellScore + "金币！");
        return false;
    }
    if (parseFloat(sellScore) > parseFloat(canSellScore)) {
        alert("您当前只允许最多结算" + canSellScore + "金币！");
        return false;
    }
    return true;
}