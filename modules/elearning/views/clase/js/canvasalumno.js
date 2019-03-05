var theimage = null;
var canvasalumno = null;
const ALTURA_TITULO_PIZARRA = 0;
new Vue({
	el: '#modulo-contenedor',
	data: function () {
		return {
			showLinksVideo: null,
			spanCurrentPizarra: null,
			razoncambio: 1.77777777,
			razonZoom: 0,
			zoomAplicado: false,
			LECCION: {
				ID: 0,
				SESSION_ID: 0,
				SESSION_HASH: ''
			},
			CANVAS: {
				width: 0,
				height: 0
			},
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
		onSocket_RECIVE_LINKS: function(link) {
			console.log(link)
			if (this.showLinksVideo != null && this.showLinksVideo != undefined) {
				let ta = document.createElement('a');
				ta.text = link
				ta.href = link
				ta.target ="_blank"
				ta.classList.add('list-group-item')
				this.showLinksVideo.append(ta);
			}
		},
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
		console.log(this)
		console.log('creta!')
		let hs = HASH_SESSION.split('-');
		
		this.LECCION.ID = LMS_LECCION
		this.LECCION.SESSION_ID = hs[1]
		this.LECCION.SESSION_HASH = hs[0]
		this.objSocket = new AppSocket({query: "id=" + USUARIO.id + "&curso=" + USUARIO.curso + "&tipo=2&leccion=" + LMS_LECCION + "&docente=" + USUARIO.docente + '&leccion_session=' + this.LECCION.SESSION_ID + '&leccion_session_hash=' + this.LECCION.SESSION_HASH}, base_url('socket_canvas', true))



		// this.objSocket.on('conexion_alumno', res => {
		// 	console.log('alumno conectado')
		// 	console.log(res)
		// 	if (res.success)
		// 		this.objSocket.emit('send_all_data_canvas', canvasdocente.toJSON())
		// })





	},
	mounted: function () {
		
		// this.$refs.opciones_canvas.classList.remove('hidden')
		this.showLinksVideo = document.getElementById('show_links_video')
		this.spanCurrentPizarra = document.getElementById('nro_pízarra');
		this.$refs.panel_pizarra_final.classList.remove('hidden')
		this.$refs.micanvas.width = this.CANVAS.width = this.$refs.panel_pizarra_final.offsetWidth - 2;
		console.log(this.$refs.panel_pizarra_final.offsetWidth)
		console.log(this.CANVAS.width)

		let altura = (this.$refs.micanvas.width/this.razoncambio);

		this.$refs.chatPanel.classList.remove('hidden')
		// this.$refs.pizarraPanel.classList.remove('hidden')

		this.$refs.chatPanel.style.height = (altura) + 'px'
		// this.$refs.pizarraPanel.style.height = (altura - this.$refs.navsPanel.offsetHeight) + 'px'
		// let tabCH = this.$refs.navsPanel.offsetHeight + 75
		// let tabBMT = this.$refs.navsPanel.offsetHeight + 30
		$('#chat-msn-body')[0].style.height = (altura - 74 + ALTURA_TITULO_PIZARRA) + 'px'
		$('#chat-msn-body-usuarios')[0].style.height = (altura - 29 + ALTURA_TITULO_PIZARRA) + 'px'

		this.$refs.refContainerChatPizarra.style.height = altura + 'px'
		this.$refs.panel_pizarra_final.style.height = altura + ALTURA_TITULO_PIZARRA + 'px'
		// this.$refs.panel_pizarra_final.offsetWidth
		this.$refs.micanvas.height = altura - 0

		canvasalumno = new fabric.Canvas('micanvas')
		canvasalumno.selection = false

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
			
			this.objSocket.on('SESSION_CANVAS_SUCCESS', msg => {
				console.log('SESSION_CANVAS_SUCCESS');
				console.log(msg)
				this.objSocket.on('all_data_canvas', canvas_json => {
					if (this.spanCurrentPizarra != null && this.spanCurrentPizarra != undefined) {
						if (canvas_json.canvas.pizarra_index != undefined)
							this.spanCurrentPizarra.innerText = canvas_json.canvas.pizarra_index
						else this.spanCurrentPizarra.innerText = ''
					}

					if (!this.zoomAplicado) {
						// if (+canvas_json.canvas.width > +this.$refs.micanvas.width)
							this.razonZoom = this.CANVAS.width/canvas_json.canvas.width;
							// this.razonZoom = this.$refs.micanvas.width/canvas_json.canvas.width;
						// else
							// this.razonZoom = canvas_json.canvas.width/this.$refs.micanvas.width;
						this.zoomAplicado = true;
						canvasalumno.setZoom(this.razonZoom);
					}
					console.log(this.$refs.micanvas.width)
					console.log(this.razonZoom)
					console.log(canvas_json)
					console.log('recibiendo canvas')
					canvasalumno.clear()
					canvasalumno.loadFromJSON(canvas_json.json, () => {
						console.log(canvasalumno.getObjects())
						if (!this.start_leccion) {
						// if (true) {
							this.start_leccion = true
						}
					})
				})

				
				this.objSocket.on('change_object_alumno', (msg) => {
					console.log(msg)
					let temp = null
					if (this.start_leccion) {
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
										console.log('se selecciono una imagen')
										// fabric.Image.fromURL(msg.dataUrl, (o) => {
										fabric.Image.fromURL(msg.data.src, (o) => {
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
					}

				})
				this.objSocket.on('show_img', (msg) => {
					if (this.start_leccion) {

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
					}
				})
				this.objSocket.on('move_mouse', (pos) => {
					if (this.cursor_alumno != null && this.start_leccion)
						this.cursor_alumno.set({ left: pos.x, top: pos.y });
					// canvasalumno.renderAll()
				})
				this.objSocket.on('alumnos_limpiar_canvas', res => {
					canvasalumno.clear()
				})

				this.objSocket.on('alumnos_eliminar_objetos', res => {
					if (this.start_leccion) {
						let objs = canvasalumno.getObjects()
						objs.forEach(v => {
							if (res.find(x => x == v.objeto_id) != undefined)
								canvasalumno.remove(v)
						})
					}

				})
				this.objSocket.on('RECIVE_LINKS', this.onSocket_RECIVE_LINKS)
				this.objSocket.on('CLOSE_ONLINE_AL', () => {
					window.location.reload()
				})
				this.objSocket.emit('CONFIRMACARGACANVAS', 'confirmado')
			})
			this.objSocket.emit('INIT_CANVAS', 'Iniciando desde alumno');
		})
	}
})