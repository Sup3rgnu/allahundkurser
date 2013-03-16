	function initialize() {
    console.log("init");
  	var myLat = geoip_latitude();
		var myLng = geoip_longitude();
    var map = createMap(myLat, myLng);

    if (1 == 2) {

		$.ajax({
			type: "POST",
			url: "getCoordinateData.php",
   		dataType: "json",
   		cache: false,
   		
   		success: function(data) {
      			      		
      	var numberOfCoordinates = data.coordinate.length;      		
      	var infowindow = new google.maps.InfoWindow(), marker, i;
      		
      	for(i=0;i<numberOfCoordinates;i++) {
        	marker = new google.maps.Marker({
        	 position: new google.maps.LatLng(data.coordinate[i].lat, data.coordinate[i].lng),
        	 map: map
          });
      				
        	google.maps.event.addListener(marker, 'click', (function(marker, i) {
        		return function() {
        			var contentString = "<h3>"+data.coordinate[i].header+"</h3>"+data.coordinate[i].description;
        			infowindow.setContent(contentString);
          		infowindow.open(map, marker);
        		}
        	})(marker, i));
      	}
   			}
   		});
  }
}

function createMap(lat, lng) {

  console.log("createMap");

  var myLatlng = new google.maps.LatLng(lat,lng);
  var mapOptions = {
    zoom: 12,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
    return new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
}

function putMarker(map, lat, lng, header, desc){
  
  console.log("putMarker");

  var infowindow = new google.maps.InfoWindow(), marker, i;
          
  marker = new google.maps.Marker({
    position: new google.maps.LatLng(lat, lng),
    map: map
  });
              
  google.maps.event.addListener(marker, 'click', (function(marker, i) {
    return function() {
      var contentString = "<h3>" + header + "</h3>" + desc;
      infowindow.setContent(contentString);
      infowindow.open(map, marker);
    }
  })(marker, i));

}