// $(window).scroll( function(){

//  if ($(this).scrollTop() > 250 ) {

//    $('#menuleft').addClass("fixed").fadeIn();
//    $('.cuerpo').addClass("fixed").fadeIn();
//  }
//  else{
//    $('#menuleft').removeClass("fixed");
//    $('.cuerpo').removeClass("fixed");
//  }
// }
//  );


function initMap() {

 var myLatlng = new google.maps.LatLng(-11.5106611,-60.8686626);

  // Create a map object and specify the DOM element for display.
  var map = new google.maps.Map(document.getElementById('map'), {
    center: {lat:-11.413054, lng: -60.443913},
    zoom: 3,
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
            "color": "#28488d"
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

var contentString = '<div id="iw-container">'+
    '<div class="iw-title">Cobertura de Bosques</div>'+
    '<div class="iw-content">' +
    '<div class="iw-subTitle"> 600000 Km<sup>2</sup> &nbsp;&nbsp;<a href="'+_root_+'noticias/index/index/333" title="Ver más" '+
    'target="_blank" class="glyphicon glyphicon-share"></a></div>'
    '</div>';

var contentString2 = '<div id="iw-container">'+
    '<div class="iw-title">Áreas Protegidas</div>'+
    '<div class="iw-content">' +
    '<div class="iw-subTitle"> 340000 Km<sup>2</sup> &nbsp;&nbsp;<a href="'+_root_ +'noticias/index/index/338" title="Ver más" '+
    'target="_blank" class="glyphicon glyphicon-share"></a></div>'
    '</div>';

    // '<div>'+

    // '<h4 id="firstHeading" class="firstHeading">Áreas Protegidas</h4>'+
    // '<div id="bodyContent">'+
    // '<p><b>+340000</b></p>'+
    // '</div>'+
    // '</div>';

var contentString3 = '<div id="iw-container">'+
    '<div class="iw-title">Caudal del Amazonas</div>'+
    '<div class="iw-content">' +
    '<div class="iw-subTitle"> 219000 mts<sup>3</sup>  &nbsp;&nbsp;<a href="'+_root_ +'noticias/index/index/328" title="Ver más" '+
    'target="_blank" class="glyphicon glyphicon-share"></a></div>'
    '</div>';

    // '<div>'+
    // '<h4 id="firstHeading" class="firstHeading">Carga Hídrica de Cauce</h4>'+
    // '<div id="bodyContent">'+
    // '<p><b>+323320</b></p>'+
    // '</div>'+
    // '</div>';
var contentString4 = '<div id="iw-container">'+
    '<div class="iw-title">Pueblos Indígenas</div>'+
    '<div class="iw-content">' +
    '<div class="iw-subTitle"> 75345 &nbsp;&nbsp;<a href="'+_root_ +'noticias/index/index/343" title="Ver más" '+
    'target="_blank" class="glyphicon glyphicon-share"></a></div>'
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


var cssInfoWindows = function(infowindowLocal){
    google.maps.event.addListener(infowindowLocal, 'domready', function() {

      // Reference to the DIV that wraps the bottom of infowindow
      var iwOuter = $('.gm-style-iw');

      iwOuter.css({'background-color': '#fff', 'box-shadow': '0 1px 6px rgba(24, 83, 14, 0.98)', 'border': '1px solid 3c763d', 'border-radius': '2px 2px 10px 10px'});
      /* Since this div is in a position prior to .gm-div style-iw.
       * We use jQuery and create a iwBackground variable,
       * and took advantage of the existing reference .gm-style-iw for the previous div with .prev().
      */
      var iwBackground = iwOuter.prev();

      // Removes background shadow DIV
      iwBackground.children(':nth-child(2)').css({'display' : 'none'});

      // Removes white background DIV
      iwBackground.children(':nth-child(4)').css({'display' : 'none'});

      // Moves the infowindow 115px to the right.
      iwOuter.parent().parent().css({left: '0px'});

      // Moves the shadow of the arrow 76px to the left margin.
      iwBackground.children(':nth-child(1)').attr('style', function(i,s){ return s + 'left: 76px !important;'});

      // Moves the arrow 76px to the left margin.
      iwBackground.children(':nth-child(3)').attr('style', function(i,s){ return s + 'left: 76px !important;'});

      // Changes the desired tail shadow color.
      iwBackground.children(':nth-child(3)').find('div').children().css({'box-shadow': '0 1px 6px rgba(24, 83, 14, 0.98)', 'z-index' : '1'});

      // Reference to the div that groups the close button elements.
      var iwCloseBtn = iwOuter.next();

      // Apply the desired effect to the close button
      iwCloseBtn.css({width: '25px', height: '25px', opacity: '1', right: '0px', top: '2px', border: '6px solid #5aa609', 'border-radius': '15px', 'box-shadow': '0 0px 5px rgba(24, 83, 14, 0.98)'});

      // If the content of infowindow not exceed the set maximum height, then the gradient is removed.
      if($('.iw-content').height() < 140){
        $('.iw-bottom-gradient').css({display: 'none'});
      }

      // The API automatically applies 0.7 opacity to the button after the mouseout event. This function reverses this event to the desired value.
      iwCloseBtn.mouseout(function(){
        $(this).css({opacity: '1'});
      });
    });
};


//carga gráfica de la amazonía

map.data.loadGeoJson(_root_ + 'public/img/Area_estudio_Amz.geojson');
// map.data.loadGeoJson('http://35.198.18.102/pric_otca/public/img/Area_estudio_Amz.geojson');
  map.data.setStyle({
    fillColor: 'green',
    strokeColor: '#ffffff',
    strokeWeight: 2
  });


// var iconBase = 'http://35.198.13.96/ora_otca/images/';
// var iconBase = 'http://191.232.182.250/pric_otca/views/layout/frontend/img/frontend/';
// var iconBase = 'http://35.198.18.102/ora/images/';
// var iconBase = 'http://local.github/ora_otca/images/';
var iconBase = _root_ + 'views/layout/frontend/img/frontend/';
var marker = new google.maps.Marker({
    position: new google.maps.LatLng(-10.485893, -70.000737),
    title:"Cobertura de Bosques",
    icon: iconBase + 'ic-marker-1.png'
});

var marker2 = new google.maps.Marker({
    position: new google.maps.LatLng(-1.1999344,-59.7486991),
    title:"Áreas Protegidas",
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

cssInfoWindows(infowindow);
cssInfoWindows(infowindow2);
cssInfoWindows(infowindow3);
cssInfoWindows(infowindow4);


// Event that closes the Info Window with a click on the map
  // google.maps.event.addListener(map, 'click', function() {
  //   infowindow.close();
  // });


// Carga hidrica
marker.addListener('click', function(event) {
  // infowindow.open(map, marker);

    map.setZoom(4);
    map.setCenter(marker.getPosition());
    map.data.revertStyle();
    // map.data.overrideStyle({strokeWeight: 8});
    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#008000',
      strokeWeight: 4
    });
    infowindow2.close();
    infowindow3.close();
    infowindow4.close();
    infowindow.open(map, marker);
    marker.setIcon(iconBase + 'ic-marker-1_hover.png');
    animacionMarker(marker);
});
marker.addListener('mouseover', function(event) {
  // infowindow.open(map, marker);

    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#008000',
      strokeWeight: 2
    });
    marker.setIcon(iconBase + 'ic-marker-1_hover.png');
    animacionMarker(marker);
});
marker.addListener('mouseout', function(event) {
  // infowindow.open(map, marker);

    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#efa30b',
      strokeWeight: 1
    });
    marker.setAnimation(null);
    marker.setIcon(iconBase + 'ic-marker-1.png');
});



// Areas protegidos
marker2.addListener('click', function(event) {
    // infowindow2.open(map, marker2);

    map.setZoom(4);
    map.setCenter(marker2.getPosition());
    map.data.revertStyle();
    // map.data.overrideStyle({strokeWeight: 8});
    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#ffed00',
      strokeWeight: 4
    });
    infowindow.close();
    infowindow3.close();
    infowindow4.close();
    infowindow2.open(map, marker2);
    marker2.setIcon(iconBase + 'ic-marker-2_hover.png');
    animacionMarker(marker2);

});
marker2.addListener('mouseover', function(event) {
  // infowindow2.open(map, marker2);

    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#ffed00',
      strokeWeight: 2
    });
    marker2.setIcon(iconBase + 'ic-marker-2_hover.png');
    animacionMarker(marker2);
});
marker2.addListener('mouseout', function(event) {
  // infowindow.open(map, marker);

    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#efa30b',
      strokeWeight: 1
    });
    marker2.setAnimation(null);
    marker2.setIcon(iconBase + 'ic-marker-2.png');
});


// Cobertura de Bosques
marker3.addListener('click', function(event) {
    // infowindow3.open(map, marker3);

    map.setZoom(4);
    map.setCenter(marker3.getPosition());
    map.data.revertStyle();
    // map.data.overrideStyle({strokeWeight: 8});
    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#428bca',
      strokeWeight: 4
    });
    infowindow.close();
    infowindow2.close();
    infowindow4.close();
    infowindow3.open(map, marker3);
    marker3.setIcon(iconBase + 'ic-marker-3_hover.png');
    animacionMarker(marker3);
});
marker3.addListener('mouseover', function(event) {
  // infowindow3.open(map, marker3);

    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#428bca',
      strokeWeight: 2
    });
    marker3.setIcon(iconBase + 'ic-marker-3_hover.png');
    animacionMarker(marker3);
});
marker3.addListener('mouseout', function(event) {
  // infowindow.open(map, marker);

    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#efa30b',
      strokeWeight: 1
    });
    marker3.setAnimation(null);
    marker3.setIcon(iconBase + 'ic-marker-3.png');
});


// Pueblos Indigenas
marker4.addListener('click', function(event) {
    // infowindow4.open(map, marker4);

    map.setZoom(4);
    map.setCenter(marker4.getPosition());
    map.data.revertStyle();
    // map.data.overrideStyle({strokeWeight: 8});
    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#efa30b',
      strokeWeight: 4
    });
    infowindow.close();
    infowindow2.close();
    infowindow3.close();
    infowindow4.open(map, marker4);
    marker4.setIcon(iconBase + 'ic-marker-4-hover.png');
    animacionMarker(marker4);
});
marker4.addListener('mouseover', function(event) {
  // infowindow4.open(map, marker4);

    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#efa30b',
      strokeWeight: 2
    });
    marker4.setIcon(iconBase + 'ic-marker-4-hover.png');
    animacionMarker(marker4);
});
marker4.addListener('mouseout', function(event) {
  // infowindow.open(map, marker);

    map.data.setStyle({
      fillColor: 'green',
      strokeColor: '#efa30b',
      strokeWeight: 1
    });
    marker4.setAnimation(null);
    marker4.setIcon(iconBase + 'ic-marker-4.png');
});

var animacionMarker = function(markerAnimar){
    if (markerAnimar.getAnimation() !== null) {
        markerAnimar.setAnimation(null);
    } else {
        markerAnimar.setAnimation(google.maps.Animation.BOUNCE);
    }
};



}