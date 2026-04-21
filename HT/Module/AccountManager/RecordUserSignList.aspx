<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecordUserSignList.aspx.cs" Inherits="MTEwin.Module.AccountManager.RecordUserSignList" %>


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
                你当前位置：用户系统 - 每日签到记录
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 80px">                 
                  用户名：
            </td>
            <td>
             

               
           <asp:TextBox ID="tb_serch" runat="server" CssClass="wd2"></asp:TextBox><input class="btnLine" type="button" /> 
            日期查询：
                  <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                     <asp:DropDownList ID="ddlType" runat="server">
                    <asp:ListItem Value="-1" Text="全部" Selected="True"></asp:ListItem>
                    <asp:ListItem Value="0" Text="签到奖励"></asp:ListItem>
                    <asp:ListItem Value="1" Text="连续奖励"></asp:ListItem>
                    </asp:DropDownList>
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
                <input type="button" value="签到配置" class="btn wd1" onclick="Redirect('UserSignConfig.aspx');" />
                  
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
                    玩家
                </td>
                <td class="listTitle2">
                    领取奖励
                </td>
                <td class="listTitle2">
                    奖励类型
                </td>
                <td class="listTitle2">
                   IP地址
                </td>
                 <td class="listTitle2">
                   MAC地址
                </td>
            </tr> 

            <asp:Repeater ID="rptDataList" runat="server"  >
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%#( (DateTime) Eval( "collectdate" )).ToString() %>
                        </td>
                        <td>
                           <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',950,600);">
                                <%#Game.Utils.TextUtility.CutString( Eval( "Accounts" ).ToString(),0,10)%></a>
                        </td>
                        <td>
                           <%# Eval("signReward").ToString() +( Eval("scoretype").ToString() == "0" ? "金币" : "幸运币")%>
                        </td>
                        <td>
                              <%# Eval("signtype").ToString()=="0"?"签到":"礼包" %>
                            
                        </td>
                        <td>   <%# Eval("ClientIP").ToString()%>
                          </td>
                        <td>
                            <%# Eval("MachineID").ToString()%>
                        </td>
                    </tr>
                  
                </ItemTemplate>
                <AlternatingItemTemplate>
                       <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%#( (DateTime) Eval( "collectdate" )).ToString() %>
                        </td>
                        <td>
                           <a class="l" href="javascript:void(0);" onclick="openWindowOwn('AccountsInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',950,600);">
                                <%#Game.Utils.TextUtility.CutString( Eval( "Accounts" ).ToString(),0,10)%></a>
                        </td>
                        <td>
                            <%# Eval("signReward").ToString() +( Eval("scoretype").ToString() == "0" ? "金币" : "幸运币")%>
                        </td>
                        <td>
                              <%# Eval("signtype").ToString()=="0"?"签到":"礼包" %>
                            
                        </td>
                        <td>   <%# Eval("ClientIP").ToString()%>
                          </td>
                        <td>
                            <%# Eval("MachineID").ToString()%>
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