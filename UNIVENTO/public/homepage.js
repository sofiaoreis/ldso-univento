$(googlemaps);
// enum
var info = {
	NAME : 0,
	EVENT_ID : 1,
	CATEGORIA : 2,
	LATITUDE : 3,
	LONGITUDE : 4,
	ADDRESS : 5,
	DESCRIPTION: 6
}

var markersArray = [];
var map;
var last_a_decorrer = 0;
var activeCategories = new Set();

function googlemaps () {
	// Asynchronously Load the map API 
    var script = document.createElement('script');
    script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize";
    document.body.appendChild(script);
}

function initialize() {

	$.ajax({
	    url: window.location.href+"event",
	  	type: "get",
	   	dataType: "json",
	}).done(function (eventos) {
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
		    url: window.location.href+"category",
		  	type: "get",
		   	dataType: "json",
		}).done(function (categorias) {
			var cssClass = "invertscale";
			categorias.forEach(function(categoria){
				cssClass = "invertscale";
				if(activeCategories.has(categoria.categoryID)){
					cssClass="";
				}
				$("#icons").append('<div class="col-xs-4 col-md-4 col-lg-4 categorias" id="cat_'+categoria.categoryID+'"><img src="imgs/google_maps/icons/'+categoria.categoryID+'_d.png" class="'+cssClass+'" alt=""><br>'+categoria.name+'</div>');
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

    /*// Override our map zoom level once our fitBounds function runs (Make sure it only runs once)
    var boundsListener = google.maps.event.addListener((map), 'bounds_changed', function(event) {
        this.setZoom(12);
        google.maps.event.removeListener(boundsListener);
    }); */
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