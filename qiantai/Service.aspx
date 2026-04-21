<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Service.aspx.cs" Inherits="Game.Web.Service" %>

<%@ Register TagPrefix="flb" TagName="Header" Src="~/Themes/Standard/Common_Header.ascx" %>
<%@ Register TagPrefix="flb" TagName="Footer" Src="~/Themes/Standard/Common_Footer.ascx" %>
<%@ Register TagPrefix="flb" TagName="ContentTop" Src="~/Themes/Standard/Context_Top.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="Style/Layout.css" />
    <link rel="Stylesheet" type="text/css" href="Style/Register.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0, maximum-scale=1.0,user-scalable=no"/>
    <style type="text/css">
        table {color:#fff;text-align:center;}
        table th{ background:#CCC; line-height:40px;background-color:#721e5a;} 
        table td{ background:#CCC; line-height:40px;background-color:#721e5a;}
        .click1{cursor:pointer;}
        .btn{width:104px;height:30px;position:fixed;z-index:+9;background:url(images/close.png) no-repeat;display:none;}
            .con-middle .con-con #regin-top {
                background:url("/Images/message.png") no-repeat scroll 0 0;
            }
    </style>
</head>
<body>
    <flb:Header ID="header" runat="server" />
    <button class="btn" onclick="callOC2('testFunc',{'param1':76,'param2':155,'param3':76})"></button>
    <form id="form1" runat="server">
        <div class="content">
            <div class="con-middle">
                <div class="con-con">
                    <div id="regin-top">
                    </div>
                    <div id="regmian">
                        <span class="spancon">
                            <label class="lbreg1">
                                用户名</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="textreg required"></asp:TextBox>
                            <span style="color: #CC0000; font-weight: bold;">*</span> <span class="formtips konError">用户名由6-15个英文字母或数字组成.</span>
                        </span>
                        <span class="spancon">
                            <label class="lbreg1">
                                主题</label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="textreg required" MaxLength="100"></asp:TextBox>
                        </span>
                        <span class="spancon">
                            <label class="lbreg1">
                                内容</label>
                            <asp:TextBox ID="txtContent" runat="server" CssClass="textreg1 required" TextMode="MultiLine" Height="110px"></asp:TextBox>
                        </span>
                        <span class="spancon">
                            <label class="lbreg1">验证码</label>
                            <asp:TextBox ID="txtImgCode" runat="server" CssClass="textreg required"></asp:TextBox>&nbsp;
                        <img id="picVerifyCode" style="vertical-align: middle;" width="60" height="23" onclick="UpdateImage()" alt="点击图片更换验证码" src="/ValidateImage.aspx" title="点击图片更换验证码" />
                        </span>
                    </div>
                    <div id="regin-bottom">
                        <asp:Button ID="btnAffirm" CssClass="btnAffirm" runat="server" OnClick="btnPublish_Click" OnClientClick="return checkAccounts();" />
                        <input class="btnReset" type="reset" value="" style="display:none;" />
                    </div>
                </div>
                <div class="con-con Message" style="display:none;">
                     <table width="100%" border="0" cellspacing="1" cellpadding="0"> 
                        <asp:Repeater ID="rptTable" runat="server">
                            <HeaderTemplate>
                                    <tr style="font-size:20px;color:#e0ad13;">
                                        <%--<th style="width:10%;">提交者</th>--%>
                                        <th>主题</th>
                                        <th>时间</th>
                                        <%--<th>人气</th>--%>
                                    </tr>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr class="click1">
                                    <%--<td><%#Eval("Accounts") %></td>--%>
                                    <td><%#Eval("FeedbackTitle") %></td>
                                    <td><%#Convert.ToDateTime(Eval("FeedbackDate").ToString()).ToString("yyyy-MM-dd HH:mm:ss")%></td> 
                                    
                                    <%--<td><%#Eval("ViewCount") %></td>--%>
                                </tr>
                            </ItemTemplate>
                            <AlternatingItemTemplate>
                                <tr style="display:none;">
                                    <td colspan="2" style="text-align:left;"><%#Eval("RevertContent") %></td>
                                </tr>
                            </AlternatingItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
        </div>
        <input type="hidden" id="hidSpreaderType" value="0" runat="server" />
        <input type="hidden" id="hidAgencyId" value="0" runat="server" />
    </form>
    <flb:Footer ID="footer" runat="server" />
</body>
</html>
<script type="text/javascript" src="Script/jquery-1.7.2.min.js"></script>
<script type="text/javascript">
    function UpdateImage() {
        document.getElementById("picVerifyCode").src = "/ValidateImage.aspx?r=" + Math.random();
    }
    //用户名的正确性
    function checkAccounts() {
        if ($.trim($("#txtName").val()) == "") {
            alert("请输入您的用户名");
            return false;
        }
        if ($.trim($("#txtTitle").val()) == "") {
            alert("请输入主题");
            return false;
        }
        var reg = /^[a-zA-Z0-9_\u4e00-\u9fa5]+$/;
        if (!reg.test($("#txtName").val())) {
            alert("用户名只能由字母、数字、下划线和汉字的组合！");
            return false;
        }
        var len = $("#txtName").val().replace(/(^\s*)|(\s*$)/g, "").replace(/[^\x00-\xff]/g, "**").length
        if (len < 6 || $("#txtName").length > 15) {
            alert("用户名的长度为6-15个字符");
            return false;
        }
        if ($.trim($("#txtImgCode").val()) == "") {
            alert("请输入验证码");
            return false;
        }
    }
    function callOC2(func, param) {
        var iframe = document.createElement("iframe");
        var url = "myapp:" + "&func=" + func;
        for (var i in param) url = url + "&" + i + "=" + param[i];
        iframe.src = url;
        iframe.style.display = 'none';
        document.body.appendChild(iframe);
        iframe.parentNode.removeChild(iFrame);
        iframe = null;
    }
    $(function () {
        $(".click1").click(function () {
            $(this).next("tr").show();
        })
    })
</script>
