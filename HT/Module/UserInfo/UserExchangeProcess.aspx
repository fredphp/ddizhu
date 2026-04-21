<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserExchangeProcess.aspx.cs" Inherits="MTEwin.Module.UserInfo.UserExchangeProcess" %>

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
          <div class="arr"></div>
        </td>
        <td width="1232" height="25" valign="top" align="left">你当前位置：充值系统 - 兑换管理</td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <tr>
          <td class="titleOpBg Lpd10">
            <input type="button" value="返回" class="btn wd1" onclick="Redirect('../AccountManager/ChargeAndCash.aspx?types=3&param=<%=param2 %>')" />
            <input class="btnLine" type="button" />
            <asp:Button ID="btnSave" runat="server" Text="提交" CssClass="btn wd1"
              OnClick="btnSave_Click" />
          </td>
        </tr>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
      <tr>
        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
          <div class="hg3  pd7">
            <asp:Literal ID="litInfo" runat="server"></asp:Literal>处理信息
          </div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">申请单号：</td>
        <td>
          <asp:Label ID="lblOrderID" runat="server"></asp:Label>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">申请金额：</td>
        <td>
          <asp:Label ID="lblApplyMoney" runat="server"></asp:Label>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">审核：</td>
        <td>
          <asp:RadioButtonList ID="rbtnApplyStatus" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Value="0" Text="申请中"></asp:ListItem>
            <asp:ListItem Value="1" Text="同意兑换"></asp:ListItem>
            <asp:ListItem Value="2" Text="拒绝兑换"></asp:ListItem>
            <asp:ListItem Value="3" Text="已提款"></asp:ListItem>
          </asp:RadioButtonList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">处理意见：</td>
        <td>
          <asp:TextBox ID="txtDealNote" runat="server" CssClass="text" TextMode="MultiLine" Width="300px" Height="100px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">处理时间：</td>
        <td>
          <asp:Label ID="lblDealDate" runat="server"></asp:Label>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">账户类型：</td>
        <td>
          <asp:Label ID="lblAccountType" runat="server"></asp:Label>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">账户号：</td>
        <td>
          <asp:Label ID="lblAccountNo" runat="server"></asp:Label>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">账户名：</td>
        <td>
          <asp:Label ID="lblAccountName" runat="server"></asp:Label>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">银行名称：</td>
        <td>
          <asp:Label ID="lblBankName" runat="server"></asp:Label>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">银行地址：</td>
        <td>
          <asp:Label ID="lblBankAddress" runat="server"></asp:Label>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">申请时间：</td>
        <td>
          <asp:Label ID="lblCollectDate" runat="server"></asp:Label>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">申请地址：</td>
        <td>
          <asp:Label ID="lblIPAddress" runat="server"></asp:Label>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <tr>
          <td class="titleOpBg Lpd10">
            <input type="button" value="返回" class="btn wd1" onclick="Redirect('UserExchangeList.aspx')" />
            <input class="btnLine" type="button" />
            <asp:Button ID="btnSave2" runat="server" Text="提交" CssClass="btn wd1"
              OnClick="btnSave_Click" />
          </td>
        </tr>
      </tr>
    </table>
  </form>
</body>
</html>

