<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeBehind="NewsInfo.aspx.cs" Inherits="MTEwin.Module.WebManager.NewsInfo" %>

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
        function setImgFilePath(frID, uploadPath) {
            document.getElementById(frID).contentWindow.setUploadFileView(uploadPath);
        }
/*
        KE.show({
            id: 'txtBody',
            urlType: 'domain',
            imageUploadJson: '../../asp/upload_json.asp?type=',
            fileManagerJson: '../../asp/file_manager_json.asp?type=',
            allowFileManager: true
        });
//*/
	KindEditor.ready(function(K) {
		    var editor1=K.create('#txtBody',{
		        cssPath: '/scripts/kindEditor/plugins/code/prettify.css',
		        uploadJson: '/scripts/kindEditor/asp.net/upload_json.ashx?type=',
		        fileManagerJson: '/scripts/kindEditor/asp.net/file_manager_json.ashx?type=',
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
        <td width="1232" height="25" valign="top" align="left">你当前位置：网站系统 - 新闻管理</td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect('NewsList.aspx')" />
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
            <asp:Literal ID="litInfo" runat="server"></asp:Literal>新闻
          </div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">标题：</td>
        <td>
          <asp:DropDownList ID="ddlClassID" runat="server" Width="80px">
            <asp:ListItem Value="1" Text="新闻"></asp:ListItem>
            <asp:ListItem Value="2" Text="公告"></asp:ListItem>
            <asp:ListItem Value="3" Text="活动"></asp:ListItem>
          </asp:DropDownList>
          <asp:TextBox ID="txtSubject" runat="server" CssClass="text" Width="465px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">首页活动图：</td>
        <td>
          <asp:HiddenField ID="inImgRuleUrl" runat="server" />
          <iframe id="frImgRuleUrl" name="frImgRuleUrl" src="../../Tools/FilesUpload.aspx?inImgUrl=inImgRuleUrl&path=/upload/games/news" width="800px" height="25px" frameborder="0" scrolling="no"></iframe>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">列表截图：</td>
        <td>
          <asp:HiddenField ID="inImgJoinUrl" runat="server" />
          <iframe id="frImgJoinUrl" name="frImgJoinUrl" src="../../Tools/FilesUpload.aspx?inImgUrl=inImgJoinUrl&path=/upload/games/news" width="642px" height="25px" frameborder="0" scrolling="no"></iframe>
        </td>
      </tr>

      <tr>
        <td class="listTdLeft">属性：</td>
        <td>
          <asp:CheckBox ID="chkOnTop" runat="server" Text="置顶" />
          <asp:CheckBox ID="chkOnTopAll" runat="server" Text="总置顶" />
          <asp:CheckBox ID="chkIsElite" runat="server" Text="推荐" />
          <asp:CheckBox ID="chkIsHot" runat="server" Text="热门" />
          <asp:CheckBox ID="chkIsLock" runat="server" Text="立即发布" Checked="true" />
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">引用：</td>
        <td>
          <asp:TextBox ID="txtLinkUrl" runat="server" CssClass="text" Text="http://" Width="550px"></asp:TextBox>
          <asp:CheckBox ID="chkIsLinks" runat="server" Text="链接地址" />
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">内容：</td>
        <td>
          <asp:TextBox ID="txtBody" runat="server" CssClass="text" Width="650px" Height="350px" TextMode="MultiLine"></asp:TextBox>
        </td>
      </tr>
    </table>

    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input type="button" value="返回" class="btn wd1" onclick="Redirect('NewsList.aspx')" />
          <input class="btnLine" type="button" />
          <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn wd1"
            OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>

