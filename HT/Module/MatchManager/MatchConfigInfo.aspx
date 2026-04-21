<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MatchConfigInfo.aspx.cs" Inherits="Game.Web.Module.MatchManager.MatchConfigInfo" %>

<%@ Register Src="/Tools/ImageUploader.ascx" TagName="ImageUploader" TagPrefix="GameImg" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
  <title></title>
  <link href="/styles/layout.css" rel="stylesheet" type="text/css" />
  <script src="../../scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
  <script type="text/javascript" src="/scripts/common.js"></script>
  <link rel="stylesheet" href="/scripts/kindEditor/themes/default/default.css" />
  <link rel="stylesheet" href="/scripts/kindEditor/plugins/code/prettify.css" />
  <script src="/scripts/kindEditor/kindeditor.js"></script>
  <script src="/scripts/kindEditor/lang/zh-CN.js"></script>
  <script src="/scripts/kindEditor/plugins/code/prettify.js"></script>
  <script type="text/javascript" src="/scripts/My97DatePicker/WdatePicker.js"></script>

</head>
<body>
  <form id="form1" runat="server" method="post">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
      <tr>
        <td width="19" height="25" valign="top" class="Lpd10">
          <div class="arr">
          </div>
        </td>
        <td width="1232" height="25" valign="top" align="left">你当前位置：比赛系统 - 比赛配置
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input id="btnReturn" type="button" value="返回" class="btn wd1" onclick="Redirect('MatchConfigList.aspx')" />
          <asp:Button ID="btnCreate" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
      <tr>
        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
          <div class="hg3  pd7">基础配置</div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">比赛名称：</td>
        <td>
          <asp:TextBox ID="txtMatchName" runat="server" CssClass="text wd7"></asp:TextBox>
          &nbsp;<span class="hong">*</span>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ControlToValidate="txtMatchName" Display="Dynamic" ErrorMessage="请输入比赛名称"></asp:RequiredFieldValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">比赛类型：</td>
        <td>
          <asp:DropDownList ID="ddlMatchType" runat="server" Width="150" OnSelectedIndexChanged="ddlMatchTypeSelect" AutoPostBack="true">
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">所属游戏：
        </td>
        <td>
          <asp:DropDownList ID="ddlKindID" runat="server" Width="150px">
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">参加最低要求：</td>
        <td>
          <asp:DropDownList ID="ddlMemberType" runat="server" Width="150">
          </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">报名费类型：</td>
        <td>
          <asp:RadioButtonList ID="rblFeeType" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Text="金币" Value="0" Selected="True"></asp:ListItem>

          </asp:RadioButtonList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">报 名 费：</td>
        <td>
          <asp:TextBox ID="txtFeel" runat="server" CssClass="text wd7"></asp:TextBox>
          &nbsp;<span class="hong">*</span>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red" ControlToValidate="txtFeel" Display="Dynamic" ErrorMessage="请输入报名费"></asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator6" ForeColor="Red" ControlToValidate="txtFeel" Display="Dynamic" ValidationExpression="^[0-9]\d*$" runat="server" ErrorMessage="输入格式不正确"></asp:RegularExpressionValidator>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2" runat="server" id="tbTiming" visible="false">
      <tr>
        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
          <div class="hg3  pd7">定时赛配置</div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">比赛有效期限：</td>
        <td>开始日期：<asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox>
          —
                    结束日期：<asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox>
          &nbsp;<span class="hong">*</span>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ForeColor="Red" ControlToValidate="txtStartDate" Display="Dynamic" ErrorMessage="请输入开始日期"></asp:RequiredFieldValidator>
          &nbsp;
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ForeColor="Red" ControlToValidate="txtEndDate" Display="Dynamic" ErrorMessage="请输入结束日期"></asp:RequiredFieldValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">每天开赛时间：</td>
        <td>开始时间：<asp:TextBox ID="txtStartTime" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'HH:mm',maxDate:'#F{$dp.$D(\'txtEndTime\')}'})"></asp:TextBox>
          —
                    结束时间：<asp:TextBox ID="txtEndTime" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'HH:mm',minDate:'#F{$dp.$D(\'txtStartTime\')}'})"></asp:TextBox>
          &nbsp;<span class="hong">*</span>
          &nbsp;时间采用24小时制
                    &nbsp;
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator15" runat="server" ForeColor="Red" ControlToValidate="txtStartTime" Display="Dynamic" ErrorMessage="请输入开始时间"></asp:RequiredFieldValidator>
          &nbsp;
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator16" runat="server" ForeColor="Red" ControlToValidate="txtEndTime" Display="Dynamic" ErrorMessage="请输入结束时间"></asp:RequiredFieldValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">初始积分：</td>
        <td>
          <asp:TextBox ID="txtInitScore" runat="server" CssClass="text wd7"></asp:TextBox>
          &nbsp;<span class="hong">*</span>&nbsp;比赛开始时帐号默认积分数
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" ControlToValidate="txtInitScore" Display="Dynamic" ErrorMessage="请输入初始积分"></asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator1" ForeColor="Red" ControlToValidate="txtInitScore" Display="Dynamic" ValidationExpression="^[0-9]\d*$" runat="server" ErrorMessage="输入格式不正确"></asp:RegularExpressionValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">淘汰积分：</td>
        <td>
          <asp:TextBox ID="txtCullScore" runat="server" CssClass="text wd7"></asp:TextBox>
          &nbsp;<span class="hong">*</span>&nbsp;积分数达到该值玩家即被淘汰
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red" ControlToValidate="txtCullScore" Display="Dynamic" ErrorMessage="请输入淘汰积分"></asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator2" ForeColor="Red" ControlToValidate="txtCullScore" Display="Dynamic" ValidationExpression="^[0-9]\d*$" runat="server" ErrorMessage="输入格式不正确"></asp:RegularExpressionValidator>
          <asp:CompareValidator ID="CompareValidator1" ControlToCompare="txtInitScore" ControlToValidate="txtCullScore" runat="server" Operator="LessThan" Type="Integer" ErrorMessage="淘汰积分必须小于初始积分"></asp:CompareValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">有效局数：</td>
        <td>
          <asp:TextBox ID="txtMinPlayCount" runat="server" CssClass="text wd7"></asp:TextBox>
          &nbsp;<span class="hong">*</span>&nbsp;游戏局数不少于该值的玩家成绩才会参与排名
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" ControlToValidate="txtMinPlayCount" Display="Dynamic" ErrorMessage="请输入初始积分"></asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator3" ForeColor="Red" ControlToValidate="txtMinPlayCount" Display="Dynamic" ValidationExpression="^[0-9]\d*$" runat="server" ErrorMessage="输入格式不正确"></asp:RegularExpressionValidator>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2" runat="server" id="tbImmediate" visible="false">
      <tr>
        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
          <div class="hg3  pd7">即时赛配置</div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">开赛人数：</td>
        <td>
          <asp:TextBox ID="txtStartUserCount" runat="server" CssClass="text wd7"></asp:TextBox>
          &nbsp;<span class="hong">*</span>&nbsp;报名人数达到该值即开赛
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red" ControlToValidate="txtStartUserCount" Display="Dynamic" ErrorMessage="请输入开赛人数"></asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator4" ForeColor="Red" ControlToValidate="txtStartUserCount" Display="Dynamic" ValidationExpression="^[0-9]\d*$" runat="server" ErrorMessage="输入格式不正确"></asp:RegularExpressionValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">最大机器人数：</td>
        <td>
          <asp:TextBox ID="txtAndroidUserCount" runat="server" CssClass="text wd7"></asp:TextBox>
          &nbsp;<span class="hong">*</span>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red" ControlToValidate="txtAndroidUserCount" Display="Dynamic" ErrorMessage="请输入最大机器人数"></asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator7" ForeColor="Red" ControlToValidate="txtAndroidUserCount" Display="Dynamic" ValidationExpression="^[0-9]\d*$" runat="server" ErrorMessage="输入格式不正确"></asp:RegularExpressionValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">初始游戏底分：</td>
        <td>
          <asp:TextBox ID="txtInitialBase" runat="server" CssClass="text wd7"></asp:TextBox>
          &nbsp;<span class="hong">*</span>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red" ControlToValidate="txtInitialBase" Display="Dynamic" ErrorMessage="请输入初始游戏底分"></asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator5" ForeColor="Red" ControlToValidate="txtInitialBase" Display="Dynamic" ValidationExpression="^[0-9]\d*$" runat="server" ErrorMessage="输入格式不正确"></asp:RegularExpressionValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">初始积分：</td>
        <td>
          <asp:TextBox ID="txtInitialScore" runat="server" CssClass="text wd7"></asp:TextBox>
          &nbsp;<span class="hong">*</span>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ForeColor="Red" ControlToValidate="txtInitialScore" Display="Dynamic" ErrorMessage="请输入初始积分"></asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator8" ForeColor="Red" ControlToValidate="txtInitialScore" Display="Dynamic" ValidationExpression="^[0-9]\d*$" runat="server" ErrorMessage="输入格式不正确"></asp:RegularExpressionValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">游戏局数：</td>
        <td>
          <asp:TextBox ID="txtPlayCount" runat="server" CssClass="text wd7"></asp:TextBox>
          &nbsp;<span class="hong">*</span>&nbsp;游戏局数达到该值即完成比赛
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red" ControlToValidate="txtPlayCount" Display="Dynamic" ErrorMessage="请输入游戏局数"></asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator9" ForeColor="Red" ControlToValidate="txtPlayCount" Display="Dynamic" ValidationExpression="^[0-9]\d*$" runat="server" ErrorMessage="输入格式不正确"></asp:RegularExpressionValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">换桌局数：</td>
        <td>
          <asp:TextBox ID="txtSwitchTableCount" runat="server" CssClass="text wd7"></asp:TextBox>
          &nbsp;<span class="hong">*</span>&nbsp;游戏局数达到该值自动换桌
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ForeColor="Red" ControlToValidate="txtSwitchTableCount" Display="Dynamic" ErrorMessage="请输入换桌局数"></asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator10" ForeColor="Red" ControlToValidate="txtSwitchTableCount" Display="Dynamic" ValidationExpression="^[0-9]\d*$" runat="server" ErrorMessage="输入格式不正确"></asp:RegularExpressionValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">玩家优先分配座位时间：</td>
        <td>
          <asp:TextBox ID="txtPrecedeTimer" runat="server" CssClass="text wd7"></asp:TextBox>
          秒
                    &nbsp;<span class="hong">*</span>&nbsp;某玩家游戏结束后等待时间超过该值，分配座位时优先分配
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ForeColor="Red" ControlToValidate="txtPrecedeTimer" Display="Dynamic" ErrorMessage="请输入换桌局数"></asp:RequiredFieldValidator>
          <asp:RegularExpressionValidator ID="RegularExpressionValidator11" ForeColor="Red" ControlToValidate="txtPrecedeTimer" Display="Dynamic" ValidationExpression="^[0-9]\d*$" runat="server" ErrorMessage="输入格式不正确"></asp:RegularExpressionValidator>
        </td>
      </tr>
    </table>
    <table id="Table1" width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2" runat="server">
      <tr>
        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
          <div class="hg3 pd7">奖励配置</div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">&nbsp;
        </td>
        <td id="reward">
          <%= strReward%>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2" runat="server">
      <tr>
        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
          <div class="hg3 pd7">网站展示</div>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">比赛摘要：
        </td>
        <td>
          <asp:TextBox ID="txtMatchSummary" runat="server" CssClass="text" Width="650px" MaxLength="300"></asp:TextBox>
          &nbsp;<span class="hong">*</span>
          <asp:RequiredFieldValidator ID="RequiredFieldValidator18" runat="server" ForeColor="Red" ControlToValidate="txtMatchSummary" Display="Dynamic" ErrorMessage="请输入比赛摘要"></asp:RequiredFieldValidator>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">展示图：
        </td>
        <td style="line-height: 35px;">
          <GameImg:ImageUploader ID="upSmallImage" runat="server" DeleteButtonClass="l2" DeleteButtonText="删除" Folder="/Upload/Match" ViewButtonClass="l2" ViewButtonText="查看" TextBoxClass="text" />
          &nbsp;<span class="hong">*</span> <span>[尺寸：230*160 体积：不大于1M]</span>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">首页展示图：
        </td>
        <td style="line-height: 35px;">
          <GameImg:ImageUploader ID="upBigImage" runat="server" DeleteButtonClass="l2" DeleteButtonText="删除" Folder="/Upload/Match" ViewButtonClass="l2" ViewButtonText="查看" TextBoxClass="text" />
          &nbsp;<span class="hong">*</span> <span>[体积：不大于1M] 只有推荐到首页的比赛才需要该图</span>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">是否推荐至首页：
        </td>
        <td>
          <asp:RadioButtonList ID="rblIsRecommend" runat="server" RepeatDirection="Horizontal">
            <asp:ListItem Value="1" Text="推荐" Selected="True"></asp:ListItem>
            <asp:ListItem Value="0" Text="不推荐"></asp:ListItem>
          </asp:RadioButtonList>
        </td>
      </tr>
      <tr>
        <td class="listTdLeft">比赛描述：(<span class="hong">*</span>)：
        </td>
        <td>
          <asp:TextBox ID="txtContent" runat="server" CssClass="text" Width="650px" Height="350px" TextMode="MultiLine"></asp:TextBox>
        </td>
      </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td class="titleOpBg Lpd10">
          <input id="btnReturn2" type="button" value="返回" class="btn wd1" onclick="Redirect('MatchConfigList.aspx')" />
          <asp:Button ID="btnSave2" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
        </td>
      </tr>
    </table>

    <script type="text/javascript">
          KE.show({
              id: 'txtContent',
              urlType: 'domain',
              imageUploadJson: '/Tools/KindEditorUpload.ashx?type=match',
              fileManagerJson: '/Tools/KindEditorFileManager.ashx?type=match',
              allowFileManager: true
          });
          $(function () {

              var reward = $('#reward');

             

              function renderItem(index) {
                  var item = '<div class="ui-reward-item">'
                    + '第<span class="ui-item-serial">' + (++index) + '</span>名：'
                    + '游戏币：<input type="text" class="text wd2" name="gold"> '
                    + '元宝：<input type="text" class="text wd2" name="medal"/>  '
                    + '经验：<input type="text" class="text wd2" name="experience"/> '
                    + '<a data-action="add" href="javascript:;" title="添加" '
                    + 'style="color: #0000ff; text-decoration: underline;">添加</a> '
                    + '<a data-action="delete" href="javascript:;" title="删除" '
                    + 'style="color: #0000ff; text-decoration: underline;">删除</a></div>';
                  return item;
              }


              reward.delegate('[data-action="add"]', 'click', function (e) {
                 
                  e.preventDefault();
                  var items = reward.find('.ui-reward-item'),
                    length = items.length;

                  if (length === 1) {
                      $(this).text('删除').attr('title', '删除').attr('data-action', 'delete');
                  } else {
                      $(this).remove();
                  }

                  reward.append(renderItem(length));
              });

              reward.delegate('[data-action="delete"]', 'click', function (e) { 
                  e.preventDefault();
                  var target = $(this),
                    items = reward.find('.ui-reward-item'),
                    item = target.closest('.ui-reward-item'),
                    deleteBtn = item.prev().find('[data-action="delete"]');

                  if (item[0] === items.last().get(0)) {
                      if (items.length > 2) {
                          deleteBtn.before('<a data-action="add" href="javascript:;" title="添加" style="color: #0000ff; text-decoration: underline;">添加</a> ');
                      } else {
                          deleteBtn.text('添加').attr('title', '添加').attr('data-action', 'add');
                      }
                  } else {
                      if (items.length == 2) {
                          item.next().find('[data-action="delete"]').remove();
                      }
                  }

                  item.remove();
                  items.not(item).each(function (i) {
                      $(this).find('.ui-item-serial').text(++i);
                  });
              });


              //
          }); //load end

         
    </script>
  </form>

</body>
</html>
