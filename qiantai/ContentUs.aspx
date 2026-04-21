<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContentUs.aspx.cs" Inherits="Game.Web.ContentUs" %>

<%@ Register TagPrefix="flb" TagName="Header" Src="~/Themes/Standard/Common_Header.ascx" %>
<%@ Register TagPrefix="flb" TagName="Footer" Src="~/Themes/Standard/Common_Footer.ascx" %>
<%@ Register TagPrefix="flb" TagName="ContentTop" Src="~/Themes/Standard/Context_Top.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="Style/Layout.css" />
    <script type="text/javascript">
        cpageId = 6;
        cpagetype = "contact";
    </script>
    <style type="text/css">
        #regin-top {
            background:  url("/Images/content.png") no-repeat scroll 0 0;
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
        <div class="con-middle">
            <div id="regin-top">
            </div>
            <div class="con-con">
                <ul id="usul">
                    <li>客服QQ1：<%= kfQQ1 %></li>
                    <li>客服QQ2：<%= kfQQ2 %></li>
                    <li>客服QQ3：<%= kfQQ3 %></li>
                    <li>投诉QQ：<%= tsQQ %></li>
                    <li>客服邮箱：<%= kfEmail %></li>
                    <%--<li>客服电话：<%= kfTel %></li>--%>
                    <li>投诉电话：<%= tsTel %></li>
                    <li>公司邮箱：<%= comEmail %></li>
                </ul>
            </div>
        </div>
    </div>
    </form>
    <flb:Footer ID="footer" runat="server" />
</body>
</html>

