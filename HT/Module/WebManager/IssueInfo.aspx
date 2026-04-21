<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IssueInfo.aspx.cs" Inherits="MTEwin.Module.WebManager.IssueInfo" %>

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
  <script type="text/javascript">
    /*
    KE.show({
        id: 'txtIssueContent',
        urlType: 'domain',
        imageUploadJson: '../../asp/upload_json.asp?type=issue',
        fileManagerJson: '../../asp/file_manager_json.asp?type=issue',
        allowFileManager: true
    });
    //*/
    KindEditor.ready(function(K) {
      var editor1=K.create('#txtIssueContent',{
        cssPath: '/scripts/kindEditor/plugins/code/prettify.css',
        uploadJson: '/scripts/kindEditor/asp.net/upload_json.ashx?type=issue',
        fileManagerJson: '/scripts/kindEditor/asp.net/file_manager_json.ashx?type=issue',
        allowFileManager: true,
        afterCreate: function() {
          var self=this;
          K.ctrl(document,13,function() {
            self.sync();
            K('form[name=form1]')[0].submit();
          });
          K.ctrl(self.edit.doc,13,function() {
            self.sync();
            K('form[name=form1]')[0].submit();
          });
        }
      });
      prettyPrint();
    });
  </script>
</head>
<body>
  <form id="form1" runat="server">
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
      <tr>
        <td width="19" height="25" valign="top" class="Lpd10">
          <div class="arr"></div>
        </td>
        <td width="1232" height="25" valign="top" align="left">你当前位置：网站系统 - 规则管理</td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect('IssueList.aspx')" />
          <input class="btnLine" type="button" />
          <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn wd1"
            OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
      <tr>
        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
          <div class="hg3  pd7">
            <asp:Literal ID="litInfo" runat="server"></asp:Literal>问题
          </div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">标题：</td>
        <td>
          <asp:TextBox ID="txtIssueTitle" runat="server" CssClass="text" Width="465px" MaxLength="30"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">禁用状态：</td>
        <td>
          <asp:RadioButtonList ID="rbtnNullity" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Value="0" Text="正常" Selected="True"></asp:ListItem>
            <asp:ListItem Value="1" Text="禁用"></asp:ListItem>
          </asp:RadioButtonList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">内容：</td>
        <td>
          <asp:TextBox ID="txtIssueContent" runat="server" CssClass="text" Width="650px" Height="350px" TextMode="MultiLine" MaxLength="300"></asp:TextBox>
        </td>
      </tr>
    </table>

    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect('IssueList.aspx')" />
          <input class="btnLine" type="button" />
          <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn wd1"
            OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

