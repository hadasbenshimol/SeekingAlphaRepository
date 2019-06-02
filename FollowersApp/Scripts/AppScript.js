var app = {
    apiUrl: '/api/followers/',
    userIdCookieName: "user_id",
    onReady: function() {
        $('#btnToggleCookie').click(app.toggleCookie);
        var usersTbl = $("#UsersTbl");
        usersTbl.on("mouseenter",
            ".follow-btn.btn-success",
            function() {
                $(this).removeClass("btn-success").addClass("btn-danger").text("Unfollow");
            }).on("mouseleave",
            ".follow-btn.btn-danger",
            function () {
                    $(this).removeClass("btn-danger").addClass("btn-success").text("Following");
            });
        
        usersTbl.find(".follow-btn").on("click", app.onBtnFollowClick);
    },
    onBtnFollowClick: function () {
        var btn = $(this);
        var numOfFollowers = btn.parents("tr").find("#numOfFols").text();
        var id = btn.parents("tr").data("userid");
        var users = {};
        users.UserToFollow = id;
        users.LoggedinUser = $.cookie(app.userIdCookieName);
        $.ajax({
            url: app.apiUrl,
            type: 'PUT',
            dataType: 'json',
            data: users,
            success: function (data, textStatus, xhr) {
                if (btn.data("followedbyuser")=== "True") {
                    btn.removeClass("btn-danger").addClass("btn-warning").text("Follow");
                    btn.data("followedbyuser", "False");
                    numOfFollowers--;
                }
                else {
                    btn.removeClass("btn-warning").addClass("btn-success").text("Following");
                    btn.data("followedbyuser", "True");
                    numOfFollowers++;
                }
                btn.parents("tr").find("#numOfFols").text(numOfFollowers);
            },
            error: function (xhr, textStatus, errorThrown) {
                alert(xhr.responseJSON.Message);
            }
        });  
    },
    toggleCookie: function() {
        if (!$.cookie(app.userIdCookieName) || !$.cookie(app.userIdCookieName) == null) {
            $.cookie(app.userIdCookieName, Math.floor((Math.random() * 5) + 1), { path: '/' });
            alert("Cookie set to UserID: " + $.cookie(app.userIdCookieName));
        } else {
            $.removeCookie(app.userIdCookieName, { path: '/' });
            alert("Cookie " + app.userIdCookieName + " Has Been Removed!");
        }
        location.reload();
    }
};
$(document).ready(app.onReady);