<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BankCard.aspx.cs" Inherits="MTEwin.Module.FilledManager.BankCard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../scripts/common.js"></script>

    <script type="text/javascript" src="../../scripts/comm.js"></script>

    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
<style>
.green{color:Green;}
</style>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">
                你当前位置：充值系统 - 系统银行卡管理
            </td>
        </tr>
    </table>
   
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 80px">
                兑换金额：
            </td>
            <td>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Value="-1" Text="全部"></asp:ListItem>
                    <asp:ListItem Value="0" Text="使用中"></asp:ListItem>
                    <asp:ListItem Value="1" Text="停止使用"></asp:ListItem>
                    
                </asp:DropDownList>
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" /> 
            </td>
        </tr>
    </table>
  
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
        <tr>
            <td height="39" class="titleOpBg">
              
                   <input type="button"  value="添加" onclick="location.href='AddBankCard.aspx';" /> 
                   <asp:Button ID="Update" runat="server" Text="停用" CssClass="btn wd2" OnClick="btnUpdate_Click" OnClientClick="return deleteop()" />
                   <asp:Button ID="UpdateStart" runat="server" Text="启用" CssClass="btn wd2" OnClick="btnUpdateStart_Click" OnClientClick="return deleteop()" />
                   <asp:Button ID="btnDelete" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()" />
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
                    姓名
                </td>
                <td class="listTitle2">
                    银行类名
                </td>
                <td class="listTitle2">
                    卡号
                </td>
                <td class="listTitle2">
                    状态
                </td>
                 <td class="listTitle2">
                    银行链接
                </td>
                <td class="listTitle2">
                    添加时间
                </td>
                 
            </tr>
            <asp:Repeater ID="rptUserExchange" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                      
                      <td> 
                       <input name='cid' type='checkbox' value='<%#  Eval("id") %>'/></td>
                        <td>
                            <%# Eval("name")%>
                        </td>
                        <td>
                             <%# Eval("typename")%>
                        </td>
                        <td>
                            <a href='AddBankCard.aspx?cmd=upBank&param=<%# Eval("id") %>' style="color:#0000ff;"><%#  Eval("card").ToString()%></a>
                        </td>
                        <td style='background:<%# Eval("states").ToString()=="False"?"green":"red" %>;' >
                            <%# Eval("states").ToString()=="False"?"启用":"停用"%>
                        </td>
                          <td>
                            <%#  Eval("cardurl")%>
                        </td>
                        <td>
                            <%#  Eval("recordtime")%>
                        </td>
                         
                        
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                            <td> 
                       <input name='cid' type='checkbox' value='<%#  Eval("id") %>'/></td>
                       
                        <td>
                            <%# Eval("name")%>
                        </td>
                        <td>
                             <%# Eval("typename")%>
                        </td>
                        <td>
                            <a href='AddBankCard.aspx?cmd=upBank&param=<%# Eval("id") %>' style="color:#0000ff;"><%#  Eval("card").ToString()%></a>
                        </td>
                        <td style='background:<%# Eval("states").ToString()=="False"?"green":"red" %>;' >
                                  <%# Eval("states").ToString()=="False"?"启用":"停用"%>
                        </td>
                         <td>
                            <%#  Eval("cardurl")%>
                        </td>
                        <td>
                            <%#  Eval("recordtime")%>
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
                <gsp:AspNetPager ID="anpPage" runat="server" OnPageChanged="anpNews_PageChanged" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
                    PageSize="20" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                    NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
        <tr>
            <td height="39" class="titleOpBg">
                <asp:Button ID="btnDelete2" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
 

