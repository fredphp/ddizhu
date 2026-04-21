<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MatchInfo.aspx.cs" Inherits="Game.Web.UserService.MatchInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Register TagPrefix="flb" TagName="acTop" Src="~/Themes/Standard/Activity.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
    <script type="text/javascript" src="../Script/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="../Script/matchInfo.js"></script>
    <script>
        navNum = 0;
    </script>
</head>
<body>
    <flb:acTop ID="activeTop" runat="server"></flb:acTop>
    <form id="form1" runat="server">
    <div class="platActivityBox">
        <fieldset id="matchList">
            <legend class="white f15 bold">比赛战报</legend><span>比赛规则：</span> <span class="paddLeft40 clear marb10">
                1:参加比赛不用报名，在开赛的时间内进入指定房间直接比赛；<br />
                2:比赛排名是按照玩家在房间里的金币输赢浮动进行排名；<br />
                3:比赛结束获奖玩家奖励会在2个小时内发放；<br />
                4:点击"奖励名单"可以查看比赛的排名情况；</span>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7"
                id="list">
                <tr align="center" class="bold shit f15">
                    <td class="listTitle2">
                        比赛名称
                    </td>
                    <td class="listTitle2">
                        房间名称
                    </td>
                    <td class="listTitle2">
                        开赛时间
                    </td>
                    <td class="listTitle2">
                        结束时间
                    </td>
                    <td class="listTitle2">
                        比赛状态
                    </td>
                    <td class="listTitle2 w200">
                        排名与奖励
                    </td>
                </tr>
                <asp:Repeater ID="rptMatch" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list">
                            <td class="data" data-id='<%# Eval("MatchID") %>' data-ontimeid='<%# Eval("MatchOnTimeID") %>'
                                data-name='<%# Eval("MatchName") %>'>
                                <%# Eval("MatchName") %>
                            </td>
                            <td>
                                <%# GetGameRoomName(int.Parse(Eval("ServerID").ToString()))%>
                            </td>
                            <td>
                                <%# Eval("MatchBeginTime") %>
                            </td>
                            <td>
                                <%# Eval("MatchEndTime") %>
                            </td>
                            <td>
                                <%# GetMatchStatus(int.Parse(Eval("Status").ToString()))%>
                            </td>
                            <td class="ui-table-action">
                                <label class="activity-rule">
                                    奖励规则</label>
                                |
                                <label class="activity-rank">
                                    奖励列表
                                </label>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center' class='important f15 bold'><br>没有符合查询条件的数据！<br><br></td></tr>"></asp:Literal>
            </table>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                    </td>
                    <td align="center" class="page">
                        <webdiyer:AspNetPager ID="anpNews" runat="server" OnPageChanged="anpNews_PageChanged"
                            FirstPageText="首页" LastPageText="末页" PageSize="20" NextPageText="下页" PrevPageText="上页"
                            NumericButtonCount="3">
                        </webdiyer:AspNetPager>
                    </td>
                </tr>
            </table>
        </fieldset>
        <fieldset id="matchPlacingList" style="display: none;">
            <legend class="white f15 bold">比赛排名<span id="closeplacing">隐藏</span></legend>
            <span class="clear">温馨提示：
            </span><span class="paddLeft40 marb10" style="display:block;">
            1.此处会列出当前选中的比赛的奖励情况。 <br />
            2.虚拟奖励（金币，元宝，经验）会在生成奖励名单时自动发放，其他奖励则有管理员手动发放。</span>
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7"
                id="Table1">
                
                
            </table>
        </fieldset>
    </div>
    <div id="divScreen">
    </div>
    <div id="box-modal">
        <div id="matchrewardbox">
            <div id="matchrewardtop">
                <span id="matchname"></span><span class="close">x</span>
            </div>
            <div id="guizelist">
                <ul style="margin: 0; padding: 0">
                </ul>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
