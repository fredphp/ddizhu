<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyGoldRecord.aspx.cs"
    Inherits="MTEwin.Module.AgencyManager.ApplyGoldRecord" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
    <title></title>
    <script type="text/javascript" src="../../scripts/JQuery.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".setSpan").click(function () {
                $("#recordID").val($(this).attr("data-id"));
                $("#litBankName font").remove();
                $("#litBankNum font").remove();
                $("#litBankAgencyName font").remove();
                $("#litBankAddr font").remove();
                $("#litBankName").append("<font>" + $(this).attr("data-name") + "</font>");
                $("#litBankNum").append("<font>" + $(this).attr("data-num") + "</font>");
                $("#litBankAgencyName").append("<font>" + $(this).attr("data-BankUser") + "</font>");
                $("#litBankAddr").append("<font>" + $(this).attr("data-BankAddr") + "</font>");

                var reason = $(this).attr("data-reason");
                if (reason != "处理中") {
                    $("#txtReason").text(reason);
                }

                var type = $(this).attr("data-Canuse")
                if (type == "2" || type == "1") {
                    $(".rbStatus").attr("disabled", "true");
                    $("#btnSet").attr("disabled", "true");
                }
                else {
                    var a = $(".rbStatus")
                    $(".rbStatus").removeAttr("disabled");
                    $("#btnSet").removeAttr("disabled");
                }
                $("#divQuery").show();
            });
        });

        function HideDiv() {
            $("#divQuery").hide();
        }
    </script>
    <style type="text/css">
        .setSpan
        {
            color:#0000ff;
            cursor:pointer;
        }
        .querybox
        {
            width: 500px;
            background: #caebfc;
            font-size: 12px;
            line-height: 18px;
            text-align: left;
            border-left: 1px solid #066ba4;
            border-right: 1px solid #066ba4;
            border-bottom: 1px solid #066ba4;
            border-top: 1px solid #066ba4;
            z-index: 999;
            display:none;
            position: absolute;
            top: 150px;
            left: 200px;
            padding: 5px;
            filter: progid:DXImageTransform.Microsoft.DropShadow(color=#9a8559,offX=1,offY=1,positives=true);
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">
                你当前位置：代理系统 - 代理提款记录
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td>
               <asp:Literal ID="ltMoneyTotal" runat="server"></asp:Literal>
                <input class="btnLine" type="button" />
                  输入用户名或真实姓名或代理标识:<asp:TextBox ID="txtSearch" runat="server" CssClass="text"
                    ToolTip="输入帐号或用户标识"></asp:TextBox> 
                <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
                  <asp:DropDownList ID="ddl_success" runat="server">
                <asp:ListItem Text="==所有==" Value="0"></asp:ListItem>
                <asp:ListItem Text="成功" Value="1"></asp:ListItem>
                <asp:ListItem Text="失败" Value="2"></asp:ListItem>
                </asp:DropDownList>
                 <input class="btnLine" type="button" />
                日期查询：<asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
            </td>
        </tr>
    </table>
    <div id="divQuery" class="querybox">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                    <div class="hg3  pd7">
                        提款设置</div>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    银行名称：
                </td>
                <td>
                    <span id="litBankName"></span>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    银行卡号：
                </td>
                <td>
                    <span id="litBankNum"></span>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    开户姓名：
                </td>
                <td>
                    <span id="litBankAgencyName"></span>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    开户地址：
                </td>
                <td>
                    <span id="litBankAddr"></span>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    设置状态：
                </td>
                <td style="text-align:left">
                    <asp:RadioButtonList runat="server" ID="rbStatus" RepeatDirection="Horizontal">
                        <asp:ListItem Text="成功" Value="1" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="拒绝" Value="2"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft" style="width: 100px;">
                    处理理由：
                </td>
                <td>
                    <asp:TextBox ID="txtReason" runat="server" Height="131px" TextMode="MultiLine" 
                        Width="326px" Text="成功"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right" style="padding-bottom: 10px;">
                    <asp:Button ID="btnSet" runat="server" Text="处理" CssClass="btn wd1" OnClick="btnSet_Click" />
                    <input type="button" value="关闭" class="btn wd1" onclick="HideDiv()" />
                </td>
            </tr>
        </table>
    </div>
    <div class="clear">
    </div>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
            id="list">
            <tr align="center" class="bold">
                <td class="listTitle2">
                    代理标识
                </td>
                <td class="listTitle2">
                    用户名
                </td>
                <td class="listTitle2">
                    真实姓名
                </td>
                <td class="listTitle2">
                    银行名称
                </td>
                <td class="listTitle2">
                    提款前金币
                </td>
                <td class="listTitle2">
                    提款金币
                </td>
                <td class="listTitle2">
                    手续费
                </td>
                <td class="listTitle2">
                    提款时间
                </td>
                <td class="listTitle2">
                    状态
                </td>
                <td class="listTitle2">
                    理由
                </td>
                <td class="listTitle2">
                    操作
                </td>
            </tr>
            <asp:Repeater ID="rptDataList" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%#  Eval("AgencyID").ToString()%>
                        </td>
                        <td>
                            <a href='AddAgency.aspx?cmd=upAgency&param=<%# Eval("AgencyID") %>' style="color: #0000ff;">
                                <%#  GetAgencyLogonName(int.Parse(Eval("AgencyID").ToString()))%></a>
                        </td>
                        <td>
                            <%#  GetAgencyName(int.Parse(Eval("AgencyID").ToString()))%>
                        </td>
                        <td>
                            <%#  Eval("BankName")%>
                        </td>
                        <td>
                            <%#  Eval("CurGold").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("DrawGold").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("RevenueGold").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("ApplyTime").ToString()%>
                        </td>
                        <td>
                            <%#  GetBringStatue(int.Parse(Eval("Result").ToString()))%>
                        </td>
                        <td>
                            <%#  Eval("Remark").ToString()%>
                        </td>
                        <td>
                        <%--<span class='<%# int.Parse(Eval("Result").ToString())==0?"setSpan":""%>' data-id='<%# Eval("RecordID") %>' data-name='<%# Eval("BankName") %>' data-num='<%# Eval("BankNum") %>' data-BankUser='<%# Eval("BankAgencyName") %>' data-Canuse='<%# Eval("Result") %>' data-BankAddr='<%# Eval("BankAddr") %>' >设置</span>--%>
                            <span class="setSpan" data-reason='<%# Eval("Remark") %>' data-id='<%# Eval("RecordID") %>' data-name='<%# Eval("BankName") %>' data-num='<%# Eval("BankNum") %>' data-BankUser='<%# Eval("BankAgencyName") %>' data-Canuse='<%# Eval("Result") %>' data-BankAddr='<%# Eval("BankAddr") %>' >设置</span>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <%#  Eval("AgencyID").ToString()%>
                        </td>
                        <td>
                            <a href='AddAgency.aspx?cmd=upAgency&param=<%# Eval("AgencyID") %>' style="color: #0000ff;">
                                <%#  GetAgencyLogonName(int.Parse(Eval("AgencyID").ToString()))%></a>
                        </td>
                        <td>
                            <%#  GetAgencyName(int.Parse(Eval("AgencyID").ToString()))%>
                        </td>
                        <td>
                            <%#  Eval("BankName")%>
                        </td>
                        <td>
                            <%#  Eval("CurGold").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("DrawGold").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("RevenueGold").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("ApplyTime").ToString()%>
                        </td>
                        <td>
                            <%#  GetBringStatue(int.Parse(Eval("Result").ToString()))%>
                        </td>
                        <td>
                            <%#  Eval("Remark").ToString()%>
                        </td>
                        <td>
                            <span class="setSpan" data-reason='<%# Eval("Remark") %>' data-id='<%# Eval("RecordID") %>' data-name='<%# Eval("BankName") %>' data-num='<%# Eval("BankNum") %>' data-BankUser='<%# Eval("BankAgencyName") %>' data-Canuse='<%# Eval("Result") %>' data-BankAddr='<%# Eval("BankAddr") %>' >设置</span>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
            </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
        </table>
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="listTitleBg">
                <span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a
                    class="l1" href="javascript:SelectAll(false);">无</a>
            </td>
            <td align="right" class="page">
                <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server"
                    AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="15" NextPageText="下页"
                    PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                    NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
                    UrlPaging="false">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>
    <input type="hidden" id="recordID" runat="server" value="0" />
       <input type="hidden" id="latest" runat="server" value="" />
    </form>
      <script type="text/javascript" src="../../scripts/jquery-1.4.2.min.js"></script>
    <script type="text/javascript">
        var str;
        $(function () {
            //str = $("#list").find("tr").eq(1).find("td").eq(1).find("a").eq(0).attr("href");
            //str = str.substring(str.indexOf("?param=") + 7, str.indexOf('&'));
            str = $("#latest").val();
            getres(str);
        });

        function getres() {
            if (str == "") return;
            $.ajax({
                url: '/Tools/Operating.ashx?action=agentapply&id=' + str,
                type: 'get',
                dataType: 'json',
                success: function (data) {
                    //alert(data.msg);
                    if (data.msg * 1 != 0) {
                        alert("您有[ " + data.msg + " ]笔新的订单");
                        location.href = location.href;
                    }

                },
                complete: function () {

                }
            });
        }

        var intv = setInterval("getres();", 3000);
    </script>
</body>
</html>
