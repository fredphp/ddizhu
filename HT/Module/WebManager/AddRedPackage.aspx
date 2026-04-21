<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddRedPackage.aspx.cs"
  Inherits="MTEwin.Module.WebManager.AddRedPackage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
        <td width="1232" height="25" valign="top" align="left">你当前位置：网站系统 - 发送红包
        </td>
      </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect('RedPackageList.aspx')" />
          <input class="btnLine" type="button" />
          <asp:Button ID="Button1" runat="server" Text="发送" CssClass="btn wd1" OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td class="listTdLeft" style="width: 80px">红包主题：
        </td>
        <td>
          <asp:TextBox ID="tb_theme" CssClass="text wd4 " runat="server"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">红包总金额：
        </td>
        <td>
          <asp:TextBox ID="tb_totalscore" CssClass="text wd4 " runat="server"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">红包人数：
        </td>
        <td>
          <asp:TextBox ID="tb_totaluser" CssClass="text wd4 " runat="server"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">类型：
        </td>
        <td>
          <asp:RadioButtonList ID="rdl_redtype" runat="server" AutoPostBack="true">
            <asp:ListItem Text="均分" Value="0" Selected="True"> </asp:ListItem>
            <asp:ListItem Text="随机" Value="1"></asp:ListItem>
          </asp:RadioButtonList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">随机金额：
        </td>
        <td>
          <asp:TextBox ID="tb_lessscore" CssClass="text wd4 " runat="server"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">开始时间：
        </td>
        <td>
          <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd4" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
            src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
            style="cursor: pointer; vertical-align: middle" />
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">结束时间：
        </td>
        <td>
          <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd4" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
            src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
            style="cursor: pointer; vertical-align: middle" />
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">红包限制：
        </td>
        <td>
          <asp:RadioButtonList ID="rbl_limittype" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rbl_limittype_SelectedIndexChanged">
            <asp:ListItem Text="无限制" Value="0" Selected="True"> </asp:ListItem>
            <asp:ListItem Text="充值限制" Value="1"></asp:ListItem>
            <asp:ListItem Text="携带金币限制" Value="2"></asp:ListItem>
            <asp:ListItem Text="游戏时长" Value="3"></asp:ListItem>
          </asp:RadioButtonList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">
          <asp:Literal ID="lit_limittip" runat="server"></asp:Literal>
        </td>
        <td>
          <asp:TextBox ID="tb_limit" CssClass="text wd4 " runat="server"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <div id="turnon" runat="server">
            <table width="100%">
              <tr>
                <td class="listTdLeft" style="width: 80px">充值/游戏时长：
                </td>
                <td>从：
                                <asp:TextBox ID="TextBox1" runat="server" CssClass="text wd4" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'TextBox2\')}'})"></asp:TextBox><img
                                  src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'TextBox1',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'TextBox2\')}'})"
                                  style="cursor: pointer; vertical-align: middle" /><b class="hong">（可不填写）</b>
                  到
                                <asp:TextBox ID="TextBox2" runat="server" CssClass="text wd4" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'TextBox1\')}'})"></asp:TextBox><img
                                  src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'TextBox2',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'TextBox2\')}'})"
                                  style="cursor: pointer; vertical-align: middle" />为止<b class="hong">（可不填写）</b>
                </td>
              </tr>
            </table>
          </div>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect('EmailList.aspx')" />
          <input class="btnLine" type="button" />
          <asp:Button ID="btnSave" runat="server" Text="发送" CssClass="btn wd1" OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>
