<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmialSend.aspx.cs" Inherits="MTEwin.Module.AppManager.EmialSend" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
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
            <td width="1232" height="25" valign="top" align="left">
                你当前位置：用户系统 - 发送邮件
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
       <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('EmailList.aspx')" />                           
                <input class="btnLine" type="button" />  
                <asp:Button ID="Button1" runat="server" Text="发送" CssClass="btn wd1" 
                    onclick="btnSave_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
     <tr>
            <td class="listTdLeft" style="width: 80px">
                发送者：
            </td>
            <td>
               <b>系统</b>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft" style="width: 80px">
                邮件标题：
            </td>
            <td>
                <asp:TextBox ID="tb_eTi" CssClass="text wd4 "  runat="server"></asp:TextBox>
            </td>
        </tr>
          <tr>
            <td class="listTdLeft" style="width: 80px">
                邮件内容：
            </td>
            <td>
                <asp:TextBox ID="tb_eCont" CssClass="text wd4 "  runat="server" Height="109px" 
                    TextMode="MultiLine"></asp:TextBox>
            </td>
        </tr>
         <tr>
            <td class="listTdLeft" style="width: 80px">
                邮件类型：
            </td>
            <td>
                <asp:RadioButtonList ID="rdl_etype" runat="server" AutoPostBack="true" 
                    onselectedindexchanged="rdl_etype_SelectedIndexChanged">
                <asp:ListItem Text="所有玩家" Value="0" Selected="True"> </asp:ListItem>
                <asp:ListItem Text="某玩家" Value="1" ></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
           <tr>
            <td class="listTdLeft" style="width: 80px">
                <asp:Literal ID="ltl_Tip" runat="server" Text="接受者："></asp:Literal>
            </td>
            <td>
                <asp:TextBox ID="tb_rec" CssClass="text wd4 " palceholder="玩家帐号"  Text="全部玩家" ReadOnly="true" runat="server"    ></asp:TextBox>
            </td>
        </tr>


    </table>
     <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('EmailList.aspx')" />                           
                <input class="btnLine" type="button" />  
                <asp:Button ID="btnSave" runat="server" Text="发送" CssClass="btn wd1" 
                    onclick="btnSave_Click" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
