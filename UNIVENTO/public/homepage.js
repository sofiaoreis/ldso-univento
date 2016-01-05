$(start);
var filter_prefs=false;
// enum
var info = {
	NAME : 0,
	EVENT_ID : 1,
	CATEGORIA : 2,
	LATITUDE : 3,
	LONGITUDE : 4,
	ADDRESS : 5,
	DESCRIPTION: 6,
	PROMOTER: 7,
	START_DATE: 8,
	IMG_URL: 9,
	DAY: 10,
	LIKE: 11 // true se está nas prefs do user
}

var markersArray = [];
var map;
var last_a_decorrer = 0;
var activeCategories = new Set();

function start () {
	// Asynchronously Load the map API 
    var script = document.createElement('script');
    script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize";
    document.body.appendChild(script);

    loadEvents();
}

function initialize() {

	$.ajax({
	    url: "/event",
	  	type: "get",
	   	dataType: "json",
	   	data: {func:"google_maps"}
	}).done(function (eventos) {
		//console.log(eventos);
		loadMarkers(eventos);

		$("#btn-lgg-1").on("click",function(e){
			clearMarkers();
			showMarkers(0,last_a_decorrer,map);
		});

		$("#btn-lgg-2").on("click",function(e){
			clearMarkers();
			showMarkers(last_a_decorrer,markersArray.length,map);
		});

		$("#btn-sm").on("click",function(e){
			clearMarkers();
			showMarkers(0,markersArray.length,map);
		});

		$.ajax({
		    url: "/category",
		  	type: "get",
		   	dataType: "json",
		}).done(function (categorias) {
			var cssClass = "invertscale";
			categorias.forEach(function(categoria){
				cssClass = "invertscale";
				if(activeCategories.has(categoria.categoryID)){
					cssClass="";
				}
				$("#icons").append('<div class="col-xs-2 col-md-2 col-lg-2 categorias text-center" id="cat_'+categoria.categoryID+'"><img src="imgs/google_maps/icons/'+categoria.categoryID+'_d.png" class="'+cssClass+'" alt=""><br><p>'+categoria.name+'</p></div>');
			});
			$(".categorias").on("click",function(e){
				clearMarkers();
				showMarkersWithCategory(this.id.split("_")[1],eventos);
			});
		});
	});

}

function loadMarkers(eventos){

    var bounds = new google.maps.LatLngBounds();
    var mapOptions = {
        mapTypeId: 'roadmap'
    };
                    
    // Display a map on the page
    map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
    map.setTilt(45);

	var markers = [];
    // Info Window Content
	var infoWindowContent = [];

	var pinImage = [];
    for (var k = 0; k < 2; k++) {

		//Load markers and info window content values
	    for (var j=0; j < eventos[k].length ; j++) {
	    	evento = eventos[k][j];
	    	if(k==0){
	    		pinImage.push('imgs/google_maps/markers/'+evento[info.CATEGORIA]+'_d.png');
	    		last_a_decorrer++;
	    	}else{
				pinImage.push('imgs/google_maps/markers/'+evento[info.CATEGORIA]+'_1h.png');
	    	}
	    	markers.push([evento[info.NAME],evento[info.LATITUDE],evento[info.LONGITUDE]]);
	    	infoWindowContent.push(['<div class="info_content">' +
	        '<a href="'+window.location.href+"event/"+evento[info.EVENT_ID]+'" style="text-decoration: none; color: #19a69a; background-color: #1AA69B;"><h3 style="text-decoration: none; color: #19a69a;">'+evento[info.NAME]+'</h3></a>' +
	        '<p>'+evento[info.DESCRIPTION]+'</p>' +
	        '<p>'+evento[info.ADDRESS]+', '+evento[info.LATITUDE]+', '+evento[info.LONGITUDE]+'</p>'+
	        '</div>']);

	    	activeCategories.add(evento[info.CATEGORIA]);
	    };
    };

    if (eventos[0].length+eventos[1].length==0){
		var img = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + "FF0000",
															        new google.maps.Size(21, 34),
															        new google.maps.Point(0,0),
															        new google.maps.Point(10, 34));
		pinImage.push(img);

    	markers.push(["UNIVENTO", 41.1579438, -8.629105299999992]);
    	infoWindowContent.push(['<div class="info_content">' +
        '<h3>UNIVENTO</h3></a>' +
        '<p>Não existem eventos a decorrer</p>' +
        '<p>Não existem eventos a começar dentro de 1h</p>' +
        '</div>']);

    	//activeCategories.add(-1);
    }

	// Display multiple markers on a map
    var infoWindow = new google.maps.InfoWindow(), marker, i;

    // Loop through our array of markers & place each one on the map  
    for( i = 0; i < markers.length; i++ ) {
        var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
        bounds.extend(position);
        marker = new google.maps.Marker({
            position: position,
            map: map,
            title: markers[i][0],
            draggable: false,
			animation: google.maps.Animation.DROP,
			icon: pinImage[i]
        });
        markersArray.push(marker);
        // Allow each marker to have an info window    
        google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                infoWindow.setContent(infoWindowContent[i][0]);
                infoWindow.open(map, marker);
            }
        })(marker, i));

        // Automatically center the map fitting all markers on the screen
        map.fitBounds(bounds);
    };

    // Override our map zoom level once our fitBounds function runs (Make sure it only runs once)
    if((eventos[0].length+eventos[1].length)<=1){
	    var boundsListener = google.maps.event.addListener((map), 'bounds_changed', function(event) {
	        this.setZoom(12);
	        google.maps.event.removeListener(boundsListener);
	    });
    } 
}

// Sets the map on all markers in the array.
function setMapOnAll(index,last,mapa) {
  for (var i = index; i < last ; i++) {
    markersArray[i].setMap(mapa);
  }
}

// Removes the markers from the map, but keeps them in the array.
function clearMarkers() {
  setMapOnAll(0,markersArray.length,null);
}

// Shows any markers currently in the array.
function showMarkers(index,last,mapa) {
  setMapOnAll(index,last,mapa);
}

function showMarkersWithCategory(id,eventos){
	var pos = [];
	var acc=0;
	for (var k = 0; k < 2; k++) {
	    for (var j=0; j < eventos[k].length ; j++) {
	    	evento = eventos[k][j];
	    	if(evento[info.CATEGORIA]==id){
	    		pos.push(acc);
	    	}
	    	acc++;
	    };
	};

	for (var i = 0; i < pos.length; i++) {
		markersArray[pos[i]].setMap(map);
	};
};

function loadEvents(){
	$.ajax({
	    url: "/event",
	  	type: "get",
	   	dataType: "json",
	   	data: {func:"homepage"}
	}).done(function (eventos) {
		//console.log(eventos);
/*		for (var i = 0; i < eventos.length; i++) {
			console.log(eventos[i][info.NAME]);
		};
*/
		showEvents(eventos);
		$(".filter_promoter").on("click",function(e){
			e.preventDefault();
			var txt = $(e.target).text();
			filter("PROMOTER",txt,eventos);
		});
		$(".filter_cat").on("click",function(e){
			e.preventDefault();
			var txt = $(e.target).text();
			filter("CAT",txt,eventos);
		});
		$(".filter_day").on("click",function(e){
			e.preventDefault();
			var txt = $(e.target).text();
			filter("DAY",txt,eventos);
		});
		$("#prefs").on("change",function(e){
			filter_prefs = $("#prefs").is(':checked');
			filter("PREFS",filter_prefs,eventos);
		});
	});
};

function showEvents(eventos){
	for (var i = 1; i < eventos.length/12 ; i++) {
			$("#carEventos .carousel-indicators").append('<li data-target="#carEventos" data-slide-to="'+i+'"></li>');
		};
		

		var carousel_inner = $("#carEventos .carousel-inner");
		var div_item, div_row;
		for (var i = 0; i < eventos.length; i++) {
			evento = eventos[i];
			if (i%12 == 0) {// 12 eventos por item
				active = "";
				if (i==0) {
					active="active"
				};
				carousel_inner.append('<div class="item '+active+'" id="div_item_'+i+'"></div>');
				div_item = $('#div_item_'+i);
			};
			if (i%4==0){
				div_item.append('<div class="row-fluid home-events clearfix" id="div_row_'+i+'"> </div>');
				div_row = $('#div_row_'+i);
			}
			link = "/event/"+evento[info.EVENT_ID];
			dataFields = evento[info.START_DATE].split('T');
			data = dataFields[0].replace(/-/g,'/')+' '+dataFields[1].split(':')[0]+':'+dataFields[1].split(':')[1];
			img = evento[info.IMG_URL];
			if (evento[info.IMG_URL]==null){
				img = 'imgs/404.jpg';
			}
			div_row.append('<div class="col-xs-3 col-sm-3 col-md-3  text-center doc-item">'
							    +'<div class="common-event animated fadeInUp clearfix ae-animation-fadeInUp">'

							        +'<ul class="hover-list animate">'
							          +  '<li><a href="'+link+'"><i class="fa fa-clock-o"> '+data+'</i></a></li>'
							          +  '<li><a href="'+link+'"><i class="fa fa-map-marker"> '+evento[info.ADDRESS]+'</i></a></li>'
							           + '<li><a href="'+link+'"><i class="fa fa-tags"> '+evento[info.CATEGORIA]+'</i></a></li>'
							       + '</ul>'

							      +  '<a href="'+link+'">'
							      +  '<figure>'
							     +           '<img width="250" height="250" src="'+img+'" class="doc-img animate attachment-gallery-post-single wp-post-image" alt="#">'
							     +   '</figure>'
							     +   '</a>'

							      +  '<div class="text-content">'
							      +      '<a href="'+link+'"><h5>'+evento[info.NAME]+'</h5>'
							     +       '<h5><small>'+evento[info.PROMOTER]+'</small></h5></a>'
							     +   '</div>'
							   + '</div>'
							+'</div>'
			);
		};
};

function filter(tipo,value,eventos){
	novos = [];

	if (tipo=="PROMOTER") {
		addThis(novos, eventos, info.PROMOTER, value );
	}else if (tipo=="DAY"){
		day = 2;
		if (value=="Hoje") {
		    day=0;
		}else if (value=="Amanhã"){
		    day=1;
		}
		addThis(novos, eventos, info.DAY, day );
	}else if (tipo=="CAT"){
		addThis(novos, eventos, info.CATEGORIA, value );
	}else if (tipo=="PREFS"){
		if (filter_prefs) {
			addThis(novos, eventos, info.LIKE, true );
		}else{
			novos= eventos;
		}
	};
	$("#carEventos .carousel-inner").fadeOut();
	$("#carEventos .carousel-inner").empty();
	showEvents(novos);
	$("#carEventos .carousel-inner").fadeIn();
};

function addThis(novos, eventos, infoID, value ){
	for (var i = 0; i < eventos.length; i++) {
		if (eventos[i][infoID]==value) {
			if(filter_prefs){
				if(eventos[i][info.LIKE]){
					novos.push(eventos[i]);
				}
			}else {
				novos.push(eventos[i]);
			}
		};
	};
}