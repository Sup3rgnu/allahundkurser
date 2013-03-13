	function initialize() {

  	var myLat = geoip_latitude();
		var myLng = geoip_longitude();

       	var myLatlng = new google.maps.LatLng(myLat,myLng);
      		var mapOptions = {
         		zoom: 12,
         		center: myLatlng,
         		mapTypeId: google.maps.MapTypeId.ROADMAP
          }
    	var map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

    if (1 == 2) {
		//läser koordinater från DB och presenterar på karta
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