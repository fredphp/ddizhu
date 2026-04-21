<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameWxRegisterInfos.aspx.cs" Inherits="MTEwin.Module.WebManager.GameWxRegisterInfos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../../scripts/common.js"></script>

  <script type="text/javascript" src="../../scripts/comm.js"></script>

  <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>

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
        <td width="1232" height="25" valign="top" align="left">你当前位置：活动系统 - 微信签到管理
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="28">
          <ul>

            <li class="tab2" onclick="Redirect('BindWeiXin.aspx')">微信绑定管理</li>
            <li class="tab1">微信签到管理</li>
            <li class="tab2" onclick="Redirect('GameShareList.aspx')">微信分享管理</li>
          </ul>
        </td>
      </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td>用户：<asp:TextBox ID="txtUser" runat="server"></asp:TextBox>
          &nbsp;&nbsp
                日期查询：
                 <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                   src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                   style="cursor: pointer; vertical-align: middle" />
          至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                  src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                  style="cursor: pointer; vertical-align: middle" />
          <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
          &nbsp;
               
                <input type="button" value="签到配置" onclick="Redirect('/Module/AccountManager/UserWXSignConfig.aspx');" />
        </td>
      </tr>

    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="关闭" class="btn wd1" onclick="window.close();" />
        </td>
      </tr>
    </table>
    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
        <tr align="center" class="bold">
          <td class="listTitle">用户账户</td>
          <td class="listTitle2">赢取金币</td>
          <td class="listTitle2">签到日期</td>
        </tr>
        <asp:Repeater ID="rptExchangeLogDetail" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td><%# Eval("Account")%></td>
              <td><%# Eval("RegisterMony")%></td>
              <td><%# Eval("RegisterDate")%></td>
            </tr>
          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td><%# Eval("Account")%></td>
              <td><%# Eval("RegisterMony")%></td>
              <td><%# Eval("RegisterDate")%></td>
            </tr>
          </AlternatingItemTemplate>
        </asp:Repeater>
        <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
      </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td align="right" class="page">
          <gsp:AspNetPager ID="anpNews" runat="server" OnPageChanged="anpNews_PageChanged" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="20"
            NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table" NumericButtonCount="5"
            CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
  </form>
</body>
</html>
