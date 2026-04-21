<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecordPay.aspx.cs" Inherits="Game.Web.UserService.RecordPay" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="flb" TagName="userTop" Src="~/Themes/Standard/UserCenter.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
    <script type="text/javascript" src="../Script/My97DatePicker/WdatePicker.js"></script>
    <script>
        navNum = 4;
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
        符合条件的充值记录充值总额为<label class="important" runat="server" id="lTotalScore"></label>元
            <br />
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7"
                id="list">
                <tr align="center" class="bold shit f15">
                    <td class="listTitle2">
                        充值日期
                    </td>
                    <td class="listTitle2">
                        订单号
                    </td>
                    <td class="listTitle2">
                        订单金额
                    </td>
                    <td class="listTitle2">
                        实付金额
                    </td>
                    <td class="listTitle2">
                        获赠幸运币数
                    </td>
                </tr>
                <asp:Repeater ID="rptPayList" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#888888';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                    <%#Eval( "ApplyDate" ).ToString( )%>
                                </td>
                                <td>
                                    <%#Eval( "OrderID" ).ToString( )%>
                                </td>
                                <td>
                                    <%#Eval( "OrderAmount" ).ToString( )%>
                                </td>
                                <td>
                                    <%#Eval( "PayAmount" ).ToString( )%>
                                </td>
                                <td>
                                    <%#Eval("PresentMedal").ToString()%>
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
                        <webdiyer:AspNetPager ID="anpPage" runat="server" OnPageChanged="anpPage_PageChanged"
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

