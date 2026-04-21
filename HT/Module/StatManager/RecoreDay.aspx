<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecoreDay.aspx.cs" Inherits="MTEwin.Module.StatManager.RecoreDay" %>

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
        <td width="1232" height="25" valign="top" align="left">你当前位置：用户系统 -每天数据分析
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
          <asp:Button ID="btnQueryTD" runat="server" Text="今天" CssClass="btn wd1" OnClick="btnQueryTD_Click" />
          <asp:Button ID="btnQueryYD" runat="server" Text="昨天" CssClass="btn wd1" OnClick="btnQueryYD_Click" />
          <asp:Button ID="btnQueryTW" runat="server" Text="本周" CssClass="btn wd1" OnClick="btnQueryTW_Click" />
          <asp:Button ID="btnQueryYW" runat="server" Text="上周" CssClass="btn wd1" OnClick="btnQueryYW_Click" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
      <tr>
        <td class="titleOpBg Lpd10" id="showtotal"></td>
      </tr>
    </table>
    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
        <tr align="center" class="bold">
          <td class="listTitle2">现金总额 
          </td>
          <td class="listTitle2">保险柜总额
          </td>
          <td class="listTitle2">总额共计
          </td>
          <td class="listTitle2">日注册人数  
          </td>

          <td class="listTitle">在线人数
          </td>
          <td class="listTitle">玩家总人数
          </td>
          <td class="listTitle">玩家转到银行卡金额
          </td>
          <td class="listTitle">机器人
          </td>
          <td class="listTitle">机器人已分配 
          </td>
          <td class="listTitle">注册赠送
          </td>
          <td class="listTitle">充值赠送
          </td>
          <td class="listTitle">手工赠送
          </td>
          <td class="listTitle">系统赠送
          </td>
          <td class="listTitle">抽奖奖金
          </td>
          <td class="listTitle">现有幸运币
          </td>
          <td class="listTitle">充值赠送幸运币
          </td>
          <td class="listTitle">游戏赠送幸运币
          </td>
          <td class="listTitle">抽奖消耗幸运币
          </td>
          <td class="listTitle">玩家总抽水
          </td>
          <td class="listTitle">玩家已转抽水
          </td>
          <td class="listTitle">游戏税收总额
          </td>
          <td class="listTitle">转账税收总额
          </td>
          <td class="listTitle">兑换总额
          </td>
          <td class="listTitle">兑换税收总额
          </td>
          <td class="listTitle">记录时间
          </td>



        </tr>
        <asp:Repeater ID="rptDataList" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td class="listTitle2">
                <%# Eval("ScoreTotal")%>
              </td>
              <td class="listTitle2">
                <%# Eval("InsureScoreTotal")%>
              </td>
              <td class="listTitle2">
                <%# Eval("TotalMoney")%>
              </td>
              <td class="listTitle2">
                <%# Eval("NewUserCount")%>  
              </td>

              <td class="listTitle">
                <%# Eval("OnlineCount")%>
              </td>
              <td class="listTitle">
                <%# Eval("UserTotal")%>
              </td>
              <td class="listTitle" name="t1">
                <%# Eval("cardtocard")%>
              </td>
              <td class="listTitle">
                <%# Eval("AndroidTotal")%>
              </td>
              <td class="listTitle">
                <%# Eval("AndroidCount")%> 
              </td>
              <td class="listTitle" name="t2">
                <%# Eval("RegGrantMoneyTotal")%>
              </td>
              <td class="listTitle" name="t3">
                <%# Eval("PresentScore")%>
              </td>
              <td class="listTitle" name="t4">
                <%# Eval("AdminGrantMoneyTotal")%>
              </td>
              <td class="listTitle" name="t5">
                <%# Eval("WinScore")%>
              </td>
              <td class="listTitle" name="t6">
                <%# Eval("LargessScore")%>
              </td>
              <td class="listTitle">
                <%# Eval("UserMedal")%>
              </td>
              <td class="listTitle">
                <%# Eval("PayPresentMedal")%>
              </td>
              <td class="listTitle">
                <%# Eval("GamePresentMedal")%>
              </td>
              <td class="listTitle">
                <%# Eval("PayUserMedal")%>
              </td>
              <td class="listTitle" name="t7">
                <%# Eval("UserRevenue")%>
              </td>
              <td class="listTitle" name="t8">
                <%# Eval("ExchangeRevenue")%>
              </td>

              <td class="listTitle" name="t9">
                <%# Eval("GameRevenue")%>
              </td>
              <td class="listTitle">
                <%# Eval("InsureRevenue")%>
              </td>
              <td class="listTitle" name="t10">
                <%# Eval("TradeMoney")%>
              </td>
              <td class="listTitle">
                <%# Eval("TradeRevenue")%>
              </td>
              <td class="listTitle">
                <%# Eval("Recordtime")%>
              </td>


            </tr>

          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td class="listTitle2">
                <%# Eval("ScoreTotal")%>
              </td>
              <td class="listTitle2">
                <%# Eval("InsureScoreTotal")%>
              </td>
              <td class="listTitle2">
                <%# Eval("TotalMoney")%>
              </td>
              <td class="listTitle2">
                <%# Eval("NewUserCount")%>  
              </td>

              <td class="listTitle">
                <%# Eval("OnlineCount")%>
              </td>
              <td class="listTitle">
                <%# Eval("UserTotal")%>
              </td>
              <td class="listTitle" name="t1">
                <%# Eval("cardtocard")%>
              </td>
              <td class="listTitle">
                <%# Eval("AndroidTotal")%>
              </td>
              <td class="listTitle">
                <%# Eval("AndroidCount")%> 
              </td>
              <td class="listTitle" name="t2">
                <%# Eval("RegGrantMoneyTotal")%>
              </td>
              <td class="listTitle" name="t3">
                <%# Eval("PresentScore")%>
              </td>
              <td class="listTitle" name="t4">
                <%# Eval("AdminGrantMoneyTotal")%>
              </td>
              <td class="listTitle" name="t5">
                <%# Eval("WinScore")%>
              </td>
              <td class="listTitle" name="t6">
                <%# Eval("LargessScore")%>
              </td>
              <td class="listTitle">
                <%# Eval("UserMedal")%>
              </td>
              <td class="listTitle">
                <%# Eval("PayPresentMedal")%>
              </td>
              <td class="listTitle">
                <%# Eval("GamePresentMedal")%>
              </td>
              <td class="listTitle">
                <%# Eval("PayUserMedal")%>
              </td>
              <td class="listTitle" name="t7">
                <%# Eval("UserRevenue")%>
              </td>
              <td class="listTitle" name="t8">
                <%# Eval("ExchangeRevenue")%>
              </td>

              <td class="listTitle" name="t9">
                <%# Eval("GameRevenue")%>
              </td>
              <td class="listTitle">
                <%# Eval("InsureRevenue")%>
              </td>
              <td class="listTitle" name="t10">
                <%# Eval("TradeMoney")%>
              </td>
              <td class="listTitle">
                <%# Eval("TradeRevenue")%>
              </td>
              <td class="listTitle">
                <%# Eval("Recordtime")%>
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
          <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="20" NextPageText="下页"
            PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table" NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
            UrlPaging="false">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

<script type="text/javascript">
  function showInfo(obj) {
    var ID="record"+obj.id;
    if(document.getElementById(ID).style.display=="none") {
      document.getElementById(ID).style.display="";
      obj.src="../../Images/up.gif"
    }
    else {
      document.getElementById(ID).style.display="none";
      obj.src="../../Images/down.gif"
    }
  }
  function setTotalinfo() {
    var t1=getsum("t1");
    var t2=getsum("t2");
    var t3=getsum("t3");
    var t4=getsum("t4");
    var t5=getsum("t5");
    var t6=getsum("t6");
    var t7=getsum("t7");
    var t8=getsum("t8");
    var t9=getsum("t9");
    var t10=getsum("t10");


    var htmls="    玩家转到银行卡共计："+t1+"注册赠送共计:"+t2+"手工赠送共计:"+t3+"充值赠送共计:"+t4+"系统赠送共计:"+t5+"奖奖金共计:"+t6+"玩家抽水共计:"+t7+"玩家已转抽水共计:"+t8+"游戏税收共计:"+t9+"兑换总额共计:"+t10+"  ";
    document.getElementById("showtotal").innerHTML=htmls;

  }
  function getsum(names) {
    var list=document.getElementsByName(names);
    var res=0.00;
    for(var i=0;i<list.length;i++)
    { res=res+parseFloat(list[i].innerHTML); }
    res=Math.round(res*100)/100;
    return res+"<input class=\"btnLine\" type=\"button\">";
  }

  setTotalinfo();
</script>


