<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RStationFinanceList.aspx.cs" Inherits="MTEwin.Module.StationManager.RStationFinanceList" %>

<%@ Register Src="~/Themes/TabStation.ascx" TagPrefix="Fox" TagName="Tab" %>
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

    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
      <tr>
        <td width="19" height="25" valign="top" class="Lpd10">
          <div class="arr">
          </div>
        </td>
        <td width="1232" height="25" valign="top" align="left">你当前位置：分站管理 - 收支明细记录
        </td>
      </tr>
    </table>
    <Fox:Tab ID="tab1" runat="server"></Fox:Tab>

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
          <asp:DropDownList ID="ddlType" runat="server">
            <asp:ListItem Value="0">全部类型</asp:ListItem>
            <asp:ListItem Value="1">收入</asp:ListItem>
            <asp:ListItem Value="2">提现支出</asp:ListItem>
            <asp:ListItem Value="3">赠送支出</asp:ListItem>
          </asp:DropDownList>
          <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
          <asp:Button ID="btnQueryTD" runat="server" Text="今天" CssClass="btn wd1" OnClick="btnQueryTD_Click" />
          <asp:Button ID="btnQueryYD" runat="server" Text="昨天" CssClass="btn wd1" OnClick="btnQueryYD_Click" />
          <asp:Button ID="btnQueryTW" runat="server" Text="本周" CssClass="btn wd1" OnClick="btnQueryTW_Click" />
          <asp:Button ID="btnQueryYW" runat="server" Text="上周" CssClass="btn wd1" OnClick="btnQueryYW_Click" />
        </td>
      </tr>
    </table>
    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7" id="list">
        <tr align="center" class="bold">
          <td class="listTitle2">日期
          </td>
          <td class="listTitle2">直属站点
          </td>
          <td class="listTitle2">操作金额
          </td>
          <td class="listTitle2">操作前金额
          </td>
          <td class="listTitle2">分成比例
          </td>
          <td class="listTitle2">类型
          </td>
          <td class="listTitle2">操作者
          </td>
          <td class="listTitle2">备注
          </td>
        </tr>
        <asp:Repeater ID="rptDataList" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <%# Eval( "CreateDate", "{0:yyyy-MM-dd}" ).ToString( )%>
              </td>
              <td>
                <%# GetStationName( int.Parse( Eval( "StationID" ).ToString( ) ) )%>
              </td>
              <td>
                <%# Eval( "Amount" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "PreAmount" ).ToString( )%>
              </td>
              <td>
                <%#(int) Eval( "CreateBy" )>0?"": double.Parse( Eval( "ChannelScale" ).ToString( ) ).ToString( "0%" )%>
              </td>
              <td>
                <%#GetTypeName((int) Eval( "TypeID" ) )%>
              </td>
              <td>
                <%#GetMasterName((int) Eval( "CreateBy" ))%>
              </td>
              <td>
                <%# Eval( "CollectNote" ).ToString( )%>
              </td>
            </tr>
          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <%# Eval( "CreateDate", "{0:yyyy-MM-dd}" ).ToString( )%>
              </td>
              <td>
                <%# GetStationName( int.Parse( Eval( "StationID" ).ToString( ) ) )%>
              </td>
              <td>
                <%# Eval( "Amount" ).ToString( )%>
              </td>
              <td>
                <%# Eval( "PreAmount" ).ToString( )%>
              </td>
              <td>
                <%#(int) Eval( "CreateBy" )>0?"": double.Parse( Eval( "ChannelScale" ).ToString( ) ).ToString( "0%" )%>
              </td>
              <td>
                <%#GetTypeName((int) Eval( "TypeID" ) )%>
              </td>
              <td>
                <%#GetMasterName((int) Eval( "CreateBy" ))%>
              </td>
              <td>
                <%# Eval( "CollectNote" ).ToString( )%>
              </td>
            </tr>
          </AlternatingItemTemplate>
        </asp:Repeater>
        <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
      </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td align="right" class="page">
          <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
            PageSize="20" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
            NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%" UrlPaging="false">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

