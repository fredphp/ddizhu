<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LotteryConfigInfo.aspx.cs" Inherits="MTEwin.Module.WebManager.LotteryConfigInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
  <script type="text/javascript" src="../../scripts/common.js"></script>
  <link rel="stylesheet" href="/scripts/kindEditor/themes/default/default.css" />
  <link rel="stylesheet" href="/scripts/kindEditor/plugins/code/prettify.css" />
  <script src="/scripts/kindEditor/kindeditor.js"></script>
  <script src="/scripts/kindEditor/lang/zh-CN.js"></script>
  <script src="/scripts/kindEditor/plugins/code/prettify.js"></script>

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
        <td width="1232" height="25" valign="top" align="left">你当前位置：游戏系统 - 抽奖中奖率设置
        </td>
      </tr>
    </table>
    <div id="content">
      <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
        <tr align="center" class="bold">
          <td style="width: 30px;" class="listTitle">序号
          </td>
          <td class="listTitle2">操作
          </td>
          <td style="width: 100px;" class="listTitle2">奖项范围
          </td>
          <td class="listTitle2">中奖范围
          </td>
          <td class="listTitle2">中奖号码
          </td>
          <td class="listTitle2">奖金代号
          </td>
          <td class="listTitle2">奖金
          </td>
          <td class="listTitle1">说明
          </td>
        </tr>
        <asp:Repeater ID="rptDataList" runat="server">
          <ItemTemplate>
            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <%#Eval("ConfigID").ToString() %>
              </td>
              <td>
                <a href="LotteryConfigInfo.aspx?param=<%#Eval("ConfigID").ToString() %>" style="text-decoration: underline; color: Blue;">更新</a>
              </td>
              <td>
                <%#Eval( "MinNum" ).ToString( ) + "-" + Eval( "MaxNum" ).ToString( )%>
              </td>
              <td>1-<%#Eval("Probability").ToString() %>
              </td>
              <td>
                <%#Eval("Number").ToString() %>
              </td>
              <td>
                <%#Eval("Code").ToString() %>
              </td>
              <td>
                <%#Eval("Bonus").ToString() %>元
              </td>
              <td>
                <%#Eval("Remark").ToString() %>
              </td>
            </tr>
          </ItemTemplate>
          <AlternatingItemTemplate>
            <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
              onmouseout="this.style.backgroundColor=currentcolor">
              <td>
                <%#Eval("ConfigID").ToString() %>
              </td>
              <td>
                <a href="LotteryConfigInfo.aspx?param=<%#Eval("ConfigID").ToString() %>" style="text-decoration: underline; color: Blue;">更新</a>
              </td>
              <td>
                <%#Eval( "MinNum" ).ToString( ) + "-" + Eval( "MaxNum" ).ToString( )%>
              </td>
              <td>1-<%#Eval("Probability").ToString() %>
              </td>
              <td>
                <%#Eval("Number").ToString() %>
              </td>
              <td>
                <%#Eval("Code").ToString() %>
              </td>
              <td>
                <%#Eval("Bonus").ToString() %>元
              </td>
              <td>
                <%#Eval("Remark").ToString() %>
              </td>
            </tr>
          </AlternatingItemTemplate>
        </asp:Repeater>
      </table>
      <table width="90%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td colspan="3">
            <div style="padding: 5px 0px 5px 10px; line-height: 15px; font-size: 13px;">
              <span style="font-weight: bold;">中奖率配置说明：</span><br />
              中奖率公式：中奖率 = 奖项数字范围 ÷ 摇奖数字范围 ÷ 中奖数字范围<br />
              1、摇奖数字范围最小值和最大值定义了产生奖项数字的范围。<br />
              2、中奖数字范围是从1到中奖范围的最大值，此范围内产生中奖号码。<br />
              3、此抽奖活动的奖项有12个等级，奖项数字范围、中奖范围及中奖号码均在下面的录入框中进行设置，各个奖项数字的范围应在定义的摇奖数字范围内；奖项之间的数字范围不允许交叉。
            </div>
          </td>
        </tr>
        <tr>
          <td style="text-align: right; height: 35px; font-weight: bold;" width="10%">摇奖数字范围：
          </td>
          <td width="15%">
            <asp:TextBox ID="txtMin" runat="server" CssClass="text" Width="40" MaxLength="7"></asp:TextBox>&nbsp;至&nbsp;<asp:TextBox
              ID="txtMax" runat="server" CssClass="text" Width="40" MaxLength="7"></asp:TextBox>&nbsp;
          </td>
          <td>
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
          </td>
        </tr>
        <tr>
          <td style="text-align: right; height: 35px; font-weight: bold;" width="10%">奖项数字范围：
          </td>
          <td width="15%">
            <asp:TextBox ID="txtMinNum" runat="server" CssClass="text" Width="40" MaxLength="7"></asp:TextBox>&nbsp;至&nbsp;<asp:TextBox
              ID="txtMaxNum" runat="server" CssClass="text" Width="40" MaxLength="7"></asp:TextBox>&nbsp;
          </td>
          <td>
            <asp:Literal ID="ltRemark" runat="server"></asp:Literal>
          </td>
        </tr>
        <tr>
          <td style="text-align: right; height: 35px; font-weight: bold;">中奖数字范围：
          </td>
          <td>
            <asp:TextBox ID="txtProbability1" runat="server" Enabled="false" CssClass="text" Width="40" MaxLength="7" Text="1"></asp:TextBox>&nbsp;至&nbsp;<asp:TextBox
              ID="txtProbability" runat="server" CssClass="text" Width="40" MaxLength="7"></asp:TextBox>
          </td>
          <td>此范围内随机产生一个中奖号码，与下面所设定的中奖号码比较，若相同表示中奖。
          </td>
        </tr>
        <tr>
          <td style="text-align: right; height: 35px; font-weight: bold;">中奖号码：
          </td>
          <td>
            <asp:TextBox ID="txtNumber" runat="server" CssClass="text" Width="110" MaxLength="7"></asp:TextBox>
          </td>
          <td></td>
        </tr>
      </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

