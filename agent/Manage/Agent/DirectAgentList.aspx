<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DirectAgentList.aspx.cs"
    Inherits="AgencyManage.Manage.Agent.DirectAgentList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>直接下级代理管理</title>
    <link href="../../Css/default.css" rel="stylesheet" type="text/css" />
    <script src="../../Js/base.js" type="text/javascript"></script>
    <script src="../../Js/JsCommon.js" type="text/javascript"></script>
    <script src="../../PlugIn/artdialog/artDialog.min.js" type="text/javascript"></script>
    <script src="../Js/DirectAgentList.js" type="text/javascript"></script>
</head>
<body>
    <div id="divHidShow"></div>
    <form id="form1" runat="server">
            <div class="divAgentList" style="z-index:20000">
        <div class="divAgentChild"><h2>代理充值</h2></div>
        <table cellspacing="0" cellpadding="15"id="tabAgentList" style="width:100%;border-collapse:collapse;">
           <tr>
               <td>代理账号：</td><td><input type="text" readonly id="tdAgentAccount" /></td>
           </tr>
            <tr>
                <td>充值金币:</td><td><input type="text" runat="server" id="RechargeMuch" Required /></td>
            </tr>
            <tr>
                <td></td><td><label id="lxlmessage" style="color:red;" runat="server"></label></td>
            </tr>
            <tr>
       
                <td></td><td><asp:Button ID="ButtonRecharge" runat="server" Text="确定充值" OnClick="submitRecharge_Click" /><input type="button" value="取消" onclick="CloseDiv" id="closediv" /></td>
            </tr>
        </table>
    </div>

        <div id="main">
            <div class="currentPath">
                当前位置：代理后台>>用户管理>>直接下级代理管理
            </div>
            <fieldset id="edit">
                <legend>新增下级代理</legend>
                <label>
                    代理账号：</label><input type="text" id="txtAgentAccount" class="w100" runat="server" />
                <label>
                    密码：</label><input type="password" id="txtPassword" class="w100" runat="server" />
                <label>
                    确认密码：</label><input type="password" id="txtPasswordCon" class="w100" runat="server" />
                <label>
                    抽水比例：</label><input type="text" id="txtRevenue" class="w30" runat="server" />%
            <asp:Button ID="btnAdd" runat="server" Text="新增代理" OnClick="btnAdd_Click" />
                <div class="hint">
                    温馨提示：新增下级代理时，其抽水比例不能高于您的抽水比例。
                </div>
                <div id="myInfo">
                    <label>
                        我的金币：</label><asp:Label ID="lblMyScore" runat="server"></asp:Label>金币
                <label>
                    我的抽水比例：</label><asp:Label ID="lblMyRevenue" runat="server"></asp:Label>%
                </div>
            </fieldset>
            <div class="tool">
                <input runat="server" id="hideRemark" type="hidden" />
                <fieldset>
                    <legend>查询</legend>
                    <label>
                        代理账号：</label><input type="text" id="txtAccount" class="w100" runat="server" />
                    <asp:Button ID="btnQuery" runat="server" Text="查询" OnClick="btnQuery_Click" />
                    <input type="hidden" id="hideAgentID" runat="server" />
                    <input type="hidden" id="hiddenAccount" runat="server" />
                    <input type="hidden" id="agentAccount" runat="server" />
                </fieldset>
                <fieldset id="changeRevenue" class="operate">
                    <legend>设置下级代理抽水比例 <a href="###" class="hide">隐藏</a></legend>
                    <label>
                        代理账号：</label><span class="agentAccount"></span>
                    <label>
                        抽水比例：</label><input type="text" id="txtNewRevenue" class="w65" runat="server" />%
                <asp:Button ID="btnSaveRevenue" runat="server" Text="确认修改" OnClick="btnSaveRevenue_Click" />
                    <span class="hint">温馨提示：下级代理的抽水比例不能大于您的抽水比例！</span>
                </fieldset>
            </div>
            <div class="result">
                <div class="list">
                    <asp:GridView ID="gvAgentList" runat="server" AutoGenerateColumns="False"
                        CellPadding="4" EnableModelValidation="True" Width="100%">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField HeaderText="代理编号" DataField="AgencyID" />
                            <asp:BoundField HeaderText="代理账号" DataField="LoginName" />
                            <asp:BoundField HeaderText="真实姓名" DataField="AgencyName" />
                            <asp:BoundField HeaderText="资产(金币)" DataField="AgencyGold" />
                            <asp:BoundField HeaderText="抽水比例" DataField="AgencyRoyalty" />
                            <asp:TemplateField HeaderText="操作">
                                <ItemTemplate>
                                    <div class="CellDiv"><%# BindPeopleCount(int.Parse(Eval("AgencyID").ToString())) %></div>
                                </ItemTemplate>
                            </asp:TemplateField>
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
                    <webdiyer:AspNetPager ID="pageAgent" runat="server" FirstPageText="首页" LastPageText="末页"
                        NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always" PageSize="15" OnPageChanged="pageAgent_PageChanged">
                    </webdiyer:AspNetPager>
                </div>
            </div>
        </div>
    </form>
</body>

</html>

