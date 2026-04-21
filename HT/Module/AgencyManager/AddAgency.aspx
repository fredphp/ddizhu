<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddAgency.aspx.cs" Inherits="MTEwin.Module.AgencyManager.AddAgency" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <title></title>
</head>
<body>
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">
                目前操作功能：<asp:Literal ID="opters" runat="server"></asp:Literal>代理
            </td>
        </tr>
    </table>
    <form id="form1" runat="server">
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="关闭" runat="server" id="btnClose" class="btn wd1" onclick="window.close();" />
                <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                <div class="hg3  pd7">
                    基本信息</div>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                用户名：
            </td>
            <td>
                <asp:TextBox ID="txtAccount" runat="server" CssClass="text wd4"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                真实姓名：
            </td>
            <td>
                <asp:TextBox ID="txtRealName" runat="server" CssClass="text wd4"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                登录密码：
            </td>
            <td>
                <asp:TextBox ID="txtLogonPass" TextMode="Password" runat="server" CssClass="text wd4"></asp:TextBox><span
                    class="hong" runat="server" id="tips" visible="false">不填则不修改</span>
            </td>
        </tr>
        <div id="divlopwd" runat="server">
            <tr>
                <td class="listTdLeft">
                    确认登录密码：
                </td>
                <td>
                    <asp:TextBox ID="txtLogonPass2" TextMode="Password" runat="server" CssClass="text wd4"></asp:TextBox>
                </td>
            </tr>
        </div>
        <tr>
            <td class="listTdLeft">
                一级安全密码：
            </td>
            <td>
                <asp:TextBox ID="txtSafePass" TextMode="Password" runat="server" CssClass="text wd4"></asp:TextBox><span
                    class="hong" runat="server" id="tips1" visible="false">不填则不修改</span>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                二级安全密码：
            </td>
            <td>
                <asp:TextBox ID="txtSafePass2" TextMode="Password" runat="server" CssClass="text wd4"></asp:TextBox><span
                    class="hong" runat="server" id="tips2" visible="false">不填则不修改</span>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                代理抽水比率：
            </td>
            <td>
                <asp:TextBox ID="txtRoyalty" runat="server" CssClass="text wd4"></asp:TextBox>%
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                代理有效会员单价：
            </td>
            <td>
                <asp:TextBox ID="txtUserPrice" runat="server" CssClass="text wd4"></asp:TextBox>金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                代理有效会员游戏时间：
            </td>
            <td>
                <asp:TextBox ID="txtUserPlayTime" runat="server" CssClass="text wd4"></asp:TextBox>秒
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                代理邮箱：
            </td>
            <td>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="text wd4"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                代理电话：
            </td>
            <td>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="text wd4"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                代理QQ：
            </td>
            <td>
                <asp:TextBox ID="txtQQ" runat="server" CssClass="text wd4"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                代理新增下级代理是否开启：
            </td>
            <td>
                <asp:CheckBox ID="AddAgencyStatus" runat="server" Text="开启" Checked="true" />
            </td>
        </tr>
    </table>
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="关闭" runat="server" id="btnClose1"  class="btn wd1" onclick="window.close();" />
                <asp:Button ID="btnSave1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
