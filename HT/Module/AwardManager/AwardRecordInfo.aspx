<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AwardRecordInfo.aspx.cs" Inherits="MTEwin.Module.AwardManager.AwardRecordInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
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
            <td width="19" height="25" valign="top"  class="Lpd10"><div class="arr"></div></td>
            <td width="1232" height="25" valign="top" align="left">你当前位置：奖品系统 - 兑奖记录</td>
        </tr>
    </table>
    <!-- 头部菜单 End --> 
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('AwardRecordList.aspx')" />                           
                <input class="btnLine" type="button" />  
                <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn wd1" 
                    onclick="btnSave_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10"><div class="hg3  pd7">
                <asp:Literal ID="litInfo" runat="server"></asp:Literal>处理兑奖记录</div></td>
        </tr>
        <tr>
            <td class="listTdLeft">兑奖单号：</td>
            <td>        
                <asp:Label ID="lblOrderID" runat="server"></asp:Label>   
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">兑奖用户：</td>
            <td>        
                <asp:Label ID="lblUserID" runat="server"></asp:Label>   
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">奖品名称：</td>
            <td>        
                <asp:Label ID="lblAwardID" runat="server"></asp:Label>   
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">奖品价格：</td>
            <td>        
                <asp:Label ID="lblAwardPrice" runat="server"></asp:Label>            
            </td>
        </tr>        
        <tr>
            <td class="listTdLeft">兑换数量：</td>
            <td>        
                <asp:Label ID="lblAwardCount" runat="server"></asp:Label>            
            </td>
        </tr>  
        <tr>
            <td class="listTdLeft">邮资：</td>
            <td>        
                <asp:Label ID="lblPostage" runat="server"></asp:Label>            
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">支付金额：</td>
            <td>        
                <asp:Label ID="lblPayPrice" runat="server"></asp:Label>            
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">姓名：</td>
            <td>        
                <asp:Label ID="lblCompellation" runat="server"></asp:Label>            
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">电话：</td>
            <td>        
                <asp:Label ID="lblMobilePhone" runat="server"></asp:Label>            
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">详细地址：</td>
            <td>        
                <asp:Label ID="lblDwellingPlace" runat="server"></asp:Label>            
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">邮编：</td>
            <td>        
                <asp:Label ID="lblPostalCode" runat="server"></asp:Label>            
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">兑换时间：</td>
            <td>        
                <asp:Label ID="lblBuyDate" runat="server"></asp:Label>            
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">兑换地址：</td>
            <td>        
                <asp:Label ID="lblBuyIP" runat="server"></asp:Label>            
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">订单状态：</td>
            <td>        
                <asp:RadioButtonList ID="rbtnOrderStatus" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="0" Text="新订单"></asp:ListItem>
                    <asp:ListItem Value="1" Text="已发货"></asp:ListItem>
                    <asp:ListItem Value="2" Text="已收货"></asp:ListItem>
                    <asp:ListItem Value="3" Text="申请退货"></asp:ListItem>
                    <asp:ListItem Value="4" Text="已退货"></asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">处理备注：</td>
            <td>        
                <asp:TextBox ID="txtSolveNote" runat="server" CssClass="text" TextMode="MultiLine" Height="60px" Width="500px"></asp:TextBox>          
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('AwardRecordList.aspx')" />                           
                <input class="btnLine" type="button" />  
                <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn wd1" 
                    onclick="btnSave_Click" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

