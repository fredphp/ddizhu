<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgencyReport.aspx.cs" Inherits="MTEwin.Module.AgencyManager.AgencyReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
    <title></title>
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
                你当前位置：代理系统 - 代理报表
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td>
                &nbsp;
                输入用户名或真实姓名或代理标识:<asp:TextBox ID="txtSearch" runat="server" CssClass="text" ToolTip="输入帐号或用户标识"></asp:TextBox>
                 <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox>
                    <img src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})" style="cursor: pointer; vertical-align: middle" />
                    至
                 <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox>
                    <img src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"  style="cursor: pointer; vertical-align: middle" />
                    <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
                 <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
                </td>
            </tr>
        </table>
        <div class="clear">
        </div>
        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
                id="list">
                <tr align="center" class="bold">
                    <td class="listTitle2">代理标识
                    </td>
                    <td class="listTitle2">用户名
                    </td>
                    <td class="listTitle2">充值人数
                    </td>
                    <td class="listTitle2">真实姓名
                    </td>
                    <td class="listTitle2">上级代理
                    </td>
                    <td class="listTitle2">注册总数
                    </td>
                    <td class="listTitle2">有效会员
                    </td>

                    <td class="listTitle2">代理单价
                    </td>
                    <td class="listTitle2">抽水总金币
                    </td>
                    <td class="listTitle2">代理资产
                    </td>
                    <td class="listTitle2">已转资产
                    </td>
                    <td class="listTitle2">已提现
                    </td>
                    <td class="listTitle2">会员充值总金额
                    </td>
                    <td class="listTitle2">会员提现总金额
                    </td>
                   
                </tr>
                <asp:Repeater ID="rptDataList" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                <%#  Eval("AgencyID").ToString()%>
                            </td>
                            <td>
                                <a href='AddAgency.aspx?cmd=upAgency&param=<%# Eval("AgencyID") %>' style="color: #0000ff;"><%#  Eval("LoginName").ToString()%></a>
                            </td>
                            <td>
                               <%-- <%#  GetPayUserCountByID(int.Parse(Eval("AgencyID").ToString())) + GetAgencyPay(Eval("AgencyID").ToString(),"","",1)%>--%>
                                <%# GetPayCountByTime(Eval("AgencyID").ToString(),startDate,endDate) %>
                            </td>
                            <td>
                                <%#  Eval("AgencyName").ToString()%>
                            </td>
                            <td>
                                <%#  GetAgencyLogonName(int.Parse(Eval("AgencyParentID").ToString()))%>
                            </td>
                            <td>
                               <%-- <%#  GetRegisterCount(int.Parse(Eval("AgencyID").ToString()))%>--%>
                               <%#  GetAccountsCountByTime(Eval("AgencyID").ToString(),startDate,endDate)%>
                            </td>
                            <td>
                                <%#  GetUserCount(int.Parse(Eval("AgencyID").ToString()))%>
                            </td>
                            <td>
                                <%#  Eval("UserPrice").ToString()%>
                            </td>
                            <td>
                                <%#  GetRoyGoldCount(int.Parse(Eval("AgencyID").ToString()))%>
                            </td>
                            <td>
                                <%#  Eval("AgencyGold").ToString()%>
                            </td>
                            <td>
                               <a href="AgencyDrawRecord.aspx?param=<%# Eval("AgencyID")%>"><%#  GetTotalGoldDraw(int.Parse(Eval("AgencyID").ToString()))%></a> 
                            </td>
                            <td>
                               <a href="ApplyGoldRecord.aspx?param=<%# Eval("AgencyID")%>"><%#  GetTotalGoldBring(int.Parse(Eval("AgencyID").ToString()))%></a> 
                            </td>
                            <td>
                              <%-- <%#  GetUserTotalGoldDraw(int.Parse(Eval("AgencyID").ToString()))%>--%>
                                 <%#  GetPayAmountByTime(Eval("AgencyID").ToString(),startDate,endDate)%>
                            </td>
                            <td>
                               <%-- <%#  GetUserTotalGoldBring(int.Parse(Eval("AgencyID").ToString()))%>--%>
                               <%#  GetApplyMoneyByTime(Eval("AgencyID").ToString(),startDate,endDate)%>
                            </td>
                            
                            
                        </tr>
                    </ItemTemplate>
                    <AlternatingItemTemplate>
                        <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                <%#  Eval("AgencyID").ToString()%>
                            </td>
                            <td>
                                <a href='AddAgency.aspx?cmd=upAgency&param=<%# Eval("AgencyID") %>' style="color: #0000ff;"><%#  Eval("LoginName").ToString()%></a>
                            </td>
                            <td>
                                <%-- <%#  GetPayUserCountByID(int.Parse(Eval("AgencyID").ToString())) + GetAgencyPay(Eval("AgencyID").ToString(),"","",1)%>--%>
                                <%# GetPayCountByTime(Eval("AgencyID").ToString(),startDate,endDate) %>
                            </td>
                            <td>
                                <%#  Eval("AgencyName").ToString()%>
                            </td>
                            <td>
                                <%#  GetAgencyLogonName(int.Parse(Eval("AgencyParentID").ToString()))%>
                            </td>
                            <td>
                               <%-- <%#  GetRegisterCount(int.Parse(Eval("AgencyID").ToString()))%>--%>
                               <%#  GetAccountsCountByTime(Eval("AgencyID").ToString(),startDate,endDate)%>
                            </td>
                            <td>
                                <%#  GetUserCount(int.Parse(Eval("AgencyID").ToString()))%>
                            </td>
                            <td>
                                <%#  Eval("UserPrice").ToString()%>
                            </td>
                            <td>
                                <%#  GetRoyGoldCount(int.Parse(Eval("AgencyID").ToString()))%>
                            </td>
                            <td>
                                <%#  Eval("AgencyGold").ToString()%>
                            </td>
                           <td>
                               <a href="AgencyDrawRecord.aspx?param=<%# Eval("AgencyID")%>"><%#  GetTotalGoldDraw(int.Parse(Eval("AgencyID").ToString()))%></a> 
                            </td>
                            <td>
                               <a href="ApplyGoldRecord.aspx?param=<%# Eval("AgencyID")%>"><%#  GetTotalGoldBring(int.Parse(Eval("AgencyID").ToString()))%></a> 
                            </td>
                            <td>
                               <%-- <%#  GetUserTotalGoldDraw(int.Parse(Eval("AgencyID").ToString()))%>--%>
                                 <%#  GetPayAmountByTime(Eval("AgencyID").ToString(),startDate,endDate)%>
                            </td>
                            <td>
                                 <%-- <%#  GetUserTotalGoldBring(int.Parse(Eval("AgencyID").ToString()))%>--%>
                               <%#  GetApplyMoneyByTime(Eval("AgencyID").ToString(),startDate,endDate)%>
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
