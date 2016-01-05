function start(){
    $(".colapseButton").on("click",function(){
        window.setTimeout(loadMaps,500);
    });
    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/pt_PT/sdk.js#xfbml=1&version=v2.5&appId=548043568677408";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
};
function loadMaps(){
    $(".gllpLatlonPicker").each(function() {
        $(document).gMapsLatLonPicker().init( $(this) );
    });
};

$(document).ready(start);
//$(document).on('page:load', start);