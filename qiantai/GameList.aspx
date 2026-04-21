<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameList.aspx.cs" Inherits="Game.Web.GameList" %>

<%@ Register TagPrefix="flb" TagName="Header" Src="~/Themes/Standard/Common_Header.ascx" %>
<%@ Register TagPrefix="flb" TagName="Footer" Src="~/Themes/Standard/Common_Footer.ascx" %>
<%@ Register TagPrefix="flb" TagName="ContentTop" Src="~/Themes/Standard/Context_Top.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="Style/GameList.css" />
    <script type="text/javascript" src="Script/comm.js"></script>
    <script type="text/javascript">
        cpageId = 4;
        cpagetype = "gamelist";
    </script>
</head>
<body>
    <flb:Header ID="header" runat="server" />
    <form id="form1" runat="server">
    <div id="gamelist-contentbottom">
        <div id="regin-top">
        </div>
        <asp:Repeater ID="rptGameKinds" runat="server">
            <ItemTemplate>
                <div class="gamelistbox">
                    <div class="gamelistbg" style="background:url(<%# GetKindImage(Eval("KindID")) %>);" onclick="openWindowOwn('GameRules.aspx?KID=<%#Eval("KindID") %>','_游戏介绍','1050','664'); return false">
                        <%--<div class="gameName">
                            <%# Eval("KindName") %></div>--%>
                        <%--<div class="gamelistName">
                            <a onclick="openWindowOwn('GameRules.aspx?KID=<%#Eval("KindID") %>','_游戏介绍','1050','664'); return false"
                                href="#">游戏规则</a></div>--%>
                    </div>
                    <%--<div class="gamelistimg">
                        <img width="279" height="141" src="<%# GetKindImage(Eval("KindID")) %>" /></div>--%>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    </form>
    <flb:Footer ID="footer" runat="server" />
</body>
</html>
