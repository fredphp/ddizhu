<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddAgencyScore.aspx.cs" Inherits="MTEwin.Module.AgencyManager.AddAgencyScore" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
                 代理：<asp:Literal ID="opters" runat="server"></asp:Literal>+/-点
            </td>
        </tr>
    </table>
    <form id="form1" runat="server">
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="关闭" runat="server" id="btnClose" class="btn wd1" onclick="window.close();" />
                <asp:Button ID="btnSave" runat="server" Text="确定" CssClass="btn wd1" OnClick="btnSave_Click" />
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
                代理加币：
            </td>
            <td>
                <asp:TextBox ID="txtScore" runat="server" CssClass="text wd4"></asp:TextBox><b>(+/-)</b>
            </td>
        </tr>
          <tr>
            <td class="listTdLeft">
                加币备注：
            </td>
            <td>
                <asp:TextBox ID="txtNote" runat="server" CssClass="text wd4"></asp:TextBox><b class="hong">备注必填</b>
            </td>
        </tr>
         
    </table>
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="关闭" runat="server" id="btnClose1"  class="btn wd1" onclick="window.close();" />
                <asp:Button ID="btnSave1" runat="server" Text="确定" CssClass="btn wd1" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
