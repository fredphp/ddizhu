<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgencyRoyeRecord.aspx.cs"
    Inherits="MTEwin.Module.AgencyManager.AgencyRoyeRecord" %>

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
        $(function () {
            $(".setSpan").click(function () {
                $("#spanLogonName font").remove();
                $("#spanRealName font").remove();
                $("#spanCount font").remove();
                $("#spanGoldCount font").remove();
                $("#spanUserCount font").remove();
                $("#spanRoyGold font").remove();
                $("#spanLogonName").append("<font>" + $(this).attr("data-name") + "</font>");
                $("#spanRealName").append("<font>" + $(this).attr("data-real") + "</font>");
                $("#spanCount").append("<font>" + $(this).attr("data-usercount") + "</font>");
                $("#spanGoldCount").append("<font>" + $(this).attr("data-Paycount") + "</font>");
                $("#spanUserCount").append("<font>" + $(this).attr("data-CanCount") + "</font>");
                $("#spanRoyGold").append("<font>" + $(this).attr("data-RoyCount") + "</font>");
                $("#divQuery").show();
            });
        });

        function HideDiv() {
            $("#divQuery").hide();
        }
    </script>
    <style type="text/css">
        .querybox
        {
            width: 500px;
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
                你当前位置：代理系统 - 代理抽水记录
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td style="height: 30px;">
                &nbsp; 输入用户名或真实姓名或代理标识:<asp:TextBox ID="txtSearch" runat="server" CssClass="text"
                    ToolTip="输入帐号或用户标识"></asp:TextBox>
                <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
                日期查询：<asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
            </td>
        </tr>
        <tr>
            <td style="height: 30px; padding-left: 20px;">
                抽水总额：<asp:Literal ID="ltRoyTotal" runat="server"></asp:Literal>金币
                <input class="btnLine" type="button" />
                充值人数：<asp:Literal ID="ltPayCount" runat="server"></asp:Literal>
                <input class="btnLine" type="button" />
                充值总额：<asp:Literal ID="ltPayGoldCount" runat="server"></asp:Literal>
                <input class="btnLine" type="button" />
                注册人数：<asp:Literal ID="ltRegister" runat="server"></asp:Literal>
                <input class="btnLine" type="button" />
                游戏人数：<asp:Literal ID="ltCanUser" runat="server"></asp:Literal>
                <input class="btnLine" type="button" />
                代理单价：<asp:Literal ID="ltPrice" runat="server"></asp:Literal>
                <input class="btnLine" type="button" />
                提现金币：<asp:Literal ID="ltBring" runat="server"></asp:Literal>
                <input class="btnLine" type="button" />
                转账金币：<asp:Literal ID="ltDraw" runat="server"></asp:Literal>
                <input class="btnLine" type="button" />
                代理资产：<asp:Literal ID="ltGold" runat="server"></asp:Literal>
            </td>
        </tr>
    </table>
    <%--<div id="divQuery" class="querybox">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                    <div class="hg3  pd7">
                        代理下级玩家信息</div>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    代理用户名：
                </td>
                <td>
                    <span id="spanLogonName"></span>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    代理真实姓名：
                </td>
                <td>
                    <span id="spanRealName"></span>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    充值人数：
                </td>
                <td style="text-align: left">
                    <span id="spanCount"></span>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    充值总金额：
                </td>
                <td>
                    <span id="spanGoldCount"></span>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    有效玩家总数：
                </td>
                <td>
                    <span id="spanUserCount"></span>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    抽水总金币数：
                </td>
                <td>
                    <span id="spanRoyGold"></span>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right" style="padding-bottom: 10px;">
                    <input type="button" value="关闭" class="btn wd1" onclick="HideDiv()" />
                </td>
            </tr>
        </table>
    </div>--%>
    <div class="clear">
    </div>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
            id="list">
            <tr align="center" class="bold">
                <td class="listTitle2">
                    代理标识
                </td>
                <td class="listTitle2">
                    用户名
                </td>
                <td class="listTitle2">
                    真实姓名
                </td>
                <td class="listTitle2">
                    游戏玩家
                </td>
                <td class="listTitle2">
                    玩家输赢
                </td>
                <td class="listTitle2">
                    抽水总额
                </td>
                <td class="listTitle2">
                    抽水比例
                </td>
                <td class="listTitle2">
                    抽水金额
                </td>
                <td class="listTitle2">
                    抽水时间
                </td>
                <td class="listTitle2">
                    备注
                </td>
                <%--<td class="listTitle2">
                    查看代理业绩
                </td>--%>
            </tr>
            <asp:Repeater ID="rptDataList" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%#  Eval("AgencyID").ToString()%>
                        </td>
                        <td>
                            <%#  GetAgencyLogonName(int.Parse(Eval("AgencyID").ToString()))%>
                        </td>
                        <td>
                            <%#  GetAgencyName(int.Parse(Eval("AgencyID").ToString()))%>
                        </td>
                        <td>
                            <%#  GetAccounts(int.Parse(Eval("UserID").ToString()))%>
                        </td>
                        <td>
                            <%#  Eval("UserWin").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("RoyaltyTotal").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("RoyaltyRatio").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("RoyaltyGold").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("RoyaltyTime").ToString()%>
                        </td>

                          <td>
                            <%#  Eval("remark").ToString()%>
                        </td>
                        <%--<td>
                            <span class="setSpan" data-name='<%#  GetAgencyLogonName(int.Parse(Eval("AgencyID").ToString()))%>'
                                data-real='<%#  GetAgencyName(int.Parse(Eval("AgencyID").ToString()))%>' data-usercount='<%#  GetPayUserCountByID(int.Parse(Eval("AgencyID").ToString()))%>'
                                data-paycount='<%#  GetPayGoldCountByID(int.Parse(Eval("AgencyID").ToString()))%>'
                                data-cancount='<%#  GetUserCount(int.Parse(Eval("AgencyID").ToString()))%>' data-roycount='<%#  GetRoyGoldCount(int.Parse(Eval("AgencyID").ToString()))%>'
                                style="color: #0000ff;">查看</span>
                        </td>--%>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%#  Eval("AgencyID").ToString()%>
                        </td>
                        <td>
                            <%#  GetAgencyLogonName(int.Parse(Eval("AgencyID").ToString()))%>
                        </td>
                        <td>
                            <%#  GetAgencyName(int.Parse(Eval("AgencyID").ToString()))%>
                        </td>
                        <td>
                            <%#  GetAccounts(int.Parse(Eval("UserID").ToString()))%>
                        </td>
                        <td>
                            <%#  Eval("UserWin").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("RoyaltyTotal").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("RoyaltyRatio").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("RoyaltyGold").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("RoyaltyTime").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("remark").ToString()%>
                        </td>
                        <%--<td>
                            <span class="setSpan" data-name='<%#  GetAgencyLogonName(int.Parse(Eval("AgencyID").ToString()))%>'
                                data-real='<%#  GetAgencyName(int.Parse(Eval("AgencyID").ToString()))%>' data-usercount='<%#  GetPayUserCountByID(int.Parse(Eval("AgencyID").ToString()))%>'
                                data-paycount='<%#  GetPayGoldCountByID(int.Parse(Eval("AgencyID").ToString()))%>'
                                data-cancount='<%#  GetUserCount(int.Parse(Eval("AgencyID").ToString()))%>' data-roycount='<%#  GetRoyGoldCount(int.Parse(Eval("AgencyID").ToString()))%>'
                                style="color: #0000ff;">查看</span>
                        </td>--%>
                    </tr>
                </AlternatingItemTemplate>
            </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
        </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="listTitleBg">
                <span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a
                    class="l1" href="javascript:SelectAll(false);">无</a>
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
    <input type="hidden" runat="server" id="hidAgencyId" />
    </form>
</body>
</html>
