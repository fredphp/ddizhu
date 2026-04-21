<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StatInfo.aspx.cs" Inherits="MTEwin.Module.StatManager.StatInfo" %>

<%@ Register Src="~/Themes/TabUser.ascx" TagPrefix="Fox" TagName="Tab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title></title>
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../../scripts/common.js"></script>

  <script type="text/javascript" src="../../scripts/comm.js"></script>

  <script type="text/javascript" src="../../scripts/jquery.js"></script>

</head>
<body>
  <!-- 头部菜单 Start -->
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
    <tr>
      <td width="19" height="25" valign="top" class="Lpd10">
        <div class="arr">
        </div>
      </td>
      <td width="1232" height="25" valign="top" align="left" style="width: 1232px; height: 25px; vertical-align: top; text-align: left;">目前操作功能：汇总统计 - 货币统计
      </td>
    </tr>
  </table>
  <form runat="server" id="form1">
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
      <tr>
        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
          <div class="hg3  pd7">
            系统统计<span style="padding-left: 50px;"><input type="button" id="btnRefresh" value="刷新" onclick="location.href=location.href;" /></span>
          </div>
        </td>
      </tr>
      <tr>
        <td>
          <table>
            <tr>
              <td colspan="2" class="bold Lpd10 Rpd10" align="center">系统金币
              </td>
            </tr>
            <tr>
              <td class="listTdLeft">现金总额：
              </td>
              <td>￥<asp:Literal ID="ltScore" runat="server"></asp:Literal>
              </td>
            </tr>
            <tr>
              <td class="listTdLeft">
                <%=BankMoneyName%>总额：
              </td>
              <td>￥<asp:Literal ID="ltInsureScore" runat="server"></asp:Literal>
              </td>
            </tr>
            <tr>
              <td class="listTdLeft">总额共计：
              </td>
              <td>￥<asp:Literal ID="ltTotalMoney" runat="server"></asp:Literal>
              </td>
            </tr>
            <tr>
              <td class="listTdLeft"></td>
              <td></td>
            </tr>
          </table>
        </td>
        <td>
          <table>
            <tr>
              <td colspan="2" class="bold Lpd10 Rpd10" align="center">用户统计
              </td>
            </tr>
            <tr>
              <td class="listTdLeft">在线人数：
              </td>
              <td>
                <asp:Literal ID="ltOnlineCount" runat="server"></asp:Literal>人
              </td>
            </tr>
            <tr>
              <td class="listTdLeft">今日注册人数：
              </td>
              <td>
                <asp:Literal ID="ltNewUserCount" runat="server"></asp:Literal>人
              </td>
            </tr>
            <tr>
              <td class="listTdLeft">玩家总人数：
              </td>
              <td>
                <asp:Literal ID="ltUserCount" runat="server"></asp:Literal>人
              </td>
            </tr>
            <tr>
              <td class="listTdLeft">机器人：
              </td>
              <td>
                <asp:Literal ID="ltAndroidTotal" runat="server"></asp:Literal>人&nbsp;&nbsp; 其中已分配到房间的有<asp:Literal ID="ltAndroidCount" runat="server"></asp:Literal>人
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
          <div class="hg3  pd7">
            金币统计
          </div>
        </td>
      </tr>
      <tr>
        <td>
          <table>
          <td colspan="2" class="bold Lpd10 Rpd10" align="center">金币流入
          </td>
        <tr>
          <td class="listTdLeft">注册赠送：
          </td>
          <td>￥<asp:Literal ID="ltRegGrantMoneyTotal" runat="server"></asp:Literal>
          </td>
        </tr>
      <tr>
        <td class="listTdLeft">充值赠送：
        </td>
        <td>￥<asp:Literal ID="ltPresentScore" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">手工赠送：
        </td>
        <td>￥<asp:Literal ID="ltAdminGrantMoneyTotal" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">系统赠送：
        </td>
        <td>￥<asp:Literal ID="ltLargessScore" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">抽奖奖金：
        </td>
        <td>￥<asp:Literal ID="ltWinScore" runat="server"></asp:Literal>
        </td>
      </tr>
    </table>
    </td>
            <td>
              <table>
                <tr>
                  <td colspan="2" class="bold Lpd10 Rpd10" align="center">金币流出与消耗
                  </td>
                </tr>
                <tr>
                  <td class="listTdLeft">游戏税收总额：
                  </td>
                  <td>￥
                            <asp:Literal ID="ltGameRevenue" runat="server"></asp:Literal>
                  </td>
                </tr>
                <tr>
                  <td class="listTdLeft">转账税收总额：
                  </td>
                  <td>￥
                            <asp:Literal ID="ltInsureRevenue" runat="server"></asp:Literal>
                  </td>
                </tr>
                <tr>
                  <td class="listTdLeft">兑换总额：
                  </td>
                  <td>￥
                            <asp:Literal ID="ltTradeMoney" runat="server"></asp:Literal>
                  </td>
                </tr>
                <tr>
                  <td class="listTdLeft">兑换税收总额：
                  </td>
                  <td>￥
                            <asp:Literal ID="ltTradeRevenue" runat="server"></asp:Literal>
                  </td>
                </tr>
              </table>
            </td>
    </tr>
        <tr>
          <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
            <div class="hg3  pd7">
              抽水统计
            </div>
          </td>
        </tr>
    <tr>
      <td class="listTdLeft">玩家总抽水：
      </td>
      <td>￥
                <asp:Literal ID="ltUserRevenue" runat="server"></asp:Literal>
      </td>
    </tr>
    <tr>
      <td class="listTdLeft">玩家已转抽水：
      </td>
      <td>￥
                <asp:Literal ID="ltExchangeRevenue" runat="server"></asp:Literal>
      </td>
    </tr>
    <tr>
      <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
        <div class="hg3  pd7">
          幸运币统计
        </div>
      </td>
    </tr>
    <tr>
      <td class="listTdLeft">充值赠送幸运币：
      </td>
      <td>
        <asp:Literal ID="ltPayPresentMedal" runat="server"></asp:Literal>
      </td>
    </tr>
    <tr>
      <td class="listTdLeft">游戏赠送幸运币：
      </td>
      <td>
        <asp:Literal ID="ltGamePresentMedal" runat="server"></asp:Literal>
      </td>
    </tr>
    <tr>
      <td class="listTdLeft">现有幸运币：
      </td>
      <td>
        <asp:Literal ID="ltUserMedal" runat="server"></asp:Literal>
      </td>
    </tr>
    <tr>
      <td class="listTdLeft">抽奖消耗幸运币：
      </td>
      <td>
        <asp:Literal ID="ltPayUserMedal" runat="server"></asp:Literal>
      </td>
    </tr>
    </table>
  </form>
</body>
</html>

