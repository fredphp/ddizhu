<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RecordUserPackage.aspx.cs" Inherits="MTEwin.Module.WebManager.RecordUserPackage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title></title>
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="../../scripts/common.js"></script>
  <script type="text/javascript" src="../../scripts/comm.js"></script>
  <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
  <style type="text/css">
    #info tr { width: 49%; float: left }
  </style>
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
        <td width="1232" height="25" valign="top" align="left">你当前位置：网站系统 - 红包详情
        </td>
      </tr>
    </table>
    <!-- 头部菜单 End -->
    <table id="info" width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>

        <td class="listTdLeft" style="width: 80px">红包主题：
        </td>
        <td>
          <asp:Literal ID="lit_theme" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">总金币：
        </td>
        <td>
          <asp:Literal ID="lit_TotalScore" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">红包总数量：
        </td>
        <td>
          <asp:Literal ID="lit_TotalUser" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">红包类型：
        </td>
        <td>
          <asp:Literal ID="lit_redtype" runat="server"></asp:Literal>
        </td>
      </tr>

      <tr>
        <td class="listTdLeft" style="width: 80px">随机金币：
        </td>
        <td>
          <asp:Literal ID="lit_lesscore" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">领取数量：
        </td>
        <td>
          <asp:Literal ID="lit_HaveUser" runat="server"></asp:Literal>
        </td>
      </tr>

      <tr>
        <td class="listTdLeft" style="width: 80px">领取金币：
        </td>
        <td>
          <asp:Literal ID="lit_Getscore" runat="server"></asp:Literal>
        </td>
      </tr>


      <tr>
        <td class="listTdLeft" style="width: 80px">开始时间：
        </td>
        <td>
          <asp:Literal ID="lit_ValidityStart" runat="server"></asp:Literal>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">结束时间：
        </td>
        <td>
          <asp:Literal ID="lit_ValidityEnd" runat="server"></asp:Literal>
        </td>
      </tr>

      <tr>
        <td class="listTdLeft" style="width: 80px">领取限制：
        </td>
        <td>
          <asp:Literal ID="lit_limittype" runat="server"></asp:Literal>
        </td>
      </tr>

      <tr>
        <td class="listTdLeft" style="width: 80px">隐藏红包：
        </td>
        <td>
          <asp:CheckBox ID="chb_nullity" runat="server" Text="勾选隐藏" AutoPostBack="true"
            OnCheckedChanged="chb_nullity_CheckedChanged" />
        </td>
      </tr>


      <tr>
        <td class="listTdLeft" style="width: 80px">领取红包：
        </td>
        <td>有<asp:TextBox ID="tb_number" runat="server" CssClass="wd2"></asp:TextBox>人，领取了
           <asp:TextBox ID="tb_score" runat="server" CssClass="wd2"></asp:TextBox>金币
                
                    <asp:Button ID="btn_virGetPackage" runat="server" Text="领取"
                      CssClass="btn wd1" OnClick="btn_virGetPackage_Click" />

        </td>
      </tr>

    </table>

    <table width="100%" id="table_ser" runat="server" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td class="listTdLeft" style="width: 80px">用户名：
        </td>
        <td>



          <asp:TextBox ID="tb_serch" runat="server" CssClass="wd2"></asp:TextBox>


          <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />

        </td>
      </tr>
    </table>
    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
        id="list">
        <tr align="center" class="bold">
          <td class="listTitle2">领取玩家名
          </td>
          <td class="listTitle2">领取金额
          </td>
          <td class="listTitle2">领取日期
          </td>
        </tr>
        <asp:Repeater ID="rptDataList" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <%# Eval("accounts") %>
              </td>
              <td>
                <%#  Eval("score")  %>
              </td>
              <td>
                <%# Eval("recordtime")%>
              </td>
            </tr>
          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <%# Eval("accounts") %>
              </td>
              <td>
                <%#  Eval("score")  %>
              </td>
              <td>
                <%# Eval("recordtime")%>
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
          <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server"
            AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="20" NextPageText="下页"
            PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
            NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
            UrlPaging="false">
          </gsp:AspNetPager>
        </td>
      </tr>
    </table>
  </form>
</body>
</html>
