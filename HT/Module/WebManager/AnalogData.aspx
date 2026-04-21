<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnalogData.aspx.cs" Inherits="MTEwin.Module.WebManager.AnalogData" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="../../scripts/common.js"></script>
  <title></title>
  <script src="/scripts/jquery-1.4.2.min.js"></script>
  <style>
    .list.add { display: none; }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
      <tr>
        <td width="19" height="25" valign="top" class="Lpd10">
          <div class="arr"></div>
        </td>
        <td width="1232" height="25" valign="top" align="left">你当前位置：网站设置 - 虚拟信息</td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="28">
          <ul>
            <li class="tab2" onclick="Redirect('NewsList.aspx')">新闻管理</li>
            <li class="tab2" onclick="Redirect('RulesList.aspx')">规则管理</li>
            <li class="tab2" onclick="Redirect('IssueList.aspx')">问题管理</li>
            <li class="tab2" onclick="Redirect('FeedbackList.aspx')">反馈管理</li>
            <li class="tab2" onclick="Redirect('NoticeList.aspx')">跑马管理</li>
            <li class="tab1">虚拟信息</li>
          </ul>
        </td>
      </tr>
    </table>
    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
        <tr align="center" class="bold">
          <td class="listTitle2">管理</td>
          <td class="listTitle2">账号</td>
          <td class="listTitle2">金额</td>
        </tr>
        <tr align="center" class="bold">
          <td colspan="5">抽奖数据</td>
        </tr>

        <asp:Repeater ID="rptAnalog2" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default'" onmouseout="this.style.backgroundColor=currentcolor">
              <td><a class="l" href="AnalogData.aspx?cmd=del&param=<%#Eval("ID")%>">删除</a></td>
              <td><%# Eval("Name") %></td>
              <td><%# Eval("Value") %></td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>
        <tr align="center" class="list add">
          <td>
            <input type="submit" onclick="$('input[name=type]').val(2)" /></td>
          <td>
            <input name="name2" /></td>
          <td>
            <input name="value2" /></td>
        </tr>
        <tr class='tdbg'>
          <td colspan='5' class="titleOpBg" align='center'>
            <input type="button" value="新增" class="btn wd1" onclick="$(this).parents('tr').prev().show()" />&nbsp;|&nbsp;<input type="button" value="全部删除" class="btn wd1" onclick="Redirect('AnalogData.aspx?cmd=del&type=2')" /></td>
        </tr>
        <tr align="center" class="bold">
          <td colspan="5">充值数据</td>
        </tr>

        <asp:Repeater ID="rptAnalog4" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default'" onmouseout="this.style.backgroundColor=currentcolor">
              <td><a class="l" href="AnalogData.aspx?cmd=del&param=<%#Eval("ID")%>">删除</a></td>
              <td><%# Eval("Name") %></td>
              <td><%# Eval("Value") %></td>
            </tr>
          </ItemTemplate>
        </asp:Repeater>

        <tr align="center" class="list add">
          <td>
            <input type="submit" onclick="$('input[name=type]').val(4)" /></td>
          <td>
            <input name="name4" /></td>
          <td>
            <input name="value4" /></td>
        </tr>
        <tr class='tdbg'>
          <td colspan='5' class="titleOpBg" align='center'>
            <input type="button" value="新增" class="btn wd1" onclick="$(this).parents('tr').prev().show()" />&nbsp;|&nbsp;<input type="button" value="全部删除" class="btn wd1" onclick="    Redirect('AnalogData.aspx?cmd=del&type=4')" /></td>
        </tr>
      </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="listTitleBg"><span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a class="l1" href="javascript:SelectAll(false);">无</a></td>
      </tr>
    </table>
    <input type="hidden" name="type" />
  </form>
</body>
</html>
<script>$(function() { $("#content tr:even").addClass("listBg") })</script>
