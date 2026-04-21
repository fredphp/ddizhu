<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlatformTop.aspx.cs" Inherits="Game.Web.ads.PlatformTop" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        *
        {
            border: none;
            padding: 0;
            margin: 0;
        }

        html, body
        {
            width: 100%;
            height: 100%;
            overflow: hidden;
        }

        body
        {
            width: 100%;
            height: 20px;
            overflow: hidden;
            background-color: #000;
            color: #fff;
            font-weight: bold;
        }

        marquee
        {
            width: 100%;
            height: 20px;
            line-height: 20px;
            overflow: hidden;
            font-size: 12px;
            background-color: #000;
        }
    </style>
   <script type="text/javascript" src="../Script/jquery-1.4.1.min.js"></script>
    <script type="text/javascript">
        $(function () {
            setInterval("refr1()", 30000);
        });

        function refr1() {
            location.reload();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <marquee scrollamount="100%" loop="1" id="mar"><%= note %></marquee>
    </form>
</body>
</html>
