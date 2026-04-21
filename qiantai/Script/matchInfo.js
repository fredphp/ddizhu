$('document').ready(function () {
    $.ajaxSetup({ global: false });

    $(".close").click(function () {
        $("#box-modal").hide();
        $("#divScreen").hide();
    });

    $("#divScreen").mousedown(function () {
        $(".close").addClass("no");
    }).mouseup(function () {
        $(".close").removeClass("no");
    });

    $('.activity-rule').click(function () {
        var matchid = $(this).parent().parent().find('.data').attr('data-id');
        var onTimeId = $(this).parent().parent().find('.data').attr('data-OntimeId');
        var matchname = $(this).parent().parent().find('.data').attr('data-name');
        $("#divScreen").show();
        $('#box-modal').show();
        $("#matchname").html(matchname);
        $('#box-modal #guizelist').html('<div class="ui-loading" style="color:#888888;">加载中</div>');
        $.ajax({
            contentType: "application/json",
            url: "/WS/WSMatch.asmx/GetMatchRewardRules",
            data: "{'matchID':'" + matchid + "','onTimeID':'" + onTimeId + "'}",
            type: "POST",
            dataType: "json",
            success: function (json) {
                json = eval("(" + json.d + ")");
                $('#box-modal #guizelist').html(json.msg);
            },
            error: function (json) {

            }
        });
    });

    $("#closeplacing").click(function () {
        $("#matchPlacingList").hide();
    });

        $('.activity-rank').click(function () {
            var matchid = $(this).parent().parent().find('.data').attr('data-id');
            $('#matchPlacingList').show();
            $('#Table1').html('<tr><td class="ui-loading" style="color:#888888; text-align:left; padding-left:10px;">加载中</td></tr>');
            $.ajax({
                contentType: "application/json",
                url: "/WS/WSMatch.asmx/GetMatchRewardRank",
                data: "{'matchID':'" + matchid + "'}",
                type: "POST",
                dataType: "json",
                success: function (json) {
                    json = eval("(" + json.d + ")");
                    if (json.success = "success") {
                        $('#Table1').html(json.msg);
                    }
                    else {
                    }

                },
                error: function (json) {
                }
            });
        });
});