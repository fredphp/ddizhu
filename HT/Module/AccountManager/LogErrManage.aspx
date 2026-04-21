<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogErrManage.aspx.cs" Inherits="MTEwin.Module.AccountManager.LogErrManage" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../scripts/common.js"></script>

    <script type="text/javascript" src="../../scripts/comm.js"></script>

    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>

    

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
                你当前位置：用户系统 - 用户登录锁死管理
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 80px">
                直属站点：
            </td>
            <td>
                <asp:DropDownList ID="ddlStation" runat="server">
                </asp:DropDownList>
                &nbsp;&nbsp; 普通查询：
                <asp:TextBox ID="txtSearch" runat="server" CssClass="text" ToolTip="输入帐号或用户标识"></asp:TextBox>
               &nbsp;
                <asp:Button ID="btn_all" runat="server" Text="查询所有" CssClass="btn wd2" 
                    onclick="btn_all_Click"   />&nbsp;&nbsp; <input class="btnLine" type="button" />
                <asp:Button ID="btnQuery" runat="server" Text="查询锁定" CssClass="btn wd2" OnClick="btnQuery_Click" />
              
            </td>
        </tr>
    </table> 
    <div class="clear"></div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
        <tr>
            <td height="39" class="titleOpBg">
                &nbsp;<asp:Button ID="btnDelete" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()"
                     />
             
               
            </td>
        </tr>
    </table>
     
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
            <tr align="center" class="bold">
                <td class="listTitle">
                    <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" />
                </td>
                <td class="listTitle2">
                    用户标识
                </td>
                <td class="listTitle2">
                    用户帐号
                </td>
                <td class="listTitle2">
                   错误次数
                </td>
                <td class="listTitle2">
                    收集时间
                </td> 
                <td class="listTitle1">
                    状态
                </td>
            </tr>
            <asp:Repeater ID="rptDataList" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                       <td style="width: 30px;">
                            <input name='cid' type='checkbox' value='<%# Eval("UserID").ToString()%>' />
                        </td>
                        <td>
                            <%#　 Eval( "UserID" )　%>
                        </td>
                        <td>
                         <%#　 Eval( "accounts" )　%> 
                        </td>
                        <td>
                            <%# Eval("ErrorTime") %>
                        </td>
                         <td>
                            <%# Eval("LastErrorTime")%>
                        </td>
                       <td>
                        <%# islock(Eval("ErrorTime").ToString(), Eval("LastErrorTime").ToString())%>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                       <td style="width: 30px;">
                            <input name='cid' type='checkbox' value='<%# Eval("UserID").ToString()%>' />
                        </td>
                        <td>
                            <%#　 Eval( "UserID" )　%>
                        </td>
                        <td>
                         <%#　 Eval( "accounts" )　%> 
                        </td>
                        <td>
                            <%# Eval("ErrorTime") %>
                        </td>
                         <td>
                            <%# Eval("LastErrorTime")%>
                        </td>
                       <td>
                            <%# islock(Eval("ErrorTime").ToString(), Eval("LastErrorTime").ToString())%>
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
                <span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a class="l1" href="javascript:SelectAll(false);">无</a>
            </td>
            <td align="right" class="page">
                <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
                    PageSize="15" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                    NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%" UrlPaging="false">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
        <tr>
            <td height="39" class="titleOpBg">
                &nbsp;<asp:Button ID="btnDelete1" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()"
                     />
                &nbsp;&nbsp;
                <%--<input id="btnGrantExperience2" type="button" value="赠送经验" class="btn wd2" onclick="GrantManager('GrantExperience')" />--%>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

