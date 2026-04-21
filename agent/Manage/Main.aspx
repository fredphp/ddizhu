<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Main.aspx.cs" Inherits="AgencyManage.Manage.Main" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../Css/default.css" rel="stylesheet" type="text/css" />
    <script src="../Js/base.js" type="text/javascript"></script>
    <script src="../Lib/jquery.layout.js" type="text/javascript"></script>
    <script src="Js/Main.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="loading">
        操作处理中，请稍候......
    </div>
    <div class="ui-layout-north">
        <div class="mainHeader">
            <div class="userInfoDiv">
                <label class="labelAlign">
                    代理账号：</label><asp:Label ID="lblAgentAccount" runat="server" CssClass="labelContent"></asp:Label>
                <label class="labelAlign">
                    || 抽水比例：</label><asp:Label ID="lblRevenue" runat="server" CssClass="labelContent"></asp:Label>
                <label class="labelAlign">
                    || 代理资产：</label><asp:Label ID="lblScore" runat="server" CssClass="labelContent"></asp:Label>
                <label class="labelAlign">
                    || 今日注册人数：</label><asp:Label ID="lblRegisteCount" runat="server" CssClass="labelContent"></asp:Label>
                <label class="labelAlign">
                    || 昨日有效会员：</label><asp:Label ID="lblUserCount" runat="server" CssClass="labelContent"></asp:Label>
                ||
                <asp:LinkButton ID="lbtnFresh" Text="刷新" runat="server" CssClass="labelAlign" OnClick="lbtnFresh_Click"></asp:LinkButton>
                ||
                <asp:LinkButton ID="lbtnClose" Text="退出" runat="server" CssClass="labelAlign" OnClick="lbtnLogOut_Click"></asp:LinkButton></div>
        </div>
    </div>
    <div class="ui-layout-west">
        <div id="welcome">
            当前账户:【<asp:HyperLink ID="hlAgentName" NavigateUrl="AgentInfoDetail.aspx" CssClass="important"
                ToolTip="点击查看详细资料" Target="frmMain" runat="server"></asp:HyperLink>】
            <asp:LinkButton ID="lbtnLogOut" Text="注销" runat="server" OnClick="lbtnLogOut_Click"></asp:LinkButton>
        </div>
        <!--功能导航菜单-->
        <%--<asp:Literal ID="litFunction" runat="server"></asp:Literal>--%>
        <ul id="nav">
            <li><a href="###" class="submenu">信息维护</a>
                <ul>
                    <li><a href="AgentInfoEdit.aspx" class="item" target="frmMain">资料修改</a></li>
                    <li><a href="Notice/NewsInfo.aspx" class="item" target="frmMain">最新公告</a></li>
                    <li><a href="Notice/NewsList.aspx" class="item" target="frmMain">公告列表</a></li>
                </ul>
            </li>
            <li><a href="###" class="submenu">用户管理</a>
                <ul>
                    <li><a href="Agent/DirectAgentList.aspx" class="item" target="frmMain">下级代理管理</a></li>
                    <li><a href="Player/DirectPlayerList.aspx" class="item" target="frmMain">下级玩家管理</a></li>
                </ul>
            </li>
            <li><a href="###" class="submenu">财务管理</a>
                <ul>
                    
                 
                    <li><a href="Money/MyRevenueRecord.aspx" class="item" target="frmMain">我的抽水记录</a></li>
                    <li><a href="Money/BalanceRecord.aspx" class="item" target="frmMain">转账记录</a></li>
                    <li><a href="Money/GetGoldRecord.aspx" class="item" target="frmMain">结算记录</a></li>
                    <li><a href="Money/RechargeRecord.aspx" class="item" target="frmMain">充值记录</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <div class="ui-layout-center">
        <iframe id="frmMain" name="frmMain" src="Notice/NewsInfo.aspx" width="100%" height="100%"
            scrolling="auto" allowtransparency="true" style="background-color: #ffffff" frameborder="0"
            marginwidth="0" marginheight="0"></iframe>
    </div>
    <div class="ui-layout-south">
        <div id="mainFooter">
        </div>
    </div>
    </form>
</body>
</html>
