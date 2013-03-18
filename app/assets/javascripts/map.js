function initialize() {

  var map = createMap(getMyCoords());

  $.getJSON('home/getCoords', function(data) {
    putMultipleMarkers(map, data);
  });
}

function getMyCoords() {

  var coords = new Array();
  coords['lat'] = geoip_latitude();
  coords['lng'] = geoip_longitude();

  return coords;
}

function createMap(coords) {

  var myLatlng = new google.maps.LatLng(coords['lat'],coords['lng']);
  var mapOptions = {
    zoom: 12,
    center: myLatlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
    return new google.maps.Map(document.getElementById('map_canvas'), mapOptions);
}

function putMarker(map, data){
  
  var infowindow = new google.maps.InfoWindow(), marker, i;
          
  marker = new google.maps.Marker({
    position: new google.maps.LatLng(data[1].lat, data[1].lng),
    map: map
  });
              
  google.maps.event.addListener(marker, 'click', (function(marker, i) {
    return function() {
      var contentString = "<h3>" + data[0].name + "</h3>" + data[0].price;
      infowindow.setContent(contentString);
      infowindow.open(map, marker);
    }
  })(marker, i));

}

// Puts multiple markers on map, expects json data on the form [][],
// for the second array 0 = courses (name, desc), 1 = locations (lat, lng)
function putMultipleMarkers(map, data){
  
  var infowindow = new google.maps.InfoWindow(), marker, i;
  var locations = new Array();

  for (i = 0; i < data.length; i++) {
    
    var id = data[i][1].id;
    var lat = data[i][1].lat;
    var lng = data[i][1].lng;

    // Offsets the marker if duplicat locations
    if ($.inArray(id, locations) > -1){      
      lat = (parseFloat(lat,10) + Math.random()/1000);
      lng = (parseFloat(lng,10) + Math.random()/1000); 
    } else {
      locations.push(id);
    }

    marker = new google.maps.Marker({
      position: new google.maps.LatLng(lat, lng),
      map: map
    });
                
    google.maps.event.addListener(marker, 'click', (function(marker, i) {
      return function() {
        var contentString = "<h3>" + data[i][0].name + "</h3>" + data[i][0].price;
        infowindow.setContent(contentString);
        infowindow.open(map, marker);
      }
    })(marker, i));
  }

}