<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyGetGold.aspx.cs" Inherits="AgencyManage.Manage.Money.ApplyGetGold" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>申请结算</title>
    <link href="../../Css/default.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/base.js" type="text/javascript"></script>
    <script src="../../Js/JsCommon.js" type="text/javascript"></script>
    <script src="../../PlugIn/artdialog/artDialog.min.js" type="text/javascript"></script>
    <script src="../Js/ApplyBalance.js" type="text/javascript"></script>
    <script src="../../Lib/jquery.layout.js" type="text/javascript"></script>
    <script src="../Js/Main.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="main">
        <div class="currentPath">
            当前位置：代理后台>>统计与结算>>玩家提款
        </div>
        <div class="result">
            <fieldset>
                <legend>申请提款：</legend>
                <input type="hidden" runat="server" id="hideRemark" />
                <ul id="pBalance" class="form" runat="server">
                    <li>
                        <div class="input">
                            <label>
                                当前金币：</label><span runat="server" id="lblAgentScore" class="detail"></span><%--<asp:Label ID="" runat="server" CssClass="detail"></asp:Label>--%>
                            <label>
                                最少提款金币：</label><asp:Label ID="lblLessMoney" runat="server" CssClass="detail"></asp:Label>
                            <label>
                                提款手续费：</label><asp:Label ID="lblrev" runat="server" CssClass="detail"></asp:Label>
                        </div>
                    </li>
                    <li>
                        <div class="input">
                            <label style="width: 110px">
                                申请提款：</label><input type="text" id="txtSellScore" class="w65" runat="server" />金币
                        </div>
                    </li>
                    <li>
                        <div class="input">
                            <label style="width: 110px">
                                一级安全密码：</label><input type="password" id="txtSafeFirstPwd" class="w200" runat="server" />
                        </div>
                    </li>
                    <li>
                        <div class="input">
                            <label style="width: 110px">
                                二级安全密码：</label><input type="password" id="txtSafeSecondPwd" class="w200" runat="server" />
                        </div>
                    </li>
                    <li>
                        <div class="input">
                            <label style="width: 110px">
                                开户行名称：</label><input type="text" id="txtBankName" class="w200" runat="server" />
                        </div>
                    </li>
                    <li>
                        <div class="input">
                            <label style="width: 110px">
                                开户姓名：</label><input type="text" id="txtAgencyName" class="w200" runat="server" /><font style="color:#ff0000;">请正确填写</font>
                        </div>
                    </li>
                    <li>
                        <div class="input">
                            <label style="width: 110px">
                                开户行卡号：</label><input type="text" id="txtBankNum" class="w200" runat="server" />
                        </div>
                    </li>
                    <li>
                        <div class="input">
                            <label style="width: 110px">
                                开户行地址：</label><input type="text" id="txtBankAddr" class="w200" runat="server" />
                        </div>
                    </li>
                    <li>
                        <div class="toolbar">
                            <asp:Button ID="btnApply" Text="申请提款" runat="server" OnClick="btnApply_Click" OnClientClick="return doApply();" />
                        </div>
                    </li>
                </ul>
            </fieldset>
        </div>
    </div>
    </form>
</body>
</html>
