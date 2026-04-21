<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsertInfo.aspx.cs" Inherits="Game.Web.UserService.InsertInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="flb" TagName="userTop" Src="~/Themes/Standard/UserCenter.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
    <script type="text/javascript" src="../Script/jquery-1.4.1.min.js"></script>
    <script>
        $(function () {
            $("#btnUpdate").click(function () {
//                if ($("#txtPhone").val() == "") {
//                    alert("请输入手机号码！");
//                    return false;
//                }
//                if (!/^1[3458]\d{9}$/i.test($("#txtPhone").val())) {
//                    alert("手机号码格式错误！");
//                    return false;
//                }
//                if ($("#txtRealName").val() == "") {
//                    alert("请输入真实姓名！");
//                    return false;
//                }
//                if ($("#txtEmail").val() == "") {
//                    alert("请输入电子邮件！");
//                    return false;
//                }
//                if (!/^(\w)+(\.\w+)*@(\w)+((\.\w+)+)$/.text($("#txtEmail").val())) {
//                    alert("电子邮件格式不正确！");
//                    return false;
//                }
//                if ($("#txtBankNum").val() == "") {
//                    alert("请输入银行卡号！");
//                    return false;
//                }
            });
        });
    </script>
    <script>
        navNum = 3;
    </script>
</head>
<body>
    <flb:userTop ID="UserTop1" runat="server"></flb:userTop>
    <div class="platContentBox">
        <form id="form1" runat="server">
        <div class="platContent">
            温馨提示：
            <div id="addInfoBox" style="margin-left: 40px;">
                1.<label class="important">真实姓名必须与开户银行相同，否则不予兑换。</label><br />
                2.<label class="important">电子邮箱格式，QQ号码要填写常用的，用于找回密码。</label><br />
                3.<label class="important">开户银行和银行卡号要对应，且正确，否则不予兑换。</label><br />
                <table cellpadding="0" cellspacing="5" border="0">
                    <tr>
                        <td class="tright">
                            手机号码：
                        </td>
                        <td>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="insertInfoText"></asp:TextBox>
                            <asp:Label ID="lPhone" runat="server" CssClass="bold green" Visible="false">已绑定</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                            真实姓名：
                        </td>
                        <td>
                            <asp:TextBox ID="txtRealName" runat="server" CssClass="insertInfoText"></asp:TextBox>
                            <asp:Label ID="lRealName" runat="server" CssClass="bold green" Visible="false">已绑定</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                            电子邮件：
                        </td>
                        <td>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="insertInfoText"></asp:TextBox>
                            <asp:Label ID="lEmail" runat="server" CssClass="bold green" Visible="false">已绑定</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                            QQ号码：
                        </td>
                        <td>
                            <asp:TextBox ID="txtQQ" runat="server" CssClass="insertInfoText"></asp:TextBox>
                            <asp:Label ID="lQQ" runat="server" CssClass="bold green" Visible="false">已绑定</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                            银行账号：
                        </td>
                        <td>
                            <asp:TextBox ID="txtBankNum" runat="server" CssClass="insertInfoText"></asp:TextBox>
                            <asp:Label ID="lBankNum" runat="server" CssClass="bold green" Visible="false">已绑定</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                            开户银行：
                        </td>
                        <td>
                            <asp:DropDownList runat="server" ID="ddlBankName" CssClass="insertInfoDDL">
                                <asp:ListItem Value="工商银行" Text="工商银行" Selected="True"></asp:ListItem>
                                <asp:ListItem Value="农业银行" Text="农业银行"></asp:ListItem>
                                <asp:ListItem Value="中国银行" Text="中国银行"></asp:ListItem>
                                <asp:ListItem Value="建设银行" Text="建设银行"></asp:ListItem>
                                <asp:ListItem Value="招商银行" Text="招商银行"></asp:ListItem>
                                <asp:ListItem Value="浦发银行" Text="浦发银行"></asp:ListItem>
                                <asp:ListItem Value="广发银行" Text="广发银行"></asp:ListItem>
                                <asp:ListItem Value="交通银行" Text="交通银行"></asp:ListItem>
                                <asp:ListItem Value="邮政银行" Text="邮政银行"></asp:ListItem>
                                <asp:ListItem Value="中信银行" Text="中信银行"></asp:ListItem>
                                <asp:ListItem Value="民生银行" Text="民生银行"></asp:ListItem>
                                <asp:ListItem Value="光大银行" Text="光大银行"></asp:ListItem>
                                <asp:ListItem Value="华夏银行" Text="华夏银行"></asp:ListItem>
                                <asp:ListItem Value="兴业银行" Text="兴业银行"></asp:ListItem>
                                <asp:ListItem Value="上海银行" Text="上海银行"></asp:ListItem>
                                <asp:ListItem Value="上海农商" Text="上海农商"></asp:ListItem>
                                <asp:ListItem Value="平安银行" Text="平安银行"></asp:ListItem>
                                <asp:ListItem Value="北京银行" Text="北京银行"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label ID="lBankName" runat="server" CssClass="bold green" Visible="false">已绑定</asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                        </td>
                        <td>
                            <asp:Button ID="btnUpdate" runat="server" CssClass="safeBtn" 
                                onclick="btnUpdate_Click" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        </form>
    </div>
</body>
</html>
