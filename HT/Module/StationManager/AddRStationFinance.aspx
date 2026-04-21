<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddRStationFinance.aspx.cs" Inherits="MTEwin.Module.StationManager.AddRStationFinance" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../../scripts/jquery.js"></script>

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
        <td width="1232" height="25" valign="top" align="left">你当前位置：分站系统 - 分站提款
        </td>
      </tr>
    </table>

    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="关闭" class="btn wd1" onclick="window.close();" />
          <input class="btnLine" type="button" />
          <asp:Button ID="btnSave" runat="server" Text="提交" CssClass="btn wd1" OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">

      <tr>
        <td class="listTdLeft">直属站点：
                  
        </td>
        <td>
          <asp:Literal ID="ltStation" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">账户余额：
        </td>
        <td>
          <asp:Literal ID="ltGoldBalance" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">提款金额：
        </td>
        <td>
          <asp:TextBox ID="txtAmount" runat="server" CssClass="text" MaxLength="9" onkeyup="if(isNaN(value))execCommand('undo');"></asp:TextBox>&nbsp;
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">备注：
        </td>
        <td>
          <asp:TextBox ID="txtCollectNote" runat="server" TextMode="MultiLine" Height="50" Width="300" Text="提款"></asp:TextBox>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="关闭" class="btn wd1" onclick="window.close();" />
          <input class="btnLine" type="button" />
          <asp:Button ID="btnSave1" runat="server" Text="提交" CssClass="btn wd1" OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

