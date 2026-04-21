<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgencyInfoList.aspx.cs"
    Inherits="MTEwin.Module.AgencyManager.AgencyInfoList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <title></title>
    <script type="text/javascript" src="../../scripts/JQuery.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".setRoty").click(function () {
                $("#divQuery").show();
                $("#txtRoty").val($(this).attr("data-con"));
                $("#hidAgencyId").val($(this).attr("data-id"));
            });
        });
        function HideDiv() {
            document.getElementById('divQuery').style.display = "none";
        }


        function GrantManager(a) {
            if (a * 1 == 2) {
                openWindowOwn('AddAgencyScoreList.aspx?', '_AddAgencyScoreList', 900, 640);
                return;
             }

            if (deleteop()) {
                var cid = "";
                var cids = GelTags("input");
                for (var i = 0; i < cids.length; i++) {
                    if (cids[i].checked) {
                        if (cids[i].name == "cid")
                            cid += cids[i].value + ",";
                    }
                }
                if (cid == "") {
                    showError("未选中任何数据");
                    return;
                }
                //操作处理
                cid = cid.substring(0, cid.length - 1);
                if (cid.indexOf(",") > 0) {
                    showError("只能操作一条数据");
                    return;
                }

                openWindowOwn('AddAgencyscore.aspx?param=' + cid, '_GrantTreasure', 600, 240);

            }
        }
    </script>
    <style type="text/css">
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
            border-top:1px solid #066ba4;
            z-index: 999;
            display: none;
            position: absolute;
            top: 150px;
            left: 200px; 
            padding:5px;
            filter:progid:DXImageTransform.Microsoft.DropShadow(color=#9a8559,offX=1,offY=1,positives=true); 
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
                你当前位置：代理系统 - 代理管理
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td>
                &nbsp;
                输入用户名或真实姓名或代理标识:<asp:TextBox ID="txtSearch" runat="server" CssClass="text" ToolTip="输入帐号或用户标识"></asp:TextBox>
                 
                <asp:CheckBox ID="ckbIsLike" runat="server" Text="模糊查询" />
                <asp:CheckBox ID="ckb_acc" runat="server" Text="下级玩家直属" />
                <asp:DropDownList ID="ddl_nullity" runat="server">
                <asp:ListItem Text="==所有==" Value="-1"></asp:ListItem>
                <asp:ListItem Text="启用" Value="0"></asp:ListItem>
                <asp:ListItem Text="禁用" Value="1"></asp:ListItem>
                </asp:DropDownList>

                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
            </td>
        </tr>
    </table>
    <div id="divQuery" class="querybox">
      
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
            <tr>
                <td class="listTdLeft" style="width: 50px;">
                    抽水比例：
                </td>
                <td>
                    <input id="txtRoty" runat="server" name="txtRoty" type="text" class="text wd2" />%
                </td>                
            </tr>
            <tr>
                <td colspan="2" align="right" style="padding-bottom: 10px;">
                    <asp:Button ID="btnSet" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnSet_Click" />
                    <input type="button" value="关闭" class="btn wd1" onclick="HideDiv()" />
                </td>
            </tr>
        </table>
    </div>
    <div class="clear">
    </div>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
        <tr>
            <td height="39" class="titleOpBg">
                <input type="button" value="新增" class="btn wd1" onclick="openWindowOwn('AddAgency.aspx','',850,600)" />
                <input class="btnLine" type="button" />
                <asp:Button ID="btnDongjie" runat="server" Text="冻结" CssClass="btn wd1" OnClick="btnDongjie_Click"
                    OnClientClick="return deleteop()" />
                <asp:Button ID="btnJiedong" runat="server" Text="解冻" CssClass="btn wd1" OnClick="btnJiedong_Click"
                    OnClientClick="return deleteop()" />
                    <input class="btnLine" type="button" />
                         <input type="button" value="加点" class="btn wd1" onclick=" GrantManager()" />
                            <input type="button" value="加点记录" class="btn wd2" onclick=" GrantManager(2)" />
            </td>
        </tr>
    </table>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
            id="list">
            <tr align="center" class="bold">
                <td class="listTitle">
                    <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" />
                </td>
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
                    上级代理
                </td>
                <td class="listTitle2">
                    金币
                </td>
                <td class="listTitle2">
                    抽水比例
                </td>
                <td class="listTitle2">
                    有效会员单价
                </td>
                <td class="listTitle2">
                    有效会员游戏时间
                </td>
                <td class="listTitle2">
                    电子邮箱
                </td>
                <td class="listTitle2">
                    QQ号码
                </td>
                <td class="listTitle2">
                    联系电话
                </td>
                <td class="listTitle2">
                    银行名称
                </td>
                <td class="listTitle2">
                    银行卡号码
                </td>
                <td class="listTitle2">
                    状态
                </td>
                <td class="listTitle2">
                    查看下级玩家
                </td>
                <td class="listTitle2">
                    查看下级代理
                </td>
            </tr>
            <asp:Repeater ID="rptDataList" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td style="width: 30px;">
                            <input name='cid' type='checkbox' value='<%# Eval("AgencyID").ToString()%>' />
                        </td>
                        <td>
                            <%#  Eval("AgencyID").ToString()%>
                        </td>
                        <td>
                            <a href='AddAgency.aspx?cmd=upAgency&param=<%# Eval("AgencyID") %>' style="color:#0000ff;"><%#  Eval("LoginName").ToString()%></a>
                        </td>
                        <td>
                            <%#  Eval("AgencyName").ToString()%>
                        </td>
                        <td>
                            <a href='AddAgency.aspx?cmd=upAgency&param=<%# Eval("AgencyParentID") %>' style="color:#0000ff;"><%#  GetAgencyLogonName(int.Parse(Eval("AgencyParentID").ToString()))%></a>
                        </td>
                        <td>
                            <%#  Eval("AgencyGold").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("AgencyRoyalty").ToString()%>%
                        </td>
                        <td>
                            <%#  Eval("UserPrice").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("UserPlayTime").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("AgencyEmail").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("AgencyQQ").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("AgencyPhone").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("BankName").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("BankNum").ToString()%>
                        </td>
                        <td>
                            <%#  GetNullityStatus(byte.Parse(Eval("AgencyFlag").ToString()))%>
                        </td>
                        <td>
                            <a href='AgencyAccountsList.aspx?param=<%#  Eval("AgencyID").ToString()%>' style="color:#0000ff; text-decoration:none; cursor:pointer;">查看</a>
                        </td>
                        <td>
                            <a href='AgencyInfoList.aspx?param=<%#  Eval("AgencyID").ToString()%>' style="color:#0000ff; text-decoration:none; cursor:pointer;">查看</a>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td style="width: 30px;">
                            <input name='cid' type='checkbox' value='<%# Eval("AgencyID").ToString()%>' />
                        </td>
                        <td>
                            <%#  Eval("AgencyID").ToString()%>
                        </td>
                        <td>
                            <a href='AddAgency.aspx?cmd=upAgency&param=<%# Eval("AgencyID") %>' style="color:#0000ff;"><%#  Eval("LoginName").ToString()%></a>
                        </td>
                        <td>
                            <%#  Eval("AgencyName").ToString()%>
                        </td>
                        <td>
                            <a href='AddAgency.aspx?cmd=upAgency&param=<%# Eval("AgencyParentID") %>' style="color:#0000ff;"><%#  GetAgencyLogonName(int.Parse(Eval("AgencyParentID").ToString()))%></a>
                        </td>
                        <td>
                            <%#  Eval("AgencyGold").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("AgencyRoyalty").ToString()%>%
                        </td>
                        <td>
                            <%#  Eval("UserPrice").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("UserPlayTime").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("AgencyEmail").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("AgencyQQ").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("AgencyPhone").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("BankName").ToString()%>
                        </td>
                        <td>
                            <%#  Eval("BankNum").ToString()%>
                        </td>
                        <td>
                            <%#  GetNullityStatus(byte.Parse(Eval("AgencyFlag").ToString()))%>
                        </td>
                        <td>
                            <a href='AgencyAccountsList.aspx?param=<%#  Eval("AgencyID").ToString()%>' style="color:#0000ff; text-decoration:none; cursor:pointer;">查看</a>
                        </td>
                        <td>
                            <a href='AgencyInfoList.aspx?param=<%#  Eval("AgencyID").ToString()%>' style="color:#0000ff; text-decoration:none; cursor:pointer;">查看</a>
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
    <input type="hidden" runat="server" id="hidAgencyId" />
    </form>
</body>
</html>
