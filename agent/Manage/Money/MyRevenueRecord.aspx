<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyRevenueRecord.aspx.cs"
    Inherits="AgencyManage.Manage.Money.MyRevenueRecord" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>我的抽水记录</title>
    <link href="../../Css/default.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/base.js" type="text/javascript"></script>
    <script src="../../Lib/WebCalender.js" type="text/javascript"></script>
    <script src="../Js/MyRevenueRecord.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="main">
        <div class="currentPath">
            当前位置：代理后台>>财务管理>>我的抽水记录
        </div>
        <div class="tool">
            <label>
                玩家账号：</label><input type="text" id="txtUserAccount" class="w100" runat="server" />
            <label>
                起止日期：</label><input type="text" id="txtStartDate" class="date" runat="server" />——
            <input type="text" id="txtEndDate" class="date" runat="server" />
            <asp:Button ID="btnQuery" runat="server" Text="查询" OnClick="btnQuery_Click" />
        </div>
        <div class="result">
            <div class="list">
                <asp:GridView ID="gvRecord" runat="server" AutoGenerateColumns="False" 
                    CellPadding="4" EnableModelValidation="True" Width="100%">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="PageView_RowNo" HeaderText="序号" />
                        <asp:TemplateField HeaderText="玩家账号">
                            <ItemTemplate>
                                <%# GetAccounts(int.Parse(Eval("UserID").ToString()))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="UserWin" HeaderText="玩家游戏输赢" DataFormatString="{0:N}" />
                        <asp:BoundField DataField="RoyaltyTotal" HeaderText="本局总抽水额（金币）" DataFormatString="{0:N}" />
                        <asp:BoundField DataField="RoyaltyRatio" HeaderText="我的实际抽水比例" DataFormatString="{0:G0}%" />
                        <asp:BoundField DataField="RoyaltyGold" HeaderText="我的实际抽水金币" DataFormatString="{0:N}" />
                        <asp:BoundField DataField="RoyaltyTime" HeaderText="抽水时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                        <asp:BoundField DataField="Remark" HeaderText="抽水类型" />
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                </asp:GridView>
            </div>
            <div class="page">
                <webdiyer:AspNetPager ID="pageRecord" runat="server" FirstPageText="首页" LastPageText="末页" 
                 NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always" PageSize="25"
                 OnPageChanged="pageRecord_PageChanged" >
                </webdiyer:AspNetPager>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
