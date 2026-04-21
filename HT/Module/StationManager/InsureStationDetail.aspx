<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InsureStationDetail.aspx.cs" Inherits="MTEwin.Module.StationManager.InsureStationDetail" %>

<%@ Register Src="~/Themes/TabStation.ascx" TagPrefix="Fox" TagName="Tab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../../scripts/common.js"></script>

  <title></title>
</head>
<body>
  <form id="form1" runat="server">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
      <tr>
        <td width="19" height="25" valign="top" class="Lpd10">
          <div class="arr">
          </div>
        </td>
        <td width="1232" height="25" valign="top" align="left">你当前位置：分站管理 - 财富信息
        </td>
      </tr>
    </table>
    <Fox:Tab ID="tab1" runat="server"></Fox:Tab>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect(decodeURIComponent(GetRequest('reurl','StationsList.aspx')))" />

        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
      <tr>
        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
          <div class="hg3  pd7">
            分站财富信息
          </div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">站点标识：
        </td>
        <td>
          <asp:Literal ID="ltStationID" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">账户金额：
        </td>
        <td>
          <asp:Literal ID="ltGoldBalance" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">分成比例：
        </td>
        <td>
          <asp:Literal ID="ltChannelScale" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">抽水总额：
        </td>
        <td>
          <asp:Literal ID="ltStatChannelGold" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">统计时间：
        </td>
        <td>
          <asp:Literal ID="ltStatLastDate" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">创建时间：
        </td>
        <td>
          <asp:Literal ID="ltCollectDate" runat="server"></asp:Literal>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect(decodeURIComponent(GetRequest('reurl','StationsList.aspx')))" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

