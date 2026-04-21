<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsDetail.aspx.cs" Inherits="Game.Web.UserService.NewsDetail" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="platContentBox">
        <div class="noticetitle"><%= title %></div>
        <div class="notime">发布时间：<%= issueDate%></div><br />
        <div class="noticegoback" onclick="javascript:window.location.href='NoticeList.aspx'">【返回】</div><br />
        <div class="noticebox">
            <%=content %>
        </div>
    </div>
    </form>
</body>
</html>
