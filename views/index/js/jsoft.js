/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


 function initMap() {
     
     var myLatlng = new google.maps.LatLng(-12.5106611,-67.8686626);
     
        // Create a map object and specify the DOM element for display.
        var map = new google.maps.Map(document.getElementById('map'), {
          center: {lat:-12.5106611, lng: -67.8686626},
          zoom: 4,
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
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "visibility": "off"
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
    "featureType": "road.highway",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
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
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "visibility": "on"
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
            
            '<h4 id="firstHeading" class="firstHeading">Áreas Protegidas</h4>'+
            '<div id="bodyContent">'+
            '<p><b>+340000</b></p>'+            
            '</div>'+
            '</div>';
    
     var contentString3 = '<div>'+
            
            '<h4 id="firstHeading" class="firstHeading">Carga Hídrica de Cauce</h4>'+
            '<div id="bodyContent">'+
            '<p><b>+323320</b></p>'+            
            '</div>'+
            '</div>';
    var contentString4 = '<div>'+
            
            '<h4 id="firstHeading" class="firstHeading">Pueblos Indígenas</h4>'+
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
        
        var iconBase = _root_+'views/layout/frontend/img/frontend/';
        var marker = new google.maps.Marker({
            position: myLatlng,
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
            title:"Carga Hídrica",
            icon: iconBase + 'ic-marker-3.png'
        });
        
        var marker4 = new google.maps.Marker({
            position: new google.maps.LatLng(-10.485893, -56.000737),
            title:"Pueblos Indígenas",
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
      }