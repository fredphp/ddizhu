<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RechargeRecord.aspx.cs" Inherits="AgencyManage.Manage.Money.RechargeRecord" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>充值记录</title>
    <link href="../../Css/default.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/base.js" type="text/javascript"></script>
    <script src="../../Lib/WebCalender.js" type="text/javascript"></script>
    <script src="../../PlugIn/artdialog/artDialog.min.js" type="text/javascript"></script>
    <script src="../Js/BalanceRecord.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="main">
        <div class="currentPath">当前位置：代理后台>>统计与结算>>充值记录</div>
        <div class="tool">
            <label>用户名：</label><asp:TextBox runat="server" ID="txtAccountName"></asp:TextBox>
            <label>充值日期：</label><input type="text" id="txtStartDate" class="date" runat="server" />——<input type="text" id="txtEndDate" class="date" runat="server" />
            <asp:Button ID="btnQuery" runat="server" Text="查询" onclick="btnQuery_Click" />
            <div class="tooltip">
                <dl>
                    <dt>温馨提示：</dt>
                    <dd>
                        1.为加快查询速度，建议查询的时间间隔尽量小，默认显示所有状态的提款记录。<br />
                        2.可以按指定时间段，指定状态查询符合条件的结算记录。<br />
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
                        <asp:BoundField DataField="RecordID" HeaderText="充值ID" />
                        <asp:BoundField DataField="RechargeAccount" HeaderText="充值账号"/>
                        <asp:BoundField DataField="AgenName" HeaderText="真实姓名"/>
                        <asp:BoundField DataField="RechargeBegin" HeaderText="充值前金币" DataFormatString="{0:N}" />
                        <asp:BoundField DataField="RechargeGold" ItemStyle-ForeColor="Red" HeaderText="充值金币" DataFormatString="{0:N}" />
                        <asp:BoundField DataField="RechargeEnd" HeaderText="充值后金币" DataFormatString="{0:N}" />
                        <asp:BoundField DataField="RoyaltyTime" HeaderText="充值时间" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                        <%--<asp:TemplateField HeaderText="状态">
                            <ItemTemplate>
                                <%# GetBringStatue(int.Parse(Eval("Result").ToString()))%>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
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


