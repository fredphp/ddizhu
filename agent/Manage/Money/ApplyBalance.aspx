<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyBalance.aspx.cs" Inherits="AgencyManage.Manage.Money.ApplyBalance" %>

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
            当前位置：代理后台>>统计与结算>>玩家转账
        </div>
        <div class="result">
            <fieldset>
                <legend>代理转账：</legend>
                <input type="hidden" runat="server" id="hideRemark" />
                <ul id="pBalance" class="form" runat="server">
                    <li>
                        <div class="input">
                            <label>
                                当前金币：</label><span runat="server" id="lblAgentScore" class="detail"></span><%--<asp:Label ID="" runat="server" CssClass="detail"></asp:Label>--%>
                            <label>
                                最少转账金币：</label><asp:Label ID="lblLessMoney" runat="server" CssClass="detail"></asp:Label>
                            <label>
                                转账手续费：</label><asp:Label ID="lblrev" runat="server" CssClass="detail"></asp:Label>
                        </div>
                    </li>
                    <li>
                        <div class="input">
                            <label style="width: 110px">
                                转账：</label><input type="text" id="txtSellScore" class="w65" runat="server" />金币
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
                                到账玩家：</label><input type="text" id="txtAccounts" class="w200" runat="server" />
                        </div>
                    </li>
                    <li>
                        <div class="toolbar">
                            <asp:Button ID="btnApply" Text="申请转账" runat="server" OnClick="btnApply_Click" OnClientClick="return doApply();" />
                        </div>
                    </li>
                </ul>
                <ul id="pShow" class="form" runat="server" style="color: Red; font-size: large">
                    请玩家在自己的推广链接注册一个自己真实姓名的账号，然后在自己的直接下级玩家管理里边对该玩家进行充值，然后在游戏里边进行兑换
                </ul>
            </fieldset>
        </div>
    </div>
    </form>
</body>
</html>
