<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameIndex.aspx.cs" Inherits="Game.Web.GameIndex" %>

<%@ Register TagPrefix="flb" TagName="Header" Src="~/Themes/Standard/Common_Header.ascx" %>
<%@ Register TagPrefix="flb" TagName="Footer" Src="~/Themes/Standard/Common_Footer.ascx" %>
<%@ Register TagPrefix="flb" TagName="ContentTop" Src="~/Themes/Standard/Context_Top.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="Style/Download.css" />
    <style type="text/css">
        .left {
            float: left;
            height: 200px;
            width: 440px;
        }
    </style>
    <script type="text/javascript">
        cpageId = 3;
        cpagetype = "download";
    </script>
</head>
<body>
    <flb:Header ID="header" runat="server" />
    <form id="form1" runat="server">
        <div class="download-contentbottom">
            <div id="regin-top">
            </div>
            <div id="downloadright">
                <ul>
                    <li><a class="downloadjb" href="<%=downloadjb %>"></a></li>
                    <li><a class="downloadfull" href="<%=downloadfull %>"></a></li>
                </ul>
                <div class="left">
                    <img src="/Images/rwm.png" style="margin-right: 25px;" /><img src="/Images/rwm2.png" />
                </div>
            </div>
        </div>
    </form>
    <flb:Footer ID="footer" runat="server" />
</body>
</html>
