<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GameRules.aspx.cs" Inherits="Game.Web.GameRules" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="Style/GameRules.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="rulesbox">
        <div class="ruleTop"></div>
        <div class="runlecontop"></div>
        <div class="ruleContent">
            <span class="color1"><%=KindName %>游戏规则</span><br />
            <span class="color1">一、游戏截图</span><br />
            <img alt="<%=KindName %>" src="<%=GameImage %>" /><br />
            <span class="color1">二、游戏介绍</span><br />
            <%=GameIntro %><br />
            <span class="color1">三、规则介绍</span><br />
            <%=Rules %><br />
        </div>
        <div class="ruleconbottom"></div>
    </div>
    </form>
</body>
</html>
