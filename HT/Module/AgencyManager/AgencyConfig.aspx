<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgencyConfig.aspx.cs" Inherits="MTEwin.Module.AgencyManager.AgencyConfig" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">
                你当前位置：代理系统 - 代理设置
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                <div class="hg3  pd7">
                    代理设置</div>
            </td>
        </tr>
        <tr id="trMatchName" runat="server" visible="false">
            <td class="listTdLeft">
                多少游戏时长为有效会员：
            </td>
            <td>
                <asp:TextBox ID="txtPlayTime" runat="server" CssClass="text" Width="200"></asp:TextBox>秒
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                有效会员单价：
            </td>
            <td>
                <asp:TextBox ID="txtUserPrice" runat="server" CssClass="text" Width="200"></asp:TextBox>金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                代理结算时手续费比例：
            </td>
            <td>
                <asp:TextBox ID="txtRevenue" runat="server" CssClass="text" Width="200"></asp:TextBox>%
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                代理结算时最少结算：
            </td>
            <td>
                <asp:TextBox ID="txtLitMoney" runat="server" CssClass="text" Width="200"></asp:TextBox>金币
            </td>
        </tr>

        <!---20151218add-->
         <tr>
            <td class="listTdLeft">
                代理转账玩家时手续费比例：
            </td>
            <td>
                <asp:TextBox ID="txt_rev2" runat="server" CssClass="text" Width="200"></asp:TextBox>%
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                代理转账玩家时最少结算：
            </td>
            <td>
                <asp:TextBox ID="txt_drawmoney2" runat="server" CssClass="text" Width="200"></asp:TextBox>金币
            </td>
        </tr>
<!---20151218add-->

        <tr>
            <td class="listTdLeft" colspan="2" style="text-align: left;">
                <asp:TextBox ID="txtDays" runat="server" CssClass="text" Width="50"></asp:TextBox>天最少注册
                <asp:TextBox ID="txtRegisters" runat="server" CssClass="text" Width="50"></asp:TextBox>个，有效会员
                <asp:TextBox ID="txtCanUser" runat="server" CssClass="text" Width="50"></asp:TextBox>个，否则冻结代理
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                代理能查询记录的天数：
            </td>
            <td>
                <asp:TextBox ID="txtAgencyDay" runat="server" CssClass="text" Width="200"></asp:TextBox>天
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
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <asp:Button ID="btnSave1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
