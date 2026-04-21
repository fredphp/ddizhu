<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MatchConfigList.aspx.cs" Inherits="Game.Web.Module.MatchManager.MatchConfigList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title></title>
  <link href="/styles/layout.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="/scripts/common.js"></script>
  <script type="text/javascript" src="/scripts/comm.js"></script>
  <script type="text/javascript" src="/scripts/jquery.js"></script>
  <script type="text/javascript" src="/scripts/My97DatePicker/WdatePicker.js"></script>
  <script type="text/javascript">

    // 删除比赛
    function DeleteMatch(id,type) {
      $.ajax({
        url: '/Tools/Operating.ashx?action=DeleteMatch',
        type: 'post',
        data: { matchId: id,matchType: type },
        dataType: 'json',
        success: function(result) {
          if(result.data.valid) {
            alert(result.msg);
            location.href="MatchConfigList.aspx";
          } else {
            alert(result.msg);
          }
        },
        complete: function() {

        }
      });
    }

    // 删除比赛轮次
    function DeleteMatchNo(id,num) {
      $.ajax({
        url: '/Tools/Operating.ashx?action=DeleteMatchNo',
        type: 'post',
        data: { matchId: id,matchNo: num },
        dataType: 'json',
        success: function(result) {
          if(result.data.valid) {
            alert(result.msg);
            location.href="MatchConfigList.aspx";
          } else {
            alert(result.msg);
          }
        },
        complete: function() {

        }
      });
    }
  </script>
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
        <td width="1232" height="25" valign="top" align="left">你当前位置：比赛系统 - 比赛配置
        </td>
      </tr>
    </table>

    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="39" class="titleOpBg">&nbsp;&nbsp;<input type="button" value="添加比赛" onclick="Redirect('MatchConfigInfo.aspx')" class="btn wd1" />
        </td>
      </tr>
    </table>
    <div id="content">
      <div style="height: 20px; width: 97%; margin-top: 10px;">
        <div style="margin-left: 10px; font-size: 14px; font-weight: bold; float: left;">【定时赛】</div>
      </div>
      <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list" style="margin-top: 0px;">
        <tbody class="ui-table-border">
          <tr align="center" class="list2">
            <td><strong>管理</strong></td>
            <td><strong>比赛标识</strong></td>
            <td><strong>比赛场次</strong></td>
            <td><strong>比赛名称</strong></td>
            <td><strong>报名费用</strong></td>
            <td><strong>参赛要求</strong></td>
            <td><strong>添加时间</strong></td>
          </tr>
          <asp:Repeater ID="rptTimingData" runat="server">
            <ItemTemplate>
              <tr align="center" class="list2">
                <td rowspan="<%# Eval("MatchNoCount")%>"><a href="#" class="l" onclick="DeleteMatch(<%# Eval("MatchID") %>,0)">删除比赛</a> | <a href="MatchConfigInfo.aspx?matchid=<%# Eval("MatchID") %>&num=<%# Convert.ToInt32( Eval("MatchNoCount") )+1%>&action=addno" class="l">添加场次</a></td>
                <td rowspan="<%# Eval("MatchNoCount")%>"><%# Eval("MatchID")%></td>
                <asp:Repeater ID="rptMatchNo" runat="server">
                  <ItemTemplate>
                    <%# Convert.ToInt32(Eval("MatchNo")) > 1 ? "<tr align=\"center\" class=\"list2\">" : ""%>
                    <td>第 <%# Eval("MatchNo") %> 场 <a href="MatchConfigInfo.aspx?param=<%# Eval("MatchID")%>&num=<%# Eval("MatchNo")%>&matchtype=0" class="l">编辑</a> <%# (Container.ItemIndex + 1) == matchNoCount ? "| <a href=\"#\" class=\"l\" onclick=\"DeleteMatchNo(" + Eval("MatchID") + "," + Eval("MatchNo") + ")\">删除场次</a>" : ""%></td>
                    <td><%# Eval("MatchName")%></td>
                    <td><%# Eval("MatchFee").ToString()%> <%# Enum.GetName(typeof(Game.Facade.Aide.EnumerationList.MatchFeeType), Eval("MatchFeeType"))%></td>
                    <td><%# GetMemberName(Convert.ToInt16(Eval("MemberOrder")))%></td>
                    <td><%# Eval("CollectDate","{0:yyyy-MM-dd}") %></td>
                    </tr>
                  </ItemTemplate>
                </asp:Repeater>
            </ItemTemplate>
          </asp:Repeater>
        </tbody>
      </table>
      <div style="height: 20px; width: 97%; margin-top: 20px;">
        <div style="margin-left: 10px; font-size: 14px; font-weight: bold; float: left;">【即时赛】</div>
      </div>
      <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="Table1" style="margin-top: 0px;">
        <tbody class="ui-table-border">
          <tr align="center" class="list">
            <td><strong>管理</strong></td>
            <td><strong>比赛标识</strong></td>
            <td><strong>比赛名称</strong></td>
            <td><strong>报名费用</strong></td>
            <td><strong>参赛要求</strong></td>
            <td><strong>添加时间</strong></td>
          </tr>
          <asp:Repeater ID="rptRealTimeMatch" runat="server">
            <ItemTemplate>
              <tr align="center" class="list2">
                <td><a href="#" class="l" onclick="DeleteMatch(<%# Eval("MatchID") %>,1)">删除比赛</a> | <a href="MatchConfigInfo.aspx?param=<%# Eval("MatchID")%>&num=<%# Eval("MatchNo")%>&matchtype=1" class="l">编辑</a></td>
                <td><%# Eval("MatchID")%></td>
                <td><%# Eval("MatchName")%></td>
                <td><%# Eval("MatchFee").ToString()%> <%# Enum.GetName(typeof(Game.Facade.Aide.EnumerationList.MatchFeeType),Eval("MatchFeeType"))%></td>
                <td><%# GetMemberName(Convert.ToInt16(Eval("MemberOrder")))%></td>
                <td><%# Eval("CollectDate","{0:yyyy-MM-dd}")%></td>
              </tr>
            </ItemTemplate>
          </asp:Repeater>
        </tbody>
      </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
      <tr>
        <td height="39" class="titleOpBg">&nbsp;&nbsp;<input type="button" value="添加比赛" onclick="Redirect('MatchConfigInfo.aspx')" class="btn wd1" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>
