<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewsInfo1.aspx.cs" Inherits="AgencyManage.Manage.Notice.NewsInfo1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="../../Js/base.js"></script>
    <script type="text/javascript">
        $(function () {
            GlobalFunc.HideLoading();
        });
    </script>
    <style type="text/css">
        *
        {
            padding:0;
            margin:0;
        }
        ul
        {
            list-style:none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div id="main">
        <div style="width:100%; background-color:rgb(113,178,22); color:#ffffff; height:25px; padding-top:5px;">
            当前位置：代理后台>>信息维护>>公告详情
        </div>
        <div class="result">
            <fieldset id="fsNotice" style="width: 600px; height: 450px; text-align: center; margin-left:20px;">
                <legend>公告信息</legend>
                <ul class="form">
                    <li>
                        <div style="font-size: large; font-weight: bold">
                            <span><asp:Label ID="lblNewsName" runat="server"></asp:Label></span>
                        </div>
                    </li>
                    <li>
                        <div style="font-size: larger">
                            <span><asp:Label ID="lblNewsTime" runat="server"></asp:Label></span>
                        </div>
                    </li>
                    <li>
                        <div style="width:560px; display:block; margin-left:20px;">
                            <span id="lblNewsCont" runat="server" style="width:560px; text-align:left; display:block;"></span>
                        </div>
                    </li>
                </ul>
            </fieldset>
            <span id="lblEmpty" class="emptyData"></span>
        </div>
    </div>
    </form>
</body>
</html>
