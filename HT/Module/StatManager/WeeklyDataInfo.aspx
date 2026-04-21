<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WeeklyDataInfo.aspx.cs" Inherits="MTEwin.Module.StatManager.WeeklyDataInfo" %>

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
        <td width="1232" height="25" valign="top" align="left">你当前位置：汇总统计 - 每周分析
        </td>
      </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
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
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
      <tr>
        <td height="39" class="titleOpBg">
          <asp:Button ID="btnDelete" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()"
            Visible="false" />
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
          <td class="listTitle2">登录人数
          </td>
          <td class="listTitle2">活跃人数
          </td>
          <td class="listTitle2">忠诚人数
          </td>
          <td class="listTitle2">流失人数
          </td>
          <td class="listTitle2">流失率
          </td>
          <td class="listTitle2">忠诚流失人数
          </td>
          <td class="listTitle2">忠诚流失率
          </td>
          <td class="listTitle2">转换率
          </td>
          <td class="listTitle2">充值总额
          </td>
          <td class="listTitle2">充值人数
          </td>
          <td class="listTitle2">新增充值人数
          </td>
          <td class="listTitle2">充值率
          </td>
          <td class="listTitle1">充值流失人数
          </td>
          <td class="listTitle2">充值流失率
          </td>
          <td class="listTitle2">ARPU值
          </td>
          <td class="listTitle2">平均最高在线
          </td>
          <td class="listTitle1">统计时间
          </td>
        </tr>
        <asp:Repeater ID="rptDataList" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td style="width: 30px;">
                <input name='cid' type='checkbox' value='<%# Eval("DateID").ToString()%>' />
              </td>
              <td>
                <%# Game.Facade.Fetch.ShowDate( int.Parse( Eval( "DateID" ).ToString( ) ) )%>
              </td>
              <td>
                <%# Eval( "LogonCount" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "ActiviteCount" ).ToString( )%>
              </td>
              <td>
                <%#  Eval( "LoyalCount" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "LostCount" ).ToString( )%>
              </td>
              <td>
                <%# double.Parse(Eval( "LostRate" ).ToString( )).ToString("0%")%>
              </td>
              <td>
                <%# Eval( "LoyalLostCount" ).ToString( )%>
              </td>
              <td>
                <%# double.Parse( Eval( "LoyalLostRate" ).ToString( )).ToString("0%")%>
              </td>
              <td>
                <%# double.Parse( Eval( "ChangeRate" ).ToString( )).ToString("0%")%>
              </td>
              <td>
                <%# Eval( "PaidTotal" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "PayerCount" ).ToString( )%>
              </td>
              <td>
                <%#  Eval( "NewPayerCount" ).ToString( )%>
              </td>
              <td>
                <%# double.Parse( Eval( "PayRate" ).ToString( )).ToString("0%")%>
              </td>
              <td>
                <%# Eval( "PayLostCount" ).ToString( )%>
              </td>
              <td>
                <%# double.Parse( Eval( "PayLostRate" ).ToString( )).ToString("0%")%>
              </td>
              <td>
                <%#  Eval( "ARPU" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "AvgOnline" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "CollectDate" ).ToString( )%>
              </td>
            </tr>
          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td style="width: 30px;">
                <input name='cid' type='checkbox' value='<%# Eval("DateID").ToString()%>' />
              </td>
              <td>
                <%# Game.Facade.Fetch.ShowDate( int.Parse( Eval( "DateID" ).ToString( ) ) )%>
              </td>
              <td>
                <%# Eval( "LogonCount" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "ActiviteCount" ).ToString( )%>
              </td>
              <td>
                <%#  Eval( "LoyalCount" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "LostCount" ).ToString( )%>
              </td>
              <td>
                <%# double.Parse(Eval( "LostRate" ).ToString( )).ToString("0%")%>
              </td>
              <td>
                <%# Eval( "LoyalLostCount" ).ToString( )%>
              </td>
              <td>
                <%# double.Parse( Eval( "LoyalLostRate" ).ToString( )).ToString("0%")%>
              </td>
              <td>
                <%# double.Parse( Eval( "ChangeRate" ).ToString( )).ToString("0%")%>
              </td>
              <td>
                <%# Eval( "PaidTotal" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "PayerCount" ).ToString( )%>
              </td>
              <td>
                <%#  Eval( "NewPayerCount" ).ToString( )%>
              </td>
              <td>
                <%# double.Parse( Eval( "PayRate" ).ToString( )).ToString("0%")%>
              </td>
              <td>
                <%# Eval( "PayLostCount" ).ToString( )%>
              </td>
              <td>
                <%# double.Parse( Eval( "PayLostRate" ).ToString( )).ToString("0%")%>
              </td>
              <td>
                <%#  Eval( "ARPU" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "AvgOnline" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "CollectDate" ).ToString( )%>
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

