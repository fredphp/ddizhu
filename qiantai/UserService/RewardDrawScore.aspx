<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RewardDrawScore.aspx.cs"
    Inherits="Game.Web.UserService.RewardDrawScore" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="flb" TagName="userTop" Src="~/Themes/Standard/UserCenter.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
    <script type="text/javascript" src="../Script/My97DatePicker/WdatePicker.js"></script>
    <script>
        navNum = 2;
    </script>
</head>
<body>
    <flb:userTop ID="UserTop1" runat="server"></flb:userTop>
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
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7"
                id="list">
                <tr align="center" class="bold shit f15">
                    <td class="listTitle2">
                        游戏开始时间
                    </td>
                    <td class="listTitle2">
                        游戏结束时间
                    </td>
                    <td class="listTitle2">
                        游戏类型
                    </td>
                    <td class="listTitle2">
                        输赢金币
                    </td>
                    <td class="listTitle2">
                        幸运币
                    </td>
                </tr>
                <asp:Repeater ID="rptDrawList" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#888888';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                <%# Eval("StartTime")%>
                            </td>
                            <td>
                                <%# Eval("EndTime")%>
                            </td>
                            <td>
                                <%# GetGameKindName(int.Parse(Eval("KindID").ToString()))%>
                            </td>
                            <td>
                                <%# Eval("Grade")%>
                            </td>
                            <td>
                                <%# Eval("UserMedal")%>
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
