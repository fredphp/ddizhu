<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Game.Web.Index" %>

<%@ Register TagPrefix="flb" TagName="Header" Src="~/Themes/Standard/Common_Header.ascx" %>
<%@ Register TagPrefix="flb" TagName="Footer" Src="~/Themes/Standard/Common_Footer.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="Style/Index.css" />
    <script type="text/javascript" src="Script/jquery-1.4.1.min.js" ></script>
    <script type="text/javascript" src="Script/comm.js"></script>
    <script type="text/javascript">
        cpageId = 1;
    </script>
    <script type="text/javascript">

        $(function () {
            var timer;
            timer = setInterval(movecontent, 30);
            $("#roll-centent").hover(function () {
                clearInterval(timer);
            }, function () {
                timer = setInterval(movecontent, 30);
            });
        });

        function movecontent() {
            var divTopStr = $("#roll-centent1").css("top");
            var divHeight = $("#roll-centent1").height();
            var divTop = divTopStr.substring(0, divTopStr.length - 2);
            if (parseInt(divTop) < parseInt(divHeight)*-1) {
                $("#roll-centent1").css("top", "82px");
            }
            else {
                $("#roll-centent1").css("top", parseInt(divTop) - 1);
            }
        }
    </script>
</head>
<body>
    <flb:Header ID="header" runat="server" />
    <form id="form1" runat="server">
    <div id="index-content">
        <div id="content-top">
            <div class="index-top">
                <span class="span1"><img src="/images/index/regtu.png" /></span>
                <span class="span3"><img src="/images/index/regtu2.png" /></span>
                <span style="display:block;">
                    <a class="a1" href="/Register.aspx"></a>
                    <a class="a2" href="/GameIndex.aspx"></a>
                </span>
                <span class="span2"><img src="/images/index/centu.png" /></span>
            </div>
            <div id="centent-topleft">
                <div id="roll-centent">
                    <div id="roll-centent1" style="float: left; top:0; padding:0; position:relative;">
                        <ul>
                            <li>
                                <%=content %>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="centent-topright">
            </div>
        </div>
        <div id="centent-middle">
            <ul>
                <li class="middleli_01"><a class="middle_01" href="GameList.aspx"></a></li>
                <li class="middleli_02"><a class="middle_02" onclick="openWindowOwn('GameRules.aspx?KID=11','11','1050','664'); return false"href="###"></a></li>
                <li class="middleli_03"><a class="middle_03" onclick="openWindowOwn('GameRules.aspx?KID=27','27','1050','664'); return false"href="###"></a></li>
                <li class="middleli_04"><a class="middle_04" onclick="openWindowOwn('GameRules.aspx?KID=2043','2043','1050','664'); return false"href="###"></a></li>
                <li class="middleli_05"><a class="middle_05" onclick="openWindowOwn('GameRules.aspx?KID=6','6','1050','664'); return false"href="###"></a></li>
                <li class="middleli_06"><a class="middle_06" onclick="openWindowOwn('GameRules.aspx?KID=301','301','1050','664'); return false"href="###"></a></li>
            </ul>
        </div>
    </div>
    </form>
    <flb:Footer ID="footer" runat="server" />
</body>
</html>
<!--[if lte IE 6]>
<script src="/Script/DD_belatedPNG_0.0.8a.js"></script>
<script type="text/javascript">
    DD_belatedPNG.fix('*,*:hover');
</script>
<![endif]-->