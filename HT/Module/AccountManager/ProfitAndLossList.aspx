<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProfitAndLossList.aspx.cs" Inherits="MTEwin.Module.AccountManager.ProfitAndLossList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="../../scripts/common.js"></script>
  <script type="text/javascript" src="../../scripts/jquery.js"></script>
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
        <td width="1232" height="25" valign="top" align="left">你当前位置：用户系统 - 盈亏查询
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td class="listTdLeft" style="width: 80px">直属站点：
        </td>
        <td>
          <asp:DropDownList ID="ddlStation" runat="server">
          </asp:DropDownList>
          &nbsp;&nbsp; 普通查询：
                <asp:TextBox ID="txtSearch" runat="server" CssClass="text" ToolTip="输入用户名"></asp:TextBox>
          <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
          <asp:CheckBox ID="ckbTrueName" runat="server" Text="真实姓名" />
          <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker(dateFmt:'yyyy-MM-dd')"></asp:TextBox><img
            src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd'})"
            style="cursor: pointer; vertical-align: middle" />
          <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" OnClientClick="return verification();" />
          <asp:Button ID="btnQueryTD" runat="server" Text="今天" CssClass="btn wd1" OnClick="btnQueryTD_Click" />
          <asp:Button ID="btnQueryTW" runat="server" Text="本周" CssClass="btn wd1" OnClick="btnQueryTW_Click" />
        </td>
      </tr>
    </table>
    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7" id="list">
        <tr align="center" class="bold">
          <td class="listTitle">姓名 
          </td>
          <td class="listTitle2">用户名
          </td>
          <td class="listTitle2">当日充值
          </td>
          <td class="listTitle2">充值笔数
          </td>
          <td class="listTitle2">当日已提现
          </td>
          <td class="listTitle2">提现笔数
          </td>
          <td class="listTitle2">当日盈亏
          </td>
          <td class="listTitle2">当日盈亏比
          </td>
          <td class="listTitle2">账户总充值
          </td>
          <td class="listTitle1">账户总已提现
          </td>
          <td class="listTitle1">账户总盈亏
          </td>
          <td class="listTitle1">总盈亏比
          </td>
          <td class="listTitle1">账户余额
          </td>
          <td class="listTitle1">最后登录
          </td>
        </tr>
        <asp:Repeater ID="rptDataList" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <%#GetAccountDetailByUserID(Convert.ToInt32(Eval("UserID")))%>
              </td>
              <td>
                <!--<%# Eval("Accounts")%>-->
                <a href="javascript:void(0)" onclick="openWindowOwn('AccountsInfo.aspx?param=<%#Eval("UserID")%>','<%#Eval("UserID")%>',950,600)"><%#Game.Utils.TextUtility.CutString(Eval( "Accounts" ).ToString(),0,10)%></a>
              </td>
              <td>
                <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('/Module/FilledManager/ShareInfoList.aspx?accounts=<%# Eval("Accounts")%>&stime=<%=StartDate %>','ShareInfo<%# Eval("UserID")%>',1024,800);"><%# Eval("PayAmount")%></a>
              </td>
              <td>
                <%# Eval("PayAmountCount")%>笔
              </td>
              <td>
                <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('/Module/FilledManager/UserExchangeList.aspx?accounts=<%# Eval("Accounts")%>&stime=<%=StartDate %>','UserExchange<%# Eval("UserID")%>',1024,800);"><%# Eval("ExchangeScore")%></a>
              </td>
              <td>
                <%# Eval("ExchangeScoreCount")%>笔
              </td>
              <td>
                <%# Eval("ProfitAndLoss")%>
              </td>
              <td>
                <%# (decimal.Parse(Eval("ProfitAndLossRatio").ToString())*100).ToString("0")%>%
              </td>
              <td>
                <%# Eval("SUMPayAmount")%>
              </td>
              <td>
                <%# Eval("SUMExchangeScore")%>
              </td>
              <td>
                <%# Eval("SUMProfitAndLoss")%>
              </td>
              <td>
                <%# (decimal.Parse(Eval("SUMProfitAndLossRatio").ToString())*100).ToString("0")%>%
              </td>
              <td>
                <%# Eval("Balance")%>
              </td>
              <td>
                <%# Eval("LastLogonDate")%>
              </td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
        <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
      </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td align="right" class="page">
          <gsp:AspNetPager ID="anpPage" runat="server" OnPageChanged="anpPage_PageChanged" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
            PageSize="20" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
            NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
  </form>
</body>
</html>
<script type="text/javascript">
  $(function () { $("#content tr:even").attr("class", "listBg"); })
  function verification() {
    var bool = true;
    if ($("#txtSearch").val().length < 1) {
      alert("请输入用户名！");
      $("#txtSearch").focus();
      bool = false;
    }
    return bool;
  }
</script>
