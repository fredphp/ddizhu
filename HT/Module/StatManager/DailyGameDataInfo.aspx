<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DailyGameDataInfo.aspx.cs" Inherits="MTEwin.Module.StatManager.DailyGameDataInfo" %>

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

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
      <tr>
        <td width="19" height="25" valign="top" class="Lpd10">
          <div class="arr">
          </div>
        </td>
        <td width="1232" height="25" valign="top" align="left">你当前位置：汇总统计 - 每日游戏数据
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="28">
          <ul>
            <li class="tab2" onclick="Redirect('DailyDataInfo.aspx')">每日系统数据</li>
            <li class="tab1">每日游戏数据</li>
            <li class="tab2" onclick="Redirect('DailyGamesInfo.aspx')">每日游戏局数</li>
          </ul>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="39" class="titleOpBg">
          <asp:Button ID="btnDelete" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()"
            Visible="false" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg" style="margin-bottom: 5px;">
      <tr>
        <td class="listTdLeft" style="width: 80px">日期查询：
        </td>
        <td>
          <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
            src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
            style="cursor: pointer; vertical-align: middle" />
          至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                  src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                  style="cursor: pointer; vertical-align: middle" />
          <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
          <asp:Button ID="btnRefresh" runat="server" Text="刷新" CssClass="btn wd1" OnClick="btnRefresh_Click" />
        </td>
      </tr>
    </table>

    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
        <tr align="center" class="bold">
          <td class="listTitle">
            <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" />
          </td>
          <td class="listTitle2">日期
          </td>
          <td class="listTitle2">游戏名称
          </td>
          <td class="listTitle2">登录人数
          </td>
          <td class="listTitle2">游戏税收
          </td>
          <td class="listTitle2">游戏局数
          </td>
          <td class="listTitle2">最高输赢
          </td>
          <td class="listTitle2">最低输赢
          </td>
        </tr>
        <asp:Repeater ID="rptDataList" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td style="width: 30px;">
                <input name='cid' type='checkbox' value='<%# Eval("TempID").ToString()%>' />
              </td>
              <td>
                <%#  Eval( "InputDate" )%>
              </td>
              <td>
                <%# Eval( "KindName" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "LogonCount" ).ToString( ) %>
              </td>
              <td>
                <%#  Eval( "Revenue" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "Games" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "MaxScore" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "MinScore" ).ToString( )%>
              </td>
            </tr>
          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td style="width: 30px;">
                <input name='cid' type='checkbox' value='<%# Eval("TempID").ToString()%>' />
              </td>
              <td>
                <%#  Eval( "InputDate" )%>
              </td>
              <td>
                <%# Eval( "KindName" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "LogonCount" ).ToString( ) %>
              </td>
              <td>
                <%#  Eval( "Revenue" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "Games" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "MaxScore" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "MinScore" ).ToString( )%>
              </td>
            </tr>
          </AlternatingItemTemplate>
        </asp:Repeater>
        <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
      </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="listTitleBg">
          <span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a class="l1" href="javascript:SelectAll(false);">无</a>
        </td>
        <td align="right" class="page">
          <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
            PageSize="20" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
            NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%" UrlPaging="false">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
      <tr>
        <td height="39" class="titleOpBg">

          <asp:Button ID="btnDelete1" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()"
            Visible="false" />

        </td>
      </tr>
    </table>
  </form>
</body>
</html>
