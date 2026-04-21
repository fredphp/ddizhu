<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddNews.aspx.cs" Inherits="MTEwin.Module.AgencyManager.AddNews" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/JQuery.js"></script>
    <link rel="stylesheet" href="/scripts/kindEditor/themes/default/default.css" />
    <link rel="stylesheet" href="/scripts/kindEditor/plugins/code/prettify.css" />
    <script src="/scripts/kindEditor/kindeditor.js"></script>
    <script src="/scripts/kindEditor/lang/zh-CN.js"></script>
    <script src="/scripts/kindEditor/plugins/code/prettify.js"></script>
    <script type="text/javascript">
        KE.show({
            id: 'txtNewsCont',
            imageUploadJson: '/Tools/KindEditorUpload.ashx?type=Config',
            fileManagerJson: '/Tools/KindEditorFileManager.ashx?type=config',
            allowFileManager: true
        });
    </script>
    <title></title>
</head>
<body>
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">目前操作功能：添加公告
            </td>
        </tr>
    </table>
    <form id="form1" runat="server">
        <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10"></td>
            </tr>
        </table>
        <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
            <tr>
                <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                    <div class="hg3  pd7">
                        公告信息
                    </div>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">公告标题：
                </td>
                <td>
                    <asp:TextBox ID="txtNewsName" runat="server" CssClass="text wd4"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">公告内容：
                </td>
                <td>
                    <asp:TextBox ID="txtNewsCont" runat="server" CssClass="text wd4" Height="292px"
                        Width="562px" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
        </table>
        <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input type="button" value="关闭" runat="server" id="btnclose" class="btn wd1" onclick="window.close();" />
                    <asp:Button ID="btnSave1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>

