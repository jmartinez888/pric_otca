var canvasdocente = null
new Vue({
	el: '#modulo-contenedor',
	data: function () {
		return {
			canvas_leccion: [],
			show_tools: false,
			obj_canvas: null,
			current_element: 'none',
			current_type: 'none',
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
				text: 'Ingresar texto',
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
	methods: {
		onClick_seleccionPizarra: function (leccion_id) {
			console.log(leccion_id)
			// console.log(this.$refs['pizarrabg_' + leccion_id])
			// canvasdocente.setBackgroundImage(this.$refs['pizarrabg_' + leccion_id], x => {
			// 	console.log(x)
			// })
			canvasdocente.setBackgroundImage(this.$refs['pizarrabg_' + leccion_id].src, canvasdocente.renderAll.bind(canvasdocente), {
			    // Optionally add an opacity lvl to the image
			    // backgroundImageOpacity: 0.5,
			    // should the image be resized to fit the container?
			    // backgroundImageStretch: false
			});
		  // fabric.Image.fromElement(this.$refs['pizarrabg_' + leccion_id], function(img) {
    //    // add background image
    //    	canvasdocente.setBackgroundImage(img, canvasdocente.renderAll.bind(canvasdocente), {
    //       scaleX: canvasdocente.width / img.width,
    //       scaleY: canvasdocente.height / img.height
    //    });
    //   });
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
			return opciones.find(v => v == this.current_type) == undefined ? false : true
		},
		onClick_eliminarLimpiar: function () {
			canvasdocente.clear()
			this.objSocket.emit('limpiar_canvas')
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
		addObjectCanvas: function (obj, emitData = true, addCanvas = true, dataUrl = false) {
			obj.on('selected', (e) => {
				console.log('selected')
				console.log(e)
				console.log(obj)
				this.current_element = obj.objeto_id
				this.current_type = obj.type

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
			if (emitData) {
				this.objSocket.emit('create_object', {
					data: obj.toObject(),
					dataUrl: dataUrl ? obj.toDataURL('png') : '',
					id: obj.objeto_id,
					event: 'create'
				})

			}
			if (addCanvas)
				canvasdocente.add(obj)
		},
		onClick_createObject: function (opc) {

			console.log('create ' + opc)
			switch (opc) {
				case 'lapiz':
					if (canvasdocente.isDrawingMode) {
						canvasdocente.isDrawingMode = this.lapizOn = false
						this.current_type = 'none'
					} else {
						canvasdocente.isDrawingMode = this.lapizOn = true
						this.opcelements.fill = canvasdocente.freeDrawingBrush.color
						this.opcelements.strokeWidth = canvasdocente.freeDrawingBrush.width
						this.current_type = 'lapiz'
					}



					break;
				case 'rect':
					this.addObjectCanvas(new fabric.Rect({
						fill: 'transparent',
						backgroundColor: 'transparent',
						width: 200,
						height: 100,
						stroke: 'black',
						objeto_id: this.count_id++
					}))
					break;
				case 'circulo':
					this.addObjectCanvas(new fabric.Circle({
						fill: 'transparent',
						backgroundColor: 'transparent',
						stroke: 2,
						radius: 50,
						objeto_id: this.count_id++
					}))
					break;
				case 'texto':
					this.addObjectCanvas(new fabric.Text(this.opcelements.text, {
						objeto_id: this.count_id++
					}))
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
		console.log('creta!')
		this.objSocket = new AppSocket({ query: "id=" + USUARIO.id + "&curso=" + USUARIO.curso + "&tipo=2&leccion=" + LMS_LECCION + "&docente=" + USUARIO.docente})

		//se coencto un alumno?



	},
	mounted: function () {
		this.$refs.opciones_canvas.classList.remove('hidden')
		this.$refs.panel_pizarra_final.classList.remove('hidden')

		canvasdocente = new fabric.Canvas('micanvas', {
			backgroundColor: 'white'
		})
		canvasdocente.on('mouse:down', function(options) {
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
		  this.objSocket.emit('pos_cursor', e.pointer)
		});

		this.objSocket.init(() => {

			this.objSocket.on('conexion_alumno', res => {
				console.log('alumno conectado')
				console.log(res)
				if (res.success)
					this.objSocket.emit('send_all_data_canvas', canvasdocente.toJSON())
			})
		})

	}
})