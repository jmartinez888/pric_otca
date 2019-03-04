var canvasdocente = null
const MODE_OBJECT = {
	NONE: 0,
	NORMAL: 1,
	LAPIZ: 2,
	RECT: 3,
	CIRCULO: 4,
	TEXTO: 5,
	IMAGE: 6
}
var mivue = new Vue({
	el: '#modulo-contenedor',
	data: function () {
		return {
			showLinksVideo: null,
			spanCurrentPizarra: null,
			imgTransparent100x100: 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAQAAADa613fAAAAaElEQVR42u3PQREAAAwCoNm/9CL496ABuREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREWkezG8AZQ6nfncAAAAASUVORK5CYII=',
			altura_opciones: 96,
			razoncambio: 1.77777777,
			PIZARRAS: [],
			LECCION: {
				ID: 0,
				SESSION_ID: 0,
				DOCENTE_ID: 0,
				SESSION_HASH: ''
			},
			CANVAS: {
				width: 0,
				height: 0
			},

			CURRENT_CREATE: {
				MODE: MODE_OBJECT.NORMAL,
				IS_DOWN: false,
				INITIALIZED: false,
				POINTER: {x: 0, y: 0},
				OBJECT: null
			},			
			canvas_leccion: [],
			show_tools: true,
			obj_canvas: null,
			current_element: 'none',
			current_type: 'none',
			current_pizarra: 0,
			current_pizarra_index: undefined,
			lapizOn: false,
			elementos: [],
			rect: null,
			group: null,
			group2: null,
			texto: null,
			objSocket: null,
			intervalmon: null,
			count_id: Date.now(),
			opcelements: {
				fontSize: 40,
				text: INGRESAR_TEXTO,
				top: 0,
				left: 0,
				height: 0,
				lapizcolor: '#000000',
				lapizandcho: 1,
				width: 0,
				angle: 0,
				strokeWidth: 1,
				stroke: '#000000',
				fill: '#000000'
			}
		}
	},
	watch: {
		'opcelements.stroke': function (nv, ov) {
			console.log(this.$refs.opcelementsStrokeSFH)
			this.$refs.opcelementsStrokeSFH.style.backgroundColor = nv
			this.onClick_renderCanvas();
		},
		'opcelements.fill': function (nv, ov) {
			this.$refs.opcelementsFillSFH.style.backgroundColor = nv
			this.onClick_renderCanvas();
		},
		'opcelements.strokeWidth': function (nv, ov) {
			this.onClick_renderCanvas();
		},
		'opcelements.angle': function (nv, ov) {
			this.onClick_renderCanvas();
		},
		'opcelements.fontSize': function (nv, ov) {
			this.onClick_renderCanvas();
		},
		'opcelements.text': function (nv, ov) {
			this.onClick_renderCanvas();
		},
	},
	methods: {
		btnOnClick_ToolsOption: function (opcion) {
			console.log(opcion)
			switch (opcion) {
				case 'borde':
					this.$refs.opcelementsStroke.click()
					break;
				case 'fill':
					this.$refs.opcelementsFill.click()
					break;
			}
		},
		frmOnSubmit_sendLinkVideo: function (e) {
			console.log(e)
			let link = e.target.elements.in_link_videollamada.value
			axios.post(base_url('elearning/clase/send_link_video'), parseData({
				leccion_id: this.LECCION.ID,
				leccion_session_id: this.LECCION.SESSION_ID,
				docente_id: this.LECCION.DOCENTE_ID,
				leccion_session_hash: this.LECCION.SESSION_HASH,
				link_video: link
			})).then(res => {
				if (this.showLinksVideo != null && this.showLinksVideo != undefined) {
					let ta = document.createElement('a');
					ta.text = link
					ta.href = link
					ta.classList.add('list-group-item')
					this.showLinksVideo.append(ta);
				}
				this.objSocket.emit('LINK_VIDEO', link)
			})
		},
		btnOnClick_finalizarLeccionOnline: function () {
			console.log('asd')
			// this.objSocket.emit('CLOSE_ONLINE','')
			// {BASE_URL}elearning/clase/finalizar/{$curso}/{$modulo.Moc_IdModuloCurso}/{$leccion.Lec_IdLeccion}
			axios.post(base_url('elearning/clase/finalizar_online/' + this.LECCION.ID), parseData({
				docente_id: this.LECCION.DOCENTE_ID,
				leccion_session_espera_id: this.LECCION.SESSION_HASH,
				leccion_session_espera_id_b: this.LECCION.SESSION_ID,
			})).then(res => {
				if (res.data.success) {
					this.objSocket.emit('CLOSE_ONLINE','')
				}
			})
		},
		btnOnClick_finalizarLeccion: function () {

			axios.post(base_url('elearning/clase/finalizar_leccion/' + this.LECCION.ID), parseData({
				docente_id: this.LECCION.DOCENTE_ID,
				leccion_session_espera_id: this.LECCION.SESSION_HASH,
				leccion_session_espera_id_b: this.LECCION.SESSION_ID,
			})).then(res => {
				if (res.data.success) {
					this.objSocket.emit('CLOSE_LECCION','')
				}
			})
		},
		formatItemPizarra: function (id) {
			return `
			<div class="panel item-pizarra">
				<img ref="pizarrabg_${id}" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAQAAADa613fAAAAaElEQVR42u3PQREAAAwCoNm/9CL496ABuREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREWkezG8AZQ6nfncAAAAASUVORK5CYII=" />
				<strong class="number_pizarra">${'asd'}</strong>
			</div>
			`
		},
		onClick_agregarPizarra: function (e) {
			$.fn.Mensaje({
		    mensaje: "¿Agregar pizarra vacía?",
		    tipo: "SiNo",
		    funcionSi: () => {
					axios.post(base_url('elearning/pizarra/_registrar_pizarra'), parseData({
						leccion: this.LECCION.ID,
						modo: 'noimage'
					})).then(res => {
						if (res.data.estado == 1) {
							$.fn.Mensaje({
								mensaje: res.data.mensaje,
								tipo: 'Aceptar',
								funcionAceptar: () => {
								 console.log('pizarra agregada')
								if (res.data.data.data_pizarra)
									this.PIZARRAS.push(res.data.data.data_pizarra)

								}
							});	
						}
					})
				}
		  });
			
		},
		fnOnResize_PanelPizarra: function (e) {
			console.log('dd')
			console.log(this.$refs.panel_pizarra_final.offsetWidth)
		},
		onClick_seleccionPizarra: function (pizarra, index) {
			//verificar ID pizarra
			if (pizarra != this.current_pizarra) {
				this.setNormal_Cursor()
				let agregar_a_lista = true;
				let p = this.canvas_leccion.find(v => {
					return v.pizarra == this.current_pizarra
				})
				if (p != undefined) {
					//guardar objetos actuales
					p.json = canvasdocente.toJSON(['objecto_id'])
					let solicita = this.canvas_leccion.find(v => {
						return v.pizarra == pizarra
					})
					
					if (solicita != undefined) {
						agregar_a_lista = false;
						canvasdocente.loadFromJSON(solicita.json, x => {
							canvasdocente.getObjects().forEach(obj => {
								this.addEventosObjeto(obj)
							})
							this.objSocket.emit('send_all_data_canvas', {
								json: solicita.json, 
								canvas: {
									width: this.CANVAS.width, 
									height: this.CANVAS.height,
									pizarra_index: index
								}
							})
						})
					}
				}
				if (this.spanCurrentPizarra != null && this.spanCurrentPizarra != undefined)
					this.spanCurrentPizarra.innerText = index
				if (agregar_a_lista) {
					console.log('agregfar nuevo a lista')
					canvasdocente.clear()
					let nodePizarra = document.getElementById('pizarrabg_' + pizarra)
					canvasdocente.setBackgroundImage(nodePizarra.src, x => {
						canvasdocente.renderAll.bind(canvasdocente)
						this.canvas_leccion.push({
							pizarra: pizarra,
							json: '',
							nro_pizarra: nodePizarra.dataset.nro
						})
						canvasdocente.renderAll()
						this.objSocket.emit('send_all_data_canvas', {json: canvasdocente.toJSON(['objecto_id']), canvas: {width: this.CANVAS.width, height: this.CANVAS.height, pizarra_index: index}})
						// this.objSocket.emit('send_all_data_canvas', canvasdocente.toJSON(['objecto_id']))
					}, {
							backgroundImageStretch: false,
							scaleX: this.CANVAS.width/650,
							scaleY: this.CANVAS.height/365,
					});
				}
				this.current_pizarra = pizarra
				this.current_pizarra_index = index
			}



		},
		onMouseenter_showTools: function () {
			console.log('hola!!!')
			this.show_tools = true
		},
		onChange_loadImage: function () {
				let fr = new FileReader()
				fr.onload = () => {
					let img = new Image()
					img.onload = () => {
						this.addObjectCanvas(new fabric.Image(img, {
						  objeto_id: this.count_id++,
						}), true, true, true)
					}
					img.src = fr.result
				}
				fr.readAsDataURL(this.$refs.fileimg.files[0])


		},
		showIn: function (opciones) {
			if (typeof opciones == 'string') {
				return opciones == 'all'
			} else
				return opciones.find(v => v == this.current_type) == undefined ? false : true
		},
		onClick_eliminarLimpiar: function () {
			// canvasdocente.clear()
			//canvasdocente.setBackgroundColor('white', () => canvasdocente.renderAll())
			let ids = []
			canvasdocente.getObjects().forEach(item => {
				ids.push(item.objeto_id)
				canvasdocente.remove(item)
			})
			this.objSocket.emit('eliminar_objetos', ids)
			//this.objSocket.emit('limpiar_canvas')
		},
		onClick_eliminarObjecto: function () {
			let obj = canvasdocente.getActiveObjects()
			let ids = []
			obj.forEach(v => {
				ids.push(v.objeto_id)
				canvasdocente.remove(v)
			})
			this.objSocket.emit('eliminar_objetos', ids)
		},
		onClick_renderCanvas: function () {
			console.log('actualizar')


			if (canvasdocente.isDrawingMode) {
				canvasdocente.freeDrawingBrush.color = this.opcelements.fill//color border
				canvasdocente.freeDrawingBrush.width = this.opcelements.strokeWidth
			} else {
				let el = canvasdocente.getObjects().find(v => {
					return v.objeto_id == this.current_element
				})
				if (el != undefined) {
					console.log('toca esocger')
					switch (el.type) {
						case 'text':
							el.set('fontSize', +this.opcelements.fontSize)
							el.set('text', this.opcelements.text)
							// el.set('top', this.opcelements.top)
							// el.set('left', this.opcelements.left)
							// el.set('height', this.opcelements.height)
							// el.set('width', this.opcelements.width)
							el.set('fill', this.opcelements.fill)//color border
							el.set('stroke', this.opcelements.stroke)//color border
							el.set('strokeWidth', +this.opcelements.strokeWidth)
							break;
						case 'rect':
							el.set('fill', this.opcelements.fill)//color border
							el.set('stroke', this.opcelements.stroke)//color border
							el.set('strokeWidth', +this.opcelements.strokeWidth)
							break;
						default:
							el.set('fill', this.opcelements.fill)//color border
							el.set('stroke', this.opcelements.stroke)//color border
							el.set('strokeWidth', +this.opcelements.strokeWidth)
							break;
					}
					canvasdocente.renderAll()
				} else {
					console.log('update, elemento no econtrado')
				}
			}
		},
		addEventosObjeto (obj) {
			obj.on('selected', (e) => {
				console.log('selected')
				console.log(e)
				console.log(obj)
				this.current_element = obj.objeto_id
				this.current_type = obj.type
				this.opcelements.text = obj.text
				this.opcelements.stroke = obj.stroke
				this.opcelements.strokeWidth = obj.strokeWidth
				this.opcelements.fill = obj.fill

			})
			obj.on('deselected', (e) => {
				this.current_element = 'none'
				this.current_type = 'none'
			})
			obj.on('mouseout', (x, y) => {
				console.log('mouseout')
			})
			obj.on('moving', (x, y) => {
				this.objSocket.emit('change_object', {
					data: 	{x: x.target.left, y: x.target.top},
					canvas:	{height: this.$refs.micanvas.height, width: this.$refs.micanvas.width},
					id: 		x.target.objeto_id,
					event: 	'moving'
				})
			})
			obj.on('modified', (x, y) => {
				console.log('modified')
				this.objSocket.emit('change_object', {
					data: x.target.toObject(),
					id: x.target.objeto_id,
					event: 'modified'
				})
			})
		},
		emitObject: function (obj, dataUrl) {
			this.objSocket.emit('create_object', {
				data: obj.toObject(),
				dataUrl: dataUrl ? obj.toDataURL('png') : '',
				id: obj.objeto_id,
				event: 'create'
			})

		},
		addObjectCanvas: function (obj, emitData = true, addCanvas = true, dataUrl = false, selected = false) {
			this.addEventosObjeto(obj)
			if (emitData) {
				this.emitObject(obj, dataUrl)
				// this.objSocket.emit('create_object', {
				// 	data: obj.toObject(),
				// 	dataUrl: dataUrl ? obj.toDataURL('png') : '',
				// 	id: obj.objeto_id,
				// 	event: 'create'
				// })

			}
			if (addCanvas)
				canvasdocente.add(obj)
		},
		setAllObjectsSelectable: function (opc) {
			canvasdocente.getObjects().forEach(v => {
				v.set('selectable', opc)
			})
		},
		setNormal_Cursor: function (null_object = true) {
			this.CURRENT_CREATE.INITIALIZED = false
			if (null_object)
				this.CURRENT_CREATE.OBJECT = null
			this.CURRENT_CREATE.MODE = MODE_OBJECT.NORMAL
			canvasdocente.isDrawingMode = this.lapizOn = false
			this.current_type = 'none'
			this.setAllObjectsSelectable(true)
		},
		onClick_createObject: function (opc) {
			canvasdocente.discardActiveObject()
			canvasdocente.renderAll()
			switch (opc) {
				case 'normal':
					this.setNormal_Cursor()
					break;
				case 'lapiz':
						canvasdocente.isDrawingMode = this.lapizOn = true
						this.opcelements.fill = canvasdocente.freeDrawingBrush.color
						this.opcelements.strokeWidth = canvasdocente.freeDrawingBrush.width
						this.current_type = 'lapiz'
						this.CURRENT_CREATE.INITIALIZED = false
						this.CURRENT_CREATE.OBJECT = null
						this.CURRENT_CREATE.MODE = MODE_OBJECT.LAPIZ
					break;
				case 'rect':
					canvasdocente.isDrawingMode = this.lapizOn = false
					this.CURRENT_CREATE.MODE = MODE_OBJECT.RECT
					if (!this.CURRENT_CREATE.INITIALIZED)
						this.CURRENT_CREATE.INITIALIZED = true
					this.setAllObjectsSelectable(false)
					break;
				case 'circulo':
					canvasdocente.isDrawingMode = this.lapizOn = false
					this.CURRENT_CREATE.MODE = MODE_OBJECT.CIRCULO
					if (!this.CURRENT_CREATE.INITIALIZED)
						this.CURRENT_CREATE.INITIALIZED = true
					this.setAllObjectsSelectable(false)
					break;
				case 'texto':
				this.current_type = 'text'
				canvasdocente.isDrawingMode = this.lapizOn = false
				this.CURRENT_CREATE.MODE = MODE_OBJECT.TEXTO
					if (!this.CURRENT_CREATE.INITIALIZED)
						this.CURRENT_CREATE.INITIALIZED = true
					this.setAllObjectsSelectable(false)
				case 'image':

					break;
			}

		},
		onClick_openLapiz: function () {

		},
		onClick_openCuadrado: function () {
			console.log('cuadrado')
			this.rect.set('angle', 75);
			this.rect.animate('angle', 45, {
			  onChange: canvasdocente.renderAll.bind(canvasdocente)
			});

		},
		onClick_toJson: function () {
			// console.log(JSON.stringify(canvasdocente));
			clearInterval(this.intervalmon)
		},
		procesa_imagen () {

			return new Promise((resolve, reject) => {
				  resolve(this.rect.toObject())
				  // resolve(canvasdocente.toDataURL('png'))
			});
		},
		onClick_toPng: function () {
		}
	},
	created: function () {
		console.log(this)
		console.log('creta!')
		let hs = HASH_SESSION.split('-');
		
		this.LECCION.ID = LMS_LECCION
		this.LECCION.DOCENTE_ID = DOCENTE_ID
		this.LECCION.SESSION_ID = hs[1]
		this.PIZARRAS = PIZARRAS;
		this.LECCION.SESSION_HASH = hs[0]
		this.objSocket = new AppSocket({query: "id=" + USUARIO.id + "&curso=" + USUARIO.curso + "&tipo=2&leccion=" + LMS_LECCION + "&docente=" + USUARIO.docente + '&leccion_session=' + this.LECCION.SESSION_ID + '&leccion_session_hash=' + this.LECCION.SESSION_HASH}, base_url('socket_canvas', true))
		//se coencto un alumno?



	},
	mounted: function () {
		
		document.getElementById('tag-body').onresize = this.fnOnResize_PanelPizarra;
		this.showLinksVideo = document.getElementById('show_links_video');
		this.spanCurrentPizarra = document.getElementById('nro_pízarra');
		// this.$refs.opciones_canvas.classList.remove('hidden')

		// this.$refs.panel_pizarra_final.classList.remove('hidden')
		this.$refs.micanvas.width = this.CANVAS.width = this.$refs.panel_pizarra_final.offsetWidth - 1
		

		let altura = (this.$refs.micanvas.width/this.razoncambio);
		

		this.$refs.chatPanel.classList.remove('hidden')
		this.$refs.pizarraPanel.classList.remove('hidden')

		this.$refs.chatPanel.style.height = (altura - this.$refs.navsPanel.offsetHeight) + 'px'
		this.$refs.pizarraPanel.style.height = (altura - this.$refs.navsPanel.offsetHeight) + 'px'
		let tabCH = this.$refs.navsPanel.offsetHeight + 75
		let tabBMT = this.$refs.navsPanel.offsetHeight + 30
		$('#chat-msn-body')[0].style.height = (altura + this.altura_opciones - tabCH) + 'px'
		$('#chat-msn-body-usuarios')[0].style.height = (altura + this.altura_opciones - tabBMT) + 'px'

		this.$refs.refContainerChatPizarra.style.height = (altura + this.altura_opciones) + 'px'
		this.$refs.panel_pizarra_final.style.height = (altura + this.altura_opciones) + 'px'
		// this.$refs.panel_pizarra_final.offsetWidth
		this.$refs.micanvas.height = this.CANVAS.height = altura - 1

		canvasdocente = new fabric.Canvas('micanvas', {
			backgroundColor: 'white'
		})
		console.log(this.CANVAS.width)
		// canvasdocente.setZoom(this.CANVAS.width/1280)
		canvasdocente.on('mouse:down', (options) => {
			console.log('mouse:down')
			console.log(options.pointer)
			if (this.CURRENT_CREATE.INITIALIZED) {
				this.CURRENT_CREATE.IS_DOWN = true;
				canvasdocente.discardActiveObject()
				switch (this.CURRENT_CREATE.MODE) {
					case MODE_OBJECT.RECT:
						this.CURRENT_CREATE.OBJECT = new fabric.Rect({
							fill: 'transparent',
							backgroundColor: 'transparent',
							stroke: '#000000',
							// width: 120,
							// height: 120,
							objeto_id: this.count_id++,
							left: options.pointer.x,
							top: options.pointer.y,
						})
						break;
					case MODE_OBJECT.CIRCULO:
						this.CURRENT_CREATE.OBJECT = new fabric.Circle({
							fill: 'transparent',
							left: options.pointer.x,
							top: options.pointer.y,
							originX: 'left',
							originY: 'top',
							backgroundColor: 'transparent',
							stroke: '#000000',
							radius: 0,
							strokeWidth:1,
							angle: 0,
							objeto_id: this.count_id++
						})
						break;
					case MODE_OBJECT.TEXTO:
						this.opcelements.text = INGRESAR_TEXTO
						this.CURRENT_CREATE.OBJECT = new fabric.Text(INGRESAR_TEXTO, {
							left: options.pointer.x,
							top: options.pointer.y,
							originX: 'center',
							originY: 'center',
							objeto_id: this.count_id++
						})
						break;
				}
				this.CURRENT_CREATE.POINTER = options.pointer
				this.addObjectCanvas(this.CURRENT_CREATE.OBJECT, false)
				// canvasdocente.add(this.CURRENT_CREATE.OBJECT)
				// canvasdocente.setActiveObject(this.CURRENT_CREATE.OBJECT)
			}
		});

		canvasdocente.on('mouse:up', (options) => {
			if (this.CURRENT_CREATE.INITIALIZED) {
				console.log(this.CURRENT_CREATE.POINTER)
				console.log(options.pointer)
				console.log(this.CURRENT_CREATE.OBJECT)
				this.CURRENT_CREATE.IS_DOWN = false;
				// canvasdocente.discardActiveObject()
				this.CURRENT_CREATE.OBJECT.setCoords()
				// canvasdocente.setActiveObject(this.CURRENT_CREATE.OBJECT)
				canvasdocente.discardActiveObject()
				if (this.CURRENT_CREATE.MODE == MODE_OBJECT.TEXTO) {
					canvasdocente.setActiveObject(this.CURRENT_CREATE.OBJECT)
					this.setNormal_Cursor(false)
				} else {
					this.setAllObjectsSelectable(false)
				}
				this.emitObject(this.CURRENT_CREATE.OBJECT)
				canvasdocente.renderAll()
				
				// this.CURRENT_CREATE.INITIALIZED = false
			}
			

			console.log('mouse:up')
			console.log(options.pointer)
		});
		canvasdocente.on('object:modified', function(options) {
				console.log('object:modified')
		});
		canvasdocente.on('object:selected', function(options) {
			console.log('object:selected')
		});
		canvasdocente.on('object:added', (e) => {
			console.log('object:added')
			if (e.target.type == 'path') {
				e.target.set('objeto_id', this.count_id++)
				this.addObjectCanvas(e.target, true, false)
			}
		});

		canvasdocente.on('mouse:move', (e) => {
			console.log('mouse:move')
			this.objSocket.emit('pos_cursor', e.pointer)
			
			if (this.CURRENT_CREATE.INITIALIZED && this.CURRENT_CREATE.IS_DOWN) {
				switch (this.CURRENT_CREATE.MODE) {
					case MODE_OBJECT.CIRCULO:
						var r = Math.max(Math.abs(this.CURRENT_CREATE.POINTER.y - e.pointer.y), Math.abs(this.CURRENT_CREATE.POINTER.x - e.pointer.x))/2
						// if (r > this.CURRENT_CREATE.OBJECT.strokeWidth) {
						// 	r -= this.CURRENT_CREATE.OBJECT.strokeWidth/2
						// }
						this.CURRENT_CREATE.OBJECT.set({radius: r})
						
						break;
					case MODE_OBJECT.RECT:
						this.CURRENT_CREATE.OBJECT.set({width: Math.abs(this.CURRENT_CREATE.POINTER.x - e.pointer.x)});
						this.CURRENT_CREATE.OBJECT.set({height: Math.abs(this.CURRENT_CREATE.POINTER.y - e.pointer.y)});
						break;
					// case MODE_OBJECT.TEXTO:
					// 	this.CURRENT_CREATE.OBJECT.set({width: Math.abs(this.CURRENT_CREATE.POINTER.x - e.pointer.x)});
					// 	this.CURRENT_CREATE.OBJECT.set({height: Math.abs(this.CURRENT_CREATE.POINTER.y - e.pointer.y)});
					// 	break;
				}
				if (this.CURRENT_CREATE.POINTER.x > e.pointer.x) {
					this.CURRENT_CREATE.OBJECT.set({originX: 'right'})
				} else {
					this.CURRENT_CREATE.OBJECT.set({originX: 'left'})
				}

				if (this.CURRENT_CREATE.POINTER.y > e.pointer.y) {
					this.CURRENT_CREATE.OBJECT.set({originY: 'bottom'})
				} else {
					this.CURRENT_CREATE.OBJECT.set({originY: 'top'})
				}
				canvasdocente.renderAll()
			}
		});

		this.objSocket.init(() => {
			this.objSocket.on('SESSION_CANVAS_SUCCESS', msg => {
				this.objSocket.on('CLOSE_ONLINE_AL', () => {
					window.location.reload()
				})
				console.log('SESSION_CANVAS_SUCCESS')
				this.objSocket.on('conexion_alumno', res => {
					//docente recive la conexión de un alumno y envia los datos del canvas
					console.log('alumno conectado')
					console.log(res)
					if (res.success)
						this.objSocket.emit('send_all_data_canvas', {json: canvasdocente.toJSON(), canvas: {width: this.CANVAS.width, height: this.CANVAS.height, pizarra_index: this.current_pizarra_index}})
				})
				this.objSocket.emit('CONFIRMACARGACANVAS','Iniciando desde docente')	
			})
			this.objSocket.emit('INIT_CANVAS','Iniciando desde docente')
		})

	}
})