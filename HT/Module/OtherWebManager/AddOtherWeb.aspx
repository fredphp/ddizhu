<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddOtherWeb.aspx.cs" Inherits="MTEwin.Module.OtherWebManager.AddOtherWeb" %>

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
      <td width="1232" height="25" valign="top" align="left">目前操作功能：<asp:Literal ID="opters" runat="server"></asp:Literal>商户
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
            基本信息
          </div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">商户ID：
        </td>
        <td>
          <asp:Literal ID="ltMarchantId" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">商户名：
        </td>
        <td>
          <asp:TextBox ID="txtMarchantName" runat="server" CssClass="text wd4"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">网站名称：
        </td>
        <td>
          <asp:TextBox ID="txtWebName" runat="server" CssClass="text wd4"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">网站链接：
        </td>
        <td>
          <asp:TextBox ID="txtWebLink" runat="server" CssClass="text wd4"></asp:TextBox><font style="color: #ff0000">（请在链接前加http://，例如http://www.baidu.com）</font>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">联系电话：
        </td>
        <td>
          <asp:TextBox ID="txtTelPhone" runat="server" CssClass="text wd4"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">联系QQ：
        </td>
        <td>
          <asp:TextBox ID="txtQQ" runat="server" CssClass="text wd4"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">商户密钥：
        </td>
        <td>
          <asp:Label ID="lMarchantKey" runat="server" Text=""></asp:Label>
          <asp:Button ID="btnCreatKey" runat="server" Text="生成商户密钥"
            OnClick="btnCreatKey_Click" /><font style="color: #ff0000">（生成密钥前请先输入其他信息）</font>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">是否冻结：
        </td>
        <td>
          <asp:CheckBox ID="cbDong" runat="server" />
        </td>
      </tr>

    </table>
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="关闭" runat="server" id="btnClose1" class="btn wd1" onclick="window.close();" />
          <asp:Button ID="btnSave1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>
