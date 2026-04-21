<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RouletteRecord.aspx.cs"
    Inherits="Game.Web.Roulette.RouletteRecord" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<%@ Register TagPrefix="flb" TagName="acTop" Src="~/Themes/Standard/Activity.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
    <script type="text/javascript" src="../Script/My97DatePicker/WdatePicker.js"></script>
    <script>
        navNum = 2;
    </script>
</head>
<body>
    <flb:acTop ID="activeTop" runat="server"></flb:acTop>
    <form id="form1" runat="server">
    <div class="platActivityBox">
        <div class="platSearchbox">
            <span style="margin-left: 20px;">开始时间:</span> <span class="spanBorder">
                <asp:TextBox ID="txtStartDate" runat="server" CssClass="txtNoborder" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox>
                <span class="timeImg" onclick="WdatePicker({el:'txtStartDate',skin:'whyGreen',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})">
                </span></span><span>结束时间:</span> <span class="spanBorder">
                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="txtNoborder" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox>
                    <span class="timeImg" onclick="WdatePicker({el:'txtEndDate',skin:'whyGreen',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})">
                    </span></span><span>
                        <asp:Button ID="btnSearch" runat="server" CssClass="btnSearch" OnClick="btnSearch_Click" />
                    </span>
        </div>
        <div class="rouRecordBox">
            您的抽奖总额为<label class="important" runat="server" id="lTotalScore"></label>金币
            <br />
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7"
                id="list">
                <tr align="center" class="bold shit f15">
                    <td class="listTitle2">
                        抽奖日期
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
        </div>
    </div>
    </form>
</body>
</html>
