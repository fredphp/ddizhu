<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OtherWebList.aspx.cs" Inherits="MTEwin.Module.OtherWebManager.OtherWebList" %>

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
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
      <tr>
        <td width="19" height="25" valign="top" class="Lpd10">
          <div class="arr">
          </div>
        </td>
        <td width="1232" height="25" valign="top" align="left">你当前位置：外部网站系统 - 网站管理
        </td>
      </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td>&nbsp;
                输入商户名或网站名或商户编号:<asp:TextBox ID="txtSearch" runat="server" CssClass="text" ToolTip="输入商户名或网站名或商户编号"></asp:TextBox>
          <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
          <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
        </td>
      </tr>
    </table>
    <div class="clear">
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
      <tr>
        <td height="39" class="titleOpBg">
          <input type="button" value="新增" class="btn wd1" onclick="openWindowOwn('AddOtherWeb.aspx?cmd=addOtherWeb&param=0','',850,450)" />
          <input class="btnLine" type="button" />
          <asp:Button ID="btnDongjie" runat="server" Text="冻结" CssClass="btn wd1" OnClick="btnDongjie_Click"
            OnClientClick="return deleteop()" />
          <asp:Button ID="btnJiedong" runat="server" Text="解冻" CssClass="btn wd1" OnClick="btnJiedong_Click"
            OnClientClick="return deleteop()" />
        </td>
      </tr>
    </table>
    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
        id="list">
        <tr align="center" class="bold">
          <td class="listTitle">
            <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" />
          </td>
          <td class="listTitle2">商户ID
          </td>
          <td class="listTitle2">商户名
          </td>
          <td class="listTitle2">商户密钥
          </td>
          <td class="listTitle2">网站名
          </td>
          <td class="listTitle2">联系电话
          </td>
          <td class="listTitle2">联系QQ
          </td>
          <td class="listTitle2">状态
          </td>
        </tr>
        <asp:Repeater ID="rptDataList" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td style="width: 30px;">
                <input name='cid' type='checkbox' value='<%# Eval("MerchantId").ToString()%>' />
              </td>
              <td>
                <%#  Eval("MerchantId").ToString()%>
              </td>
              <td>
                <a onclick="openWindowOwn('AddOtherWeb.aspx?cmd=upOtherWeb&param=<%# Eval("MerchantId") %>','<%# Eval("MerchantId") %>',850,450)" href='javascript:void(0);' style="color: #0000ff;"><%#  Eval("MerchantName").ToString()%></a>
              </td>
              <td>
                <%#  Eval("MerchantKey").ToString()%>
              </td>
              <td>
                <a href='<%#  Eval("WebLink").ToString()%>' target="_blank" style="color: #0000ff;"><%#  Eval("WebName").ToString()%></a>
              </td>
              <td>
                <%#  Eval("TelPhone").ToString()%>%
              </td>
              <td>
                <%#  Eval("QQ").ToString()%>
              </td>
              <td>
                <%#GetNullityStatus(Eval("Flag").ToString())%>
              </td>
            </tr>
          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td style="width: 30px;">
                <input name='cid' type='checkbox' value='<%# Eval("MerchantId").ToString()%>' />
              </td>
              <td>
                <%#  Eval("MerchantId").ToString()%>
              </td>
              <td>
                <a href='AddOtherWeb.aspx?cmd=upOtherWeb&param=<%# Eval("MerchantId") %>' style="color: #0000ff;"><%#  Eval("MerchantName").ToString()%></a>
              </td>
              <td>
                <%#  Eval("MerchantKey").ToString()%>
              </td>
              <td>
                <a href='<%#  Eval("WebLink").ToString()%>' target="_blank" style="color: #0000ff;"><%#  Eval("WebName").ToString()%></a>
              </td>
              <td>
                <%#  Eval("TelPhone").ToString()%>%
              </td>
              <td>
                <%#  Eval("QQ").ToString()%>
              </td>
              <td>
                <%#GetNullityStatus(Eval("Flag").ToString())%>
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
          <span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a
            class="l1" href="javascript:SelectAll(false);">无</a>
        </td>
        <td align="right" class="page">
          <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server"
            AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="15" NextPageText="下页"
            PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
            NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
            UrlPaging="false">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
    <input type="hidden" runat="server" id="hidAgencyId" />
  </form>
</body>
</html>

