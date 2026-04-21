<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Common_Header.ascx.cs"
    Inherits="Game.Web.Themes.Standard.Common_Header" %>
<link rel="Stylesheet" type="text/css" href="../../Style/Header.css" />
<script type="text/javascript" src="../../Script/jquery-1.4.1.min.js"></script>
<!--[if lte IE 6]>
    <script src="/Script/DD_belatedPNG_0.0.8a.js"></script>
    <script type="text/javascript">
        DD_belatedPNG.fix('div,background');
	DD_belatedPNG.fix('a,background');
        DD_belatedPNG.fix('.headerLogo,img');
	DD_belatedPNG.fix('*,*:hover');
	DD_belatedPNG.fix('*');
    </script>
    <![endif]-->
<div id="headerBox">
    <div id="topheader">
    </div>
    <div class="header">
        <div class="headerin">
            <div class="headerLogo"><img src="../../Images/logo.png" /></div>
            <div class="div1">
                <a class="a1" href="/ContentUs.aspx"></a>
                <a class="a2" href="#"></a>
            </div>
            <div id="headermenu">
                <div id="headermenulist">
                    <ul>
                        <li class="normal title_1"><a class="title_1" href="/Index.aspx"></a></li>
                        <li class="normal title_2"><a class="title_2" href="/Register.aspx"></a></li>
                        <li class="normal title_3"><a class="title_3" href="/GameIndex.aspx"></a></li>
                        <li class="normal title_4"><a class="title_4" href="/GameList.aspx"></a></li>
                        <li class="normal title_5"><a class="title_5" href="/AboustUs.aspx"></a></li>
                        <li class="normal title_6"><a class="title_6" href="/ContentUs.aspx"></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        $(".normal").removeClass("selected");
        $(".title_" + cpageId).addClass("selected");
    });
</script>
<!-- Live800在线客服图标:默认图标[浮动图标] 开始-->
<!-- 在线客服图标:默认图标 结束-->
