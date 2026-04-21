<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AwardInfo.aspx.cs" Inherits="MTEwin.Module.AwardManager.AwardInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
     <script type="text/javascript" src="../../scripts/jquery.js"></script>

    <script type="text/javascript" src="../../scripts/jquery.validate.js"></script>

    <script type="text/javascript" src="../../scripts/messages_cn.js"></script>

    <script type="text/javascript" src="../../scripts/jquery.metadata.js"></script>
    <link rel="stylesheet" href="/scripts/kindEditor/themes/default/default.css" />
    <link rel="stylesheet" href="/scripts/kindEditor/plugins/code/prettify.css" />
    <script src="/scripts/kindEditor/kindeditor.js"></script>
    <script src="/scripts/kindEditor/lang/zh-CN.js"></script>
    <script src="/scripts/kindEditor/plugins/code/prettify.js"></script>
    <title></title>
    <script type="text/javascript">
        jQuery(document).ready(function () {
            jQuery.metadata.setType("attr", "validate");
            jQuery.validator.addMethod("decmal1", function (value, element) {
                var decmal = /^\d+(\.\d+)?$/;
                return decmal.test(value) || this.optional(element);
            }, "现金价格格式有误");
            jQuery("#<%=form1.ClientID %>").validate();
        });
        KE.show({
            id: 'txtDescription',
            urlType: 'domain',
            imageUploadJson: '../../asp/upload_json.asp?type=award',
            fileManagerJson: '../../asp/file_manager_json.asp?type=award',
            allowFileManager: true
        });

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top"  class="Lpd10"><div class="arr"></div></td>
            <td width="1232" height="25" valign="top" align="left">你当前位置：奖品系统 - 奖品管理</td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td height="28">
                <ul>
	                <li class="tab2" onclick="Redirect('AwardTypeList.aspx')">类型</li>
	                <li class="tab2" onclick="Redirect('AwardPriceList.aspx')">价格</li>
	                <li class="tab1">奖品</li>
                </ul>
            </td>
        </tr>
    </table>  
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('AwardList.aspx')" />                           
                <input class="btnLine" type="button" />  
                <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn wd1" 
                    onclick="btnSave_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10"><div class="hg3  pd7">
                <asp:Literal ID="litInfo" runat="server"></asp:Literal>奖品信息</div></td>
        </tr>
        <tr>
            <td class="listTdLeft">奖品名称：</td>
            <td>        
                <asp:TextBox ID="txtAwardName" runat="server" CssClass="text" validate="{required:true}"></asp:TextBox>               
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">类型名称：</td>
            <td>        
                <asp:DropDownList ID="ddlTypeID" runat="server" Width="158px">
                </asp:DropDownList>               
            </td>
        </tr>        
        <tr>
            <td class="listTdLeft">价格名称：</td>
            <td>        
                <asp:DropDownList ID="ddlPriceID" runat="server" Width="158px">
                </asp:DropDownList>   
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">价格：</td>
            <td>        
                <asp:TextBox ID="txtPrice" runat="server" CssClass="text" validate="{decmal1:true}"></asp:TextBox>               
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">邮资：</td>
            <td>        
                <asp:TextBox ID="txtPostage" runat="server" CssClass="text" validate="{decmal1:true}"></asp:TextBox>               
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">剩余数量：</td>
            <td>        
                <asp:TextBox ID="txtRemainAmount" runat="server" CssClass="text" validate="{digits:true}" onkeyup="if(isNaN(value))execCommand('undo')"></asp:TextBox>               
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">排序：</td>
            <td>        
                <asp:TextBox ID="txtSortID" runat="server" CssClass="text" validate="{digits:true}" onkeyup="if(isNaN(value))execCommand('undo')"></asp:TextBox> 
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
            <td class="listTdLeft">图片：</td>
            <td>        
                <asp:FileUpload ID="FileUpload1" runat="server" CssClass="text" Width="355px" Height="22px" />
            </td>
        </tr>  
        <% 
            if (cmd != "add")
            {                
        %>
        <tr>
            <td class="listTdLeft">图片信息：</td>
            <td>        
                <asp:Image ID="imgInfo" runat="server"/>
            </td>
        </tr> 
        <% 
            } 
        %> 
        <tr>
            <td class="listTdLeft">奖品描述：</td>
            <td>        
                <asp:TextBox ID="txtDescription" runat="server" CssClass="text" Width="650px" Height="350px" TextMode="MultiLine"></asp:TextBox>     
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">创建时间：</td>
            <td>        
                <asp:Label ID="lblCollectDate" runat="server"></asp:Label>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('AwardList.aspx')" />                           
                <input class="btnLine" type="button" />  
                <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn wd1" 
                    onclick="btnSave_Click" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>

