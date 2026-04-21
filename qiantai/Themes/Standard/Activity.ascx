<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Activity.ascx.cs" Inherits="Game.Web.Themes.Standard.Activity" %>

<div class="platActivityTop">
<ul>
    <li onclick="javascript:window.location.href='/UserService/MatchInfo.aspx'">比赛战报</li>
    <li onclick="javascript:window.location.href='/Roulette/Roulette.aspx'">幸运大转盘</li>
    <li onclick="javascript:window.location.href='/Roulette/RouletteRecord.aspx'">我的抽奖</li>
    <li onclick="javascript:window.location.href='/Roulette/RouletteRecordNow.aspx'">最近中奖记录</li>
    <%--<li onclick="javascript:window.location.href='/UserService/ScoreRank.aspx'">金币排行</li>--%>
</ul>
</div>

<script src="../../Script/jquery-1.4.1.min.js"></script>
<script>
    $(".platActivityTop li").removeClass("selected");
    $(".platActivityTop li").eq(navNum).addClass("selected");
    $(function () {
        $(".platActivityTop li").hover(function () {
            $(this).addClass("selected");
        }, function () {
            $(this).removeClass("selected");
            $(".platActivityTop li").eq(navNum).addClass("selected");
        });
    });
</script>