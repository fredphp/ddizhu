<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Kefu.aspx.cs" Inherits="Game.Web.Kefu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
     <a id="qqhref" href="http://wpa.qq.com/msgrd?v=3&uin=<%= QQ %>&site=qq&menu=yes" target="_blank"></a>
    <script>
        window.location.href = document.getElementById("qqhref").attributes["href"].value;
    </script>
</body>
</html>
