<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgentInfoDetail.aspx.cs" Inherits="AgencyManage.Manage.AgentInfoDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>代理详细资料</title>
    <link href="../Css/default.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div id="main">
        <fieldset id="result">
            <legend>代理基本信息</legend>
            <ul class="form">
                <li>
                    <div class="input">
                        <label>
                            代理账号：</label><asp:Label ID="lblAgentAccount" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            真实姓名：</label><asp:Label ID="lblRealName" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            E-mail地址：</label><asp:Label ID="lblEmail" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            手机号码：</label><asp:Label ID="lblTelPhone" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            QQ号码：</label><asp:Label ID="lblQQ" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            抽水比例：</label><asp:Label ID="lblRevenue" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            代理资产：</label><asp:Label ID="lblScore" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            开户行：</label><asp:Label ID="lblBankName" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            银行卡号：</label><asp:Label ID="lblBankNum" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            开户行地址：</label><asp:Label ID="lblAddr" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            推广链接1：</label><asp:Label ID="lblLink" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            推广链接2：</label><asp:Label ID="lblLink1" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            推广链接3：</label><asp:Label ID="lblLink2" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            推广链接4：</label><asp:Label ID="lblLink3" runat="server" CssClass="important"></asp:Label></div>
                </li>
                <li>
                    <div class="input">
                        <label>
                            推广链接5：</label><asp:Label ID="lblLink4" runat="server" CssClass="important"></asp:Label></div>
                </li>
            </ul>
        </fieldset>
    </div>
    </form>
</body>
</html>

