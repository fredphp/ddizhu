<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RouletteRecordNow.aspx.cs"
    Inherits="Game.Web.Roulette.RouletteRecordNow" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Register TagPrefix="flb" TagName="acTop" Src="~/Themes/Standard/Activity.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
    <script>
        navNum = 3;
    </script>
</head>
<body>
    <flb:acTop ID="activeTop" runat="server"></flb:acTop>
    <form id="form1" runat="server">
    <div class="platActivityBox">
        <div class="rouRecordBox">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7"
                id="list">
                <tr align="center" class="bold shit f15">
                    <td class="listTitle2">
                        抽奖日期
                    </td>
                    <td class="listTitle">
                        用户
                    </td>
                    <td class="listTitle2">
                        支付前奖牌
                    </td>
                    <td class="listTitle2">
                        支付奖牌
                    </td>
                    <td class="listTitle2">
                        抽奖状态
                    </td>
                    <td class="listTitle2">
                        抽奖前金币
                    </td>
                    <td class="listTitle2">
                        抽奖前存款
                    </td>
                    <td class="listTitle2">
                        赢取金币
                    </td>
                </tr>
                <asp:Repeater ID="rptLotteryRecord" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#888888';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                <%# Eval("CollectDate")%>
                            </td>
                            <td>
                                <%# GetAccounts((int)Eval("UserID"))%>
                            </td>
                            <td>
                                <%# Eval("BeforeUserMedal")%>
                            </td>
                            <td>
                                <%# Eval("PayUserMedal")%>
                            </td>
                            <td>
                                <%# (int)Eval("IsWin") == 0 ? "<span class='hong'>失败</span>" : "<span class='lan'>成功</span>"%>
                            </td>
                            <td>
                                <%# Eval("BeforeScore")%>
                            </td>
                            <td>
                                <%# Eval("BeforeInsureScore")%>
                            </td>
                            <td>
                                <%# Eval("WinScore")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center' class='important f15 bold'><br>没有符合查询条件的数据！<br><br></td></tr>"></asp:Literal>
            </table>
        </div>
    </div>
    </form>
</body>
</html>
