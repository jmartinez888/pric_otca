var theimage = null;
var canvasalumno = null;
new Vue({
	el: '#modulo-contenedor',
	data: function () {
		return {
			canvas_leccion: [],
			obj_canvas: null,
			elementos: [],
			objSocket: null,
			cursor_alumno: null,
			rect: null,
			start_leccion: false


		}
	},
	methods: {
		onClick_openLapiz: function () {

		},
		onClick_openCuadrado: function () {
			console.log('cuadrado')
			this.rect.set('angle', 75);
			this.rect.animate('angle', 45, {
			  onChange: canvasalumno.renderAll.bind(canvasalumno)
			});

		},
		onClick_toJson: function () {
			console.log(JSON.stringify(canvasalumno));
		},
		onClick_toPng: function () {
			console.log(canvasalumno.toDataURL('png'));
		}
	},
	created: function () {
		console.log('creta!')

		this.objSocket = new AppSocket({ query: "id=" + USUARIO.id + "&curso=" + USUARIO.curso + "&tipo=2&leccion=" + LMS_LECCION + "&docente=" + USUARIO.docente})



		// this.objSocket.on('conexion_alumno', res => {
		// 	console.log('alumno conectado')
		// 	console.log(res)
		// 	if (res.success)
		// 		this.objSocket.emit('send_all_data_canvas', canvasdocente.toJSON())
		// })





	},
	mounted: function () {
		canvasalumno = new fabric.Canvas('micanvas')
		canvasalumno.selection = false
		this.$refs.panel_pizarra_final.classList.remove('hidden')

		fabric.Image.fromURL(_root_ + 'modules/elearning/views/clase/img/mouse_off.png', (oImg) => {
					this.cursor_alumno = oImg.set('selectable', false)
					console.log(oImg)
					canvasalumno.add(oImg);
					this.cursor_alumno.moveTo(99999)
				  // theimage = oImg
		});

		console.log(canvasalumno)
		console.log(this.$refs.temporal)
		setInterval(() => {
		// 	// console.log('-----')
		// 	if (theimage != null) {
		// 		this.$refs.temporal.src = theimage;
		// 		// canvasalumno.clear();
		// 		// canvasalumno.add(theimage);
		// 	}
			if (this.cursor_alumno != null)
				this.cursor_alumno.moveTo(9999999)
			canvasalumno.renderAll();
		}, 30)
		// canvasalumno.loadFromJSON()
		this.objSocket.init(() => {
			this.objSocket.on('all_data_canvas', canvas_json => {
				console.log(canvas_json)
				console.log('recibiendo canvas')
				canvasalumno.clear()
				canvasalumno.loadFromJSON(canvas_json, () => {
					console.log(canvasalumno.getObjects())
					if (!this.start_leccion) {
					// if (true) {

						this.objSocket.on('change_object_alumno', (msg) => {
							console.log(msg)
							let temp = null
							temp = canvasalumno.getObjects().find(v => {
								return v.objeto_id == msg.id
							})
							let create_object = (msg.event == 'create')

							if (create_object || (temp == undefined)) {
								console.log('created ' + msg.data.type)
								let xx = null
								switch (msg.data.type) {
									case 'rect':
											msg.data.objeto_id = msg.id
											xx = new fabric.Rect(msg.data)
										break;
									case 'circle':
											msg.data.objeto_id = msg.id
											xx = new fabric.Circle(msg.data)
										break;
									case 'image':

											fabric.Image.fromURL(msg.dataUrl, (o) => {
												console.log('iamgen cargada')
												o.objeto_id = msg.id
												canvasalumno.add(o)
											})
											// xx = new fabric.Circle(msg.data)
										break;
									case 'path':
											msg.data.objeto_id = msg.id
											// fabric.Path.fromObject(msg.data)
											//revisar la optención de objeto mediante otro métdo
											fabric.util.enlivenObjects([msg.data], objs => {
												// canvasalumno.add(objs[0])
												xx = objs[0]
											})

										break;
									default:
										console.log('created by default')
										msg.data.objeto_id = msg.id
											// fabric.Path.fromObject(msg.data)
											//revisar la optención de objeto mediante otro métdo
											fabric.util.enlivenObjects([msg.data], objs => {
												// canvasalumno.add(objs[0])
												xx = objs[0]
											})
										break;
								}
								if (xx != null) {
									// this.elementos.push(xx)
									canvasalumno.add(xx)
								}
							}
							if (temp != undefined) {
								switch (msg.event) {
									case 'modified':
										console.log('modified')
										temp.setOptions(msg.data)
										break
									case 'moving':
										console.log('moving')
										temp.set({ left: msg.data.x, top: msg.data.y })
										break
								}
							}

						})
						this.objSocket.on('show_img', (msg) => {
							fabric.util.enlivenObjects(msg.base64, (objects) => {
							  var origRenderOnAddRemove = canvasalumno.renderOnAddRemove;
							  canvasalumno.renderOnAddRemove = false;
							  canvasalumno.clear();
							  objects.forEach((o) => {
							    canvasalumno.add(o);
							    // canvasalumno.add(objects[0]);
							  });

							  canvasalumno.renderOnAddRemove = origRenderOnAddRemove;
							  canvasalumno.renderAll();
							});
							console.log('recive on')
							// theimage = msg.base64
							// fabric.Image.fromURL(msg.base64, (oImg) => {
							// 		oImg.set('selectable', false)
							// 		canvasalumno.clear();
							// 		canvasalumno.add(oImg);
							// 	  // theimage = oImg
							// });


							// canvasalumno.loadFromJSON('{"objects":[{"type":"rect","left":50,"top":50,"width":20,"height":20,"fill":"green","overlayFill":null,"stroke":null,"strokeWidth":1,"strokeDashArray":null,"scaleX":1,"scaleY":1,"angle":0,"flipX":false,"flipY":false,"opacity":1,"selectable":true,"hasControls":true,"hasBorders":true,"hasRotatingPoint":false,"transparentCorners":true,"perPixelTargetFind":false,"rx":0,"ry":0},{"type":"circle","left":100,"top":100,"width":100,"height":100,"fill":"red","overlayFill":null,"stroke":null,"strokeWidth":1,"strokeDashArray":null,"scaleX":1,"scaleY":1,"angle":0,"flipX":false,"flipY":false,"opacity":1,"selectable":true,"hasControls":true,"hasBorders":true,"hasRotatingPoint":false,"transparentCorners":true,"perPixelTargetFind":false,"radius":50}],"background":"rgba(0, 0, 0, 0)"}')
						})
						this.objSocket.on('move_mouse', (pos) => {
							if (this.cursor_alumno != null)
								this.cursor_alumno.set({ left: pos.x, top: pos.y });
							// canvasalumno.renderAll()
						})
						this.objSocket.on('alumnos_limpiar_canvas', res => {
							canvasalumno.clear()
						})

						this.objSocket.on('alumnos_eliminar_objetos', res => {
							let objs = canvasalumno.getObjects()
							objs.forEach(v => {
								if (res.find(x => x == v.objeto_id) != undefined)
									canvasalumno.remove(v)
							})

						})
						this.start_leccion = true
					}
				})
			})
		})
	}
})