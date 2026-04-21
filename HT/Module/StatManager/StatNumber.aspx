<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatNumber.aspx.cs" Inherits="MTEwin.Module.StatManager.StatNumber" %>

<%@ Register TagPrefix="cc1" Namespace="Anthem" Assembly="Anthem" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../../scripts/common.js"></script>

  <script type="text/javascript" src="../../scripts/comm.js"></script>

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
        <td width="1232" height="25" valign="top" align="left">你当前位置：汇总统计 - 人数统计
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td class="listTdLeft" style="width: 80px">查询方式：
        </td>
        <td>
          <cc1:DropDownList ID="ddlType" runat="server" Style="vertical-align: middle" AutoCallBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
            <asp:ListItem Value="0" Text="按年"></asp:ListItem>
            <asp:ListItem Value="1" Text="按月" Selected="True"></asp:ListItem>
            <asp:ListItem Value="2" Text="按日"></asp:ListItem>
          </cc1:DropDownList>
          <cc1:DropDownList ID="ddlSelectYear" runat="server" Style="vertical-align: middle" AutoCallBack="true" OnSelectedIndexChanged="ddlSelectYear_SelectedIndexChanged">
          </cc1:DropDownList>
          <cc1:DropDownList ID="ddlSelectMonth" runat="server" Style="vertical-align: middle" AutoCallBack="true" OnSelectedIndexChanged="ddlSelectMonth_SelectedIndexChanged">
          </cc1:DropDownList>
          <cc1:DropDownList ID="ddlSelectDay" runat="server" Visible="false" Style="vertical-align: middle">
          </cc1:DropDownList>
          <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
          <asp:Button ID="btnQueryTD" runat="server" Text="今天" CssClass="btn wd1" OnClick="btnQueryTD_Click" />
          <asp:Button ID="btnQueryYD" runat="server" Text="昨天" CssClass="btn wd1" OnClick="btnQueryYD_Click" />
        </td>
      </tr>
    </table>
    <br />
    <asp:Chart ID="Chart1" runat="server" Width="800" Height="400" BackColor="#D3DFF0" BorderColor="26, 59, 105" Palette="BrightPastel"
      BorderDashStyle="Solid" BackGradientStyle="TopBottom" BackSecondaryColor="White" BorderWidth="2">
      <Legends>
        <asp:Legend Name="Default" BackColor="Transparent" IsTextAutoFit="False">
        </asp:Legend>
      </Legends>
      <BorderSkin SkinStyle="Emboss"></BorderSkin>
      <ChartAreas>
        <asp:ChartArea Name="ChartArea1" BorderColor="64, 64, 64, 64" BorderDashStyle="Solid" BackSecondaryColor="White" BackColor="Transparent"
          ShadowColor="Transparent">
          <Position Y="10" Height="83" Width="89.43796" X="3.824818"></Position>
          <AxisY LineColor="64, 64, 64, 64" IsLabelAutoFit="False">
            <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" />
            <MajorGrid Interval="Auto" LineColor="64, 64, 64, 64" />
            <MajorTickMark Interval="1" Enabled="False" />
          </AxisY>
          <AxisX LineColor="64, 64, 64, 64" IsLabelAutoFit="False" IsMarginVisible="true" Interval="1">
            <LabelStyle Font="Trebuchet MS, 8.25pt, style=Bold" Interval="0" />
            <MajorGrid Interval="1" LineColor="64, 64, 64, 64" />
            <MajorTickMark Interval="1" Enabled="False" />
          </AxisX>
        </asp:ChartArea>
      </ChartAreas>
    </asp:Chart>
    <br />
    <div style="width: 800px;">
      <asp:HiddenField ID="hfdTime" runat="server" />
    </div>
  </form>
</body>
</html>

