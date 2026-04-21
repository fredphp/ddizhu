<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MatchReward.aspx.cs" Inherits="MTEwin.Module.AccountManager.MatchReward" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>   
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top"  class="Lpd10"><div class="arr"></div></td>
            <td width="1232" height="25" valign="top" align="left">你当前位置：用户系统 - 比赛奖励管理</td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('MatchUserInfo.aspx')" />                           
                <input class="btnLine" type="button" />  
                <asp:Button ID="btnSave" runat="server" Text="保存" CssClass="btn wd1" 
                    onclick="btnSave_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10"><div class="hg3  pd7">
                <asp:Literal ID="litInfo" runat="server"></asp:Literal>比赛奖励信息</div></td>
        </tr>
        <div id="divMatchName" runat="server">
        <tr>
            <td class="listTdLeft">比赛名称：</td>
            <td>        
                <asp:TextBox ID="txtMatchName" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>               
            </td>
        </tr>
        </div>
        <tr>
            <td class="listTdLeft">比赛房间：</td>
            <td>      
               <asp:TextBox ID="txtMatchRoom" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>                           
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">比赛类型：</td>
            <td>
                <asp:TextBox ID="txtMatchType" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>
            </td>
        </tr>
        <div id="divMatchTime" runat="server">
        <tr>
            <td class="listTdLeft">开始日期：</td>
            <td>      
                <asp:TextBox ID="txtBeginTime" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>                           
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">结束日期：</td>
            <td>        
                <asp:TextBox ID="txtEndTime" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>                           
            </td>
        </tr>
        </div>
        <div id="divMatchOnTime" runat="server">
        <tr>
            <td class="listTdLeft">开始日期：</td>
            <td>      
                <asp:TextBox ID="txtBeginDate" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>                           
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">结束日期：</td>
            <td>        
                <asp:TextBox ID="txtEndDate" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>                           
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">开始时间：</td>
            <td>      
                <asp:TextBox ID="txtOnTimeBeginTime" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>                           
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">结束时间：</td>
            <td>        
                <asp:TextBox ID="txtOnTimeEndTime" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>                           
            </td>
        </tr>
        </div>
        <tr>
            <td class="listTdLeft">比赛状态：</td>
            <td>        
                 <asp:TextBox ID="txtMatchStatus" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>                          
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">报名：</td>
            <td>        
                 <asp:TextBox ID="txtSign" Enabled="false" runat="server" CssClass="text" Width="200"></asp:TextBox>                           
            </td>
        </tr>  
        <tr>
            <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10"><div class="hg3  pd7">
                比赛奖励</div></td>
        </tr>     
        <tr>
            <td class="listTdLeft">第一名：</td>
            <td>        
                <asp:TextBox ID="txtfirst" runat="server" CssClass="text" Width="80"></asp:TextBox>               
                </td>
        </tr>   
        <tr>
            <td class="listTdLeft">第二名：</td>
            <td>        
                <asp:TextBox ID="txtSecond" runat="server" CssClass="text" Width="80"></asp:TextBox>               
                </td>
        </tr>
        <tr>
            <td class="listTdLeft">第三名：</td>
            <td>        
                <asp:TextBox ID="txtThird" runat="server" CssClass="text" Width="80"></asp:TextBox>               
                </td>
        </tr>
        <tr>
            <td class="listTdLeft">第四名：</td>
            <td>        
                <asp:TextBox ID="txtFour" runat="server" CssClass="text" Width="80"></asp:TextBox>               
                </td>
        </tr>
        <tr>
            <td class="listTdLeft">第五名：</td>
            <td>        
                <asp:TextBox ID="txtFive" runat="server" CssClass="text" Width="80"></asp:TextBox>               
                </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第六名：
            </td>
            <td>
                <asp:TextBox ID="txtSix" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第七名：
            </td>
            <td>
                <asp:TextBox ID="txtSeven" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第八名：
            </td>
            <td>
                <asp:TextBox ID="txtEight" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第九名：
            </td>
            <td>
                <asp:TextBox ID="txtNing" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
        <tr>
            <td class="listTdLeft">
                第十名：
            </td>
            <td>
                <asp:TextBox ID="txtTen" runat="server" CssClass="text" Width="80"></asp:TextBox>&nbsp;金币
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
            <td class="titleOpBg Lpd10">
                <input type="button" value="返回" class="btn wd1" onclick="Redirect('MatchUserInfo.aspx')" />                           
                <input class="btnLine" type="button" />  
                <asp:Button ID="btnSave1" runat="server" Text="保存" CssClass="btn wd1" onclick="btnSave_Click" />
            </td>
        </tr>
    </table>
    </form>
</body>
</html>



