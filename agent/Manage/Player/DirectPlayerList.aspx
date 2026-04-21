<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DirectPlayerList.aspx.cs"
    Inherits="AgencyManage.Manage.Player.DirectPlayerList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>直接玩家管理</title>
    <link href="../../Css/default.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/base.js" type="text/javascript"></script>
    <script src="../../Js/JsCommon.js" type="text/javascript"></script>
    <script src="../../PlugIn/artdialog/artDialog.min.js" type="text/javascript"></script>
    <script src="../Js/DirectPlayerList.js" type="text/javascript"></script>
    <script src="../Js/AddPlayer.js" type="text/javascript"></script>
    <script src="../../Lib/WebCalender.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="main">
        <div class="currentPath">
            当前位置：代理后台>>用户管理>>直接玩家管理
            <input type="hidden" id="hideUserID" runat="server" />
            <input type="hidden" id="hideUserAccount" runat="server" />
            <input type="hidden" id="hideRemark" runat="server" />
        </div>
        <%--<fieldset id="add" class="operate">
            <legend>新增游戏玩家</legend>
            <label>
                玩家账号：</label><input type="text" id="txtUserAccount" class="w100" runat="server" />
            <label>
                真实姓名：</label><input type="text" id="txtRealName" class="w80" runat="server" />
            <label>
                性别：</label><asp:DropDownList ID="ddlGender" runat="server">
                    <asp:ListItem Text="男" Value="1"></asp:ListItem>
                    <asp:ListItem Text="女" Value="2"></asp:ListItem>
                </asp:DropDownList>
            <label>
                密码：</label><input type="password" id="txtPassword" class="w100" runat="server" />
            <label>
                确认密码：</label><input type="password" id="txtPasswordCon" class="w100" runat="server" />
            <label>
                抽水比例：</label><input type="text" id="txtRevenue" class="w30" runat="server" />%
            <asp:Button ID="btnSaveAdd" runat="server" Text="确认新增" OnClick="btnSaveAdd_Click" />
            <div class="hint">
                温馨提示：新增游戏玩家时，如果系统开启注册赠送功能，则会赠送其相应金币。
            </div>
        </fieldset>--%>
        <div class="tool">
            <fieldset>
                <legend>常用功能</legend>
                <label>
                    玩家账号：</label><input type="text" id="txtAccount" class="w100" runat="server" />
                <asp:Button ID="btnQuery" runat="server" Text="查询" OnClick="btnQuery_Click" />
                <input type="hidden" id="btnAdd" class="button" value="新增游戏玩家" />
                <div id="myInfo">
                    <label>
                        我的金币：</label><asp:Label ID="lblMyScore" runat="server"></asp:Label>金币
                    <label>
                        我的抽水比例：</label><asp:Label ID="lblMyRevenue" runat="server"></asp:Label>%
                </div>
            </fieldset>
<%--            <fieldset id="charge" class="operate">
                <legend>设置下级玩家抽水比例 <a href="###" class="hide">隐藏</a></legend>
                <label>
                    玩家账号：</label><span class="agentAccount"></span>
                <label>
                    抽水比例：</label><input type="text" id="txtNewRevenue" class="w65" runat="server" />%
                <asp:Button ID="btnSaveRevenue" runat="server" Text="确认修改" OnClick="btnSaveRevenue_Click" />
                <span class="hint">温馨提示：下级玩家的抽水比例不能大于您的抽水比例！</span>
            </fieldset>--%>
        </div>
        <div class="result">
            <div class="list">
                <asp:GridView ID="gvPlayer" runat="server" AutoGenerateColumns="False" CellPadding="4" EnableModelValidation="True"
                    Width="100%">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="玩家编号" />
                        <asp:BoundField DataField="Accounts" HeaderText="登录账号" />
                        <asp:BoundField DataField="NickName" HeaderText="昵称" />
                        <asp:BoundField DataField="Compellation" HeaderText="真实姓名" />
                        <asp:TemplateField HeaderText="金币总额">
                            <ItemTemplate>
                                <span class="important">
                                    <%# string.Format("{0:N}",float.Parse(GetScoreByUserID(int.Parse(Eval("UserID").ToString()))) + float.Parse(GetInsureScoreByUserID(int.Parse(Eval("UserID").ToString()))))%>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="携带金币">
                            <ItemTemplate>
                                <span class="important">
                                    <%# GetScoreByUserID(int.Parse(Eval("UserID").ToString()))%>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="银行金币">
                            <ItemTemplate>
                                <span class="important">
                                    <%# GetInsureScoreByUserID(int.Parse(Eval("UserID").ToString()))%>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="游戏时长">
                            <ItemTemplate>
                                <span class="important">
                                    <%# Display_Time(Eval("PlayTimecount").ToString())%></span></ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="RegisterDate" HeaderText="注册日期" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                        <asp:BoundField DataField="LastLogonDate" HeaderText="最后登录日期" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
                        <asp:BoundField DataField="LastLogonIP" HeaderText="最后登录IP" />
                        <asp:BoundField DataField="SpreaderScale" HeaderText="抽水比例" />
<%--                        <asp:TemplateField HeaderText="操作">
                            <ItemTemplate>
                                <a href="###" class="chargeIn">设置抽水比例</a>
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
                <webdiyer:AspNetPager ID="pagePlayer" runat="server"  FirstPageText="首页" LastPageText="末页" 
                 NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always" PageSize="10" OnPageChanged="pagePlayer_PageChanged">
                </webdiyer:AspNetPager>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
