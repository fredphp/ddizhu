<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="server_url.aspx.cs" Inherits="Game.Web.IpsPay.server_url" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="Jquery/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="Jquery/themes/icon.css" rel="stylesheet" type="text/css" />
    <link href="Jquery/demo/demo.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="Jquery/jquery.min.js"></script>
    <script type="text/javascript" src="Jquery/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="Jquery/locale/easyui-lang-zh_CN.js"></script>
    <style>
        td
        {
            line-height: 100%;
        }
    </style>
</head>
<body>
    <form id="Form1" runat="server">

        <div id="content">
            <div class="clearfix" style="margin: 0px 0px 0px 15px">
                <div id="logo">
                    <img src="images/logo.png" alt="环迅支付" />
                </div>
            </div>
            <div class="confirm-box">
                <img src="images/index_05.gif" border="0" align="absmiddle">
                &nbsp;&nbsp;确认付款信息→&nbsp;&nbsp;&nbsp;&nbsp;
            <img src="images/index_06.gif" border="0" align="absmiddle">
                &nbsp;&nbsp;付款→&nbsp;&nbsp;&nbsp;&nbsp;
            <img src="images/index_07.gif" border="0" align="absmiddle">&nbsp;&nbsp;付款完成
            </div>
            <div class="choosebank">
                <div id="Mainpay" style="padding-bottom: 10px">
                    <div class="tab">
                        <ul>
                            <li>支付结果</li>
                        </ul>
                    </div>

                    <table align="center" width="100%" cellspacing="0" border="0" class="write-info">
                        <tbody>
                            <tr>
                                <td align="right" valign="top">&nbsp;
                                </td>
                                <td>&nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td align="right" height="35" width="100">订单号 <span class="red"></span>：
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="IpsOrder"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" height="35" width="100">IPS订单号 <span class="red"></span>：
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lbIpsOrder"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td align="right" height="35" width="100">金额 <span class="red"></span>：
                                </td>
                                <td>
                                    <asp:Label runat="server" ID="lbAmount"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td align="right" height="35" width="100">状态 <span class="red"></span>：
                                </td>
                                <td>
                                    <asp:Label runat="server" ForeColor="ForestGreen" ID="lbState"></asp:Label>
                                </td>
                            </tr>
                             <tr>
                                <td align="right" height="35" width="100">内容<span class="red"></span>：
                                </td>
                                <td>
                                    <asp:Label runat="server"  ID="lbContent"></asp:Label>
                                </td>
                            </tr>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>

    </form>
</body>
</html>
