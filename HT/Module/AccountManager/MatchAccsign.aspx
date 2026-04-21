<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MatchAccsign.aspx.cs" Inherits="MTEwin.Module.AccountManager.MatchAccsign" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/JQuery.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".spanFirst").click(function () {
                $("#textFirst").val($(this).attr("data-con"));
                $("#hidFirst").val($(this).attr("data-id"));
            })
            $(".spanSecond").click(function () {
                $("#textSecond").val($(this).attr("data-con"));
                $("#hidSecond").val($(this).attr("data-id"));
            })
            $(".spanThird").click(function () {
                $("#textThird").val($(this).attr("data-con"));
                $("#hidThird").val($(this).attr("data-id"));
            })
            $(".spanFour").click(function () {
                $("#textFour").val($(this).attr("data-con"));
                $("#hidFour").val($(this).attr("data-id"));
            })
            $(".spanFive").click(function () {
                $("#textFive").val($(this).attr("data-con"));
                $("#hidFive").val($(this).attr("data-id"));
            })
            $(".spanSix").click(function () {
                $("#textSix").val($(this).attr("data-con"));
                $("#hidSix").val($(this).attr("data-id"));
            });
            $(".spanSeven").click(function () {
                $("#textSeven").val($(this).attr("data-con"));
                $("#hidSeven").val($(this).attr("data-id"));
            });
            $(".spanEight").click(function () {
                $("#textEight").val($(this).attr("data-con"));
                $("#hidEight").val($(this).attr("data-id"));
            });
            $(".spanNine").click(function () {
                $("#textNine").val($(this).attr("data-con"));
                $("#hidNine").val($(this).attr("data-id"));
            });
            $(".spanTen").click(function () {
                $("#textTen").val($(this).attr("data-con"));
                $("#hidTen").val($(this).attr("data-id"));
            });
        });
    </script>
    <style type="text/css">
        .style1
        {
            width: 223px;
        }
        span
        {
            cursor: pointer;
            color: #0000ff;
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
                你当前位置：用户系统 - 比赛名次设定
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('MatchUserInfo.aspx')" />
                <input class="btnLine" type="button" />
                <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                <div class="hg3  pd7">
                    比赛信息</div>
            </td>
            <td height="35" colspan="6" class="f14 bold Lpd10 Rpd10">
                <div class="hg3  pd7">
                    比赛排名</div>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                比赛名称：
            </td>
            <td class="style1">
                <asp:TextBox ID="txtMatchName" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>
            </td>
            <td class="listTdLeft">
                第一名：
            </td>
            <td>
                <asp:TextBox ID="textFirst" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <%--<td>
                浮动金币：
            </td>--%>
            <td>
                <asp:TextBox ID="txtFirstScore" runat="server" TabIndex="12"></asp:TextBox>
            </td>
            <td class="listTdLeft">
                第六名：
            </td>
            <td>
                <asp:TextBox ID="textSix" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <%--<td>
                浮动金币：
            </td>--%>
            <td>
                <asp:TextBox ID="txtSixScore" runat="server" TabIndex="17"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                比赛房间：
            </td>
            <td class="style1">
                <asp:TextBox ID="txtMatchRoom" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>
            </td>
            <td class="listTdLeft">
                第二名：
            </td>
            <td>
                <asp:TextBox ID="textSecond" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <%--<td>
                浮动金币：
            </td>--%>
            <td>
                <asp:TextBox ID="txtSecondScore" runat="server" TabIndex="13"></asp:TextBox>
            </td>
            <td class="listTdLeft">
                第七名：
            </td>
            <td>
                <asp:TextBox ID="textSeven" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <%--<td>
                浮动金币：
            </td>--%>
            <td>
                <asp:TextBox ID="txtSevenScore" runat="server" TabIndex="18"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                开始日期：
            </td>
            <td class="style1">
                <asp:TextBox ID="txtBeginTime" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>
            </td>
            <td class="listTdLeft">
                第三名：
            </td>
            <td>
                <asp:TextBox ID="textThird" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <%--<td>
                浮动金币：
            </td>--%>
            <td>
                <asp:TextBox ID="txtThirdScore" runat="server" TabIndex="14"></asp:TextBox>
            </td>
            <td class="listTdLeft">
                第八名：
            </td>
            <td>
                <asp:TextBox ID="textEight" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <%--<td>
                浮动金币：
            </td>--%>
            <td>
                <asp:TextBox ID="txtEightScore" runat="server" TabIndex="19"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                结束日期：
            </td>
            <td class="style1">
                <asp:TextBox ID="txtEndTime" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>
            </td>
            <td class="listTdLeft">
                第四名：
            </td>
            <td>
                <asp:TextBox ID="textFour" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <%--<td>
                浮动金币：
            </td>--%>
            <td>
                <asp:TextBox ID="txtFourScore" runat="server" TabIndex="15"></asp:TextBox>
            </td>
            <td class="listTdLeft">
                第九名：
            </td>
            <td>
                <asp:TextBox ID="textNine" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <%--<td>
                浮动金币：
            </td>--%>
            <td>
                <asp:TextBox ID="txtNineScore" runat="server" TabIndex="20"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                比赛状态：
            </td>
            <td class="style1">
                <asp:TextBox ID="txtMatchStatus" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>
            </td>
            <td class="listTdLeft">
                第五名：
            </td>
            <td>
                <asp:TextBox ID="textFive" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <%--<td>
                浮动金币：
            </td>--%>
            <td>
                <asp:TextBox ID="txtFiveScore" runat="server" TabIndex="16"></asp:TextBox>
            </td>
            <td class="listTdLeft">
                第十名：
            </td>
            <td>
                <asp:TextBox ID="textTen" Enabled="false" runat="server"></asp:TextBox>
            </td>
            <%--<td>
                浮动金币：
            </td>--%>
            <td>
                <asp:TextBox ID="txtTenScore" runat="server" TabIndex="21"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td>
                &nbsp;&nbsp; 普通查询：
                <asp:TextBox ID="txtSearch" runat="server" CssClass="text" ToolTip="输入帐号或用户标识"></asp:TextBox>
                <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
        <tr align="center" class="bold">
            <td class="listTitle2">
                用户标识
            </td>
            <td class="listTitle2">
                用户帐号
            </td>
            <td class="listTitle2">
                第一名
            </td>
            <td class="listTitle2">
                第二名
            </td>
            <td class="listTitle2">
                第三名
            </td>
            <td class="listTitle2">
                第四名
            </td>
            <td class="listTitle2">
                第五名
            </td>
            <td class="listTitle2">
                第六名
            </td>
            <td class="listTitle2">
                第七名
            </td>
            <td class="listTitle2">
                第八名
            </td>
            <td class="listTitle2">
                第九名
            </td>
            <td class="listTitle2">
                第十名
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
                        <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                            <%#Game.Utils.TextUtility.CutString( Eval( "Accounts" ).ToString(),0,10)%></a>
                    </td>
                    <td>
                        <span class="spanFirst" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第一名</span>
                    </td>
                    <td>
                        <span class="spanSecond" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第二名</span>
                    </td>
                    <td>
                        <span class="spanThird" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第三名</span>
                    </td>
                    <td>
                        <span class="spanFour" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第四名</span>
                    </td>
                    <td>
                        <span class="spanFive" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第五名</span>
                    </td>
                    <td>
                        <span class="spanSix" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第六名</span>
                    </td>
                    <td>
                        <span class="spanSeven" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第七名</span>
                    </td>
                    <td>
                        <span class="spanEight" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第八名</span>
                    </td>
                    <td>
                        <span class="spanNine" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第九名</span>
                    </td>
                    <td>
                        <span class="spanTen" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第十名</span>
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
                        <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                            <%#Game.Utils.TextUtility.CutString( Eval( "Accounts" ).ToString(),0,10)%></a>
                    </td>
                    <td>
                        <span class="spanFirst" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第一名</span>
                    </td>
                    <td>
                        <span class="spanSecond" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第二名</span>
                    </td>
                    <td>
                        <span class="spanThird" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第三名</span>
                    </td>
                    <td>
                        <span class="spanFour" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第四名</span>
                    </td>
                    <td>
                        <span class="spanFive" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第五名</span>
                    </td>
                    <td>
                        <span class="spanSix" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第六名</span>
                    </td>
                    <td>
                        <span class="spanSeven" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第七名</span>
                    </td>
                    <td>
                        <span class="spanEight" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第八名</span>
                    </td>
                    <td>
                        <span class="spanNine" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第九名</span>
                    </td>
                    <td>
                        <span class="spanTen" data-id='<%# Eval("UserID") %>' data-con='<%# Eval("Accounts") %>'>
                            设置第十名</span>
                    </td>
                </tr>
            </AlternatingItemTemplate>
        </asp:Repeater>
        <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="listTitleBg">
            </td>
            <td align="right" class="page">
                <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server"
                    AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="13" NextPageText="下页"
                    PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                    NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
                    UrlPaging="false">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('MatchUserInfo.aspx')" />
                <input class="btnLine" type="button" />
                <asp:Button ID="btnSave1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    <input type="hidden" id="hidFirst" runat="server" />
    <input type="hidden" id="hidSecond" runat="server" />
    <input type="hidden" id="hidThird" runat="server" />
    <input type="hidden" id="hidFour" runat="server" />
    <input type="hidden" id="hidFive" runat="server" />
    <input type="hidden" id="hidSix" runat="server" />
    <input type="hidden" id="hidSeven" runat="server" />
    <input type="hidden" id="hidEight" runat="server" />
    <input type="hidden" id="hidNine" runat="server" />
    <input type="hidden" id="hidTen" runat="server" />
    </form>
</body>
</html>
