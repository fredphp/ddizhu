<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TabStation.ascx.cs" Inherits="MTEwin.Themes.TabStation" %>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
    <tr>
        <td height="28">
            <ul>
                <li class="tab2" onclick="Redirect('StationsInfo.aspx?param='+GetRequest('param','0')+'&reurl='+GetRequest('reurl','StationsList.aspx'))">
                    基本信息</li>
                <li class="tab2" onclick="Redirect('InsureStationDetail.aspx?param='+GetRequest('param','0')+'&reurl='+GetRequest('reurl','StationsList.aspx'))">财富信息</li>
                <li class="tab2" onclick="Redirect('RStationFinanceList.aspx?param='+GetRequest('param','0')+'&reurl='+GetRequest('reurl','StationsList.aspx'))">
                    收支记录</li>
            </ul>
        </td>
    </tr>
</table>
<script>
    var intParam = GetRequest('param', "");
    if (intParam == "" || intParam <= 0) {
        $(".tab2:not(:first-child)").hide();
        //$(".tab2:first-child").unbind();
    }
    
</script>