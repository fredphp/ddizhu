<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeList.aspx.cs" Inherits="Game.Web.UserService.NoticeList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="platContentBox">
        <ul id="uNoticeList">
            <asp:Repeater ID="rptNews" runat="server">
                <ItemTemplate>
                    <li><span class="noticenum">
                        <%# Eval("PageView_RowNo")%></span> <span class="noticeimg"></span><span class="noticecon"
                            onclick="javascript:window.location.href='NewsDetail.aspx?IDX=<%# Eval("NewsID") %>'">
                            <%#Eval("Subject")%></span> <span class="noticetime">[<%# string.Format("{0:F}",Convert.ToDateTime(Eval("IssueDate"))) %>]</span>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </ul>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="padding-top:10px;">
            <tr>
                <td style="width: 50px;">
                </td>
                <td align="center" class="page">
                    <webdiyer:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server"
                        FirstPageText="首页" LastPageText="尾页" PageSize="5" NextPageText="后页" PrevPageText="前页"
                        ShowCustomInfoSection="Left" ShowMoreButtons="false" ShowPageIndexBox="Never"
                        NumericButtonCount="5" CustomInfoHTML="共<font class='hong'>%RecordCount%</font>条符合条件的记录，当前为第<font class='hong'>%CurrentPageIndex%</font>页共<font class='hong'>%PageCount%</font>页">
                    </webdiyer:AspNetPager>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
