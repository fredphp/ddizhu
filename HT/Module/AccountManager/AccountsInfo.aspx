<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccountsInfo.aspx.cs" Inherits="MTEwin.Module.AccountManager.AccountInfo" %>

<%@ Register Src="~/Themes/TabUser.ascx" TagPrefix="Fox" TagName="Tab" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="/scripts/JQuery.js"></script>
    <%--  <link type="text/css" href="../../scripts/lhgdialog/lhgdialog.css" rel="stylesheet" />
    <script src="../../scripts/lhgdialog/lhgcore.min.js" type="text/javascript"></script>

    <script src="../../scripts/lhgdialog/lhgdialog.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function() {
            //弹出页面
            J('#btnSwitchFace').dialog({ id: 'winUserfaceList', title: '更换头像', width: 540, height: 385, page: '../../Tools/UserfacesList.aspx', rang: true, cover: true });
        })		        
    </script>--%>
</head>
<body>
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left" style="width: 1232px; height: 25px;
                vertical-align: top; text-align: left;">
                目前操作功能：用户信息
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <Fox:Tab ID="fab1" runat="server" NavActivated="A"></Fox:Tab>
    <script type="text/javascript">
        function CheckForm() {
            var re = /^(-?[1-9][0-9]*|0)$/;
            var userName = document.form1.in_Accounts.value;
            var experience = document.form1.in_Experience.value;
            var loveLiness = document.form1.in_LoveLiness.value;
            var present = document.form1.in_Present.value;
            var nickname = document.form1.in_Nickname.value;
            var underWrite = document.form1.in_UnderWrite.value;
            if (userName.trim() == "") {
                alert("用户名不能为空！");
                document.form1.in_Accounts.focus();
                return false;
            }
            else if (len(userName.trim()) > 31) {
                alert("用户名字符长度不可超过31个字符！");
                document.form1.in_Accounts.focus();
                return false;
            }
            if (len(nickname.trim()) > 31) {
                alert("用户昵称字符长度不可超过31个字符！");
                document.form1.in_Nickname.focus();
                return false;
            }
            if (len(underWrite.trim()) > 63) {
                alert("个性签名字符长度不可超过63个字符！");
                document.form1.in_UnderWrite.focus();
                return false;
            }
            if (!re.test(experience)) {
                alert("经验值必须为整数！");
                document.form1.in_Experience.focus();
                return false;
            }
            if (!re.test(present)) {
                alert("礼物必须为整数！");
                document.form1.in_Present.focus();
                return false;
            }
            if (!re.test(loveLiness)) {
                alert("魅力值必须为整数！");
                document.form1.in_LoveLiness.focus();
                return false;
            }

        }
    </script>
    <form runat="server" id="form1">
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="关闭" class="btn wd1" onclick="window.close();" />
                <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
                <input type="button" value="刷新" class="btn wd1" onclick="location.href=location.href;"  />
            </td>
        </tr>
    </table>
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                <div class="hg3  pd7">
                    基本信息</div>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                ID号码(UserID)：
            </td>
            <td>
                <asp:Literal ID="ltUserID" runat="server"></asp:Literal>
                 用户名：<asp:Literal ID="ltAccounts" runat="server"></asp:Literal>
                <span class="Lpd10 bold">直属站点：</span><asp:Literal ID="ltStationName" runat="server"></asp:Literal>
                <span class="Lpd10 bold">直属上级：</span><asp:Literal ID="ltSpreader" runat="server"></asp:Literal>
                <span class="Lpd10 bold">注册设备：</span><asp:Literal ID="ltDevice" runat="server"></asp:Literal>
                <span class="Rpd20 lan bold"></span>
            </td>
        </tr>
        <tr>
        <td class="listTdLeft">控制标志：</td>
        <td> <asp:TextBox ID="txt_mark" runat="server" Width="25" ></asp:TextBox><b class="hong">一个字</b></td>
        </tr>
        <tr>
            <td class="listTdLeft">
                在线状态：
            </td>
            <td>
                <asp:Literal ID="lit_online" runat="server"></asp:Literal>
            </td>
        </tr>
        <%-- <tr>
            <td class="listTdLeft">
                头像：
            </td>
            <td>
                <input id="inFaceID" name="inFaceID" type="hidden" value="<%=strFaceID %>" />
                <img id="picFace" alt="头像" title="头像" src="/gamepic/face<%=strFaceID %>.gif" />&nbsp;&nbsp;
                <a href="javascript:void(0)" id="btnSwitchFace">查看更多头像</a>
            </td>
        </tr>--%>
        <tr>
            <td class="listTdLeft">
                选项：
            </td>
            <td>
                <asp:CheckBox ID="ckbNullity" runat="server" Text="冻结帐号" />
                <asp:CheckBox ID="ckbStunDown" runat="server" Text="安全关闭" Visible="false" />
                <asp:CheckBox ID="chkIsAndroid" runat="server" Text="设为机器人" />
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                锁定机器：
            </td>
            <td>
                <asp:RadioButtonList ID="rdoMoorMachine" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Value="0" Selected="True">未锁定</asp:ListItem>
                    <asp:ListItem Value="1">客户端锁定</asp:ListItem>
                    <asp:ListItem Value="2">网页锁定</asp:ListItem>
                </asp:RadioButtonList>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                <%--全选<input type="checkbox" onclick="CheckAll();" />--%>
                用户权限：
            </td>
            <td>
                <asp:CheckBoxList ID="ckbUserRight" runat="server" RepeatDirection="Horizontal" RepeatColumns="6">
                </asp:CheckBoxList>
            </td>
        </tr>
		<tr>
            <td class="listTdLeft">
            禁止游戏：
            </td>
            <td>
                <asp:CheckBoxList ID="ckbServerID" runat="server" RepeatDirection="Horizontal" RepeatColumns="6"></asp:CheckBoxList>
            </td>
        </tr>
        <tr  >
            <td class="listTdLeft">
                用户身份：
            </td>
            <td>
                &nbsp;<asp:DropDownList ID="ddlMasterOrder" runat="server">
                    <asp:ListItem Value="0" Text="玩家"></asp:ListItem>
                    <asp:ListItem Value="1" Text="管理员"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr  >
            <td class="listTdLeft">
                管理权限：
            </td>
            <td>
                <asp:CheckBoxList ID="ckbMasterRight" runat="server" RepeatDirection="Horizontal" RepeatColumns="6">
                </asp:CheckBoxList>
            </td>
        </tr> 
        <tr>
            <td class="listTdLeft">
                现金余额：
            </td>
            <td>
                <asp:Literal ID="ltScore" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                <%=base.BankMoneyName%>余额：
            </td>
            <td>
                <asp:Literal ID="ltInsureScore" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                幸运币：
            </td>
            <td>
                <asp:Literal ID="litUserMedal" runat="server"></asp:Literal>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="listTdLeft">
                <table width="100%" cellpadding=0 cellspacing=0>
                    <tr>
                        <td class="wd2">
                            赢局：  <asp:Literal ID="ltWinCount" runat="server"></asp:Literal>
                        </td>
                        <td class="wd2">
                            输局：  <asp:Literal ID="ltLostCount" runat="server"></asp:Literal>
                        </td>
                        <td class="wd2">
                            和局： <asp:Literal ID="ltDrawCount" runat="server"></asp:Literal>
                        </td>
                        <td class="wd2">
                            逃局：  <asp:Literal ID="ltFleeCount" runat="server"></asp:Literal>
                        </td>
                        <td class="wd2">
                            游戏税收：  <asp:Literal ID="ltRevenue" runat="server"></asp:Literal>
                        </td>
                    </tr>
                   
                </table>
            </td>
        </tr>

          <tr>
            <td class="listTd" style="padding-left: 88px;" colspan="2">     
              
                <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('ChargeAndCash.aspx?types=4&param='+GetRequest('param',0),'UserInout'+GetRequest('param',0),1024,800);" >
                    游戏记录</a>&nbsp;&nbsp;     
                     <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('ChargeAndCash.aspx?types=5&param='+GetRequest('param',0),'RDrawInfo'+GetRequest('param',0),1024,800);" >
                   进出记录</a>&nbsp;&nbsp;         
                <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('ChargeAndCash.aspx?param='+GetRequest('param',0),'RInsure'+GetRequest('param',0),1024,800);" >
                      <%=base.BankMoneyName%>操作记录</a>&nbsp;&nbsp;    
                <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('ChargeAndCash.aspx?types=2&param='+GetRequest('param',0),'ShareDetail'+GetRequest('param',0),1024,800);" >
                    充值记录</a>&nbsp;&nbsp; 
                    <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('ChargeAndCash.aspx?types=3&param='+GetRequest('param',0),'ShareDetail2'+GetRequest('param',0),1024,800);" >
                     提现记录</a>&nbsp;&nbsp; 
                       <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('ChargeAndCash.aspx?types=1&param='+GetRequest('param',0),'AddScore'+GetRequest('param',0),1024,800);" >
                   赠送金币/幸运币记录</a>&nbsp;&nbsp; 

                    <a href="javascript:void(0)" class="l" onclick="javascript:openWindowOwn('ChargeAndCash.aspx?types=6&param='+GetRequest('param',0),'Roullte'+GetRequest('param',0),1024,800);" >
                   抽奖记录</a>&nbsp;&nbsp; 
                    <a href="RecordUserPackageById.aspx?param=<%=base.IntParam %>" target="content" class="l">红包记录</a>&nbsp;&nbsp;
                     <a href="/Module/WebManager/BindWeiXin.aspx?param=<%=base.IntParam %>" class="l">微信绑定记录</a>&nbsp;&nbsp; 
                     <a href="/Module/WebManager/GameShareList.aspx?param=<%=base.IntParam %>" class="l">分享记录</a>&nbsp;&nbsp;
                     <a href="/Module/WebManager/GameWxRegisterInfos.aspx?param=<%=base.IntParam %>" class="l">微信签到记录</a>&nbsp;&nbsp;
            </td>
        </tr>

           <tr>
            <td class="listTdLeft">
                管理员备注(管理员可见)：
            </td>
            <td>
                 <asp:TextBox ID="tb_adminnote"  runat="server" Height="45px"   TextMode="MultiLine" Width="643px"></asp:TextBox>
            </td>
        </tr>
    </table>
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="关闭" class="btn wd1" onclick="window.close();" />
                <asp:Button ID="btnSave1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
               <input type="button" value="刷新" class="btn wd1" onclick="location.href=location.href;"  />
            </td>
        </tr>
    </table>
    </form>
</body>
</html> <!--
<script type="text/javascript">
    $(document).ready(function () {

 
        var txtSpr = $("#<%//=txtSpreaderScale.ClientID %>");
        var SprValue = txtSpr.val();
        $("#<%//=ckbIsSpreader.ClientID %>").click(function () {
            if (this.checked) {
                txtSpr.removeAttr("disabled");
                txtSpr.val(SprValue);
            }
            else {
                txtSpr.attr("disabled", "disabled");
                txtSpr.val("10");
            }
        });
  

    });
</script>-->
