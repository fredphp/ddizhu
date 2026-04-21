<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeBehind="Online.aspx.cs" Inherits="Game.Web.Pay.Online" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
    <script type="text/javascript" src="../Script/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="../Script/Pay.js"></script>
    <script>$(document).ready(function() {$("input[name=btnPayment]").change(function(e) { if(e.target.checked&&e.target.value=="NetBank") $("#vBanks").show(); else $("#vBanks").hide(); })})</script>
</head>
<body>
    <form id="form1" runat="server" target="_blank">
    <div id="pay_main">
        <div class="tool">
            <dl class="tooltip">
                <dt>温馨提示： </dt>
                <dd>
                    1.每次最小充值金额为<span id="lblMinCharge" class="important">20</span>元，每日充值无上限。
                    <br />
                    2.请确保您填写的用户名正确无误，因玩家输入错误而导致的任何损失由用户自行承担。
                    <br />
                    3.遇到任何充值问题，请您联系客服中心。
                </dd>
            </dl>
        </div>
        <div class="result">
            <div class="paddLeft40">充值方式：<asp:RadioButtonList ID="btnPayment" runat="server" CssClass="Payment" RepeatDirection="Horizontal" RepeatLayout="Flow">
                    <asp:ListItem Value="NetBank" Selected="True">网银充值</asp:ListItem>
                    <asp:ListItem Value="WeChat">微信支付</asp:ListItem>
                    <asp:ListItem Value="Alipay">支付宝</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <div class="paddLeft40" id="vBanks">选择银行：
                <style>
                    .Payment>*,.BanksList>*{vertical-align:middle}
                    .Payment>label,.BanksList>label{display:inline-block;width:114px;padding:0 3px;font-size:12px}
                    .Payment>input,.BanksList>input{width:13px}
                </style>

                <br/>
                <p>
                <asp:RadioButtonList ID="btnBank" runat="server" CssClass="BanksList" RepeatDirection="Horizontal" RepeatLayout="Flow">
                    <asp:ListItem Value="ICBC" Selected="True">工商银行</asp:ListItem>
                    <asp:ListItem Value="ABC">农业银行</asp:ListItem>
                    <asp:ListItem Value="BOC">中国银行</asp:ListItem>
                    <asp:ListItem Value="CCB">建设银行</asp:ListItem>
                    <asp:ListItem Value="BOCO">交通银行</asp:ListItem>
                    <%--<asp:ListItem Value="PSBS">邮政储蓄</asp:ListItem>--%>
                    <asp:ListItem Value="CMB">招商银行</asp:ListItem>
                    <asp:ListItem Value="CMBC">民生银行</asp:ListItem>
                    <asp:ListItem Value="CTTIC">中信银行</asp:ListItem>
                    <asp:ListItem Value="CIB">兴业银行</asp:ListItem>
                    <asp:ListItem Value="CEB">光大银行</asp:ListItem>
                    <%--<asp:ListItem Value="HXB">华夏银行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="HKBEA">東亞銀行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="PINGANBANK">平安银行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="SDB">深圳发展银行</asp:ListItem>--%>
                    <asp:ListItem Value="SPDB">浦发银行</asp:ListItem>
                    <asp:ListItem Value="GDB">广发银行</asp:ListItem>
                    <%--<asp:ListItem Value="BCCB">北京银行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="SHB">上海银行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="NJCB">南京银行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="NBCB">宁波银行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="CBHB">渤海银行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="SRCB">上海农商银行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="CZCB">浙江稠州商业银行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="CZB">浙商银行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="HCCB">杭州银行</asp:ListItem>--%>
                    <%--<asp:ListItem Value="BJRCB">北京农村商业银行</asp:ListItem>--%>
                </asp:RadioButtonList>
                </p>
            </div>
            <div class="padd3 paddLeft40">
                充值金额：<asp:TextBox ID="txtMoney" runat="server" CssClass="w80"></asp:TextBox>
            </div>
            <div class="padd3 paddLeft40">
                游戏账号：<asp:TextBox ID="txtAccount" runat="server" CssClass="w80"></asp:TextBox>
            </div>
            <asp:Button runat="server" ID="btnPay" CssClass="payBtn" onclick="payBtn_Click" />
            <input type="hidden" runat="server" id="minPay" value="20" />
        </div>
    </div>
    </form>
</body>
</html>
