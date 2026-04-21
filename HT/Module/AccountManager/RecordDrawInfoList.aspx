<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecordDrawInfoList.aspx.cs" Inherits="MTEwin.Module.AccountManager.RecordDrawInfoList" %>

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
                <td width="1232" height="25" valign="top" align="left">你当前位置：用户系统 - 游戏记录
                </td>
            </tr>
        </table>
        <!-- 头部菜单 End -->
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
            <tr>
                <td class="listTdLeft" style="width: 80px">日期查询：
                </td>
                <td>
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd4" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                        src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                        style="cursor: pointer; vertical-align: middle" />
                    至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd4" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                    <asp:DropDownList ID="ddl_gametype" runat="server">
                    </asp:DropDownList>
                    <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
                    <asp:Button ID="btnQueryTD" runat="server" Text="今天" CssClass="btn wd1" OnClick="btnQueryTD_Click" />
                    <asp:Button ID="btnQueryYD" runat="server" Text="昨天" CssClass="btn wd1" OnClick="btnQueryYD_Click" />
                    <asp:Button ID="btnQueryTW" runat="server" Text="本周" CssClass="btn wd1" OnClick="btnQueryTW_Click" />
                    <asp:Button ID="btnQueryYW" runat="server" Text="上周" CssClass="btn wd1" OnClick="btnQueryYW_Click" />
                </td>
            </tr>
        </table>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input type="button" value="关闭" class="btn wd1" onclick="window.close();" />
                    <b style="color: #fff"><%="总赢:"+AllWIn+"|总输：" + AllLose+"|总税收："+AllRevenue%>     </b>
                </td>
            </tr>
        </table>
        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
                <tr align="center" class="bold">
                    <td class="listTitle2">开始时间
                    </td>
                    <td class="listTitle2">结束时间
                    </td>
                    <td class="listTitle2">游戏时长
                    </td>
                    <td class="listTitle2">游戏
                    </td>
                    <td class="listTitle">房间
                    </td>
                    <td class="listTitle">税收
                    </td>
                    <td class="listTitle">幸运币
                    </td>
                    <td class="listTitle">桌子人数
                    </td>
                    <td class="listTitle" align="left">游戏记录
                    </td>
                </tr>
                <asp:Repeater ID="rptDataList" runat="server" OnItemDataBound="rptDataList_ItemDataBound">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor" data-drawinfo="<%# Eval( "drawinfo" ).ToString( ).Replace("\"","'")%>">
                            <td>
                                <%# Eval( "StartTime", "{0:yyyy-MM-dd HH:mm:ss}" )%>
                             &nbsp;<img id="<%# Eval( "DrawID" ).ToString( )%>" src="../../Images/down.gif" style="cursor: pointer" alt="查看同桌玩家" title="查看同桌玩家"
                                 onclick="showInfo(this)" />
                            </td>
                            <td>
                                <%# Eval( "ConcludeTime", "{0:yyyy-MM-dd HH:mm:ss}" )%>
                            </td>
                            <td>
                                <%#Game.Facade.Fetch.GetTimeSpan( Convert.ToDateTime( Eval( "StartTime" ) ), Convert.ToDateTime( Eval( "ConcludeTime" ) ) )%>
                            </td>
                            <td>
                                <%#GetGameKindName(int.Parse( Eval( "KindID" ).ToString( )))%>
                            </td>
                            <td>
                                <%# GetGameRoomName(int.Parse( Eval( "ServerID" ).ToString( )))%>
                            </td>
                            <td>
                                <%# Eval( "Revenue" ).ToString( )%>
                            </td>
                            <td>
                                <%# Eval( "UserMedal" ).ToString( )%>
                            </td>
                            <td>
                                <%# Eval( "UserCount" ).ToString( )%>
                         
                            </td>
                            <td align="left">
                                <a href="javascript:void(0)" onclick="showdrawinfo('record<%# Eval( "DrawID" ).ToString( )%>');">游戏信息</a>
                            </td>
                        </tr>
                        <tr style="display: none" id="record<%# Eval( "DrawID" ).ToString( )%>">
                            <td colspan="100" align="left">
                                <table width="70%" style="max-width: 1000px" border="0" align="left">
                                    <tr class="list" align="left">
                                        <td style="font-weight: bold;">用户名
                                        </td>
                                        <td style="font-weight: bold;">输赢金额
                                        </td>
                                        <td style="font-weight: bold;">税收
                                        </td>
                                        <td style="font-weight: bold;">幸运币
                                        </td>
                                        <td style="font-weight: bold;">椅子编号
                                        </td>
                                    </tr>
                                    <asp:Repeater ID="rptSubData" runat="server">
                                        <ItemTemplate>
                                            <tr class="list" align="left">
                                                <td style="font-weight: bold;">
                                                    <%#GetAccounts(int.Parse( Eval( "UserID" ).ToString( )))%>
                                                </td>
                                                <td style="font-weight: bold;">
                                                    <%# Eval( "Score" ).ToString( )%>
                                                </td>
                                                <td style="font-weight: bold;">
                                                    <%# Eval( "Revenue" ).ToString( )%>
                                                </td>
                                                <td style="font-weight: bold;">
                                                    <%# Eval( "UserMedal" ).ToString( )%>
                                                </td>
                                                <td style="font-weight: bold;">
                                                    <%# Eval( "ChairID" ).ToString( )%>
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
                            onmouseout="this.style.backgroundColor=currentcolor" data-drawinfo="<%# Eval( "drawinfo" ).ToString( ).Replace("\"","'")%>">
                            <td>
                                <%# Eval( "StartTime", "{0:yyyy-MM-dd HH:mm:ss}" )%>
                             &nbsp;<img id="<%# Eval( "DrawID" ).ToString( )%>" src="../../Images/down.gif" style="cursor: pointer" alt="查看同桌玩家" title="查看同桌玩家"
                                 onclick="showInfo(this)" />
                            </td>
                            <td>
                                <%# Eval( "ConcludeTime", "{0:yyyy-MM-dd HH:mm:ss}" )%>
                            </td>
                            <td>
                                <%#Game.Facade.Fetch.GetTimeSpan( Convert.ToDateTime( Eval( "StartTime" ) ), Convert.ToDateTime( Eval( "ConcludeTime" ) ) )%>
                            </td>
                            <td>
                                <%#GetGameKindName(int.Parse( Eval( "KindID" ).ToString( )))%>
                            </td>
                            <td>
                                <%# GetGameRoomName(int.Parse( Eval( "ServerID" ).ToString( )))%>
                            </td>
                            <td>
                                <%# Eval( "Revenue" ).ToString( )%>
                            </td>
                            <td>
                                <%# Eval( "UserMedal" ).ToString( )%>
                            </td>
                            <td>
                                <%# Eval( "UserCount" ).ToString( )%>
                           
                            </td>
                            <td align="left">
                                <a href="javascript:void(0)" onclick="showdrawinfo('record<%# Eval( "DrawID" ).ToString( )%>');">游戏信息</a>
                            </td>
                        </tr>
                        <tr style="display: none" id="record<%# Eval( "DrawID" ).ToString( )%>">
                            <td colspan="100" align="left">
                                <table width="70%" style="max-width: 1000px" border="0" align="left">
                                    <tr class="list" align="left">
                                        <td style="font-weight: bold;">用户名
                                        </td>
                                        <td style="font-weight: bold;">输赢金额
                                        </td>
                                        <td style="font-weight: bold;">税收
                                        </td>
                                        <td style="font-weight: bold;">幸运币
                                        </td>
                                        <td style="font-weight: bold;">椅子编号
                                        </td>
                                    </tr>
                                    <asp:Repeater ID="rptSubData" runat="server">
                                        <ItemTemplate>
                                            <tr class="list" align="left">
                                                <td style="font-weight: bold;">
                                                    <%#GetAccounts(int.Parse( Eval( "UserID" ).ToString( )))%>
                                                </td>
                                                <td style="font-weight: bold;">
                                                    <%# Eval( "Score" ).ToString( )%>
                                                </td>
                                                <td style="font-weight: bold;">
                                                    <%# Eval( "Revenue" ).ToString( )%>
                                                </td>
                                                <td style="font-weight: bold;">
                                                    <%# Eval( "UserMedal" ).ToString( )%>
                                                </td>
                                                <td style="font-weight: bold;">
                                                    <%# Eval( "ChairID" ).ToString( )%>
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
                    <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="20" NextPageText="下页"
                        PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table" NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
                        UrlPaging="false">
                    </gsp:AspNetPager>
                </td>
            </tr>
        </table>
    </form>
    <style type="text/css">
        .showdinfo { display: none; position: absolute; top: 0%; left: 0%; width: 100%; height: 100%; background-color: black; z-index: 1001; -moz-opacity: 0.7; opacity: .70; filter: alpha(opacity=70); }
        .content { display: none; position: absolute; top: 10px; left: 22%; width: 60%; background-color: #fff; z-index: 1002; border: 2px solid #000; }
        /*.content ul{width:80%;max-width:1000px;margin:0 auto;  background-color: #fff;   z-index:1003; border: 2px solid #733c5f;  padding:  30px;}
    .content li{list-style:none;display:table;margin:0 auto;width:100%;color:red  }*/
        .content table { width: 90%; max-width: 1000px; margin: 0 auto; background-color: #fff; z-index: 1003; border: 1px solid #733c5f; padding: 30px; }
        .content tr { list-style: none; display: table; margin: 0 auto; width: 100%; color: red; }
        .content td { border: 1px solid #000; }
        .palyer { padding-bottom: 20px; margin-bottom: 10px; }
        .tit { background: #e3e3e3; color: #000 !important; font-weight: bold; }
    </style>
    <div id="showdinfo" class="showdinfo">
        <b style="color: #fff; margin: 10px;">点击灰色区域关闭</b>
    </div>
    <div class="content" id="showcontent">
    </div>


</body>
</html>
<script src="../../scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
<script type="text/javascript">
    function showInfo(obj) {
        var ID="record"+obj.id;
        if(document.getElementById(ID).style.display=="none") {
            document.getElementById(ID).style.display="";
            obj.src="../../Images/up.gif"
        }
        else {
            document.getElementById(ID).style.display="none";
            obj.src="../../Images/down.gif"
        }
    }
    $("#showcontent").click(function(e) {
        e.stopPropagation();
        e.preventDefault();
        return false;
    })
    $("#showdinfo").click(function() {
        $("#showdinfo").attr("style","display:none");
        $("#showcontent").attr("style","display:none");
    })

    function showdrawinfo(e) {
        var drawinfo=$("#"+e).prev().attr("data-drawinfo").replace(/'/g,"\"");
        if(drawinfo.length<=0) { alert("没有信息"); return; }
        var obj=eval("("+drawinfo+")");
        if(obj.r.k==undefined) { alert("信息格式不正确"); return; }

        var c=$("#showcontent");
        c.html("");
        var s=$("#showdinfo");
        s.attr("style","display:block");
        c.attr("style","display:block");

        var res=" <table width='100%'cellpadding='2' cellspacing='0'>    <tr  class='tit'  width='100%'>        <td width='20%'>系统开牌</td>        <td width='50%'>总下注</td>        <td  width='30%'>总成绩</td>    </tr>       "+
        "<tr>        <td width='20%'>"+replaceKey(obj.r.k).replace(/:/g,"")+" </td>        <td  width='50%'>"+replaceKey(obj.r.x)+" </td>        <td> "+replaceKey(((obj.r.c)?obj.r.c:"--"))+"</td>    </tr>"+
        "       <tr class='tit'  >        <td width='20%'>玩家</td>        <td width='40%'>下注</td>        <td width='40%'>成绩</td>    </tr>    ";


        $.each(obj.p,function(ind,e) { res+="     <tr>        <td width='20%'>["+e.n+"]</td>        <td  width='40%'>"+replaceKey(e.x)+" </td>        <td width='40%'>"+replaceKey(e.c||"0")+" </td>    </tr>"; });

        res+="     </table>";


        c.append(res);
        if(s.height()<c.height()) s.height(c.height()+20);

    }

    var arrkey=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","Y","Z","T","U","V","W","X","①","②","③"];

    var arrval=[" 黑桃: "," 红桃: "," 梅花: "," 方块: "," 大小王: "," 上门: "," 天门: "," 下门"," 上天桥: "," 上下桥: "," 天下桥: "," 庄: "," 庄对: "," 庄天王: "," 闲: "," 闲对: "," 闲天王: "," 平: "," 同点平: "," 结果得分: "," 税收: "," 奔驰X40"," 宝马X30"," 奥迪X20 "," 大众X10 "," 奔驰X5 "," 宝马X5 "," 奥迪X5 "," 大众X5 "];

    function replaceKey(a) { return a.replace(/([A-Z①②③])/g,function(m,r) { return arrval[arrkey.indexOf(r)] }) }
</script>


