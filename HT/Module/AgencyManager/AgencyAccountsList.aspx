<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgencyAccountsList.aspx.cs"
    Inherits="MTEwin.Module.AgencyManager.AgencyAccountsList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">
                你当前位置：代理系统 - 代理下级玩家查看
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 80px">
            </td>
            <td>
                &nbsp;&nbsp; 普通查询：
                <asp:TextBox ID="txtSearch" runat="server" CssClass="text" ToolTip="输入帐号或用户标识"></asp:TextBox>
                <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
            </td>
        </tr>
    </table>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
            id="list">
            <tr align="center" class="bold">
                <td class="listTitle2">
                    用户标识
                </td>
                <td class="listTitle2">
                    用户帐号
                </td>
                <td class="listTitle2">
                    性别
                </td>
                <td class="listTitle2">
                    余额
                </td>
                <td class="listTitle2">
                    <%=BankMoneyName%>余额
                </td>
                <td class="listTitle2">
                    幸运币
                </td>
                <td class="listTitle2">
                    一级比例
                </td>
                <td class="listTitle2">
                    直属站点
                </td>
                <td class="listTitle2">
                    注册时间
                </td>
                <td class="listTitle2">
                    注册地址
                </td>
                <td class="listTitle2">
                    登录次数
                </td>
                <td class="listTitle2">
                    游戏/在线时长
                </td>
                <td class="listTitle2">
                    最后登录时间
                </td>
                <td class="listTitle2">
                    最后登录地址
                </td>
                <td class="listTitle1">
                    状态
                </td>
            </tr>
            <asp:Repeater ID="rptDataList" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%#string.Format( "<span class=\"{0}\">{1}</span>",(byte) Eval( "IsSpreader" ) == 1 ? "lan bold" : "", Eval( "UserID" ).ToString( ) )%>
                        </td>
                        <td>
                            <%#GetIsPaidStyle( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                            <a class="l" href="javascript:void(0);" onclick="openWindowOwn('../AccountManager/AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                                <%#Game.Utils.TextUtility.CutString( Eval( "Accounts" ).ToString(),0,10)%></a>
                        </td>
                        <td>
                            <%# Eval( "Gender" ).ToString()=="1"?"男":"女"%>
                        </td>
                        <td>
                            <%# GetScoreByUserID( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# GetInsureScoreByUserID( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%#  Eval( "UserMedal" ).ToString()%>
                        </td>
                        <td>
                            <%#double.Parse( Eval( "SpreaderScale" ).ToString()).ToString("0%")%>
                        </td>
                        <td>
                            <%# GetStationName( int.Parse( Eval( "StationID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# Eval( "RegisterDate" ).ToString()%>
                        </td>
                        <td title="<%# Eval("RegisterIP").ToString()%>">
                            <%# Game.Utils.IPQuery.GetAddressWithIP( Eval("RegisterIP").ToString())%>
                        </td>
                        <td>
                            <%# Eval( "GameLogonTimes" ).ToString()%>
                        </td>
                        <td>
                            <%# Eval( "PlayTimeCount" ).ToString( ) + "/" + Eval( "OnLineTimeCount" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "LastLogonDate" ).ToString()%>
                        </td>
                        <td title="<%# Eval("LastLogonIP").ToString()%>">
                            <%# Game.Utils.IPQuery.GetAddressWithIP( Eval("LastLogonIP").ToString())%>
                        </td>
                        <td>
                            <%# GetNullityStatus((byte)Eval("Nullity"))%>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%#string.Format( "<span class=\"{0}\">{1}</span>",(byte) Eval( "IsSpreader" ) == 1 ? "lan bold" : "", Eval( "UserID" ).ToString( ) )%>
                        </td>
                        <td>
                            <%#GetIsPaidStyle( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                            <a class="l" href="javascript:void(0);" onclick="openWindowOwn('../AccountManager/AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                                <%#Game.Utils.TextUtility.CutString( Eval( "Accounts" ).ToString(),0,10)%></a>
                        </td>
                        <td>
                            <%# Eval( "Gender" ).ToString()=="1"?"男":"女"%>
                        </td>
                        <td>
                            <%# GetScoreByUserID( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# GetInsureScoreByUserID( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%#  Eval( "UserMedal" ).ToString()%>
                        </td>
                        <td>
                            <%#double.Parse( Eval( "SpreaderScale" ).ToString()).ToString("0%")%>
                        </td>
                        <td>
                            <%# GetStationName( int.Parse( Eval( "StationID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# Eval( "RegisterDate" ).ToString()%>
                        </td>
                        <td title="<%# Eval("RegisterIP").ToString()%>">
                            <%# Game.Utils.IPQuery.GetAddressWithIP( Eval("RegisterIP").ToString())%>
                        </td>
                        <td>
                            <%# Eval( "GameLogonTimes" ).ToString()%>
                        </td>
                        <td>
                            <%# Eval( "PlayTimeCount" ).ToString( ) + "/" + Eval( "OnLineTimeCount" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "LastLogonDate" ).ToString()%>
                        </td>
                        <td title="<%# Eval("LastLogonIP").ToString()%>">
                            <%# Game.Utils.IPQuery.GetAddressWithIP( Eval("LastLogonIP").ToString())%>
                        </td>
                        <td>
                            <%# GetNullityStatus((byte)Eval("Nullity"))%>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
            </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
        </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="listTitleBg">
            </td>
            <td align="right" class="page">
                <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server"
                    AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="15" NextPageText="下页"
                    PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                    NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
                    UrlPaging="false">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
