<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AndroidList.aspx.cs" Inherits="MTEwin.Module.AccountManager.AndroidList" %>

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
            <td width="1232" height="25" valign="top" align="left">你当前位置：用户系统 - 机器人管理</td>
        </tr>
    </table>
    <!-- 头部菜单 End -->   
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 80px">
                日期查询：
            </td>
            <td>
                <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',skin:'whyGreen',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',skin:'whyGreen',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" /> <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />      
                <asp:Button ID="btnQueryTD" runat="server" Text="今天" CssClass="btn wd1" 
                    onclick="btnQueryTD_Click" />   
                <asp:Button ID="btnQueryYD" runat="server" Text="昨天" CssClass="btn wd1" 
                    onclick="btnQueryYD_Click" />   
                <asp:Button ID="btnQueryTW" runat="server" Text="本周" CssClass="btn wd1" 
                    onclick="btnQueryTW_Click" />   
                <asp:Button ID="btnQueryYW" runat="server" Text="上周" CssClass="btn wd1" 
                    onclick="btnQueryYW_Click" />             
            </td>
        </tr>
    </table>  
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg Tmg7">
        <tr>
            <td class="listTdLeft" style="width: 80px">
                用户查询：
            </td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="text"></asp:TextBox>     
                <asp:DropDownList ID="ddlNullity" runat="server">
                    <asp:ListItem Value="-1" Text="全部状态"></asp:ListItem>
                    <asp:ListItem Value="0" Text="启用"></asp:ListItem>
                    <asp:ListItem Value="1" Text="禁用"></asp:ListItem>
                </asp:DropDownList>     
                <asp:DropDownList ID="ddlServerID" runat="server">
                </asp:DropDownList>                       
                <asp:Button ID="btnQueryAcc" runat="server" Text="查询" CssClass="btn wd1" 
                    onclick="btnQueryAcc_Click" />      
            </td>
        </tr>
    </table>     
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
        <tr>
            <td height="39" class="titleOpBg">
                <input type="button" value="新增" class="btn wd1" onclick="Redirect('AndroidAdd.aspx')" />                
                <asp:Button ID="btnDelete" runat="server" Text="删除" CssClass="btn wd1" 
                    onclick="btnDelete_Click" OnClientClick="return deleteop()" />    
                <input class="btnLine" type="button" /> 
                <asp:Button ID="btnDongjie" runat="server" Text="冻结" CssClass="btn wd1" OnClick="btnDongjie_Click" OnClientClick="return deleteop()" />
                <asp:Button ID="btnJiedong" runat="server" Text="解冻" CssClass="btn wd1" OnClick="btnJiedong_Click" OnClientClick="return deleteop()" />              
            </td>
        </tr>
    </table>  
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
            <tr align="center" class="bold">
                <td style="width:30px;" class="listTitle"><input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" /></td>
                <td style="width:100px;" class="listTitle2">管理</td>
                <td class="listTitle2">创建时间</td>
                <td class="listTitle2">用户帐号</td>     
                <td class="listTitle2">房间</td>         
                <td class="listTitle2">最少局数</td>         
                <td class="listTitle2">最大局数</td>         
                <td class="listTitle2">最少分数</td>         
                <td class="listTitle2">最高分数</td>               
                <td class="listTitle2">最少休息</td>       
                <td class="listTitle2">最大休息</td>                        
                <td class="listTitle2">服务类型</td>       
                <td class="listTitle2">状态</td>
                <td class="listTitle1">地址信息</td>                                       
            </tr>
            <asp:Repeater ID="rptAndroid" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                    onmouseout="this.style.backgroundColor=currentcolor">    
                        <td><input name='cid' type='checkbox' value='<%# Eval("UserID")%>'/></td>    
                        <td>                             
                            <a class="l" href="AndroidInfo.aspx?id=<%#Eval("UserID") %>">配置</a>              
                        </td>                     
                        <td><%# Eval("CreateDate")%></td>
                        <td>
                            <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                                <%# GetAccounts((int)Eval("UserID"))%></a>
                        </td>
                        <td><%# GetGameRoomName((int)Eval("ServerID"))%></td>
                        <td><%# Eval("MinPlayDraw")%></td>
                        <td><%# Eval("MaxPlayDraw")%></td>
                        <td><%# Eval("MinTakeScore")%></td>
                        <td><%# Eval("MaxTakeScore")%></td>
                        <td><%# Eval("MinReposeTime")%></td>
                        <td><%# Eval("MaxReposeTime")%></td>
                        <td><%# Eval("ServiceGender")%></td>
                        <td><%# GetNullityStatus((byte)Eval("Nullity"))%></td>
                        <td><%# Eval("AndroidNote")%></td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                    onmouseout="this.style.backgroundColor=currentcolor">                            
                        <td><input name='cid' type='checkbox' value='<%# Eval("UserID")%>'/></td>    
                        <td>                             
                            <a class="l" href="AndroidInfo.aspx?id=<%#Eval("UserID") %>">配置</a>              
                        </td>                     
                        <td><%# Eval("CreateDate")%></td>
                        <td>
                            <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,600);">
                                <%# GetAccounts((int)Eval("UserID"))%></a>
                        </td>
                        <td><%# GetGameRoomName((int)Eval("ServerID"))%></td>
                        <td><%# Eval("MinPlayDraw")%></td>
                        <td><%# Eval("MaxPlayDraw")%></td>
                        <td><%# Eval("MinTakeScore")%></td>
                        <td><%# Eval("MaxTakeScore")%></td>
                        <td><%# Eval("MinReposeTime")%></td>
                        <td><%# Eval("MaxReposeTime")%></td>
                        <td><%# Eval("ServiceGender")%></td>
                        <td><%# GetNullityStatus((byte)Eval("Nullity"))%></td>
                        <td><%# Eval("AndroidNote")%></td>
                    </tr>
                </AlternatingItemTemplate>
            </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
        </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="listTitleBg"><span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a class="l1" href="javascript:SelectAll(false);">无</a></td>                
            <td align="right" class="page">                
                <gsp:AspNetPager ID="anpNews" runat="server" onpagechanged="anpNews_PageChanged" AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="20" 
                    NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table" NumericButtonCount="5"
                    CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>  
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
        <tr>
            <td height="39" class="titleOpBg">
                <input type="button" value="新增" class="btn wd1" onclick="Redirect('AndroidAdd.aspx')" />
                <asp:Button ID="Button1" runat="server" Text="删除" CssClass="btn wd1" 
                    onclick="btnDelete_Click" OnClientClick="return deleteop()" />      
                <input class="btnLine" type="button" />
                <asp:Button ID="btnDongjie1" runat="server" Text="冻结" CssClass="btn wd1" OnClick="btnDongjie_Click" OnClientClick="return deleteop()" />
                <asp:Button ID="btnJiedong1" runat="server" Text="解冻" CssClass="btn wd1" OnClick="btnJiedong_Click" OnClientClick="return deleteop()" />          
            </td>
        </tr>
    </table>  
    </form>
</body>
</html>

