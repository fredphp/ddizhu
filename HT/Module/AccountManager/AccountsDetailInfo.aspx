<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccountsDetailInfo.aspx.cs" Inherits="MTEwin.Module.AccountManager.AccountsDetailInfo" %>

<%@ Register Src="~/Themes/TabUser.ascx" TagPrefix="Fox" TagName="Tab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/jquery.js"></script>
    <script type="text/javascript" src="../../scripts/jquery.validate.js"></script>
    <script type="text/javascript" src="../../scripts/messages_cn.js"></script>
    <script type="text/javascript" src="../../scripts/jquery.metadata.js"></script>

      
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    

</head>
<body>
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">
                目前操作功能：用户信息
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <Fox:Tab ID="fab1" runat="server" NavActivated="B"></Fox:Tab>
    <form runat="server" id="form1">
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="关闭" class="btn wd1" onclick="window.close();" />
                <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>

    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                <div class="hg3  pd7">
                    详细信息</div>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                ID号码（UserID）：
            </td>
            <td>
              原用户名：
                <asp:Literal ID="ltRegAccounts" runat="server"></asp:Literal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Literal ID="ltUserID" runat="server"></asp:Literal>
                用户名：<asp:Literal ID="ltAccounts" runat="server"></asp:Literal>
            </td>
        </tr>
          <tr>
        <td colspan="2"> 
        <table  >
        <tr>
            <td class="">
                真实姓名：
            </td>
            <td style="width:360px">
                <asp:TextBox ID="txtCompellation" runat="server" CssClass="text wd4" MaxLength="16"></asp:TextBox>&nbsp;真实姓名字符长度不可超过16个字符
              </td>
            <td class="">
                QQ 号 码：
            </td>
            <td>
                <asp:TextBox ID="txtQQ" runat="server" CssClass="text wd4" MaxLength="16" onkeyup="if(isNaN(value))execCommand('undo');"></asp:TextBox>&nbsp;QQ字符长度不可超过16个字符
            </td>
        </tr>
        </table>
        </td>
        </tr>
           <tr>
        <td colspan="2"> 
        <table >
        <tr>
            <td class="">
                电子邮箱：
            </td>
            <td style="width:360px">
                <asp:TextBox ID="txtEMail" runat="server" CssClass="text wd4" MaxLength="32" validate="{email:true}"></asp:TextBox>&nbsp;电子邮箱字符长度不可超过32个字符
            </td>
       
            <td class="">
                固定电话：
            </td>
            <td>
                <asp:TextBox ID="txtSeatPhone" runat="server" CssClass="text wd4" MaxLength="32"></asp:TextBox>&nbsp;固定电话字符长度不可超过32个字符
            </td>
        </tr>
          </table>
        </td>
        </tr>

            <tr>
        <td colspan="2"> 
        <table >
        <tr>
            <td class="">
                手机号码：
            </td>
            <td style="width:360px">
                <asp:TextBox ID="txtMobilePhone" runat="server" CssClass="text wd4" MaxLength="16" onkeyup="if(isNaN(value))execCommand('undo');"></asp:TextBox>&nbsp;手机号码字符长度不可超过16个字符
            </td>
        
            <td class="">
                邮政编码：
            </td>
            <td>
                <asp:TextBox ID="txtPostalCode" runat="server" CssClass="text wd4" MaxLength="8" onkeyup="if(isNaN(value))execCommand('undo');"></asp:TextBox>&nbsp;邮政编码字符长度不可超过8个字符
            </td>
        </tr>

         </table>
        </td>
        </tr>
          <tr>
        <td colspan="2"> 
        <table >
        <tr>
            <td class="listTdLeft"  style="width:auto">
                居住地址：
            </td>
            <td colspan="4">
                <asp:TextBox ID="txtDwellingPlace" runat="server" CssClass="text wd4" Style="width: 500px" MaxLength="128"></asp:TextBox>&nbsp;长度不可超过128个字符
            </td>
        </tr>
        <tr>
            <td class="listTdLeft" style="width:auto">
                用户备注：
            </td>
            <td colspan="4">
                <asp:TextBox ID="txtUserNote" runat="server" CssClass="text wd4" Style="width: 500px" MaxLength="256"></asp:TextBox>&nbsp;长度不可超过256个字符
            </td>
        </tr>
           </table>
        </td>
        </tr>

<!--------add---->
</table>
<table  border="0" align="center" cellpadding="0" cellspacing="0" width="99%"  class="listBg2">
      <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                <div class="hg3  pd7">
                    用户信息</div>
            </td>
        </tr>
           <tr>
        <td colspan="2"> 
        <table width="100%">
        <tr>
            <td class="listTdLeft">
                用户名：
            </td>
            <td  style="width:360px">
                <asp:TextBox ID="txtAccount" runat="server" CssClass="text wd4" MaxLength="20" ReadOnly></asp:TextBox>&nbsp;用户名字符长度不可超过31个字符
            </td>
        
            <td class="listTdLeft">
                登录密码：
            </td>
            <td>
                <asp:TextBox ID="txtLogonPass" TextMode="Password" runat="server" CssClass="text wd4" MaxLength="20"></asp:TextBox>&nbsp;留空不修改
            </td>
          
        </tr>
         </table>
        </td>
        </tr>

        <tr style="display: none;">
            <td class="listTdLeft">
                用户昵称：
            </td>
            <td>
                <asp:TextBox ID="txtNickName" runat="server" CssClass="text wd4" MaxLength="20"></asp:TextBox>&nbsp;用户昵称字符长度不可超过31个字符
            </td>
        </tr>
        <tr>
        <td colspan="2"> 
        <table width="100%">
           <tr>

        
            <td class="listTdLeft">
                <%=BankMoneyName%>密码：
            </td>
            <td style="width:360px">
                <asp:TextBox ID="txtInsurePass" TextMode="Password" runat="server" CssClass="text wd4" MaxLength="20"></asp:TextBox>&nbsp;留空不修改
            </td>
              <td class="listTdLeft">
                二级域名：
            </td>
            <td>
                <asp:TextBox ID="txtSLDomain" runat="server" CssClass="text wd4" MaxLength="20"></asp:TextBox>
            </td>
        </tr>
        </table>
        </td>
        </tr>
     
      
         <tr>
        <td colspan="2"> 
        <table>
          <tr>
            <td class="listTdLeft">
                性别：
            </td>
            <td>
                <asp:DropDownList ID="ddlGender" runat="server">
                    <asp:ListItem Value="1" >男</asp:ListItem>
                    <asp:ListItem Value="0">女</asp:ListItem>
                </asp:DropDownList>
            </td>
       
            <td class="listTdLeft">
                密码保护：
            </td>
            <td>
                <asp:Literal ID="ltProtectID" runat="server"></asp:Literal>
            </td>
        </tr>
        </table>
        </td>
        </tr>
          <tr>
            <td class="listTdLeft">
                第一级抽水比例：
            </td>
            <td>
                <asp:TextBox ID="txtSpreaderScale" runat="server" CssClass="text wd4" Width="20" MaxLength="2"></asp:TextBox>%&nbsp; 比例最高可设置为89%
                <asp:CheckBox ID="ckbIsSpreader" runat="server" Text="设为高级推广员" />
            </td>
        </tr>
        </table>


<table  border="0" align="center" cellpadding="0" cellspacing="0" width="99%"  class="listBg2">

          <tr>
            <td class="listTd" style="padding-left: 88px;" colspan="2">     
              
              <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('RecordUserRevenueList.aspx?param='+GetRequest('param',0),'RRevenueInfo'+GetRequest('param',0),1024,800);">
                    我的抽水记录</a>&nbsp;&nbsp;
                 <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('RecordUserFinanceList.aspx?param='+GetRequest('param',0),'RUserFinance'+GetRequest('param',0),1024,800);">
                    我的抽水结算记录</a>&nbsp;&nbsp;   
                <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('AccountUnderlingInfo.aspx?param='+GetRequest('param',0),'AccountUnderlingInfo'+GetRequest('param',0),1024,800);" >
                    下级玩家</a>&nbsp;&nbsp;    
            

                   
               
            </td>
        </tr>
</table>

<table  border="0" align="center" cellpadding="0" cellspacing="0" width="99%"  class="listBg2">
      
      
        <!---登录信息---->
      
          <tr style="display: none;">
            <td class="listTdLeft">
                经验值：
            </td>
            <td>
                <asp:TextBox ID="txtExperience" runat="server" CssClass="text wd4" MaxLength="20"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                <div class="hg3  pd7">
                    登录信息</div>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                网站登录次数：
            </td>
            <td>
                <asp:Literal ID="ltWebLogonTimes" runat="server"></asp:Literal>次
                <span style="padding-left: 100px;">大厅登录次数：</span>
                <asp:Literal ID="ltGameLogonTimes" runat="server"></asp:Literal>次
                <span style="padding-left: 10px;"></span>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                在线时长共计：
            </td>
            <td>
                <asp:Literal ID="ltOnLineTimeCount" runat="server"></asp:Literal>
                <span style="padding-left: 100px;">游戏时长共计：</span>
                <asp:Literal ID="ltPlayTimeCount" runat="server"></asp:Literal>
                <span style="padding-left: 10px;"></span>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                最后登录时间：
            </td>
            <td>
                <asp:Literal ID="ltLastLogonDate" runat="server"></asp:Literal>&nbsp;&nbsp;
                <asp:Literal ID="ltLogonSpacingTime" runat="server"></asp:Literal>前
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                最后登录地址：
            </td>
            <td>
                <asp:Literal ID="ltLastLogonIP" runat="server"></asp:Literal>&nbsp;&nbsp;
                <asp:Literal ID="ltLogonIPInfo" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                登录机器：
            </td>
            <td>
                <asp:Literal ID="ltLastLogonMachine" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                注册时间：
            </td>
            <td>
                <asp:Literal ID="ltRegisterDate" runat="server"></asp:Literal>&nbsp;&nbsp;
                <asp:Literal ID="ltRegSpacingTime" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                注册地址：
            </td>
            <td>
                <asp:Literal ID="ltRegisterIP" runat="server"></asp:Literal>&nbsp;&nbsp;
                <asp:Literal ID="ltRegIPInfo" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                注册机器：
            </td>
            <td>
                <asp:Literal ID="ltRegisterMachine" runat="server"></asp:Literal>
            </td>
        </tr>
        <!----登录信息 end---->
        
<!--------add end---->
    </table>
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="关闭" class="btn wd1" onclick="window.close();" />
                <asp:Button ID="btnSave1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

<script type="text/javascript">
    jQuery(document).ready(function () {

        var txtSpr = $("#<%=txtSpreaderScale.ClientID %>");
        var SprValue = txtSpr.val();
     
        $("#<%=ckbIsSpreader.ClientID %>").click(function () {
            if (this.checked) {
                txtSpr.removeAttr("disabled");
                txtSpr.val(SprValue);
            }
            else {
                txtSpr.attr("disabled", "disabled");
                txtSpr.val("10");
            }
        });


        jQuery.metadata.setType("attr", "validate");
        jQuery("#<%=form1.ClientID %>").validate();
    });
</script>

  