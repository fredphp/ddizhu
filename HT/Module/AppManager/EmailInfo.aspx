<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmailInfo.aspx.cs" Inherits="MTEwin.Module.AppManager.EmailInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
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
                你当前位置：用户系统 - 邮件详情
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 80px">
                邮件类型：
            </td>
            <td>
                <asp:Literal ID="lit_etype" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft" style="width: 80px">
                邮件标题：
            </td>
            <td>
                <asp:Literal ID="lit_eTit" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft" style="width: 80px">
                邮件内容：
            </td>
            <td>
                <asp:Literal ID="lit_content" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft" style="width: 80px">
                邮件发送者：
            </td>
            <td>
                <asp:Literal ID="lit_sender" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft" style="width: 80px">
                邮件接收者：
            </td>
            <td>
                <asp:Literal ID="lit_rec" runat="server"></asp:Literal>
            </td>
        </tr>
    </table>

      <table width="100%" id="table_ser" runat="server" border="0"  align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 80px">                 
                  用户名：
            </td>
            <td>
             
 
               
           <asp:TextBox ID="tb_serch" runat="server" CssClass="wd2"></asp:TextBox>
          
                     
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
               
            </td>
        </tr>
    </table>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
            id="list">
            <tr align="center" class="bold">
                <td class="listTitle2">
                    接收人
                </td>
                <td class="listTitle2">
                    读取状态
                </td>
                <td class="listTitle2">
                    读取日期
                </td>
            </tr>
            <asp:Repeater ID="rptDataList" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%# Eval("accounts") %>
                        </td>
                        <td>
                            <%#  (bool)Eval("haveread") ==false ? "未读" : "已读"%>
                        </td>
                        <td>
                            <%# Eval( "readtime" )==null?"---":Eval( "readtime" ) %>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                         <td>
                            <%# Eval("accounts") %>
                        </td>
                        <td>
                            <%#  (bool)Eval("haveread") ==false ? "未读" : "已读"%>
                        </td>
                        <td>
                            <%# Eval( "readtime" )==null?"---":Eval( "readtime" ) %>
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
                <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server"
                    AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="20" NextPageText="下页"
                    PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                    NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
                    UrlPaging="false">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
