<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AgencyManage.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>登录</title>
    <link href="Css/default.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function ChangeCodeimg() {
            Images = document.getElementById("ImageCheck");
            Images.src = "Tools/VerifyImagePage.aspx?" + Math.random();
        }
    </script>
</head>
<body id="loginBody">
    <form id="form1" runat="server">
    <div id="loginMain">
        <div id="login">
            <p>
                <input type="text" id="txtAccount" class="normalText" style="width: 140px;" runat="server" />
            </p>
            <p>
                <input type="password" id="txtPassword" class="normalText" style="width: 140px;"
                    runat="server" />
            </p>
            <p>
                <input type="text" id="txtCheckCode" runat="server" class="normalText" maxlength="5" />
                <img src="Tools/VerifyImagePage.aspx" id="ImageCheck" style="cursor: pointer;width:72px; height:24px;" title="点击更换验证码图片!"
                    onclick="ChangeCodeimg();" />
            </p>
            <p style="margin-top: 30px;">
                <asp:ImageButton ID="ibtnLogin" runat="server" src="Images/login.jpg" Width="60px"
                    Height="28px" OnClick="ibtnLogin_Click" /></p>
        </div>
    </div>
    </form>
</body>
</html>
