<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RedPackageList.aspx.cs" Inherits="MTEwin.Module.WebManager.RedPackageList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../../scripts/common.js"></script>

  <script type="text/javascript" src="../../scripts/comm.js"></script>

  <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>

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
        <td width="1232" height="25" valign="top" align="left">你当前位置：网站系统 - 红包记录
        </td>
      </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td class="listTdLeft" style="width: 80px">
          <asp:Literal ID="lit_TIPS" runat="server"></asp:Literal>
          日期查询：
        </td>
        <td>
          <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd4" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
            src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
            style="cursor: pointer; vertical-align: middle" />
          至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd4" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                  src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                  style="cursor: pointer; vertical-align: middle" />

          <asp:DropDownList ID="ddl_redpackagestuta" runat="server">
            <asp:ListItem Selected="True" Text="=全部=" Value="0"> </asp:ListItem>
            <asp:ListItem Text="领取完" Value="1"> </asp:ListItem>
            <asp:ListItem Text="领取中" Value="2"> </asp:ListItem>
            <asp:ListItem Text="未领取" Value="3"> </asp:ListItem>
          </asp:DropDownList>
          <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
          <asp:Button ID="btnQueryTD" runat="server" Text="今天" CssClass="btn wd1" OnClick="btnQueryTD_Click" />
          <asp:Button ID="btnQueryYD" runat="server" Text="昨天" CssClass="btn wd1" OnClick="btnQueryYD_Click" />
          <asp:Button ID="btnQueryTW" runat="server" Text="本周" CssClass="btn wd1" OnClick="btnQueryTW_Click" />
          <asp:Button ID="btnQueryYW" runat="server" Text="上周" CssClass="btn wd1" OnClick="btnQueryYW_Click" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="发送红包" class="btn wd1" onclick="Redirect('AddRedPackage.aspx');" />
        </td>
      </tr>
    </table>
    <div id="content">



      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
        <tr align="center" class="bold">
          <td class="listTitle">主题
          </td>
          <td class="listTitle">总金额
          </td>
          <td class="listTitle">总人数
          </td>
          <td class="listTitle">红包类型
          </td>
          <td class="listTitle">随机金额
          </td>
          <td class="listTitle">领取人数
          </td>
          <td class="listTitle">领取金额
          </td>
          <td class="listTitle">开始时间
          </td>
          <td class="listTitle2">截至时间
          </td>

          <td class="listTitle2">创建时间
          </td>
          <td class="listTitle2">限制条件
          </td>

        </tr>
        <asp:Repeater ID="rptUserInout" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <a class="l" href="javascript:void(0);" onclick="openWindowOwn('RecordUserPackage.aspx?param=<%#Eval("rid").ToString() %>','redpackage_<%#Eval("rid").ToString() %>',950,600);">
                  <%# Game.Utils.TextUtility.CutString( Eval("theme").ToString() ,0,15 )%></a>

              </td>
              <td>
                <%# Eval( "TotalScore" ).ToString( )  %>
              </td>
              <td>
                <%#   Eval("TotalUser")%>
              </td>
              <td>
                <%# (int)Eval("redtype") == 0 ? "<span style= ='color:green'>均分" : "<span >随机"%></span>
              </td>

              <td>
                <%# Eval("LessScore")%>
              </td>
              <td>
                <%# Eval("HaveUser")%>
              </td>
              <td>
                <%# Eval("GetScore")%>
              </td>
              <td>
                <%# Eval("ValidityStart")%>
              </td>
              <td>
                <%# Eval("ValidityEnd")%>
              </td>
              <td>
                <%# Eval("CollectDate")%>
              </td>


              <td>
                <%# GetLimit((int)Eval("limittype")) + ((int)Eval("limittype")==0?"":Eval("limit"))%>
              </td>

            </tr>
          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <a class="l" href="javascript:void(0);" onclick="openWindowOwn('RecordUserPackage.aspx?param=<%#Eval("rid").ToString() %>','redpackage_<%#Eval("rid").ToString() %>',950,600);">
                  <%# Game.Utils.TextUtility.CutString( Eval("theme").ToString() ,0,15 )%></a>

              </td>
              <td>
                <%# Eval( "TotalScore" ).ToString( )  %>
              </td>
              <td>
                <%#   Eval("TotalUser")%>
              </td>
              <td>
                <%# (int)Eval("redtype") == 0 ? "<span style= ='color:green'>均分" : "<span >随机"%></span>
              </td>
              <td>
                <%# Eval("LessScore")%>
              </td>
              <td>
                <%# Eval("HaveUser")%>
              </td>
              <td>
                <%# Eval("GetScore")%>
              </td>
              <td>
                <%# Eval("ValidityStart")%>
              </td>
              <td>
                <%# Eval("ValidityEnd")%>
              </td>
              <td>
                <%# Eval("CollectDate")%>
              </td>
              <td>
                <%# GetLimit((int)Eval("limittype")) + ((int)Eval("limittype")==0?"":Eval("limit"))%>
              </td>
            </tr>
          </AlternatingItemTemplate>
        </asp:Repeater>
        <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
      </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td align="right" class="page">
          <gsp:AspNetPager ID="anpNews" runat="server" OnPageChanged="anpNews_PageChanged" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
            PageSize="20" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
            NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

