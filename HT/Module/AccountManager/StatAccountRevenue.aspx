<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatAccountRevenue.aspx.cs" Inherits="MTEwin.Module.AccountManager.StatAccountRevenue" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../scripts/common.js"></script>

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
                你当前位置：用户系统 - 抽水统计与结算
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <div style="text-align: center;">
        <h3>
            作为紧急处理。统计玩家抽水，只统计到昨天为止的数据。<br /><br />
            描述：在断电或维护时，忘记开启作业执行，导致玩家的抽水没有及时统计，则需要手工执行。</h3>
        <br />
        <asp:Button ID="btnUpdateRevenue" runat="server" Text="开始统计并结算" OnClick="btnUpdateRevenue_Click" />
    </div>
    </form>
</body>
</html>

