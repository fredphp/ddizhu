<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MatchList.aspx.cs" Inherits="MTEwin.Module.AppManager.MatchList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
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
            <td width="19" height="25" valign="top"  class="Lpd10"><div class="arr"></div></td>
            <td width="1232" height="25" valign="top" align="left">你当前位置：游戏系统 - 比赛管理</td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 80px">
                比赛查询：
            </td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="text"></asp:TextBox>                    
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" 
                    onclick="btnQuery_Click" />      
            </td>
        </tr>
    </table>     
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
        <tr>
            <td height="39" class="titleOpBg">
                <input type="button" value="新增" class="btn wd1" onclick="Redirect('MatchInfo.aspx?cmd=add')" />
                <input class="btnLine" type="button" /> 
                <asp:Button ID="btnDelete" runat="server" Text="删除" CssClass="btn wd1" 
                    onclick="btnDelete_Click" OnClientClick="return deleteop1()" />        
            </td>
        </tr>
    </table>  
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list1">
            <tr height="30"><td style="font-size:14px; font-weight:bold;">定时赛</td></tr>
            <tr align="center" class="bold">
                <td style="width:30px;" class="listTitle"><input type="checkbox" name="chkAll" onclick="SelectAll1(this.checked);" /></td>
                <td class="listTitle2">修改</td> 
                <td class="listTitle2">房间名称</td>
                <td class="listTitle2">开始日期</td>
                <td class="listTitle2">结束日期</td>
                <td class="listTitle2">开始时间</td>
                <td class="listTitle2">结束时间</td>
                <td class="listTitle2">是否需要报名</td> 
                <td class="listTitle2">报名费用</td> 
            </tr>
            <asp:Repeater ID="repeaterOnTime" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                    onmouseout="this.style.backgroundColor=currentcolor">
                        <td><input name='cid1' type='checkbox' value='<%# Eval("MatchOnTimeID")%>'/></td>  
                        <td><a class="l" href="MatchInfo.aspx?cmd=edit&type=ontime&param=<%#Eval("MatchOnTimeID") %>">修改</a></td> 
                        <td> <%# GetGameRoomName(int.Parse(Eval("ServerID").ToString()))%></td>
                        <td><%# Eval("MatchBeginDate").ToString().Split(' ')[0]%></td>
                        <td><%# Eval("MatchEndDate").ToString().Split(' ')[0]%></td>
                        <td><%# Eval("MatchBeginTime").ToString().Split(' ')[1]%></td>
                        <td><%# Eval("MatchEndTime").ToString().Split(' ')[1]%></td>
                        <td><%# GetSign(int.Parse(Eval("NeedSign").ToString()))%></td>
                        <td><%# int.Parse(Eval("NeedSign").ToString()) == 0 ? "-" : Eval("SignPrice")%></td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                    onmouseout="this.style.backgroundColor=currentcolor">                        
                        <td><input name='cid1' type='checkbox' value='<%# Eval("MatchOnTimeID")%>'/></td>   
                        <td><a class="l" href="MatchInfo.aspx?cmd=edit&type=ontime&param=<%#Eval("MatchOnTimeID") %>">修改</a></td> 
                        <td> <%# GetGameRoomName(int.Parse(Eval("ServerID").ToString()))%></td>
                        <td><%# Eval("MatchBeginDate").ToString().Split(' ')[0]%></td>
                        <td><%# Eval("MatchEndDate").ToString().Split(' ')[0]%></td>
                        <td><%# Eval("MatchBeginTime").ToString().Split(' ')[1]%></td>
                        <td><%# Eval("MatchEndTime").ToString().Split(' ')[1]%></td>
                        <td><%# GetSign(int.Parse(Eval("NeedSign").ToString()))%></td>
                        <td><%# int.Parse(Eval("NeedSign").ToString()) == 0 ? "-" : Eval("SignPrice")%></td>
                    </tr>
                </AlternatingItemTemplate>
            </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData1" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
            <tr>
            <td class="listTitleBg"><span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll1(true);">全部</a>&nbsp;-&nbsp;<a class="l1" href="javascript:SelectAll1(false);">无</a></td>                
            <td align="right" colspan="8" class="page">                
                <gsp:AspNetPager ID="anpage1" runat="server" onpagechanged="anpage1_PageChanged" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="7" 
                    NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table" NumericButtonCount="5"
                    CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%" Width="100%">
                </gsp:AspNetPager>
            </td>
        </tr>
        </table>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
            <tr height="65"><td style="font-size:14px; font-weight:bold; vertical-align:bottom; padding-bottom:8px;">即时赛</td></tr>
            <tr align="center" class="bold">
                <td style="width:30px;" class="listTitle"><input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" /></td>
                <td style="width:150px;" class="listTitle2">比赛名称</td>
                <td class="listTitle2">房间名称</td>
                <td class="listTitle2">开始时间</td>
                <td class="listTitle2">结束时间</td>
                <td class="listTitle2">比赛状态</td>
                <td class="listTitle2">是否需要报名</td> 
                <td class="listTitle2">报名费用</td>               
            </tr>
            <asp:Repeater ID="rptDataBase" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                    onmouseout="this.style.backgroundColor=currentcolor">
                        <td><input name='cid' type='checkbox' value='<%# Eval("MatchID")%>'/></td>      
                        <td>                             
                            <a class="l" href="MatchInfo.aspx?cmd=edit&type=match&param=<%#Eval("MatchID") %>"><%# Eval("MatchName").ToString() %></a>              
                        </td>                
                        <td> <%# GetGameRoomName(int.Parse(Eval("ServerID").ToString()))%></td>
                        <td><%# Eval("MatchBeginTime")%></td>
                        <td><%# Eval("MatchEndTime")%></td>
                        <td><%# GetMatchStatus(int.Parse(Eval("Status").ToString()))%></td>
                        <td><%# GetSign(int.Parse(Eval("NeedSign").ToString())) %></td>
                        <td><%# int.Parse(Eval("NeedSign").ToString())==0?"-":Eval("SignPrice") %></td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                    onmouseout="this.style.backgroundColor=currentcolor">                        
                        <td><input name='cid' type='checkbox' value='<%# Eval("MatchID")%>'/></td>      
                        <td>                             
                            <a class="l" href="MatchInfo.aspx?cmd=edit&type=match&param=<%#Eval("MatchID") %>"><%# Eval("MatchName").ToString() %></a>              
                        </td>                
                        <td> <%# GetGameRoomName(int.Parse(Eval("ServerID").ToString()))%></td>
                        <td><%# Eval("MatchBeginTime")%></td>
                        <td><%# Eval("MatchEndTime")%></td>
                        <td><%# GetMatchStatus(int.Parse(Eval("Status").ToString()))%></td>
                        <td><%# GetSign(int.Parse(Eval("NeedSign").ToString())) %></td>
                        <td><%# int.Parse(Eval("NeedSign").ToString())==0?"-":Eval("SignPrice") %></td>
                    </tr>
                </AlternatingItemTemplate>
            </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
            <tr>
            <td class="listTitleBg"><span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a class="l1" href="javascript:SelectAll(false);">无</a></td>                
            <td align="right" colspan="7" class="page">                
                <gsp:AspNetPager ID="anpNews" runat="server" onpagechanged="anpNews_PageChanged" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="7" 
                    NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table" NumericButtonCount="5"
                    CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%" Width="100%">
                </gsp:AspNetPager>
            </td>
        </tr>
        </table>
    </div> 
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
        <tr>
            <td height="39" class="titleOpBg">
                <input type="button" value="新增" class="btn wd1" onclick="Redirect('MatchInfo.aspx?cmd=add')" />
                <input class="btnLine" type="button" /> 
                <asp:Button ID="btnDelete2" runat="server" Text="删除" CssClass="btn wd1" 
                    onclick="btnDelete_Click" OnClientClick="return deleteop1()" />                    
            </td>
        </tr>
    </table>  
    </form>
</body>
</html>


