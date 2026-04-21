<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecordUserRevenueDetailList.aspx.cs" Inherits="MTEwin.Module.AccountManager.RecordUserRevenueDetailList" %>

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
                你当前位置：用户系统 - 每日抽水记录
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 80px">
           公司抽水总额：  
            </td>
            <td> 
                <input class="btnLine" type="button" />  <asp:Literal ID="ltRevenueTotal" runat="server"></asp:Literal>    
           
            </td>
        </tr>
         <tr>
            <td class="listTdLeft" style="width: 80px">
            条件查询：
            </td>
            <td> 
             <input class="btnLine" type="button" /> 
            直属站点：
             <asp:DropDownList ID="ddlStation" runat="server"></asp:DropDownList>&nbsp;&nbsp;
                日期查询：
               <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
                <asp:Button ID="btnQueryTD" runat="server" Text="今天" CssClass="btn wd1" OnClick="btnQueryTD_Click" />
                <asp:Button ID="btnQueryYD" runat="server" Text="昨天" CssClass="btn wd1" OnClick="btnQueryYD_Click" />
                <asp:Button ID="btnQueryTW" runat="server" Text="本周" CssClass="btn wd1" OnClick="btnQueryTW_Click" />
                <asp:Button ID="btnQueryYW" runat="server" Text="上周" CssClass="btn wd1" OnClick="btnQueryYW_Click" />
            </td>
        </tr>
    </table>
    
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7" id="list">
            <tr align="center" class="bold">
                <td class="listTitle2">
                    日期
                </td>
                <td class="listTitle2">
                    贡献玩家
                </td>
                <td class="listTitle2">
                    贡献抽水
                </td>
                 <td class="listTitle2">
                    直属站点
                </td>
                <td class="listTitle2">
                    公司抽水
                </td>
                <td class="listTitle2">
                    公司比例
                </td>
                <td class="listTitle2">
                    一级
                </td>
                <td class="listTitle2">
                    一级比例
                </td>
                <td class="listTitle2">
                    一级抽水
                </td>
                <td class="listTitle2">
                    二级
                </td>
                <td class="listTitle2">
                    二级抽水(比例5%)
                </td>
                <td class="listTitle2">
                    三级
                </td>
                <td class="listTitle2">
                    三级抽水(比例3%)
                </td>
                <td class="listTitle2">
                    四级
                </td>
                <td class="listTitle2">
                    四级抽水(比例2%)
                </td>
                <td class="listTitle2">
                    五级
                </td>
                <td class="listTitle2">
                    五级抽水(比例1%)
                </td>
               
                <td class="listTitle">
                    统计时间
                </td>
            </tr>
            <asp:Repeater ID="rptDataList" runat="server" OnItemDataBound="rptDataList_ItemDataBound">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%# Game.Facade.Fetch.ShowDate( int.Parse( Eval( "DateID" ).ToString( ) ) )%>
                            &nbsp;<img id="<%# Eval( "DateID" ).ToString( )+"_"+Eval("UserID").ToString()%>" src="../../Images/down.gif" style="cursor: pointer"
                                alt="查看贡献玩家的输赢" title="查看贡献玩家的输赢" onclick="showInfo(this)" />
                        </td>
                         <td>
                          <%#GetIsPaidStyle( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                         <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsRecordInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                            <%# GetAccounts( int.Parse( Eval( "UserID" ).ToString( ) ) )%></a>
                        </td>
                        <td>
                            <%# Eval( "Revenue" ).ToString( )%>
                        </td>
                         <td>
                            <%# GetStationName( int.Parse( Eval( "StationID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# Eval( "CompanyRevenue" ).ToString( )%>
                        </td>
                        <td>
                            <%# double.Parse( Eval( "CompanyScale" ).ToString( )).ToString("0%")%>
                        </td>
                        <td>
                            <%# GetAccounts( int.Parse( Eval( "UserID1" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# double.Parse( Eval( "Scale1" ).ToString( ) ) == 0 ? "" : double.Parse( Eval( "Scale1" ).ToString( ) ).ToString( "0%" )%>
                        </td>
                        <td>
                             <%# int.Parse( Eval( "UserID1" ).ToString( ) ) == 0 ? "" : Eval( "Revenue1" ).ToString( )%>
                        </td>
                        <td>
                            <%# GetAccounts( int.Parse( Eval( "UserID2" ).ToString( ) ) )%>
                        </td>
                        <td>
                              <%# int.Parse( Eval( "UserID2" ).ToString( ) ) == 0 ? "" : Eval( "Revenue2" ).ToString( )%>
                        </td>
                        <td>
                            <%# GetAccounts( int.Parse( Eval( "UserID3" ).ToString( ) ) )%>
                        </td>
                        <td>
                              <%# int.Parse( Eval( "UserID3" ).ToString( ) ) == 0 ? "" : Eval( "Revenue3" ).ToString( )%>
                        </td>
                        <td>
                            <%# GetAccounts( int.Parse( Eval( "UserID4" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# int.Parse( Eval( "UserID4" ).ToString( ) ) == 0 ? "" : Eval( "Revenue4" ).ToString( )%>
                        </td>
                        <td>
                            <%# GetAccounts( int.Parse( Eval( "UserID5" ).ToString( ) ) )%>
                        </td>
                        <td>
                             <%# int.Parse( Eval( "UserID5" ).ToString( ) ) == 0 ? "" : Eval( "Revenue5" ).ToString( )%>
                        </td>
                       
                        <td>
                            <%# Eval( "CollectDate","{0:yyyy-MM-dd HH:mm:ss}" ).ToString( )%>
                        </td>
                    </tr>
                    <tr style="display: none" id="record<%# Eval( "DateID" ).ToString( )+"_"+Eval("UserID").ToString()%>">
                        <td colspan="100" align="left" style="text-align:left;">
                            <table width="70%" border="0" align="center">
                                <tr class="list" align="center">
                                    <td style="font-weight: bold;">
                                        用户名
                                    </td>
                                    <td style="font-weight: bold;">
                                        赢
                                    </td>
                                    <td style="font-weight: bold;">
                                        输
                                    </td>
                                    <td style="font-weight: bold;">
                                        税收
                                    </td>
                                    <td style="font-weight: bold;">
                                        游戏时长(秒)
                                    </td>
                                </tr>
                                <asp:Repeater ID="rptSubData" runat="server">
                                    <ItemTemplate>
                                        <tr class="list" align="center">
                                            <td style="font-weight: bold;">
                                                <%# GetAccounts(int.Parse(Eval("UserID").ToString())) %>
                                            </td>
                                            <td style="font-weight: bold;">
                                                <%# Eval( "WinScore" ).ToString( )%>
                                            </td>
                                            <td style="font-weight: bold;">
                                                <%# Eval( "LostScore" ).ToString( )%>
                                            </td>
                                            <td style="font-weight: bold;">
                                                <%# Eval( "Revenue" ).ToString( )%>
                                            </td>
                                            <td>
                                                <%# Eval( "PlayTimeCount" ).ToString( )%>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%# Game.Facade.Fetch.ShowDate( int.Parse( Eval( "DateID" ).ToString( ) ) )%>
                            &nbsp;<img id="<%# Eval( "DateID" ).ToString( )+"_"+Eval("UserID").ToString()%>" src="../../Images/down.gif" style="cursor: pointer"
                                alt="查看贡献玩家的输赢" title="查看贡献玩家的输赢" onclick="showInfo(this)" />
                        </td>
                        <td>
                         <%#GetIsPaidStyle( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                        <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsRecordInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                            <%# GetAccounts( int.Parse( Eval( "UserID" ).ToString( ) ) )%></a>
                        </td>
                        <td>
                            <%# Eval( "Revenue" ).ToString( )%>
                        </td>
                         <td>
                            <%# GetStationName( int.Parse( Eval( "StationID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# Eval( "CompanyRevenue" ).ToString( )%>
                        </td>
                        <td>
                            <%# double.Parse( Eval( "CompanyScale" ).ToString( )).ToString("0%")%>
                        </td>
                        <td>
                            <%# GetAccounts( int.Parse( Eval( "UserID1" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# double.Parse( Eval( "Scale1" ).ToString( ) ) == 0 ? "" : double.Parse( Eval( "Scale1" ).ToString( ) ).ToString( "0%" )%>
                        </td>
                        <td>
                             <%# int.Parse( Eval( "UserID1" ).ToString( ) ) == 0 ? "" : Eval( "Revenue1" ).ToString( )%>
                        </td>
                        <td>
                            <%# GetAccounts( int.Parse( Eval( "UserID2" ).ToString( ) ) )%>
                        </td>
                        <td>
                              <%# int.Parse( Eval( "UserID2" ).ToString( ) ) == 0 ? "" : Eval( "Revenue2" ).ToString( )%>
                        </td>
                        <td>
                            <%# GetAccounts( int.Parse( Eval( "UserID3" ).ToString( ) ) )%>
                        </td>
                        <td>
                              <%# int.Parse( Eval( "UserID3" ).ToString( ) ) == 0 ? "" : Eval( "Revenue3" ).ToString( )%>
                        </td>
                        <td>
                            <%# GetAccounts( int.Parse( Eval( "UserID4" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# int.Parse( Eval( "UserID4" ).ToString( ) ) == 0 ? "" : Eval( "Revenue4" ).ToString( )%>
                        </td>
                        <td>
                            <%# GetAccounts( int.Parse( Eval( "UserID5" ).ToString( ) ) )%>
                        </td>
                        <td>
                             <%# int.Parse( Eval( "UserID5" ).ToString( ) ) == 0 ? "" : Eval( "Revenue5" ).ToString( )%>
                        </td>
                       
                        <td>
                            <%# Eval( "CollectDate","{0:yyyy-MM-dd HH:mm:ss}" ).ToString( )%>
                        </td>
                    </tr>
                    <tr style="display: none" id="record<%# Eval( "DateID" ).ToString( )+"_"+Eval("UserID").ToString()%>">
                        <td colspan="100" align="left" style="text-align:left;">
                            <table width="70%" border="0" align="center">
                                <tr class="list" align="center">
                                    <td style="font-weight: bold;">
                                        用户名
                                    </td>
                                    <td style="font-weight: bold;">
                                        赢
                                    </td>
                                    <td style="font-weight: bold;">
                                        输
                                    </td>
                                    <td style="font-weight: bold;">
                                        税收
                                    </td>
                                    <td style="font-weight: bold;">
                                        游戏时长(秒)
                                    </td>
                                </tr>
                                <asp:Repeater ID="rptSubData" runat="server">
                                    <ItemTemplate>
                                        <tr class="list" align="center">
                                            <td style="font-weight: bold;">
                                                <%# GetAccounts(int.Parse(Eval("UserID").ToString())) %>
                                            </td>
                                            <td style="font-weight: bold;">
                                                <%# Eval( "WinScore" ).ToString( )%>
                                            </td>
                                            <td style="font-weight: bold;">
                                                <%# Eval( "LostScore" ).ToString( )%>
                                            </td>
                                            <td style="font-weight: bold;">
                                                <%# Eval( "Revenue" ).ToString( )%>
                                            </td>
                                            <td>
                                                <%# Eval( "PlayTimeCount" ).ToString( )%>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </table>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
            </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
        </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="right" class="page">
                <gsp:AspNetPager ID="anpPage" onpagechanged="anpPage_PageChanged" runat="server" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="20" NextPageText="下页"
                    PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table" NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
                    UrlPaging="false">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

<script type="text/javascript">
    function showInfo(obj) {
        var ID = "record" + obj.id;
        if (document.getElementById(ID).style.display == "none") {
            document.getElementById(ID).style.display = "";
            obj.src = "../../Images/up.gif"
        }
        else {
            document.getElementById(ID).style.display = "none";
            obj.src = "../../Images/down.gif"
        }
    }
</script>


