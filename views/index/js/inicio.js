// const interes = {
// 	props: ['id'],
// 	data: function () {
// 		return {
// 			difusion: {
// 				ODif_Image: ''
// 			}
// 		}
// 	},
// 	template: '#interes',
// 	created () {
// 		axios.get(_root_lang + 'difusion/contenido/' + this.id + '?type=json').then(res => {
// 			console.log(res.data)
// 			this.difusion = res.data.data
// 		})
// 		console.log(this.id)
// 	}
// }


new Vue({
	el: '#inicio',
	// components: {
	// 	interes
	// },
	methods: {
		cssInfoWindows: function(infowindowLocal){
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
		},
		animacionMarker : function(markerAnimar){
		    if (markerAnimar.getAnimation() !== null) {
		        markerAnimar.setAnimation(null);
		    } else {
		        markerAnimar.setAnimation(google.maps.Animation.BOUNCE);
		    }
		},
		initMap : function () {
			var _this = this;
			var myLatlng = new google.maps.LatLng(-11.5106611,-60.8686626);
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

			map.data.loadGeoJson(_root_ + 'public/img/Area_estudio_Amz.geojson');
			map.data.setStyle({
		    fillColor: 'green',
		    strokeColor: '#ffffff',
		    strokeWeight: 2
		  });
			var iconBase = _root_ + 'files/difusion/indicador/';
			axios.get(_root_lang + 'difusion/contenido/datos_cifras').then(res => {

				res.data.forEach(item => {
					var contentString = `
						<div id="iw-container">
				    	<div class="iw-title">${item.indicador.OInd_Titulo}</div>
				    	<div class="iw-content">
				    		<div class="iw-subTitle">${item.ODii_Descripcion}&nbsp;&nbsp;<a href="${_root_lang + 'difusion/contenido/' + item.difusion.ODif_IdDifusion}" title="Ver más" target="_blank" class="glyphicon glyphicon-share"></a>
				    	</div>
				    </div>`;

				    var infowindow = new google.maps.InfoWindow({
						  content: contentString
						});

						var marker = new google.maps.Marker({
						    position: new google.maps.LatLng(item.ODii_PosLatitude, item.ODii_PosLongitude),
						    title: item.indicador.OInd_Titulo,
						    icon: iconBase + item.indicador.OInd_IdIndicadores + '/' + item.indicador.OInd_IconoPath
						});

						marker.setMap(map);
						this.cssInfoWindows(infowindow);

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
						    // infowindow2.close();
						    // infowindow3.close();
						    // infowindow4.close();
						    infowindow.open(map, marker);
						    marker.setIcon(iconBase + item.indicador.OInd_IdIndicadores + '/' + item.indicador.OInd_IconoPath);
						    // marker.setIcon(iconBase + 'ic-marker-1_hover.png');
						    _this.animacionMarker(marker);
						});
						marker.addListener('mouseover', function(event) {
						  // infowindow.open(map, marker);

						    map.data.setStyle({
						      fillColor: 'green',
						      strokeColor: '#008000',
						      strokeWeight: 2
						    });
						    marker.setIcon(iconBase + item.indicador.OInd_IdIndicadores + '/' + item.indicador.OInd_IconoPath);
						    // marker.setIcon(iconBase + 'ic-marker-1_hover.png');
						    _this.animacionMarker(marker);
						});
						marker.addListener('mouseout', function(event) {
						  // infowindow.open(map, marker);

						    map.data.setStyle({
						      fillColor: 'green',
						      strokeColor: '#efa30b',
						      strokeWeight: 1
						    });
						    marker.setAnimation(null);
						    // marker.setIcon(iconBase + 'ic-marker-1.png');
						    marker.setIcon(iconBase + item.indicador.OInd_IdIndicadores + '/' + item.indicador.OInd_IconoPath);
						});

				})
			})

		}
	},
	created () {

	},
	mounted: function () {
		this.initMap()
		$('.mainstage').wwfMainstage(banners);
	}
});