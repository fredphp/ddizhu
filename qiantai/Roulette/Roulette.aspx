<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Roulette.aspx.cs" Inherits="Game.Web.Roulette.Roulette" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="flb" TagName="acTop" Src="~/Themes/Standard/Activity.ascx" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
    <script>
        navNum = 1;
    </script>
</head>
<body>
    <flb:acTop ID="activeTop" runat="server"></flb:acTop>
    <form id="form1" runat="server">
    <div class="platActivityBox">
        <div class="rouBox" runat="server" id="rou">
            <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0"
                width="390" height="390" style="float:left;">
                <param name="movie" value="luck.swf" />
                <param name="quality" value="high" />
                <param name="wmode" value="transparent">
                <embed src="luck.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer"
                    wmode="transparent" type="application/x-shockwave-flash" width="390" height="390"></embed>
            </object>
            <div class="rowconBox">
                <div class="rowConTop">
                    奖品设置
                </div>
                <span>特等奖：<label class="important">10000元</label></span>
                <span>一等奖：<label class="important">5000元</label></span>
                <span>二等奖：<label class="important">1000元</label></span>
                <span>三等奖：<label class="important">500元</label></span>
                <span>四等奖：<label class="white">100元</label></span>
                <span>五等奖：<label class="white">50元</label></span>
                <span>六等奖：<label class="white">20元</label></span>
                <span>七等奖：<label class="white">10元</label></span>
                <span>八等奖：<label class="white">5元</label></span>
                <span>九等奖：<label class="white">3元</label></span>
                <span>安慰奖：<label class="white">1元</label></span>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
