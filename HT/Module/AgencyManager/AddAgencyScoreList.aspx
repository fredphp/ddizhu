<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddAgencyScoreList.aspx.cs" Inherits="MTEwin.Module.AgencyManager.AddAgencyScoreList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
    <title></title>
    <script type="text/javascript" src="../../scripts/JQuery.js"></script>
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
                你当前位置：代理系统 - 代理加减币操作
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End --> 
       <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td style="height: 30px;">
                &nbsp; 输入用户名或真实姓名或代理标识:<asp:TextBox ID="txtSearch" runat="server" CssClass="text"
                    ToolTip="输入帐号或用户标识"></asp:TextBox>
                   <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
                日期查询：<asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
            </td>
        </tr>
        <tr>
        <td colspan="10">总和： <%=Suminfo%></td>
        </tr>
           </table>
         <div class="clear">
    </div>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
            id="list">
            <tr align="center" class="bold">
                <td class="listTitle2">
                    代理标识
                </td>
                <td class="listTitle2">
                    代理名
                </td>
                <td class="listTitle2">
                    加币
                </td>
                <td class="listTitle2">
                    备注
                </td>
                <td class="listTitle2">
                    操作人
                </td>
                <td class="listTitle2">
                    操作时间
                </td>
             
            </tr>
            <asp:Repeater ID="rptDataList" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%#  Eval("agencyid").ToString()%>
                        </td> 
                        <td> 
                            <%#  GetAgencyName(int.Parse(Eval("AgencyID").ToString()))%>
                        </td>
                        <td>
                            <%#   (Eval("score").ToString() )%>
                        </td>
                       
                        <td>
                            <%#  Eval("note").ToString()%>
                        </td>
                         <td>
                            <%#  (Eval("admacc").ToString() )%>
                        </td>
                        <td>
                            <%#  Eval("collectdate").ToString()%>
                        </td>
                       
                    </tr>
                </ItemTemplate>     </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
        </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
           
            <td align="right" class="page">
                <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server"
                    AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="15" NextPageText="下页"
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
