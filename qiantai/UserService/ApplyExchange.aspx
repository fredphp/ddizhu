<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyExchange.aspx.cs"
    Inherits="Game.Web.UserService.ApplyExchange" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="Stylesheet" type="text/css" href="../Style/PlatformBase.css" />
</head>
<body>
    <div class="platContentBox">
        <form id="form1" runat="server">
        <div class="platContent">
            <dt>温馨提示： </dt>
            <dd style="padding-left:40px;">
                1.本系统每周<span class="important">星期一,星期二,星期三,星期四,星期五,星期六,星期日</span>开放，开放时间为当天的<span class="important">0</span>点到<span class="important">24</span>点。
                <br />
                2.本系统当前状态为<span class="important">开启，当前时段可以进行交易！</span>。<br />
                3.当前系统金币价格为：1金币=<span class="important">1</span>元，每次最少出售<Label ID="lblMinCharge" class="important" runat="server">20</Label>金币。 <span class="important">注册赠送的金币不可以出售。</span>
                <br />
                4.当前每次交易手续费为交易总额的<Label ID="lblChargeRate" class="important" runat="server">1%</Label>，最低手续费额为<span class="important">2</span>元 。每天可出售<Label ID="lblChargeTimes" class="important" runat="server">2</Label>次！如24小时内未收到提款请及时联系在线客服.<br />
                5.游戏中不能出售金币，要出售金币，请先退出游戏大厅。
                <br />
                6.请正确填写开户行，银行账号，开户行具体地址（例：某省某市某区某某分行）开户名需与注册时一致,以免影响出款.。
                <br />
                7.请将金币存到保险柜，才能实现兑换。
            </dd>
            <fieldset id="chargeContent">
                <legend class="white f15 bold">出售金币</legend>
                <table>
                    <tr>
                        <td class="tright">
                            游戏账号:
                        </td>
                        <td class="white">
                            <asp:Literal runat="server" ID="lAccounts"></asp:Literal>
                        </td>
                        <td class="tright">
                            真实姓名:
                        </td>
                        <td class="white">
                            <asp:Literal runat="server" ID="lNickName"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                            保险柜金币:
                        </td>
                        <td class="white">
                            <asp:Literal runat="server" ID="lInsureScore"></asp:Literal>
                        </td>
                        <td class="tright">
                            身上金币:
                        </td>
                        <td class="white">
                            <asp:Literal runat="server" ID="lScore"></asp:Literal>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                            保险柜密码:
                        </td>
                        <td class="black" colspan="3">
                            <asp:TextBox runat="server" TextMode="Password" ID="txtInsurePwd" CssClass="w200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                            开户行:
                        </td>
                        <td class="black" colspan="3">
                            <asp:TextBox runat="server" ID="txtBankName" CssClass="w200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                            开户行详细地址:
                        </td>
                        <td class="black" colspan="3">
                            <asp:TextBox runat="server" ID="txtBankAddr" CssClass="w200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                            银行卡号:
                        </td>
                        <td class="black" colspan="3">
                            <asp:TextBox runat="server" ID="txtBankNum" CssClass="w200"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="tright">
                            出售:
                        </td>
                        <td class="black" colspan="3">
                            <asp:TextBox runat="server" ID="txtScore" CssClass="w80"></asp:TextBox>金币
                        </td>
                    </tr>
                    <tr>
                        <td class="tcenter" colspan="4">
                            <asp:Button runat="server" ID="btnRecharge" CssClass="btnSubmit" 
                                onclick="btnRecharge_Click" />
                        </td>
                    </tr>
                </table>
            </fieldset>
        </div>
        </form>
    </div>
</body>
</html>
