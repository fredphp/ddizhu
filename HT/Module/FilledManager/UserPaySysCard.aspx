<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserPaySysCard.aspx.cs" Inherits="MTEwin.Module.FilledManager.UserPaySysCard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../../scripts/common.js"></script>

  <script type="text/javascript" src="../../scripts/comm.js"></script>

  <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
  <style>
    .green { color: Green; }
  </style>
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
        <td width="1232" height="25" valign="top" align="left">你当前位置：充值系统 - 申请充值
        </td>
      </tr>
    </table>

    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td class="listTdLeft" style="width: 80px">银行充值金额：
        </td>
        <td>
          <asp:Literal ID="ltMoneyTotal" runat="server"></asp:Literal>
          <input class="btnLine" type="button" />
          直属站点：
                <asp:DropDownList ID="ddlStation" runat="server">
                </asp:DropDownList>
          &nbsp;&nbsp; 日期查询：
                <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                  src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                  style="cursor: pointer; vertical-align: middle" />
          至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                  src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                  style="cursor: pointer; vertical-align: middle" />
          <asp:DropDownList ID="ddlStatus" runat="server">
            <asp:ListItem Value="-1" Text="全部"></asp:ListItem>
            <asp:ListItem Value="0" Text="申请中"></asp:ListItem>
            <asp:ListItem Value="1" Text="确认到帐"></asp:ListItem>
            <asp:ListItem Value="2" Text="没到帐不在处理"></asp:ListItem>
            <asp:ListItem Value="3" Text="已发放金币"></asp:ListItem>
          </asp:DropDownList>
          <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
          <asp:Button ID="btnQueryTD" runat="server" Text="今天" CssClass="btn wd1" OnClick="btnQueryTD_Click" />
          <asp:Button ID="btnQueryYD" runat="server" Text="昨天" CssClass="btn wd1" OnClick="btnQueryYD_Click" />
          <asp:Button ID="btnQueryTW" runat="server" Text="本周" CssClass="btn wd1" OnClick="btnQueryTW_Click" />
          <asp:Button ID="btnQueryYW" runat="server" Text="上周" CssClass="btn wd1" OnClick="btnQueryYW_Click" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg Tmg7">
      <tr>
        <td class="listTdLeft" style="width: 80px">普通查询：
        </td>
        <td>
          <asp:TextBox ID="txtSearch" runat="server" CssClass="text" ToolTip="支持申请人查询和订单查询"></asp:TextBox>
          <asp:Button ID="btnQueryUser" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQueryUser_Click" />

          <asp:Button ID="Button1" runat="server" Text="刷新" CssClass="btn wd1" OnClick="btnQueryUser_Click" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
      <tr>
        <td height="39" class="titleOpBg">
          <asp:Button ID="btnDelete" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()" />
        </td>
      </tr>
    </table>
    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
        <tr align="center" class="bold">
          <td class="listTitle">
            <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" />
          </td>

          <td class="listTitle2">管理
          </td>
          <td class="listTitle2">申请时间
          </td>
          <td class="listTitle2">申请人
          </td>
          <td class="listTitle2">填写姓名
          </td>
          <td class="listTitle2">申请单号
          </td>
          <td class="listTitle2">发放金额
          </td>
          <td class="listTitle2">申请金额
          </td>
          <td class="listTitle2">银行/姓名
          </td>
          <td class="listTitle2">申请状态
          </td>
          <td class="listTitle2">处理日期
          </td>
          <td class="listTitle1">处理备注
          </td>
        </tr>
        <asp:Repeater ID="rptUserExchange" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <%# (int)Eval("ApplyStatus") == 0 ? "<input name='cid' type='checkbox' value='" + Eval("RecordID") + "'/>" : (int)Eval("ApplyStatus") == 2 ? "<input name='cid' type='checkbox' value='" + Eval("RecordID") + "'/>" : "&nbsp;"%>
              </td>
              <td style="width: 100px;">
                <a class="l" href="CardPayProcess.aspx?param=<%#Eval("RecordID")+"&user="+Eval("Accounts") %>">审核</a>
              </td>
              <td>
                <%# Eval("CollectDate")%>
              </td>
              <td>
                <%#GetIsPaidStyle( int.Parse( Eval( "UserID" ).ToString( ) ) )%><a class="l" href="javascript:void(0);" onclick="openWindowOwn('../AccountManager/AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);"><%#Eval("Accounts") %></a>
              </td>
              <td>
                <%# Eval("cardbindname")%>
              </td>
              <td>
                <%# Eval("OrderID")%>
              </td>
              <td>
                <%# Eval("sendmoney")%>
              </td>
              <td>
                <%# Eval("ApplyMoney")%>
              </td>
              <td>
                <%#  Eval("typename").ToString()+"/"+Eval("name").ToString() %>
              </td>


              <td>
                <%#Eval("ApplyStatus").ToString() == "1" ? "确认到帐" : Eval("ApplyStatus").ToString() == "2" ? "没到帐不在处理" : Eval("ApplyStatus").ToString() == "3" ? "已发放金币" : "<span class='hong'>申请中</span>"%>
              </td>
              <td>
                <%# Eval("DealDate")%>
              </td>
              <td>
                <%# Eval("DealNote").ToString().Length>26?Eval("DealNote").ToString().Substring(0,26)+"...":Eval("DealNote").ToString()%>
              </td>
            </tr>
          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <%# (int)Eval("ApplyStatus") == 0 ? "<input name='cid' type='checkbox' value='" + Eval("RecordID") + "'/>" : (int)Eval("ApplyStatus") == 2 ? "<input name='cid' type='checkbox' value='" + Eval("RecordID") + "'/>" : "&nbsp;"%>
              </td>
              <td style="width: 100px;">
                <a class="l" href="CardPayProcess.aspx?param=<%#Eval("RecordID")+"&user="+Eval("Accounts") %>">审核</a>
              </td>
              <td>
                <%# Eval("CollectDate")%>
              </td>
              <td>
                <%#GetIsPaidStyle( int.Parse( Eval( "UserID" ).ToString( ) ) )%><a class="l" href="javascript:void(0);" onclick="openWindowOwn('../AccountManager/AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);"><%#Eval("Accounts") %></a>
              </td>
              <td>
                <%# Eval("cardbindname")%>
              </td>
              <td>
                <%# Eval("OrderID")%>
              </td>
              <td>
                <%# Eval("sendmoney")%>
              </td>
              <td>
                <%# Eval("ApplyMoney")%>
              </td>
              <td>
                <%#  Eval("typename").ToString()+"/"+Eval("name").ToString() %>
              </td>


              <td>
                <%#Eval("ApplyStatus").ToString() == "1" ? "确认到帐" : Eval("ApplyStatus").ToString() == "2" ? "没到帐不在处理" : Eval("ApplyStatus").ToString() == "3" ? "已发放金币" : "<span class='hong'>申请中</span>"%>
              </td>
              <td>
                <%# Eval("DealDate")%>
              </td>
              <td>
                <%# Eval("DealNote").ToString().Length>26?Eval("DealNote").ToString().Substring(0,26)+"...":Eval("DealNote").ToString()%>
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
          <gsp:AspNetPager ID="anpPage" runat="server" OnPageChanged="anpNews_PageChanged" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
            PageSize="20" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
            NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
      <tr>
        <td height="39" class="titleOpBg">
          <asp:Button ID="btnDelete2" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()" />
        </td>
      </tr>
    </table>
    <input type="hidden" id="latest" runat="server" value="" />
  </form>
  <script type="text/javascript" src="../../scripts/jquery-1.4.2.min.js"></script>
  <script type="text/javascript">
    var str;
    $(function() {
      //str = $("#list").find("tr").eq(1).find("td").eq(1).find("a").eq(0).attr("href");
      //str = str.substring(str.indexOf("?param=") + 7, str.indexOf('&'));
      str=$("#latest").val();
      getres(str);
    });

    function getres() {
      if(str=="") return;
      $.ajax({
        url: '/Tools/Operating.ashx?action=reflashUserExchange_card&id='+str,
        type: 'get',
        dataType: 'json',
        success: function(data) {
          //alert(data.msg);
          if(data.msg*1!=0) {
            alert("您有[ "+data.msg+" ]笔新的订单");
            location.href=location.href;
          }

        },
        complete: function() {

        }
      });
    }

    var intv=setInterval("getres();",3000);
  </script>
</body>
</html>


