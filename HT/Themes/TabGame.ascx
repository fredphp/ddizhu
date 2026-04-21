<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TabGame.ascx.cs" Inherits="MTEwin.Themes.TabGame" %>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
  <tr>
    <td height="28">
      <ul>
        <% if(NavActivated == "A") {
        %>
        <li class="tab1" onclick="Redirect('GameGameItemList.aspx')">模块</li>
        <%} else { %>
        <li class="tab2" onclick="Redirect('GameGameItemList.aspx')">模块</li>
        <%} %>

        <% if(NavActivated == "B") {
        %>
        <li class="tab1" onclick="Redirect('GameTypeItemList.aspx')">类型</li>
        <%} else { %>
        <li class="tab2" onclick="Redirect('GameTypeItemList.aspx')">类型</li>
        <%} %>

        <% if(NavActivated == "C") {
        %>
        <li class="tab1" onclick="Redirect('GameKindItemList.aspx')">游戏</li>
        <%} else { %>
        <li class="tab2" onclick="Redirect('GameKindItemList.aspx')">游戏</li>
        <%} %>
      </ul>
    </td>
  </tr>
</table>
