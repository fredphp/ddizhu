<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Game.Web.Register" %>

<%@ Register TagPrefix="flb" TagName="Header" Src="~/Themes/Standard/Common_Header.ascx" %>
<%@ Register TagPrefix="flb" TagName="Footer" Src="~/Themes/Standard/Common_Footer.ascx" %>
<%@ Register TagPrefix="flb" TagName="ContentTop" Src="~/Themes/Standard/Context_Top.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="Style/Layout.css" />
    <link rel="Stylesheet" type="text/css" href="Style/Register.css" />
    <script type="text/javascript" src="Script/jquery-1.4.1.min.js"></script>
    <script type="text/javascript" src="Script/Register.js"></script>
    <script type="text/javascript">
        cpageId = 2;
        cpagetype = "register";
        window.onerror = function () {
            return true;
        }
    </script>
</head>
<body>
    <flb:Header ID="header" runat="server" />
    <form id="form1" runat="server">
    <div class="content">
        
        <div class="con-middle">
            <div class="con-con">
                <div id="regin-top">
                </div>
                <div id="regmian">
                    <span class="spancon">
                        <label class="lbreg" style="background-position:100% 2%">
                            </label>
                        <input id="txtAccounts" class="textreg required" type="text" runat="server" name="txtAccounts"
                            value="" size="15" maxlength="15" />
                        <span style="color: #CC0000; font-weight: bold;">*</span> <span class="formtips konError" id="txtAccountsTips">
                            用户名由6-15个英文字母或数字组成.</span> 
                     </span>
                     <span class="spancon">
                        <label class="lbreg" style="background-position:100% 18%">
                            </label>
                        <input id="txtRealname" class="textreg required" type="text" runat="server" name="txtRealname"
                            value="" size="20" maxlength="20" />
                        <span style="color: #CC0000; font-weight: bold;">*</span> <span class="formtips konError" id="txtRealnameTips">
                            必须与银行开户名一致,绑定后不可更改.</span>
                    </span>
                    <span class="spancon">
                        <label class="lbreg" style="background-position:100% 34%">
                            </label>
                        <input id="txtPwd" class="textreg required" type="password" runat="server" name="txtPwd"
                            value="" size="32" maxlength="32" />
                        <span style="color: #CC0000; font-weight: bold;">*</span> <span class="formtips konError" id="txtPwdTips">
                            由6-32个英文字母或数字组成.</span> 
                    </span>
                    <span class="spancon">
                        <label class="lbreg" style="background-position:100% 50%">
                            </label>
                        <input id="txtRepwd" class="textreg required" type="password" runat="server" name="txtRepwd"
                            value="" size="32" maxlength="32" />
                        <span style="color: #CC0000; font-weight: bold;">*</span> <span class="formtips konError" id="txtRepwdTips">
                            再一次输入密码.</span> 
                    </span>
                    <span class="spancon">
                        <label class="lbreg" style="background-position:100% 66%">
                            </label>
                        <input id="txtBankpwd" class="textreg required" type="password" runat="server" name="txtBankpwd"
                            value="" size="32" maxlength="32" />
                        <span style="color: #CC0000; font-weight: bold;">*</span> <span class="formtips konError" id="txtBankpwdTips">
                            保险箱密码由6-15个英文字母或数字组成.</span> 
                    </span>
                    <span class="spancon">
                        <label class="lbreg" style="background-position:100% 82%"></label>
                        <input id="txtRebankpwd" class="textreg required" type="password" runat="server" name="txtRebankpwd"
                            value="" size="32" maxlength="32" />
                        <span style="color: #CC0000; font-weight: bold;">*</span> 
                        <span class="formtips konError" id="txtRebankpwdTips">再一次输入保险箱密码.</span> 
                    </span>
                    <span class="spancon" style="display:none;">
                        <label class="lbreg">手机号码</label>
                        <input id="txtPhone" class="textreg required" type="text" runat="server" name="txtPhone"
                            value="" size="11" maxlength="11" />
                        <span style="color: #CC0000; font-weight: bold;">*</span> 
                        <span class="formtips konError" id="txtPhoneTips">找回密码使用请填写真实手机号.</span> 
                    </span>
                    <span class="spancon">
                        <label class="lbreg" style="background-position:100% 98%"></label>
                        <input id="txtValidate" class="textvalidate" type="text" runat="server" name="txtValidate"
                            value="" size="4" maxlength="4" />
                        <img onclick="UpdateImage()" src="/ValidateImage.aspx"
                            id="picVerifyCode" alt="点击图片更换验证码" style="cursor: pointer;  height: 20px; margin: 11px 10px -6px -51px; border: 0px;" />
                        <span style="color: #CC0000; font-weight: bold;">*</span> 
                        <span class="formtips konError" id="txtValidateTips">输入四位验证码.</span> 
                    </span>
                </div>
                <div id="regin-bottom">
                    <asp:Button ID="btnAffirm" CssClass="btnAffirm" runat="server" 
                        onclick="btnAffirm_Click" />
                    <input id="btnReset" class="btnReset" style="display:none;" type="button" value="" />
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="hidSpreaderType" value="0" runat="server" />
    <input type="hidden" id="hidAgencyId" value="0" runat="server" />
    </form>
    <flb:Footer ID="footer" runat="server" />
</body>
</html>
