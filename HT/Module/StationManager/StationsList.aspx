<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StationsList.aspx.cs" Inherits="MTEwin.Module.StationManager.StationsList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../../scripts/common.js"></script>

  <script type="text/javascript" src="../../scripts/comm.js"></script>

  <title></title>
</head>
<body>
  <form id="form1" runat="server">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
      <tr>
        <td width="19" height="25" valign="top" class="Lpd10">
          <div class="arr">
          </div>
        </td>
        <td width="1232" height="25" valign="top" align="left">你当前位置：分站管理 - 分站管理
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td class="listTdLeft" style="width: 80px">普通查询：
        </td>
        <td>
          <asp:TextBox ID="txtSearch" runat="server" CssClass="text"></asp:TextBox>
          <asp:DropDownList ID="ddlSearch" runat="server">
            <asp:ListItem Value="1" Text="按站点标识"></asp:ListItem>
            <asp:ListItem Value="2" Text="按站点名称"></asp:ListItem>
          </asp:DropDownList>
          <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
          <asp:Button ID="btnRefresh" runat="server" Text="刷新" CssClass="btn wd1" OnClick="btnRefresh_Click" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
      <tr>
        <td height="39" class="titleOpBg">
          <input id="btnAddStation" runat="server" type="button" value="新增" class="btn wd1" onclick="Redirect('StationsInfo.aspx?cmd=add')" />
          <asp:Button ID="btnDelete" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()" Visible="false" />
          <input class="btnLine" type="button" />
          <asp:Button ID="btnDongjie" runat="server" Text="冻结" CssClass="btn wd1" OnClick="btnDongjie_Click" OnClientClick="return deleteop()" />
          <asp:Button ID="btnJiedong" runat="server" Text="解冻" CssClass="btn wd1" OnClick="btnJiedong_Click" OnClientClick="return deleteop()" />
        </td>
      </tr>
    </table>
    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
        <tr align="center" class="bold">
          <td class="listTitle">
            <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" />
          </td>
          <td class="listTitle2">管理
          </td>
          <td class="listTitle2">站点标识
          </td>
          <td class="listTitle2">站点名称
          </td>
          <td class="listTitle2">站点别名
          </td>
          <td class="listTitle2">站点域名
          </td>
          <td class="listTitle2">联系人
          </td>
          <td class="listTitle2">联系邮箱
          </td>
          <td class="listTitle1">冻结状态
          </td>
        </tr>
        <asp:Repeater ID="rptStation" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td style="width: 30px;">
                <input name='cid' type='checkbox' value='<%# Eval("ID")%>' />
              </td>
              <td style="width: 100px;">
                <%#"<a class='l' href='StationsInfo.aspx?cmd=edit&param=" + Eval( "ID" ) + "&reurl=" + Server.UrlEncode( Game.Utils.Utility.CurrentUrl ) + "'>查看</a>&nbsp;" +
                               "<a class='l' href='javascript:void(0);' onclick=\"openWindowOwn('AddRStationFinance.aspx?param=" + Eval( "StationID" ).ToString() + "','" + Eval( "StationID" ).ToString() + "',480,280);\">提款</a>&nbsp;" +
                               "<a class='l' href='StationsList.aspx?cmd=del&param=" + Eval( "StationID" ) + "&reurl=" + Server.UrlEncode( Game.Utils.Utility.CurrentUrl ) + "' onclick=\"return confirm('您确定要删除吗？')\">删除</a>"%>
              </td>
              <td>
                <%# Eval("StationID") %>
              </td>
              <td>
                <%# Eval("StationName") %>
              </td>
              <td>
                <%# Eval("StationAlias")%>
              </td>
              <td>
                <%# Eval("StationDomain")%>
              </td>
              <td>
                <%# Eval("ContactUser")%>
              </td>
              <td>
                <%# Eval("ContactMail")%>
              </td>
              <td>
                <%# GetNullityStatus((byte)Eval("Nullity"))%>
              </td>
            </tr>
          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td style="width: 30px;">
                <input name='cid' type='checkbox' value='<%# Eval("ID")%>' />
              </td>
              <td style="width: 100px;">
                <%#"<a class='l' href='StationsInfo.aspx?cmd=edit&param=" + Eval( "ID" ) + "&reurl=" + Server.UrlEncode( Game.Utils.Utility.CurrentUrl ) + "'>查看</a>&nbsp;" +
                               "<a class='l' href='javascript:void(0);' onclick=\"openWindowOwn('AddRStationFinance.aspx?param=" + Eval( "StationID" ).ToString() + "','" + Eval( "StationID" ).ToString() + "',480,280);\">提款</a>&nbsp;" +
                               "<a class='l' href='StationsList.aspx?cmd=del&param=" + Eval( "StationID" ) + "&reurl=" + Server.UrlEncode( Game.Utils.Utility.CurrentUrl ) + "' onclick=\"return confirm('您确定要删除吗？')\">删除</a>"%>
              </td>
              <td>
                <%# Eval("StationID") %>
              </td>
              <td>
                <%# Eval("StationName") %>
              </td>
              <td>
                <%# Eval("StationAlias")%>
              </td>
              <td>
                <%# Eval("StationDomain")%>
              </td>
              <td>
                <%# Eval("ContactUser")%>
              </td>
              <td>
                <%# Eval("ContactMail")%>
              </td>
              <td>
                <%# GetNullityStatus((byte)Eval("Nullity"))%>
              </td>
            </tr>
          </AlternatingItemTemplate>
        </asp:Repeater>
        <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
      </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="listTitleBg">
          <span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a class="l1" href="javascript:SelectAll(false);">无</a>
        </td>
        <td align="right" class="page">
          <gsp:AspNetPager ID="anpNews" runat="server" OnPageChanged="anpNews_PageChanged" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
            PageSize="20" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
            NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
      <tr>
        <td height="39" class="titleOpBg">
          <input id="btnAddStation1" runat="server" type="button" value="新增" class="btn wd1" onclick="Redirect('StationsInfo.aspx?cmd=add')" />
          <asp:Button ID="btnDelete1" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()" Visible="false" />
          <input class="btnLine" type="button" />
          <asp:Button ID="btnDongjie1" runat="server" Text="冻结" CssClass="btn wd1" OnClick="btnDongjie_Click" OnClientClick="return deleteop()" />
          <asp:Button ID="btnJiedong1" runat="server" Text="解冻" CssClass="btn wd1" OnClick="btnJiedong_Click" OnClientClick="return deleteop()" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

