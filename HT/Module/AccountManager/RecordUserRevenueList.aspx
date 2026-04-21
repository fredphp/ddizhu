<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecordUserRevenueList.aspx.cs" Inherits="MTEwin.Module.AccountManager.RecordUserRevenueList" %>

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
                我的抽水：
            </td>
            <td>
             <asp:Literal ID="ltRevenueTotal" runat="server"></asp:Literal>
            <input class="btnLine" type="button" />    
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
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="关闭" class="btn wd1" onclick="window.close();" />
            </td>
        </tr>
    </table>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
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
                    比例
                </td>
                <td class="listTitle2">
                    我的抽水
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
                            <%# GetAccounts( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# Eval( "Revenue" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "UserID1" ).ToString( ).Equals(IntParam.ToString())? double.Parse( Eval( "Scale1" ).ToString()).ToString( "0%"):""%>
                            <%# Eval( "UserID2" ).ToString( ).Equals(IntParam.ToString())? double.Parse( Eval( "Scale2" ).ToString()).ToString( "0%"):""%>
                            <%# Eval( "UserID3" ).ToString( ).Equals(IntParam.ToString())? double.Parse( Eval( "Scale3" ).ToString()).ToString( "0%"):""%>
                            <%# Eval( "UserID4" ).ToString( ).Equals(IntParam.ToString())? double.Parse( Eval( "Scale4" ).ToString()).ToString( "0%"):""%>
                            <%# Eval( "UserID5" ).ToString( ).Equals( IntParam.ToString( ) ) ? double.Parse( Eval( "Scale5" ).ToString( ) ).ToString( "0%" ) : ""%>
                        </td>
                        <td>
                            <%# Eval( "UserID1" ).ToString( ).Equals( IntParam.ToString( ) ) ?   double.Parse( Eval( "Revenue1" ).ToString( )  ).ToString( ) : ""%>
                            <%# Eval( "UserID2" ).ToString( ).Equals( IntParam.ToString( ) ) ?   double.Parse( Eval( "Revenue2" ).ToString( )  ).ToString( ) : ""%>
                            <%# Eval( "UserID3" ).ToString( ).Equals( IntParam.ToString( ) ) ?   double.Parse( Eval( "Revenue3" ).ToString( )  ).ToString( ) : ""%>
                            <%# Eval( "UserID4" ).ToString( ).Equals( IntParam.ToString( ) ) ?   double.Parse( Eval( "Revenue4" ).ToString( )  ).ToString( ) : ""%>
                            <%# Eval( "UserID5" ).ToString( ).Equals( IntParam.ToString( ) ) ?   double.Parse( Eval( "Revenue5" ).ToString( )  ).ToString( ) : ""%>
                        </td>
                        <td>
                            <%# Eval( "CollectDate","{0:yyyy-MM-dd HH:mm:ss}" ).ToString( )%>
                        </td>
                    </tr>
                    <tr style="display: none" id="record<%# Eval( "DateID" ).ToString( )+"_"+Eval("UserID").ToString()%>">
                        <td colspan="100">
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
                            <%# GetAccounts( int.Parse( Eval( "UserID" ).ToString( ) ) )%>
                        </td>
                        <td>
                            <%# Eval( "Revenue" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "UserID1" ).ToString( ).Equals(IntParam.ToString())? double.Parse( Eval( "Scale1" ).ToString()).ToString( "0%"):""%>
                            <%# Eval( "UserID2" ).ToString( ).Equals(IntParam.ToString())? double.Parse( Eval( "Scale2" ).ToString()).ToString( "0%"):""%>
                            <%# Eval( "UserID3" ).ToString( ).Equals(IntParam.ToString())? double.Parse( Eval( "Scale3" ).ToString()).ToString( "0%"):""%>
                            <%# Eval( "UserID4" ).ToString( ).Equals(IntParam.ToString())? double.Parse( Eval( "Scale4" ).ToString()).ToString( "0%"):""%>
                            <%# Eval( "UserID5" ).ToString( ).Equals( IntParam.ToString( ) ) ? double.Parse( Eval( "Scale5" ).ToString( ) ).ToString( "0%" ) : ""%>
                        </td>
                        <td>
                           <%# Eval( "UserID1" ).ToString( ).Equals( IntParam.ToString( ) ) ?   double.Parse( Eval( "Revenue1" ).ToString( )  ).ToString( ) : ""%>
                            <%# Eval( "UserID2" ).ToString( ).Equals( IntParam.ToString( ) ) ?   double.Parse( Eval( "Revenue2" ).ToString( )  ).ToString( ) : ""%>
                            <%# Eval( "UserID3" ).ToString( ).Equals( IntParam.ToString( ) ) ?   double.Parse( Eval( "Revenue3" ).ToString( )  ).ToString( ) : ""%>
                            <%# Eval( "UserID4" ).ToString( ).Equals( IntParam.ToString( ) ) ?   double.Parse( Eval( "Revenue4" ).ToString( )  ).ToString( ) : ""%>
                            <%# Eval( "UserID5" ).ToString( ).Equals( IntParam.ToString( ) ) ?   double.Parse( Eval( "Revenue5" ).ToString( )  ).ToString( ) : ""%>
                        </td>
                        <td>
                            <%# Eval( "CollectDate","{0:yyyy-MM-dd HH:mm:ss}" ).ToString( )%>
                        </td>
                    </tr>
                    <tr style="display: none" id="record<%# Eval( "DateID" ).ToString( )+"_"+Eval("UserID").ToString()%>">
                        <td colspan="100">
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


