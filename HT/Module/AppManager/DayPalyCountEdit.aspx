<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DayPalyCountEdit.aspx.cs"
    Inherits="MTEwin.Module.AppManager.DayPalyCountEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
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
                你当前位置：网站系统 - 发送红包
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('DayPalyCount.aspx')" />
                <input class="btnLine" type="button" />
                <asp:Button ID="btn_edit" runat="server" Text="添加" CssClass="btn wd1" OnClick="btn_edit_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        
         <tr>
            <td class="listTdLeft" style="width: 80px">
                房间：
            </td>
            <td>
                <asp:DropDownList ID="ddl_rooinfo" runat="server">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft" style="width: 80px">
                满局：
            </td>
            <td>
                <asp:TextBox ID="tb_fullcouncil" CssClass="text wd4 " runat="server"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft" style="width: 80px">
                奖励金额：
            </td>
            <td>
                <asp:TextBox ID="tb_score" CssClass="text wd4 " runat="server"></asp:TextBox>
            </td>
        </tr>
          <tr>
            <td class="listTdLeft" style="width: 80px">
                可领取次数：
            </td>
            <td>
                <asp:TextBox ID="tb_times" CssClass="text wd4 " Text="1" runat="server"></asp:TextBox>
            </td>
        </tr>
          <tr>
            <td class="listTdLeft" style="width: 80px">
                启用状态：
            </td>
            <td>
                <asp:DropDownList ID="ddl_enable" runat="server">
                <asp:ListItem Text="启用" Value="0"></asp:ListItem>
                <asp:ListItem Text="禁用" Value="1"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('DayPalyCount.aspx')" />
                <input class="btnLine" type="button" />
                <asp:Button ID="btnSave" runat="server" Text="添加" CssClass="btn wd1" OnClick="btn_edit_Click" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
