<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StationsInfo.aspx.cs" Inherits="MTEwin.Module.StationManager.StationsInfo" %>

<%@ Register Src="~/Themes/TabStation.ascx" TagPrefix="Fox" TagName="Tab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../../scripts/jquery.js"></script>

  <script type="text/javascript" src="../../scripts/common.js"></script>
  <script type="text/javascript" src="../../scripts/jquery.validate.js"></script>

  <script type="text/javascript" src="../../scripts/messages_cn.js"></script>

  <script type="text/javascript" src="../../scripts/jquery.metadata.js"></script>

  <script type="text/javascript">
    jQuery(document).ready(function() {
      jQuery.metadata.setType("attr","validate");
      jQuery("#<%=form1.ClientID %>").validate();
    });
  </script>
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
        <td width="1232" height="25" valign="top" align="left">你当前位置：分站管理 - 基本信息
        </td>
      </tr>
    </table>
    <Fox:Tab ID="tab1" runat="server"></Fox:Tab>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect(decodeURIComponent(GetRequest('reurl','StationsList.aspx')))" />
          <input class="btnLine" type="button" />
          <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
      <tr>
        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
          <div class="hg3  pd7">
            <asp:Literal ID="litInfo" runat="server"></asp:Literal>基本信息
          </div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">站点标识：
        </td>
        <td>
          <asp:TextBox ID="txtStationID" runat="server" CssClass="text" MaxLength="15" validate="{required:true,digits:true}"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">提款密码：
        </td>
        <td>
          <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="text" MaxLength="18"></asp:TextBox>&nbsp;留空不修改
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">分成比例：
        </td>
        <td>
          <asp:TextBox ID="txtChannelScale" runat="server" CssClass="text  wd4" MaxLength="3" validate="{range:[0,100]}" onkeyup="if(isNaN(value))execCommand('undo');"></asp:TextBox>(%)&nbsp;比例设置范围0-100%
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">站点名称：
        </td>
        <td>
          <asp:TextBox ID="txtStationName" runat="server" CssClass="text" MaxLength="30" validate="{required:true}"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">站点别名：
        </td>
        <td>
          <asp:TextBox ID="txtStationAlias" runat="server" CssClass="text" MaxLength="30"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">站点域名：
        </td>
        <td>
          <asp:TextBox ID="txtStationDomain" runat="server" CssClass="text" MaxLength="200"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">授权码：
        </td>
        <td>
          <asp:TextBox ID="txtAccreditID" runat="server" CssClass="text" Width="200px" MaxLength="200"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">联系人：
        </td>
        <td>
          <asp:TextBox ID="txtContactUser" runat="server" CssClass="text" Width="200px" MaxLength="50"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">联系邮箱：
        </td>
        <td>
          <asp:TextBox ID="txtContactMail" runat="server" CssClass="text" Width="200px" MaxLength="50" validate="{email:true}"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">联系电话：
        </td>
        <td>
          <asp:TextBox ID="txtContactPhone" runat="server" CssClass="text" Width="200px" MaxLength="35"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">联系手机：
        </td>
        <td>
          <asp:TextBox ID="txtContactMobile" runat="server" CssClass="text" Width="200px" MaxLength="35"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">联系地址：
        </td>
        <td>
          <asp:TextBox ID="txtContactAddress" runat="server" CssClass="text" Width="300px" MaxLength="200"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">冻结状态：
        </td>
        <td>
          <asp:DropDownList ID="ddlNullity" runat="server">
            <asp:ListItem Value="0" Text="正常"></asp:ListItem>
            <asp:ListItem Value="1" Text="冻结"></asp:ListItem>
          </asp:DropDownList>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect(decodeURIComponent(GetRequest('reurl','StationsList.aspx')))" />
          <input class="btnLine" type="button" />
          <asp:Button ID="btnSave1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

