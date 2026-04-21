<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsList.aspx.cs" Inherits="AgencyManage.Manage.Notice.NewsList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    
    
    <title></title>
    <link href="../../Css/default.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/base.js" type="text/javascript"></script>
    <script src="../../Lib/WebCalender.js" type="text/javascript"></script>
    <script src="../../PlugIn/artdialog/artDialog.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(function () {
            GlobalFunc.HideLoading();
        });
    </script>   
</head>
<body>
    <form id="form1" runat="server">
    <div id="main">
        <div class="currentPath">
            当前位置：代理后台>>信息维护>>公告列表
        </div>
        <div class="tool">
            <input type="text" id="txtStartDate" class="date" runat="server" />——<input type="text" id="txtEndDate" class="date" runat="server" />
            <asp:Button ID="btnQuery" runat="server" Text="查询" onclick="btnQuery_Click" />
            <div class="tooltip">
                <dl>
                    <dt>温馨提示：</dt>
                    <dd>
                        为加快查询速度，建议查询的时间间隔尽量小<br />
                    </dd>
                </dl>
            </div>
        </div>
        <div class="result">
            <div class="list">
                <asp:GridView ID="gvNews" runat="server" AutoGenerateColumns="False" CellPadding="4" EnableModelValidation="True"
                    Width="100%">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="PageView_RowNo" HeaderText="编号" />
                        <asp:TemplateField HeaderText="公告标题">
                            <ItemTemplate>
                                <span class="important">
                                    <a href='NewsInfo1.aspx?param=<%# Eval("NewsID").ToString()%>'><%#Game.Utils.TextUtility.CutString(Eval("NewsName").ToString(), 0, 30)%></a>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="公告内容">
                            <ItemTemplate>
                                <span class="important">
                                    <%#Game.Utils.TextUtility.CutString(Eval("NewsCont").ToString(), 0, 60)%>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="NewsTime" HeaderText="公告时间" />
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
                <webdiyer:AspNetPager ID="pageNews" runat="server" FirstPageText="首页" LastPageText="末页" 
                 NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always" PageSize="25" OnPageChanged="pagePlayer_PageChanged">
                </webdiyer:AspNetPager>
            </div>
        </div>
    </div>
    </form>
</body>
</html>

