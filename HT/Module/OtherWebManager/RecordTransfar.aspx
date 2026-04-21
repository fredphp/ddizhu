<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecordTransfar.aspx.cs" Inherits="MTEwin.Module.OtherWebManager.RecordTransfar" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
        <td width="1232" height="25" valign="top" align="left">你当前位置：外部网站系统 - 用户转账记录
        </td>
      </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td class="listTdLeft" style="width: 80px">日期查询：
        </td>
        <td>
          <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
            src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',skin:'whyGreen',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
            style="cursor: pointer; vertical-align: middle" />
          至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                  src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',skin:'whyGreen',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                  style="cursor: pointer; vertical-align: middle" />
          <asp:Button ID="btnQueryTD" runat="server" Text="今天" CssClass="btn wd1"
            OnClick="btnQueryTD_Click" />
          <asp:Button ID="btnQueryYD" runat="server" Text="昨天" CssClass="btn wd1"
            OnClick="btnQueryYD_Click" />
          <asp:Button ID="btnQueryTW" runat="server" Text="本周" CssClass="btn wd1"
            OnClick="btnQueryTW_Click" />
          <asp:Button ID="btnQueryYW" runat="server" Text="上周" CssClass="btn wd1"
            OnClick="btnQueryYW_Click" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td>&nbsp;
                输入商户编号:<asp:TextBox ID="txtSearch" runat="server" CssClass="text" ToolTip="输入商户编号"></asp:TextBox>
          玩家用户名:<asp:TextBox ID="txtAccount" runat="server" CssClass="text" ToolTip="输入玩家用户名"></asp:TextBox>
          <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
          <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
        </td>
      </tr>
    </table>
    <div class="clear">
    </div>
    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
        id="list">
        <tr align="center" class="bold">
          <td class="listTitle2">商户ID
          </td>
          <td class="listTitle2">商户名
          </td>
          <td class="listTitle2">网站金额
          </td>
          <td class="listTitle2">转账玩家
          </td>
          <td class="listTitle2">转账前金币
          </td>
          <td class="listTitle2">转账类型
          </td>
          <td class="listTitle2">转账金币
          </td>
          <td class="listTitle2">转账时间
          </td>
        </tr>
        <asp:Repeater ID="rptDataList" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <%#  Eval("MerchantId").ToString()%>
              </td>
              <td>
                <a onclick="openWindowOwn('AddOtherWeb.aspx?cmd=upOtherWeb&param=<%# Eval("MerchantId") %>','<%# Eval("MerchantId") %>',850,450)" href='javascript:void(0);' style="color: #0000ff;"><%#  getMerchantName(int.Parse(Eval("MerchantId").ToString()))%></a>
              </td>
              <td>
                <%#  Eval("WebAmount").ToString()%>
              </td>
              <td>
                <%#GetIsPaidStyle(int.Parse(Eval("UserId").ToString()))%>
                <a class="l" href="javascript:void(0);" onclick="openWindowOwn('/Module/AccountManager/AccountsInfo.aspx?param=<%#Eval("UserId").ToString() %>','<%#Eval("UserId").ToString() %>',850,600);">
                  <%#Game.Utils.TextUtility.CutString(Eval("Accounts").ToString(), 0, 10)%></a>
              </td>
              <td>
                <%#  Eval("OldInsure").ToString()%>
              </td>
              <td>
                <%#  Eval("Type").ToString()=="0"?"转入":"转出"%>
              </td>
              <td>
                <%#  Eval("Money").ToString()%>
              </td>
              <td>
                <%#  Eval("InsertTime").ToString()%>
              </td>
            </tr>
          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <%#  Eval("MerchantId").ToString()%>
              </td>
              <td>
                <a onclick="openWindowOwn('AddOtherWeb.aspx?cmd=upOtherWeb&param=<%# Eval("MerchantId") %>','<%# Eval("MerchantId") %>',850,450)" href='javascript:void(0);' style="color: #0000ff;"><%#  getMerchantName(int.Parse(Eval("MerchantId").ToString()))%></a>
              </td>
              <td>
                <%#  Eval("WebAmount").ToString()%>
              </td>
              <td>
                <%#GetIsPaidStyle(int.Parse(Eval("UserId").ToString()))%>
                <a class="l" href="javascript:void(0);" onclick="openWindowOwn('/Module/AccountManager/AccountsInfo.aspx?param=<%#Eval("UserId").ToString() %>','<%#Eval("UserId").ToString() %>',850,600);">
                  <%#Game.Utils.TextUtility.CutString(Eval("Accounts").ToString(), 0, 10)%></a>
              </td>
              <td>
                <%#  Eval("OldInsure").ToString()%>
              </td>
              <td>
                <%#  Eval("Type").ToString()=="0"?"转入":"转出"%>
              </td>
              <td>
                <%#  Eval("Money").ToString()%>
              </td>
              <td>
                <%#  Eval("InsertTime").ToString()%>
              </td>
            </tr>
          </AlternatingItemTemplate>
        </asp:Repeater>
        <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
      </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="listTitleBg"></td>
        <td align="right" class="page">
          <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server"
            AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="15" NextPageText="下页"
            PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
            NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
            UrlPaging="false">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
    <input type="hidden" runat="server" id="hidAgencyId" />
  </form>
</body>
</html>



