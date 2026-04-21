<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddBankCard.aspx.cs" Inherits="MTEwin.Module.FilledManager.AddBankCard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

  <script type="text/javascript" src="../../scripts/common.js"></script>

  <script type="text/javascript" src="../../scripts/comm.js"></script>

  <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
  <script type="text/javascript">

    /*
    * 设置图片文件
    */
    function setImgFilePath(frID,uploadPath) {
      document.getElementById(frID).contentWindow.setUploadFileView(uploadPath);
    }


  </script>
  <style type="text/css">
    .green { color: Green; }
  </style>
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
        <td width="1232" height="25" valign="top" align="left">你当前位置：充值系统 - 系统银行卡
        </td>
      </tr>
    </table>

    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
      <tr>
        <td class="listTdLeft" style="width: 80px">卡号：
        </td>
        <td>
          <asp:TextBox ID="txtcard" runat="server" CssClass="text"></asp:TextBox>
        </td>
      </tr>

      <tr>
        <td class="listTdLeft" style="width: 80px">持卡人姓名：
        </td>
        <td>
          <asp:TextBox ID="txtname" runat="server" CssClass="text"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">卡类别：
        </td>
        <td>
          <asp:TextBox ID="txttypename" runat="server" CssClass="text"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">开户地址：
        </td>
        <td>
          <asp:TextBox ID="txtaddr" runat="server" CssClass="text"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">银行链接：
        </td>
        <td>
          <asp:TextBox ID="tb_cardurl" runat="server" CssClass="text"></asp:TextBox>
          <span class="hong">例如 http://www.cmbchina.com/</span>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft" style="width: 80px">二维码上传：
        </td>
        <td>
          <asp:HiddenField ID="inImgRuleUrl" runat="server" />
          <iframe id="frImgRuleUrl" name="frImgRuleUrl" src="../../Tools/FilesUpload.aspx?inImgUrl=inImgRuleUrl&path=/upload/web/ercode" width="800px" height="25px" frameborder="0" scrolling="no"></iframe>

        </td>
      </tr>
    </table>


    <div id="content">
    </div>

    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
      <tr>
        <td height="39" class="titleOpBg">
          <asp:Button ID="btnQuery" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnQuery_Click" />
        </td>
      </tr>
    </table>
  </form>
</body>
</html>


