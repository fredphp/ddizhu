<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MatchUserInfo.aspx.cs"
    Inherits="MTEwin.Module.AccountManager.MatchUserInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="../../scripts/JQuery.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#btnUpdateReward").click(function () {
                var matchID = $('#txtMatchId').val();
                var matchType = $('#txtMatchType').val();
                if (matchID == "请选择比赛" || matchID == null || matchID == "") {
                    showError("请先选择比赛");
                }
                else {
                    Redirect('MatchReward.aspx?cmd=upReward&type=' + matchType + '&param=' + matchID);
                }
            });
            $("#btnSetMatchPlace").click(function () {
                var matchID = $('#txtMatchId').val();
                if (matchID == "请选择比赛" || matchID == null || matchID == "") {
                    showError("请先选择比赛");
                }
                else {
                    Redirect('MatchAccsign.aspx?param=' + matchID);
                }
            });
        });
        function ShowDiv(a) {
            document.getElementById('divQuery').style.display = "block";
            $("#txtUserId").val($(a).attr("data-id"));
        }
        function HideDiv() {
            document.getElementById('divQuery').style.display = "none";
        }
    </script>
    <style type="text/css">
        .querybox
        {
            width: 400px;
            background: #caebfc;
            font-size: 12px;
            line-height: 18px;
            text-align: left;
            border-left: 1px solid #066ba4;
            border-right: 1px solid #066ba4;
            border-bottom: 1px solid #066ba4;
            border-top: 1px solid #066ba4;
            z-index: 999;
            display: none;
            position: absolute;
            top: 150px;
            left: 200px;
            padding: 5px;
            filter: progid:DXImageTransform.Microsoft.DropShadow(color=#9a8559,offX=1,offY=1,positives=true);
        }
        .blue
        {
            color:#0000ff;
        }
    </style>
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
                你当前位置：用户系统 - 游戏比赛记录
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 120px">
                比赛游戏房间：
            </td>
            <td>
                <asp:DropDownList ID="ddlGameName" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlGameName_SelectedIndexChanged">
                </asp:DropDownList>
                <input class="btnLine" type="button" />
                <asp:TextBox ID="txtSearch" runat="server" CssClass="text" Width="100"></asp:TextBox>
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
                <input class="btnLine" type="button" />
                <input type="button" id="btnSetMatchPlace" value="设置排名" class="btn wd1" style="width: 80px;" />
                <input class="btnLine" type="button" />
                <asp:Button ID="btnTakeGold" runat="server" Text="发放奖励" Width="80" CssClass="btn wd1"
                    OnClick="btnTakeGold_Click" />
                <input class="btnLine" type="button" />
                <input type="button" id="btnUpdateReward" value="修改奖励" class="btn wd1" style="width: 80px;" />
                <input class="btnLine" type="button" />
                输总和：<asp:Literal ID="ltLostTotal" runat="server"></asp:Literal>
                <input class="btnLine" type="button" />
                赢总和：<asp:Literal ID="ltWinTotal" runat="server"></asp:Literal>
                <input class="btnLine" type="button" />
                税收总和：<asp:Literal ID="ltRevenueTotal" runat="server"></asp:Literal>
                <input class="btnLine" type="button" runat="server" id="btnsline" visible="false" />
                <asp:Literal ID="ltmatchStatus" runat="server" Visible="false"></asp:Literal>
            </td>
        </tr>
    </table>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7"
            id="list">
            <tr align="center" class="bold">
                <td class="listTitle">
                    玩家名次
                </td>
                <td class="listTitle">
                    比赛玩家
                </td>
                <td class="listTitle">
                    用户标识
                </td>
                <td class="listTitle2">
                    赢
                </td>
                <td class="listTitle">
                    输
                </td>
                <td class="listTitle">
                    输赢总和
                </td>
                <td class="listTitle">
                    贡献税收
                </td>
                <td class="listTitle">
                    赢/输局数
                </td>
                <td class="listTitle">
                    游戏时长(秒)
                </td>
                <td class="listTitle">
                    比赛奖励
                </td>
                <td class="listTitle">
                    首次参与比赛时间
                </td>
                <td class="listTitle">
                    最后参与比赛时间
                </td>
                <%--<td class="listTitle">
                    设置比赛名次
                </td>--%>
            </tr>
            <asp:Repeater ID="rptDataList" runat="server" Visible="false">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%# Eval("UserPlacing").ToString() %>
                        </td>
                        <td>
                            <%#GetIsPaidStyle( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                            <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsRecordInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                                <%# GetAccounts( int.Parse( Eval( "UserID" ).ToString( ) ) )%></a>
                        </td>
                        <td>
                            <%# Eval( "UserID" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "WinScore" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "LostScore" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval("TotalScore").ToString() %>
                        </td>
                        <td>
                            <%# Eval( "Revenue" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "WinCount" ).ToString( )+"/"+Eval("LostCount").ToString()%>
                        </td>
                        <td>
                            <%# Eval( "PlayTimeCount" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval("UserReward").ToString() == "0" ? "-" : Eval("UserReward").ToString()%>
                        </td>
                        <td>
                            <%# Eval( "MatchBeginTime" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval("MatchEndTime").ToString() %>
                        </td>
                        <%--<td>
                            <span data-id='<%# Eval("UserID") %>' onclick='<%# GetMatchStatus()==3?"":"ShowDiv(this)" %>' class='<%# GetMatchStatus()==3?"":"blue" %>'>设置</span>
                        </td>--%>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%# Eval("UserPlacing").ToString() %>
                        </td>
                        <td>
                            <%#GetIsPaidStyle( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                            <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsRecordInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                                <%# GetAccounts( int.Parse( Eval( "UserID" ).ToString( ) ) )%></a>
                        </td>
                        <td>
                            <%# Eval( "UserID" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "WinScore" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "LostScore" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval("TotalScore").ToString() %>
                        </td>
                        <td>
                            <%# Eval( "Revenue" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "WinCount" ).ToString( )+"/"+Eval("LostCount").ToString()%>
                        </td>
                        <td>
                            <%# Eval( "PlayTimeCount" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval("UserReward").ToString() == "0" ? "-" : Eval("UserReward").ToString()%>
                        </td>
                        <td>
                            <%# Eval( "MatchBeginTime" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval("MatchEndTime").ToString() %>
                        </td>
                        <%--<td>
                            <span data-id='<%# Eval("UserID") %>' onclick='<%# GetMatchStatus()==3?"":"ShowDiv(this)" %>' class='<%# GetMatchStatus()==3?"":"blue" %>'>设置</span>
                        </td>--%>
                    </tr>
                </AlternatingItemTemplate>
            </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData" Visible="true" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
        </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="right" class="page">
                <gsp:AspNetPager ID="anpPage" runat="server" OnPageChanged="anpPage_PageChanged"
                    AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="20" NextPageText="下页"
                    PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                    NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
                    UrlPaging="false">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>
    <%--<div id="divQuery" class="querybox">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    名次：
                </td>
                <td>
                    <asp:RadioButtonList ID="rblPlace" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Text="第一名" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="第二名" Value="2"></asp:ListItem>
                        <asp:ListItem Text="第三名" Value="3"></asp:ListItem>
                        <asp:ListItem Text="第四名" Value="4"></asp:ListItem>
                        <asp:ListItem Text="第五名" Value="5"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right" style="padding-bottom: 10px; padding-right:120px;">
                    <asp:Button ID="btnAssignPlace" runat="server" Text="确定" CssClass="btn wd1" OnClick="btnAssignPlace_Click" />
                    &nbsp;&nbsp;&nbsp;
                    <input type="button" value="关闭" class="btn wd1" onclick="HideDiv()" />
                </td>
            </tr>
        </table>
    </div>--%>
    <input type="hidden" id="txtMatchId" runat="server" value="" />
    <input type="hidden" id="txtMatchType" runat="server" value="" />
    <input type="hidden" id="txtUserId" runat="server" value="" />
    </form>
</body>
</html>
