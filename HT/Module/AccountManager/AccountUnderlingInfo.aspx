<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccountUnderlingInfo.aspx.cs" Inherits="MTEwin.Module.AccountManager.AccountUnderlingInfo" %>

<%@ Register Src="~/Themes/TabUser.ascx" TagPrefix="Fox" TagName="Tab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../scripts/common.js"></script>

    <script type="text/javascript" src="../../scripts/jquery.js"></script>

    <style type="text/css">
        .treeview td div
        {
            height: 20px !important;
        }
    </style>
</head>
<body>
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">
                目前操作功能：用户信息
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <Fox:Tab ID="fab1" runat="server" NavActivated="E"></Fox:Tab>
    <form runat="server" id="form1">
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="关闭" class="btn wd1" onclick="window.close();" />
            </td>
        </tr>
    </table>
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
        <tr>
            <td>
                <div style="color: Black; width: 19%; height:715px; border: solid 1px #ccc; float: left; overflow: auto; overflow-x: hidden;
                    overflow-y: scroll;">
                    <asp:TreeView ID="tvAccounts" Height="100%" runat="server" Width="100%" NodeIndent="10" ImageSet="msdn" SkinID="girdviewskin"
                        PopulateNodesFromClient="False" ExpandDepth="1" ShowLines="True" CssClass="treeview">
                        <ParentNodeStyle Font-Bold="False" ForeColor="Black" ImageUrl="~/images/02.gif" />
                        <HoverNodeStyle BackColor="Transparent" BorderStyle="None" Font-Underline="True" ForeColor="Black" BorderWidth="0px" />
                        <SelectedNodeStyle BackColor="White" BorderColor="#888888" BorderStyle="Solid" BorderWidth="1px" Font-Underline="False" HorizontalPadding="3px"
                            VerticalPadding="1px" ForeColor="White" />
                        <NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="1px" VerticalPadding="2px"
                            ImageUrl="~/images/03.gif" />
                        <RootNodeStyle ForeColor="Gray" Font-Bold="True" ImageUrl="~/images/01.gif" />
                        <LeafNodeStyle ForeColor="Black" />
                    </asp:TreeView>                    
                </div>
                <iframe id="iframe1" name="iframe1" frameborder="0" scrolling="no" src="AccountsUnderlingList.aspx?param=<%= IntParam %>"
                    width="80%" height="715" style="float: left;"></iframe>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

