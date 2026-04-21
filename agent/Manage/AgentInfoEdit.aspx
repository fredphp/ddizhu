<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgentInfoEdit.aspx.cs" Inherits="AgencyManage.Manage.AgentInfoEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>资料修改</title>
    <link href="../Css/default.css" rel="stylesheet" type="text/css" />
    <script src="../Js/base.js" type="text/javascript"></script>
    <script src="Js/AgentInfoEdit.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="main">
        <div class="currentPath">
            当前位置：代理后台>>信息维护>>资料修改
        </div>
        <div class="result">
            <fieldset>
                <legend>修改基本资料</legend>
                <ul class="form">
                    <li>
                        <div class="input">
                            <label>
                                代理账号：</label><asp:Label ID="lblAccount" runat="server"></asp:Label>
                            <a href="AgentInfoDetail.aspx">详细信息</a>
                        </div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                真实姓名：</label><input type="text" id="txtRealName" class="w80" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                E-mail地址：</label><input type="text" id="txtEmail" class="w130" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                手机号码：</label><input type="text" id="txtPhone" class="w200" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                QQ号码：</label><input type="text" id="txtQQ" class="w200" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                开户行：</label><input type="text" id="txtBankName" class="w200" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                银行卡号：</label><input type="text" id="txtBankNum" class="w200" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                开户行地址：</label><input type="text" id="txtBankAddr" class="w200" runat="server" /></div>
                    </li>
                    <li class="toolbar">
                        <asp:Button ID="btnUpdateBaseInfo" runat="server" Text="保存修改" OnClick="btnUpdateBaseInfo_Click" />
                    </li>
                </ul>
            </fieldset>
            <fieldset>
                <legend>修改登录密码</legend>
                <ul class="form">
                    <li>
                        <div class="input">
                            <label>
                                原密码：</label><input type="password" id="txtPwdOld" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                新密码：</label><input type="password" id="txtPwd" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                确认密码：</label><input type="password" id="txtPwdCon" runat="server" /></div>
                    </li>
                    <li class="toolbar">
                        <asp:Button ID="btnUpdatePwd" runat="server" Text="保存修改" OnClick="btnUpdatePwd_Click" />
                    </li>
                 </ul>
            </fieldset>
            <fieldset>
                <legend>修改安全密码</legend>
                <ul class="form">
                    <li>
                        <div class="input">
                            <label>
                                原一级安全密码：</label><input type="password" id="txtPwdOldFirst" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                新一级安全密码：</label><input type="password" id="txtPwdNewFirst" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                确认一级安全密码：</label><input type="password" id="txtPwdConFirst" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                原二级安全密码：</label><input type="password" id="txtPwdOldSecond" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                新二级安全密码：</label><input type="password" id="txtPwdNewSecond" runat="server" /></div>
                    </li>
                    <li>
                        <div class="input">
                            <label>
                                确认二级安全密码：</label><input type="password" id="txtPwdConSecond" runat="server" /></div>
                    </li>
                    <li class="toolbar">
                        <asp:Button ID="Button1" runat="server" Text="保存修改" OnClick="btnUpdatePwd1_Click" />
                    </li>
                 </ul>
            </fieldset>
        </div>
    </div>
    </form>
</body>
</html>


