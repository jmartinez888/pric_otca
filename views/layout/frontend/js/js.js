// $(window).scroll( function(){

// 	if ($(this).scrollTop() > 250 ) {

// 		$('#menuleft').addClass("fixed").fadeIn();
// 		$('.cuerpo').addClass("fixed").fadeIn();
// 	}
// 	else{
// 		$('#menuleft').removeClass("fixed");
// 		$('.cuerpo').removeClass("fixed");
// 	}
// }
// 	);


function initMap() {
     
 var myLatlng = new google.maps.LatLng(-10.5106611,-60.8686626);
     
  // Create a map object and specify the DOM element for display.
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat:-10.413054, lng: -60.443913},
    zoom: 5,
     disableDefaultUI: true,
    styles:[
  {
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "administrative.neighborhood",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#7171ff"
      },
      {
        "visibility": "on"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
});

var contentString = '<div>'+
    
    '<h4 id="firstHeading" class="firstHeading">Cobertura de Bosques</h4>'+
    '<div id="bodyContent">'+
    '<p><b>+60000</b></p>'+            
    '</div>'+
    '</div>';

var contentString2 = '<div>'+
    
    '<h4 id="firstHeading" class="firstHeading">Ãreas Protegidas</h4>'+
    '<div id="bodyContent">'+
    '<p><b>+340000</b></p>'+            
    '</div>'+
    '</div>';

var contentString3 = '<div>'+
    
    '<h4 id="firstHeading" class="firstHeading">Carga HÃ­drica de Cauce</h4>'+
    '<div id="bodyContent">'+
    '<p><b>+323320</b></p>'+            
    '</div>'+
    '</div>';
var contentString4 = '<div>'+
    
    '<h4 id="firstHeading" class="firstHeading">Pueblos IndÃ­genas</h4>'+
    '<div id="bodyContent">'+
    '<p><b>+75345</b></p>'+            
    '</div>'+
    '</div>';

var infowindow = new google.maps.InfoWindow({
  content: contentString
});
var infowindow2 = new google.maps.InfoWindow({
  content: contentString2
});

var infowindow3 = new google.maps.InfoWindow({
  content: contentString3
});

var infowindow4 = new google.maps.InfoWindow({
  content: contentString4
});

// var iconBase = 'http://191.232.182.250/pric_otca/views/layout/frontend/img/frontend/';
var iconBase = 'http://localhost/iiap/pricv2/images/';
var marker = new google.maps.Marker({
    position: new google.maps.LatLng(-8.485893, -62.000737),
    title:"Cobertura de Bosques",
    icon: iconBase + 'ic-marker-1.png'
});

var marker2 = new google.maps.Marker({
    position: new google.maps.LatLng(-1.1999344,-59.7486991),
    title:"Areas Protegidas",
    icon: iconBase + 'ic-marker-2.png'
});

var marker3 = new google.maps.Marker({
    position: new google.maps.LatLng(-3.4246604,-68.5244404),
    title:"Carga HÃ­drica",
    icon: iconBase + 'ic-marker-3.png'
});

var marker4 = new google.maps.Marker({
    position: new google.maps.LatLng(-10.485893, -56.000737),
    title:"Pueblos IndÃ­genas",
    icon: iconBase + 'ic-marker-4.png'
});

// To add the marker to the map, call setMap();
marker.setMap(map);
marker2.setMap(map);
marker3.setMap(map);
marker4.setMap(map);  

marker.addListener('click', function() {
  infowindow.open(map, marker);
});

marker2.addListener('click', function() {
  infowindow2.open(map, marker2);
});

marker3.addListener('click', function() {
  infowindow3.open(map, marker3);
});

marker4.addListener('click', function() {
  infowindow4.open(map, marker4);
});

var ctaLayer = new google.maps.KmlLayer({
  url: 'http://191.232.182.250/pric_otca/public/img/Limite_biogeografico_Amz.kml',
  map: map
});

  map.addListener('center_changed', function() {
    // 3 seconds after the center of the map has changed, pan back to the
    // marker.
    window.setTimeout(function() {
      map.panTo(myLatlng);
    }, 3000);
  });

  ctaLayer.addListener('click', function() {
    map.setZoom(6);
    map.setCenter(myLatlng);
  });

}