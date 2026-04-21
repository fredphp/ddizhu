<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MemberInfo.aspx.cs" Inherits="Game.Web.UserService.MemberInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="flb" TagName="userTop" Src="~/Themes/Standard/UserCenter.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
    <script>
        navNum = 0;
    </script>
</head>
<body>
    <flb:userTop runat="server">
    </flb:userTop>
    <div class="platContentBox">
        <form id="form1" runat="server">
        <div class="platContent">
            <table cellpadding="0" cellspacing="0" border="0" width="100%" id="tablecol2">
                <tr>
                    <td class="tright w100">用户名：</td>
                    <td class="bold white"><asp:Literal ID="lAccounts" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td class="tright w100">游戏编号：</td>
                    <td class="bold white"><asp:Literal ID="lGameID" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td class="tright w100">当前金币：</td>
                    <td class="bold white"><asp:Literal ID="lScore" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td class="tright w100">保险箱金币：</td>
                    <td class="bold white"><asp:Literal ID="lInsureScore" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td class="tright w100">真实姓名：</td>
                    <td class="bold white"><asp:Literal ID="lNickName" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td class="tright w100">电子邮件：</td>
                    <td class="<%=emailStyle %>"><asp:Literal ID="lEmail" runat="server"></asp:Literal></td>
                </tr>
               <tr>
                    <td class="tright w100">联系电话：</td>
                    <td class="<%=phoneStyle %>"><asp:Literal ID="lPhone" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td class="tright w100">QQ号码：</td>
                    <td class="<%=qqStyle %>"><asp:Literal ID="lQQ" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td class="tright w100">银行账号：</td>
                    <td class="<%=bankStyle %>"><asp:Literal ID="lBankNum" runat="server"></asp:Literal></td>
                </tr>
               <tr>
                    <td class="tright w100">开户银行：</td>
                    <td class="<%=bankNameStyle %>"><asp:Literal ID="lBankName" runat="server"></asp:Literal></td>
                </tr>
                <tr>
                    <td class="tright w100">银行密码：</td>
                    <td><asp:TextBox runat="server" ID="txtInsurePwd" TextMode="Password" CssClass="look"></asp:TextBox>
                        &nbsp;<asp:Button runat="server" ID="btnLook" CssClass="btnLook" 
                            onclick="btnLook_Click" />
                        &nbsp;&nbsp;&nbsp;<label class="hong">温馨提示：输入银行密码可查询绑定信息</label>
                    </td>
                </tr>
            </table>
        </div>
        </form>
    </div>
</body>
</html>
