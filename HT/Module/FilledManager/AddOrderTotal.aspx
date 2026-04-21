<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddOrderTotal.aspx.cs" Inherits="MTEwin.Module.FilledManager.AddOrderTotal" %>

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
   
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">
                你当前位置：充值系统 - 其他途经充值加分补单
            </td>
        </tr>
    </table>
    
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
     <tr>
            <td class="listTdLeft" style="width: 80px">
                充值方式：
            </td>
            <td>
                <asp:DropDownList ID="ddl_paytype" runat="server">
                <asp:ListItem Text="微信" Value="5"></asp:ListItem>
                <asp:ListItem Text="支付宝"  Value="6" ></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft" style="width: 80px">
                充值玩家账号：
            </td>
            <td>
                 <asp:TextBox ID="txtacc" runat="server" CssClass="text"></asp:TextBox> 
            </td>
        </tr>
        
         <tr>
            <td class="listTdLeft" style="width: 80px">
                充值金额：
            </td>
            <td>
                 <asp:TextBox ID="txtorderamount" runat="server" CssClass="text"></asp:TextBox> 
            </td>
        </tr>
         <tr>
            <td class="listTdLeft" style="width: 80px">
                充值加币：
            </td>
            <td>
                 <asp:TextBox ID="txtaddscore" runat="server" CssClass="text"></asp:TextBox> 
            </td>
        </tr>
          </table>
  
     
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="OpList">
        <tr>
            <td height="39" class="titleOpBg">
                <asp:Button ID="btnQuery" runat="server" Text="确认添加" CssClass="btn wd1" OnClick="btnQuery_Click" /> 
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
    </form>
</body>
</html>
