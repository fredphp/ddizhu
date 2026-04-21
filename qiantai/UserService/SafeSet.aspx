<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SafeSet.aspx.cs" Inherits="Game.Web.UserService.SafeSet" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="flb" TagName="userTop" Src="~/Themes/Standard/UserCenter.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
    <script type="text/javascript" src="../Script/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="../Script/Safe.js"></script>
    <script>
        navNum = 1;
    </script>
</head>
<body>
    <flb:userTop ID="UserTop1" runat="server"></flb:userTop>
    <div class="platContentBox">
        <form id="form1" runat="server">
        <div id="safeBox">
            <fieldset>
                <legend class="f15 bold white">修改登录密码</legend>
                <table cellpadding="0" cellspacing="3" border="0">
                    <tr>
                        <td class="safeLabel">原登录密码：</td>
                        <td><asp:TextBox runat="server" ID="txtOldPwd" TextMode="Password" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel">新登录密码：</td>
                        <td><asp:TextBox runat="server" ID="txtNewPwd" TextMode="Password" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel">确认新密码：</td>
                        <td><asp:TextBox runat="server" ID="txtNewPwdRe" TextMode="Password" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel">银行密码：</td>
                        <td><asp:TextBox runat="server" ID="txtInsurePwd" TextMode="Password" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel"><asp:Button runat="server" ID="btnUpLogonPwd" 
                                CssClass="safeBtn" onclick="btnUpLogonPwd_Click" /></td>
                        <td></td>
                    </tr>
                </table>
            </fieldset>
            <fieldset>
                <legend class="f15 bold white">修改银行密码</legend>
                <table cellpadding="0" cellspacing="3" border="0">
                    <tr>
                        <td class="safeLabel">原银行密码：</td>
                        <td><asp:TextBox runat="server" ID="txtOldInsurePwd" TextMode="Password" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel">新银行密码：</td>
                        <td><asp:TextBox runat="server" ID="txtNewInsurePwd" TextMode="Password" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel">手机号：</td>
                        <td><asp:TextBox runat="server" ID="txtPhone" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="safeLabel"><asp:Button runat="server" ID="btnUpInsurePwd" 
                                CssClass="safeBtn" onclick="btnUpInsurePwd_Click" /></td>
                        <td></td>
                    </tr>
                </table>
            </fieldset>
            <fieldset>
                <legend class="f15 bold white">修改电子邮箱</legend>
                <table cellpadding="0" cellspacing="3" border="0">
                    <tr>
                        <td class="safeLabel">原电子邮箱：</td>
                        <td><asp:TextBox runat="server" ID="txtOldEmail" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel">新电子邮箱：</td>
                        <td><asp:TextBox runat="server" ID="txtNewEmail" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel">确认新邮箱：</td>
                        <td><asp:TextBox runat="server" ID="txtNewEmailRe" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="safeLabel"><asp:Button runat="server" ID="btnUpEmail" CssClass="safeBtn" 
                                onclick="btnUpEmail_Click" /></td>
                        <td></td>
                    </tr>
                </table>
            </fieldset>
            <fieldset>
                <legend class="f15 bold white">修改手机号码</legend>
                <table cellpadding="0" cellspacing="3" border="0">
                    <tr>
                        <td class="safeLabel">原绑手机号：</td>
                        <td><asp:TextBox runat="server" ID="txtOldPhone" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel">新绑手机号：</td>
                        <td><asp:TextBox runat="server" ID="txtNewPhone" CssClass="safeText"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td class="safeLabel"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="safeLabel"></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="safeLabel"><asp:Button runat="server" ID="btnUpPhone" CssClass="safeBtn" 
                                onclick="btnUpPhone_Click" /></td>
                        <td></td>
                    </tr>
                </table>
            </fieldset>
        </div>
        </form>
    </div>
</body>
</html>
