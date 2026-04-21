<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RulesInfo.aspx.cs" Inherits="MTEwin.Module.WebManager.RulesInfo" %>

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
    * 设置图片文件
    */
    function setImgFilePath(frID,uploadPath) { document.getElementById(frID).contentWindow.setUploadFileView(uploadPath); }
    /*
    KE.show({
        id: 'txtHelpRule',
        urlType: 'domain',
        imageUploadJson: '../../asp/upload_json.asp?type=rules',
        fileManagerJson: '../../asp/file_manager_json.asp?type=rules',
        allowFileManager: true
    });
    //*/
    KindEditor.ready(function(K) {
      var editor1=K.create('#txtHelpRule',{
        cssPath: '/scripts/kindEditor/plugins/code/prettify.css',
        uploadJson: '/scripts/kindEditor/asp.net/upload_json.ashx?type=rules',
        fileManagerJson: '/scripts/kindEditor/asp.net/file_manager_json.ashx?type=rules',
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
    /*
            KE.show({
                id: 'txtHelpGrade',
                urlType: 'domain',
                imageUploadJson: '../../asp/upload_json.asp?type=rules',
                fileManagerJson: '../../asp/file_manager_json.asp?type=rules',
                allowFileManager: true
            });
    //*/
    KindEditor.ready(function(K) {
      var editor1=K.create('#txtHelpGrade',{
        cssPath: '/scripts/kindEditor/plugins/code/prettify.css',
        uploadJson: '/scripts/kindEditor/asp.net/upload_json.ashx?type=rules',
        fileManagerJson: '/scripts/kindEditor/asp.net/file_manager_json.ashx?type=rules',
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
        <td width="1232" height="25" valign="top" align="left">你当前位置：网站系统 - 反馈管理</td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect('RulesList.aspx')" />
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
            <asp:Literal ID="litInfo" runat="server"></asp:Literal>规则
          </div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">游戏名称：</td>
        <td>
          <asp:DropDownList ID="ddlKind" runat="server">
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">游戏截图：</td>
        <td>
          <asp:HiddenField ID="inImgRuleUrl" runat="server" />
          <iframe id="frImgRuleUrl" name="frImgRuleUrl" src="../../Tools/FilesUpload.aspx?inImgUrl=inImgRuleUrl&path=/upload/games/rules" width="800px" height="25px" frameborder="0" scrolling="no"></iframe>
        </td>
      </tr>
      <tr style="padding-top: 10px">
        <td class="listTdLeft">游戏介绍：</td>
        <td>
          <asp:TextBox ID="txtHelpIntro" runat="server" TextMode="MultiLine" Width="642px" Height="100px"></asp:TextBox>
        </td>
      </tr>
      <tr style="padding-top: 10px">
        <td class="listTdLeft">规则介绍：</td>
        <td>
          <asp:TextBox ID="txtHelpRule" runat="server" TextMode="MultiLine" Width="650px" Height="350px"></asp:TextBox>
        </td>
      </tr>
      <tr style="padding-top: 10px">
        <td class="listTdLeft">等级介绍：</td>
        <td>
          <asp:TextBox ID="txtHelpGrade" runat="server" TextMode="MultiLine" Width="650px" Height="250px"></asp:TextBox>
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
        <td class="listTdLeft">首页截图：</td>
        <td>
          <asp:HiddenField ID="inImgIndexUrl" runat="server" />
          <iframe id="frImgIndexUrl" name="frImgIndexUrl" src="../../Tools/FilesUpload.aspx?inImgUrl=inImgIndexUrl&path=/upload/games/spread" width="642px" height="25px" frameborder="0" scrolling="no"></iframe>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">列表截图：</td>
        <td>
          <asp:HiddenField ID="inImgJoinUrl" runat="server" />
          <iframe id="frImgJoinUrl" name="frImgJoinUrl" src="../../Tools/FilesUpload.aspx?inImgUrl=inImgJoinUrl&path=/upload/games/spread" width="642px" height="25px" frameborder="0" scrolling="no"></iframe>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">首页显示：</td>
        <td>
          <asp:RadioButtonList ID="rbtnIsIndex" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Value="1" Text="否" Selected="True"></asp:ListItem>
            <asp:ListItem Value="0" Text="是"></asp:ListItem>
          </asp:RadioButtonList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">列表显示：</td>
        <td>
          <asp:RadioButtonList ID="rbtnIsJoin" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Value="1" Text="否" Selected="True"></asp:ListItem>
            <asp:ListItem Value="0" Text="是"></asp:ListItem>
          </asp:RadioButtonList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">创建时间：</td>
        <td>
          <asp:Label ID="lblCollectDate" runat="server"></asp:Label>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">修改时间：</td>
        <td>
          <asp:Label ID="lblModifyDate" runat="server"></asp:Label>
        </td>
      </tr>
    </table>

    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect('RulesList.aspx')" />
          <input class="btnLine" type="button" />
          <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn wd1"
            OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

