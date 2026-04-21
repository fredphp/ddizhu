<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MatchInfo.aspx.cs" Inherits="MTEwin.Module.AppManager.MatchInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
    <title></title>
    <script type="text/javascript" src="../../scripts/JQuery.js"></script>
    <script type="text/javascript">
        function getRoomName() {
            var select1 = document.all.<%= ddlGameName.ClientID %>;
            var selectText= select1.options[select1.selectedIndex].text;
            var matchtime = document.getElementById("txtStartDate").value;
            $("#txtMatchName").val("【"+matchtime.toString().split(' ')[0]+"】"+selectText.split('(')[0] + " 比赛");
        }
    </script>
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
                你当前位置：游戏系统 - 比赛管理
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" runat="server" onserverclick="goBack_Click" />
                <input class="btnLine" type="button" />
                <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                <div class="hg3  pd7">
                    <asp:Literal ID="litInfo" runat="server"></asp:Literal>比赛信息</div>
            </td>
        </tr>
        <tr id="trMatchName" runat="server" visible="false">
            <td class="listTdLeft">
                比赛名称：
            </td>
            <td>
                <asp:TextBox ID="txtMatchName" runat="server" CssClass="text" Width="200"></asp:TextBox>
                （选择比赛房间和开始时间后自动生成比赛名称）
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                比赛类型：
            </td>
            <td>
                <asp:DropDownList ID="ddlMatchType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlMatchType_SelectedIndexChanged">
                    <asp:ListItem Value="==请选择比赛类型==">==请选择比赛类型==</asp:ListItem>
                    <asp:ListItem Value="0">即时赛</asp:ListItem>
                    <asp:ListItem Value="1">定时赛</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                比赛房间：
            </td>
            <td>
                <asp:DropDownList ID="ddlGameName" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlGameName_SelectedIndexChanged">
                </asp:DropDownList>
            </td>
        </tr>
        <div id="divMatchOnce" runat="server" visible="false">
            <tr>
                <td class="listTdLeft">
                    开始日期：
                </td>
                <td>
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                        onchange="getRoomName()" Width="150"></asp:TextBox><img src="../../Images/btn_calendar.gif"
                            onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                            style="cursor: pointer; vertical-align: middle" />
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">
                    结束日期：
                </td>
                <td>
                    <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                        Width="150"></asp:TextBox><img src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                            style="cursor: pointer; vertical-align: middle" />
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">
                    比赛状态：
                </td>
                <td>
                    <asp:DropDownList ID="ddlMatchStatus" runat="server">
                        <asp:ListItem Value="0">未开始</asp:ListItem>
                        <asp:ListItem Value="1">比赛中</asp:ListItem>
                        <asp:ListItem Value="2">等待发放奖品</asp:ListItem>
                        <asp:ListItem Value="4">已结束</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </div>
        <div id="divMatchOnTime" runat="server" visible="false">
            <tr>
                <td class="listTdLeft">
                    开始日期：
                </td>
                <td>
                    <asp:TextBox ID="txtMatchBeginDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtMatchEndDate\')}'})"
                        Width="150"></asp:TextBox><img src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtMatchBeginDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtMatchEndDate\')}'})"
                            style="cursor: pointer; vertical-align: middle" />
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">
                    结束日期：
                </td>
                <td>
                    <asp:TextBox ID="txtMatchEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtMatchBeginDate\')}'})"
                        Width="150"></asp:TextBox><img src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtMatchEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtMatchBeginDate\')}'})"
                            style="cursor: pointer; vertical-align: middle" />
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">
                    开始时间：
                </td>
                <td>
                    <asp:TextBox ID="txtMatchBeginTime" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'HH:mm:ss',maxDate:'#F{$dp.$D(\'txtMatchEndTime\')}'})"
                        onchange="getRoomName()" Width="150"></asp:TextBox><img src="../../Images/btn_calendar.gif"
                            onclick="WdatePicker({el:'txtMatchBeginTime',dateFmt:'HH:mm:ss',maxDate:'#F{$dp.$D(\'txtMatchEndTime\')}'})"
                            style="cursor: pointer; vertical-align: middle" />
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">
                    结束时间：
                </td>
                <td>
                    <asp:TextBox ID="txtMatchEndTime" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'HH:mm:ss',minDate:'#F{$dp.$D(\'txtMatchBeginTime\')}'})"
                        Width="150"></asp:TextBox><img src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtMatchEndTime',dateFmt:'HH:mm:ss',minDate:'#F{$dp.$D(\'txtMatchBeginTime\')}'})"
                            style="cursor: pointer; vertical-align: middle" />
                </td>
            </tr>
        </div>
        <tr>
            <td class="listTdLeft">
                是否需要报名：
            </td>
            <td>
                <asp:DropDownList ID="ddlsign" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlsign_SelectedIndexChanged">
                    <asp:ListItem Value="0">无需报名</asp:ListItem>
                    <asp:ListItem Value="1">需要报名</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr id="trSignPrice" runat="server" visible="false">
            <td class="listTdLeft">
                报名费用：
            </td>
            <td>
                <asp:TextBox ID="txtSignPrice" runat="server" CssClass="text" Width="150"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                <div class="hg3  pd7">
                    比赛奖励</div>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第一名：
            </td>
            <td>
                <asp:TextBox ID="txtfirst" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第二名：
            </td>
            <td>
                <asp:TextBox ID="txtSecond" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第三名：
            </td>
            <td>
                <asp:TextBox ID="txtThird" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第四名：
            </td>
            <td>
                <asp:TextBox ID="txtFour" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第五名：
            </td>
            <td>
                <asp:TextBox ID="txtFive" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第六名：
            </td>
            <td>
                <asp:TextBox ID="txtSix" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第七名：
            </td>
            <td>
                <asp:TextBox ID="txtSeven" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第八名：
            </td>
            <td>
                <asp:TextBox ID="txtEight" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第九名：
            </td>
            <td>
                <asp:TextBox ID="txtNing" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第十名：
            </td>
            <td>
                <asp:TextBox ID="txtTen" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" runat="server" onserverclick="goBack_Click" />
                <input class="btnLine" type="button" />
                <asp:Button ID="btnSave1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
