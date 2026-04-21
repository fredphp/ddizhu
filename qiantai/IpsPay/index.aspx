<%@ Page ValidateRequest="false" Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs"
    Inherits="Game.Web.IpsPay.index" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="Jquery/themes/default/easyui.css" rel="stylesheet" type="text/css" />
    <link href="Jquery/themes/icon.css" rel="stylesheet" type="text/css" />
    <link href="Jquery/demo/demo.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="Form1" runat="server">
    <div id="content">
        <div class="clearfix" style="margin: 0px 0px 0px 15px">
            <div id="logo">
                <img src="images/logo.png" alt="环迅支付" /></div>
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
                        <li>支付接口</li>
                    </ul>
                </div>
                <table align="center" width="100%" cellspacing="0" border="0" class="write-info">
                    <tbody>
                        <tr>
                            <td align="right" valign="top">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td align="right" height="35">
                                <span class="red">*</span>充值账号：
                            </td>
                            <td>
                                <asp:TextBox Width="180px" ID="txtUname" name="txtUname" runat="server" AutoPostBack="true"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                <span class="red">*</span>支付方式：
                            </td>
                            <td>
                                <select id="txtGatewayType" name="txtGatewayType" style="width: 115px" runat="server">
                                    <option value="01" selected>借记卡</option>
                                    <option value="02">信用卡</option>
                                    <option value="03">IPS账户支付</option>
                                </select>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                <span class="red">*</span>币种：
                            </td>
                            <td>
                                <select id="txtCurrencyType" name="txtCurrencyType" style="width: 115px" runat="server">
                                    <option value="156" selected>人民币</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" height="35">
                                <span class="red">*</span>订单金额：
                            </td>
                            <td>
                                <input size="30" name="txtAmount" id="txtAmount" runat="server" value="0.02" />
                                <span class="tishi02">156#人民币,保留2位小数,例如：100.00</span>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                <span class="red">*</span>请求时间：
                            </td>
                            <td>
                                <input size="30" class="easyui-datebox" id="txtReqDate" runat="server" />
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                <span class="red">*</span>商户订单号：
                            </td>
                            <td>
                                <input size="30" runat="server" id="txtMerBillNo" name="txtMerBillNo" />
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                <span class="red">*</span>订单日期：
                            </td>
                            <td>
                                <input size="30" class="easyui-datebox" id="txtDate" runat="server" />
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                <span class="red">*</span>返回页面：
                            </td>
                            <td>
                                <input size="30" name="txtMerchanturl" id="txtMerchanturl" runat="server" />
                                <span class="tishi02">处理成功后返回跳转页面</span>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                <span class="red">*</span>支付加密：
                            </td>
                            <td>
                                <select id="OrderEncodeType" name="OrderEncodeType" style="width: 115px" runat="server">
                                    <option value="5" selected>MD5</option>
                                </select>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                <span class="red">*</span>返回加密：
                            </td>
                            <td>
                                <select id="RetEncodeType" name="RetEncodeType" style="width: 115px" runat="server">
                                    <option value="17" selected>MD5</option>
                                    <option value="16">MD5WithRSA</option>
                                </select>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                <span class="red">*</span>返回方式：
                            </td>
                            <td>
                                <select id="txtRetType" name="txtRetType" style="width: 115px" runat="server">
                                    <option value="1" selected>异步返回</option>
                                    <option value="2">Browser返回</option>
                                    <option value="3">两种都返回</option>
                                </select>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                <span class="red">*</span>异步返回：
                            </td>
                            <td>
                                <input size="30" name="txtServer" id="txtServer" runat="server" />
                                <span class="tishi02">异步返回地址</span>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                直连支付方式：
                            </td>
                            <td>
                                <select id="ddlDoCredit" name="ddlDoCredit" style="width: 115px" runat="server">
                                    <option value="0" selected>非直连</option>
                                    <option value="1">银行直连</option>
                                </select>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                银行号：
                            </td>
                            <td>
                                <input size="30" name="txtBankCode" id="txtBankCode" value="00095" runat="server" />
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right" height="35">
                                产品类型：
                            </td>
                            <td>
                                <select id="txtProductType" name="txtProductType" style="width: 115px" runat="server">
                                    <option value="1" selected>个人网银</option>
                                    <option value="2">企业网银</option>
                                </select>
                            </td>
                        </tr>
                        <tr style="display: none">
                            <td align="right">
                                消息编码：
                            </td>
                            <td>
                                <input maxlength="10" size="30" runat="server" id="txtMsgId" name="txtMsgId" />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                &nbsp;
                            </td>
                            <td>
                                <br>
                            </td>
                        </tr>
                        <tr>
                            <td height="50">
                                &nbsp;
                            </td>
                            <td>
                                <asp:Button ID="BtnIps" runat="server" CssClass="btn01" Text="下一步" OnClick="BtnIps_Click" />
                            </td>
                        </tr>
                    </tbody>
                </table>
                <div class="tishi">
                    <ul>
                        <li>支付小贴士：<br>
                            1、如果您点击“确认付款”按钮，即表示您同意向卖家购买此物品。
                            <br>
                            2、您有责任查阅完整的物品登录资料，包括卖家的说明和接受的付款方式。卖家必须承担物品信息正确登录的责任！<br />
                            3、最少支付<asp:Label Style="color: #FF6600" ID="minSpan" runat="server"></asp:Label>元</li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
