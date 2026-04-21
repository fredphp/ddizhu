<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserSignConfig.aspx.cs"
    Inherits="MTEwin.Module.AccountManager.UserSignConfig" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
    <title></title>
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
                你当前位置：用户系统 -签到信息配置
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" onclick="Redirect('RecordUserSignList.aspx')" class="btn wd1"
                    value="返回">
            </td>
        </tr>
    </table>
    <table align="center" border="0" cellpadding="0" cellspacing="0" class="titleQueBg"
        width="100%">
        <tr>
            <td class="listTdLeft" style="width: 80px">
                查询：
            </td>
            <td>
                奖励类型：<asp:DropDownList ID="ddl_sertype" runat="server">
                    <asp:ListItem Text="累计签到奖励" Value="0"></asp:ListItem>
                    <asp:ListItem Text="连续签到奖励" Value="1"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btn_serch" runat="server" CssClass="btn wd1" Text="查询" OnClick="btn_serch_Click" />
            </td>
        </tr>
    </table>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box"
            id="list">
            <tr align="center" class="bold">
                <td class="listTitle2">
                    签到天数
                </td>
                <td class="listTitle2">
                    签到奖励金币
                </td>
                <td class="listTitle2">
                    签到奖励类型
                </td>
                <td class="listTitle2">
                    币类型
                </td>
                <td class="listTitle2">
                    操作
                </td>
            </tr>
            <asp:Repeater ID="rptDataList" runat="server" OnItemCommand="rptDataList_ItemCommand">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <asp:Label ID="lb_dayid" runat="server" Text='<%#Eval("DayID") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lb_gold" runat="server" Text='<%#Eval("RewardGold") %>'></asp:Label>
                            <asp:TextBox ID="tb_gold" Text='<%#Eval("RewardGold") %>' Visible="false" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lb_type" runat="server" Text='<%#((int)Eval("signtype")==0?"累计签到":"连续签到") %>'></asp:Label>
                        </td>
                      <td  title="金币请写：0, 幸运币:1">
                            <asp:Label ID="lb_scoretype" runat="server" Text='<%#  ((int)Eval("scoretype")==0?"金币":"幸运币")  %>'></asp:Label>
                            <asp:TextBox ID="tb_scoretype" Text='<%# Eval("scoretype")  %>' placeholder="金币请写：0, 幸运币:1"   Visible="false" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="btn_update" runat="server" CommandName="Update" Text="更新" />
                            <asp:Button ID="btn_sure" runat="server" Visible="false" CommandName="btn_sure" Text="确认" />
                            <asp:Button ID="btn_canser" runat="server" Visible="false" CommandName="btn_canser"
                                Text="取消" />
                            <asp:Button ID="btn_del" runat="server" Text="删除" CommandName="Delete" OnClientClick='<%# (int)Eval("signtype")==0?"javascript:return conform(\"确认删除此列？将会把大于此累计天数的也删除\")":""%>' />
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <asp:Label ID="lb_dayid" runat="server" Text='<%#Eval("DayID") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lb_gold" runat="server" Text='<%#Eval("RewardGold") %>'></asp:Label>
                            <asp:TextBox ID="tb_gold" Text='<%#Eval("RewardGold") %>' Visible="false" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lb_type" runat="server" Text='<%#((int)Eval("signtype")==0?"累计签到":"连续签到") %>'></asp:Label>
                        </td>
                        <td title="金币请写：0, 幸运币:1">
                            <asp:Label ID="lb_scoretype" runat="server" Text='<%#  ((int)Eval("scoretype")==0?"金币":"幸运币")  %>'></asp:Label>
                            <asp:TextBox ID="tb_scoretype" Text='<%# Eval("scoretype")  %>' placeholder="金币请写：0, 幸运币:1"   Visible="false" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="btn_update" runat="server" CommandName="Update" Text="更新" />
                            <asp:Button ID="btn_sure" runat="server" Visible="false" CommandName="btn_sure" Text="确认" />
                            <asp:Button ID="btn_canser" runat="server" Visible="false" CommandName="btn_canser"
                                Text="取消" />
                            <asp:Button ID="btn_del" runat="server" Text="删除" CommandName="Delete" OnClientClick='<%# (int)Eval("signtype")==0?"javascript:return conform(\"确认删除此列？将会把大于此累计天数的也删除\")":""%>' />
                        </td>
                    </tr>
                </AlternatingItemTemplate>
            </asp:Repeater>
            <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
        </table>
    </div>
    <table align="center" border="0" cellpadding="0" cellspacing="0" class="titleQueBg"
        width="100%">
        <tr>
            <td class="listTdLeft" style="width: 80px">
                新增：
            </td>
            <td>
                天数：<asp:TextBox ID="tb_day" runat="server"></asp:TextBox>
                金币：<asp:TextBox ID="tb_gold" runat="server"></asp:TextBox>
                类型：<asp:DropDownList ID="ddl_type" runat="server">
                    <asp:ListItem Text="累计签到奖励" Value="0"></asp:ListItem>
                    <asp:ListItem Text="连续签到奖励" Value="1"></asp:ListItem>
                </asp:DropDownList>
                奖励：<asp:DropDownList ID="ddl_scoretype" runat="server">
                    <asp:ListItem Text="金币" Value="0"></asp:ListItem>
                    <asp:ListItem Text="幸运币" Value="1"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btn_add" runat="server" CssClass="btn wd1" Text="添加" OnClick="btn_add_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td align="right" class="page">
                <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server"
                    AlwaysShow="true" FirstPageText="首页" LastPageText="末页" PageSize="31" NextPageText="下页"
                    PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                    NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%"
                    UrlPaging="false">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
