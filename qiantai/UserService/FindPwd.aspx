<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FindPwd.aspx.cs" Inherits="Game.Web.UserService.FindPwd" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        body
        {
            background: url(/Images/platfrombg.jpg) repeat 0 0;
        }
        #findPwdBox
        {
            width: 720px;
            margin: 0 auto;
            min-height: 400px;
        }
        #findPwdBox fieldset
        {
            width: 718px;
            border: 1px solid #fff;
        }
        #findPwdBox fieldset legend
        {
            font-size: 14px;
            font-weight: bold;
            color:#fff;
        }
        .Label
        {
            display: block;
            float: left;
            font-size: 15px;
            line-height: 24px;
            height: 24px;
            color: rgb(224,173,19);
            font-weight: bold;
            width: 100px;
            text-align: right;
        }
        .Text
        {
            float: left;
            width: 150px;
            height: 24px;
            border: none;
            background-color: rgb(170,170,170);
            color: #eeeeee;
        }
        .Btn
        {
            width: 88px;
            height: 25px;
            cursor: pointer;
            background: url(/Images/submit.png) no-repeat 0 0;
            border: none;
        }
    </style>
    <script type="text/javascript" src="../Script/jquery-1.4.1.min.js"></script>
    <script>
        $(function () {
            $("#btnUpdateByEmail").click(function () {
                if ($("#txtAccounts").val() == "") {
                    alert("请输入用户账号！");
                    return false;
                }
                if ($("#txtEmail").val() == "") {
                    alert("请输入邮箱！");
                    return false;
                }
                if (!/^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/.text($("#txtEmail").val())) {
                    alert("邮箱格式不对！");
                    return false;
                }
            });

            $("#btnUpdateByPhone").click(function () {
                if ($("#txtAccounts1").val() == "") {
                    alert("请输入用户账号！");
                    return false;
                }
                if ($("#txtPhone").val() == "") {
                    alert("请输入电话号码！");
                    return false;
                }
                if (!/^1[3458]\d{9}$/i.test($("#txtPhone").val())) {
                    alert("手机号码格式不正确！");
                    return false;
                }
            });

            $("#btnUpPWD").click(function () {
                if ($("#txtNewPwd").val() == "") {
                    alert("请输入新密码！");
                    return false;
                }
                if ($("#txtNewPwdRe").val() == "") {
                    alert("请确认新密码！");
                    return false;
                }

                if ($("#txtNewPwd").val() != $("#txtNewPwdRe").val()) {
                    alert("两次输入密码不一致！");
                    return false;
                }
            });
        });
    </script>
</head>
<body>
    <div id="findPwdBox">
        <form id="form1" runat="server">
        <fieldset>
            <legend>电子邮箱找回密码</legend>
            <table cellpadding="0" cellspacing="2" border="0">
                <tr>
                    <td class="Label">用户账号：</td>
                    <td><asp:TextBox ID="txtAccounts" runat="server" CssClass="Text"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="Label">电子邮箱：</td>
                    <td><asp:TextBox ID="txtEmail" runat="server" CssClass="Text"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="Label"><asp:Button ID="btnUpdateByEmail" runat="server" CssClass="Btn" 
                            onclick="btnUpdateByEmail_Click" /></td>
                    <td></td>
                </tr>
            </table>
        </fieldset>
        <fieldset>
            <legend>手机号码找回密码</legend>
            <table cellpadding="0" cellspacing="2" border="0">
                <tr>
                    <td class="Label">用户账号：</td>
                    <td><asp:TextBox ID="txtAccounts1" runat="server" CssClass="Text"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="Label">手机号码：</td>
                    <td><asp:TextBox ID="txtPhone" runat="server" CssClass="Text"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="Label"><asp:Button ID="btnUpdateByPhone" runat="server" CssClass="Btn" 
                            onclick="btnUpdateByPhone_Click" /></td>
                    <td></td>
                </tr>
            </table>
        </fieldset>
        </form>
        <form id="form2" runat="server" visible="false">
        <fieldset>
            <legend>修改登录密码</legend>
            <table cellpadding="0" cellspacing="2" border="0">
                <tr>
                    <td class="Label">新密码：</td>
                    <td><asp:TextBox ID="txtNewPwd" TextMode="Password" runat="server" CssClass="Text"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="Label">确认新密码：</td>
                    <td><asp:TextBox ID="txtNewPwdRe" TextMode="Password" runat="server" CssClass="Text"></asp:TextBox></td>
                </tr>
                <tr>
                    <td class="Label"></td>
                    <td><asp:Button ID="btnUpPWD" runat="server" CssClass="Btn" 
                            onclick="btnUpPWD_Click" /></td>
                </tr>
            </table>
        </fieldset>
        <input type="hidden" id="hidAccounts" runat="server" value="" />
        </form>
    </div>
</body>
</html>
