<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserCenter.ascx.cs" Inherits="Game.Web.Themes.Standard.UserCenter" %>

<div class="platActivityTop">
<ul>
    <li onclick="javascript:window.location.href='/UserService/MemberInfo.aspx'">个人信息</li>
    <li onclick="javascript:window.location.href='/UserService/SafeSet.aspx'">安全设置</li>
    <li onclick="javascript:window.location.href='/UserService/RewardDrawScore.aspx'">游戏记录</li>
    <li onclick="javascript:window.location.href='/UserService/InsertInfo.aspx'">完善资料</li>
    <li onclick="javascript:window.location.href='/UserService/RecordPay.aspx'">充值记录</li>
    <li onclick="javascript:window.location.href='/UserService/RecordExchange.aspx'">兑换记录</li>
    <%--<li onclick="javascript:window.location.href='/UserService/ScoreRank.aspx'">金币变化</li>--%>
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