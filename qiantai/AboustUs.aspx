<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AboustUs.aspx.cs" Inherits="Game.Web.AboustUs" %>

<%@ Register TagPrefix="flb" TagName="Header" Src="~/Themes/Standard/Common_Header.ascx" %>
<%@ Register TagPrefix="flb" TagName="Footer" Src="~/Themes/Standard/Common_Footer.ascx" %>
<%@ Register TagPrefix="flb" TagName="ContentTop" Src="~/Themes/Standard/Context_Top.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="Style/Layout.css" />
    <script type="text/javascript">
        cpageId = 5;
        cpagetype = "about";
    </script>
    <style type="text/css">
        #regin-top {
            background:  url("/Images/about.png") no-repeat scroll 0 0;
            float: left;
            height: 130px;
            margin-top: 15px;
            width: 100%;
            margin-left:60px;
        }
        .con-con {
            margin-top:30px;
        }
    </style>
</head>
<body>
    <flb:Header ID="header" runat="server" />
    <form id="form1" runat="server">
    <div class="content">
        <div id="regin-top">
        </div>
        <div class="con-middle">
            <div class="con-con">
                 <ul id="usul">
                 <li>如需要在线帮助，请联系官网或游戏中的在线客服</li>
                 <li>我们将为您提供7*24小时的在线帮助</li>
                </ul>
                
            </div>
        </div>
    </div>
    </form>
    <flb:Footer ID="footer" runat="server" />
</body>
</html>
