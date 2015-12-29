function googlemaps () {
	// Asynchronously Load the map API 
    var script = document.createElement('script');
    script.src = "http://maps.googleapis.com/maps/api/js?sensor=false&callback=initialize";
    document.body.appendChild(script);
}

$(googlemaps);

function initialize() {

	$.ajax({
	    url: window.location.href+"event",
	  	type: "get",
	   	dataType: "json",
	}).done(function (eventos) {
		var info = {
			NAME : 0,
			EVENT_ID : 1,
			CATEGORIA : 2,
			LATITUDE : 3,
			LONGITUDE : 4,
			ADDRESS : 5,
			DESCRIPTION: 6
		}
		var map;
	    var bounds = new google.maps.LatLngBounds();
	    var mapOptions = {
	        mapTypeId: 'roadmap'
	    };
	                    
	    // Display a map on the page
	    map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
	    map.setTilt(45);

		// Markers
	    var markers = [];

	    // Info Window Content
		var infoWindowContent = [];

		var icons = [];
	    for (var k = 0; k < 2; k++) {

			//Load markers and info window content values
		    for (var j=0; j < eventos[k].length ; j++) {
		    	icons.push(k);
		    	evento = eventos[k][j];
		    	markers.push([evento[info.NAME],evento[info.LATITUDE],evento[info.LONGITUDE]]);
		    	infoWindowContent.push(['<div class="info_content">' +
		        '<a href="'+window.location.href+"event/"+evento[info.EVENT_ID]+'"><h3>'+evento[info.NAME]+'</h3></a>' +
		        '<p>'+evento[info.DESCRIPTION]+'</p>' +
		        '<p>'+evento[info.ADDRESS]+', '+evento[info.LATITUDE]+', '+evento[info.LONGITUDE]+'</p>'+
		        '</div>']);
		    };
	    };
    	// Display multiple markers on a map
	    var infoWindow = new google.maps.InfoWindow(), marker, i;
	    
	    // Loop through our array of markers & place each one on the map  
	    for( i = 0; i < markers.length; i++ ) {
	        var position = new google.maps.LatLng(markers[i][1], markers[i][2]);
	        
	        //var pinColor = ((1<<24)*Math.random()|0).toString(16);

	        var pinImage = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + icons[i],
													        new google.maps.Size(21, 34),
													        new google.maps.Point(0,0),
													        new google.maps.Point(10, 34));
			
			//var pinImage = 'imgs/google_maps/markers/'+eventos[k][i][info.CATEGORIA]+'.png';
	        bounds.extend(position);
	        marker = new google.maps.Marker({
	            position: position,
	            map: map,
	            title: markers[i][0],
	            draggable: true,
    			animation: google.maps.Animation.DROP,
    			icon: pinImage
	        });
	        
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
	    var boundsListener = google.maps.event.addListener((map), 'bounds_changed', function(event) {
	        this.setZoom(12);
	        google.maps.event.removeListener(boundsListener);
	    }); 
	});
}