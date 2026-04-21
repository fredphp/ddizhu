<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BalanceRecord.aspx.cs" Inherits="AgencyManage.Manage.Money.BalanceRecord" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>结算记录</title>
    <link href="../../Css/default.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/base.js" type="text/javascript"></script>
    <script src="../../Lib/WebCalender.js" type="text/javascript"></script>
    <script src="../../PlugIn/artdialog/artDialog.min.js" type="text/javascript"></script>
    <script src="../Js/BalanceRecord.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="main">
        <div class="currentPath">当前位置：代理后台>>统计与结算>>转账记录</div>
        <div class="tool">
            <label>转账状态：</label>
            <asp:DropDownList runat="server" ID="bringStatus">
                <asp:ListItem Value="-1" Text="全部" Selected="True"></asp:ListItem>
                <asp:ListItem Value="0" Text="申请中"></asp:ListItem>
                <asp:ListItem Value="1" Text="转账成功"></asp:ListItem>
                <asp:ListItem Value="2" Text="拒绝转账"></asp:ListItem>
            </asp:DropDownList>
            <label>转账日期：</label><input type="text" id="txtStartDate" class="date" runat="server" />——<input type="text" id="txtEndDate" class="date" runat="server" />
            <asp:Button ID="btnQuery" runat="server" Text="查询" onclick="btnQuery_Click" />
            <div class="tooltip">
                <dl>
                    <dt>温馨提示：</dt>
                    <dd>
                        1.为加快查询速度，建议查询的时间间隔尽量小。<br />
                        2.可以按指定时间段，指定状态查询符合条件的转账记录。<br />
                    </dd>
                </dl>
            </div>
        </div>
        <div class="result">
            <div class="list">
                <asp:GridView ID="gvRecord" runat="server" AutoGenerateColumns="False" 
                    CellPadding="4" EnableModelValidation="True" Width="100%" >
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="PageView_RowNo" HeaderText="序号" />
                        <asp:TemplateField HeaderText="到账玩家">
                            <ItemTemplate>
                                <%# GetAccounts(int.Parse(Eval("UserID").ToString()))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="CurGold" HeaderText="结算前金币" DataFormatString="{0:N}金币" />
                        <asp:BoundField DataField="DrawGold" HeaderText="结算金币" DataFormatString="{0:N}金币" />
                        <asp:BoundField DataField="EndGold" HeaderText="结算后金币" DataFormatString="{0:N}金币" />
                        <asp:BoundField DataField="RevenueGold" HeaderText="手续费" DataFormatString="{0:N}金币" />
                        <asp:BoundField DataField="DrewTime" HeaderText="结算时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                        <asp:TemplateField HeaderText="状态">
                            <ItemTemplate>
                                <%# GetBringStatue(int.Parse(Eval("Result").ToString()))%>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Remark" HeaderText="理由" />
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
                 NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always" PageSize="25" OnPageChanged="pageRecord_PageChanged">
                </webdiyer:AspNetPager> 
            </div>
        </div>
    </div>
    </form>
</body>
</html>

