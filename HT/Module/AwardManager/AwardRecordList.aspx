<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AwardRecordList.aspx.cs" Inherits="MTEwin.Module.AwardManager.AwardRecordList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
     <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top"  class="Lpd10"><div class="arr"></div></td>
            <td width="1232" height="25" valign="top" align="left">你当前位置：奖品系统 - 兑奖记录</td>
        </tr>
    </table>
    <!-- 头部菜单 End -->   
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 80px">
                日期查询：
            </td>
            <td>
                <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />      
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
                单号查询：
            </td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="text"></asp:TextBox> 
                <asp:DropDownList ID="ddlOrderStatus" runat="server">
                    <asp:ListItem Value="-1" Text="兑换状态"></asp:ListItem>
                    <asp:ListItem Value="0" Text="新订单"></asp:ListItem>
                    <asp:ListItem Value="1" Text="已发货"></asp:ListItem>
                    <asp:ListItem Value="2" Text="已收货"></asp:ListItem>
                    <asp:ListItem Value="3" Text="申请退货"></asp:ListItem>
                    <asp:ListItem Value="4" Text="已退货"></asp:ListItem>
                </asp:DropDownList>                  
                <asp:Button ID="btnQueryOrder" runat="server" Text="查询" CssClass="btn wd1" 
                    onclick="btnQueryOrder_Click" />      
            </td>
        </tr>
    </table>     
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7" id="list">
            <tr align="center" class="bold">
                <td style="width:100px;" class="listTitle2">管理</td>
                <td class="listTitle2">兑换单号</td>
                <td class="listTitle2">用户</td>     
                <td class="listTitle2">奖品名称</td>         
                <td class="listTitle2">奖品价格</td>         
                <td class="listTitle2">奖品数量</td>         
                <td class="listTitle2">邮资</td>         
                <td class="listTitle2">付款金额</td>               
                <td class="listTitle2">兑换状态</td>       
                <td class="listTitle2">兑换日期</td>         
                <td class="listTitle1">兑换地址</td>         
            </tr>
            <asp:Repeater ID="rptAwardRecord" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                    onmouseout="this.style.backgroundColor=currentcolor">    
                        <td>                             
                            <a class="l" href="AwardRecordInfo.aspx?id=<%#Eval("RecordID") %>">处理</a>              
                        </td>                
                        <td><%# Eval("OrderID")%></td>
                        <td><%# GetAccounts((int)Eval("UserID"))%></td>
                        <td><%# GetAwardName((int)Eval("AwardID"))%></td>
                        <td><%# Eval("AwardPrice")%></td>
                        <td><%# Eval("AwardCount")%></td>
                        <td><%# Eval("Postage")%></td>
                        <td><%# Eval("PayPrice")%></td>
                        <td><%# GetOrderStatus((int)Eval("OrderStatus"))%></td>
                        <td><%# Eval("BuyDate")%></td>
                        <td><%# Eval("BuyIP")%></td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                    onmouseout="this.style.backgroundColor=currentcolor">                            
                        <td>                             
                            <a class="l" href="AwardRecordInfo.aspx?id=<%#Eval("RecordID") %>">处理</a>              
                        </td>                
                        <td><%# Eval("OrderID")%></td>
                        <td><%# GetAccounts((int)Eval("UserID"))%></td>
                        <td><%# GetAwardName((int)Eval("AwardID"))%></td>
                        <td><%# Eval("AwardPrice")%></td>
                        <td><%# Eval("AwardCount")%></td>
                        <td><%# Eval("Postage")%></td>
                        <td><%# Eval("PayPrice")%></td>
                        <td><%# GetOrderStatus((int)Eval("OrderStatus"))%></td>
                        <td><%# Eval("BuyDate")%></td>
                        <td><%# Eval("BuyIP")%></td>
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
    </form>
</body>
</html>

