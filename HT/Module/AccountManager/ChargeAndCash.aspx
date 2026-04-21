<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChargeAndCash.aspx.cs"
  Inherits="MTEwin.Module.AccountManager.ChargeAndCash" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
  <title></title>
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="../../scripts/common.js"></script>
  <script type="text/javascript" src="../../scripts/comm.js"></script>
  <script type="text/javascript" src="/scripts/JQuery.js"></script>
  <style type="text/css">
    .titleOpBg { background: #AAA0E3; }
    .titleOpBg a { color: #fff; }
    .titleOpBg a:hover { color: #fff; }
    .titleOpBg a:link { color: red; }
    .titleOpBg a:visited { color: red; }
  </style>
</head>
<body>
  <table align="center" border="0" cellpadding="0" cellspacing="0" width="99%">
    <tbody>
      <tr>
        <td class="titleOpBg Lpd10" id="menusss">
          <a href="RecordInsureList.aspx?param=<%=base.IntParam %>" onclick="sett(0);" target="content" class="l">银行操作记录</a>&nbsp;&nbsp; 
                    <a href="RecordGrantTreasureList.aspx?param=<%=base.IntParam %>" onclick="sett(1);" target="content" class="l">管理员赠送</a>&nbsp;&nbsp; 
                    <a href="ShareDetailList.aspx?param=<%=base.IntParam %>" target="content" onclick="sett(2);" class="l">充值记录</a>&nbsp;&nbsp; 
                    <a href="../userinfo/UserExchangeList.aspx?param=<%=base.IntParam %>" onclick="sett(3);" target="content" class="l">提现记录</a>&nbsp;&nbsp; 
                    <a href="RecordDrawInfoList.aspx?param=<%=base.IntParam %>" onclick="sett(4);" target="content" class="l">游戏记录</a>&nbsp;&nbsp;
                    <a href="RecordUserInoutList.aspx?param=<%=base.IntParam %>" onclick="sett(5);" target="content" class="l">进出记录</a>&nbsp;&nbsp;
                  <a href="../AwardManager/LotteryRecordList.aspx?param=<%=base.IntParam %>" onclick="sett(6);" target="content" class="l">抽奖记录</a>&nbsp;&nbsp;
                    <input value="关闭" class="btn wd1" onclick="window.close();" type="button">
        </td>
      </tr>
    </tbody>
  </table>

  <iframe name="content" id="content" src="RecordInsureList.aspx?param=<%=base.IntParam %>"
    onload="Javascript:SetWinHeight(this)" scrolling="no" frameborder="0" height="2904"
    width="768"></iframe>

  <script type="text/javascript">
    var p =<%=IntParam %>
      function sett(a) {
        location.href = "ChargeAndCash.aspx?types=" + a + "&param=" + p;
      }
    function getQueryString(name) {
      var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
      var r = window.location.search.substr(1).match(reg);
      if (r != null) return unescape(r[2]); return null;
    }
    var val = getQueryString("types");
    if (val) {
      content.location.href = document.getElementById("menusss").getElementsByTagName("a")[val].href.toString();
    }
  </script>
</body>
</html>
