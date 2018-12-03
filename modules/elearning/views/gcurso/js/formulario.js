Vue.component('input-tags', {
	props: ['element'],
	template: '#inputs',
	data: function () {
		return {
			edit: false,
			tipo: 'texto',
			setTime: null,
			values: {
				tipo: 'texto',
				pregunta: '',
				descripcion: '',
				options: [],
				preguntas: []

			}
		}
	},
	watch: {
		tipo : function (nv) {

		},
		'element.edit': function (nv, ov) {
			this.setStyle(nv)
		}
	},
	updated: function (e) {
		if (this.element.edit) {

			clearTimeout(this.setTime)
			this.setTime = setTimeout(()=> {
				var frm = new FormData();
				frm.append('tipo', this.tipo)
				frm.append('formulario_id', this.element.formulario_id)
				if (this.tipo != 'titulo') {
					frm.append('pregunta_id', this.element.id)
				}
				frm.append('values[tipo]', this.values.tipo)
				// frm.append('values[obligatorio]', 1)
				frm.append('values[pregunta]', this.values.pregunta)
				frm.append('values[descripcion]', this.values.descripcion)
				let i = 0
				for (var o of this.values.options) {
					frm.append('values[options][' + i + '][id]', o.id)
					frm.append('values[options][' + i + '][opcion]', o.opcion)
					frm.append('values[options][' + i + '][orden]', o.orden)
					i++
				}
				i = 0
				for (var o of this.values.preguntas) {
					frm.append('values[preguntas][' + i + '][id]', o.id)
					frm.append('values[preguntas][' + i + '][pregunta]', o.pregunta)
					frm.append('values[preguntas][' + i + '][orden]', o.orden)
					i++
				}
				if (this.tipo == 'titulo') {
					axios.post(_root_lang + 'elearning/formulario/update/' + this.element.formulario_id, frm).then(res => {
						console.log(res)
					}).catch(err => {
						console.log(err)
					})
				} else {
					//send to titulo
					axios.post(_root_lang + 'elearning/formulario/update_pregunta/' + this.element.id, frm).then(res => {
						console.log(res)
					}).catch(err => {
						console.log(err)
					})
				}
			}, 500)


		}

	},
	methods: {
		onClick_removeOption(i, opcion_id, tipo = 'none') {
			let data = new FormData();
			if (tipo == 'none' || tipo == 'fil') {
				data.append('opcion_id', opcion_id)
				axios.post(_root_lang + 'elearning/formulario/delete_opcion/' + opcion_id, data).then(res => {
					if (res.data.success) {
						this.values.options.splice(i, 1);
					}
				})
			}
			if (tipo == 'col') {
				data.append('pregunta_id', opcion_id)
				axios.post(_root_lang + 'elearning/formulario/delete_pregunta/' + opcion_id, data).then(res => {
					if (res.data.success) {
						// this.values.options.splice(i, 1);
						this.$el.parentElement.remove()
					}
				})
			}

		},
		setStyle: function (value) {
			let target = this.$el.parentElement
			if (value)
				target.classList.add('tag_input_edit_select')
			else
				target.classList.remove('tag_input_edit_select')
		},
		onClick_Obligatorio: function () {
			let frm = new FormData();
			let obl = this.element.obligatorio == 1 ? 0 : 1
			frm.append('obligatorio', obl);
			frm.append('pregunta_id', this.element.id);
			frm.append('tipo', '');
			frm.append('formulario_id', '');
			axios.post(_root_lang + 'elearning/formulario/update_pregunta/' + this.element.id + '/obligatorio', frm).then(res => {
				if (res.data.success)
					this.element.obligatorio = obl
			});
		},
		onClick_delete: function () {
			console.log(this.element)
			let data = new FormData();
			data.append('pregunta_id', this.element.id)
			axios.post(_root_lang + 'elearning/formulario/delete_pregunta/' + this.element.id, data).then(res => {
				if (res.data.success) {
					// this.values.options.splice(i, 1);
					this.$el.parentElement.remove()
				}
			})

			// this.$emit('delete_tag', this.element.id);

		},
		show_me () {
			console.log(this)
		},
		onClick_agregarOptionSelect: function () {
			let data = new FormData();
			data.append('pregunta_id', this.element.id)
			axios.post(_root_lang + 'elearning/formulario/store_opcion/' + this.element.id, data).then(res => {
				if (res.data.success)
					this.values.options.push(res.data.data)
			})
		},
		onClick_agregarOptionColFil: function (opc = 'none') {
			let data = new FormData();
			data.append('pregunta_id', this.element.id)

			switch (opc) {
				case 'fil':
					data.append('tipo_opc', opc)
					axios.post(_root_lang + 'elearning/formulario/store_opcion/' + this.element.id, data).then(res => {
						if (res.data.success)
							this.values.options.push(res.data.data)
					})
					break;
				case 'col':
					data.append('pregunta_padre', this.element.id)
					axios.post(_root_lang + 'elearning/formulario/store_pregunta/' + this.element.formulario_id + (this.element.tipo == 'cuadricula' ? '/radio' : '/box'), data).then(res => {
						if (res.data.success) {
							this.values.preguntas.push(res.data.data)
							// this.tags.push({name: 'b', id: res.data.data.id, edit: false, tag_name: 'texto', })
						}
					})
					break;
			}
		}
	},
	mounted: function () {
		// this.element.edit = true
		this.setStyle(this.element.edit)
	},
	created: function () {
		if (this.element.id == 'titulo_frm') {
			this.tipo = 'titulo'
			this.values.tipo = 'titulo'
			this.values.pregunta = this.element.pregunta
			this.values.descripcion = this.element.descripcion
		} else {
			this.tipo = this.element.tipo
			this.values.tipo = this.element.tipo
			this.values.pregunta = this.element.pregunta
			this.values.descripcion = this.element.descripcion
			this.values.options = this.element.opciones
			if (this.element.tipo == 'cuadricula' || this.element.tipo == 'casilla') {
				this.values.preguntas = this.element.hijos
			}
		}


	}
})
new Vue({
	el: '#formulario_respuestas_vue',
	data: function () {
		return {

		}
	},
	methods: {
		onClick_deleteRespuesta: function (respuesta_id) {
			console.log(event)
			let target = event.target.parent.parent
			axios.post(_root_lang + 'elearning/formulario/delete_respuesta/' + respuesta_id).then(res => {
				if (res.data.success) {
					target.remove()
				}
			})
		}
	}
})

new Vue({
	el: '#formulario_editar_vue',
	data: function () {
		return {
			data: data_frm,
			escribe: 'asd',
			tags: [],
			count_tags: 0,
			current_edit: 0,
			element_titulo: {
				name: 'titulo',
				id: 'titulo_frm',
				edit: false,
				tag_name: 'titulo',
				formulario_id: data_frm.id,
				pregunta: data_frm.titulo,
				descripcion: data_frm.descripcion,
			}
		}
	},
	methods: {
		onClick_editar: function (e, id) {

			if (id == 'titulo_frm') {
				this.element_titulo.edit = true
				this.tags.forEach(v => {
					v.edit = false
				})
			} else {

				this.tags.forEach(v => {
					if (v.id != id) {
						v.edit = false
					} else {
						v.edit = true
					}
				})
				this.element_titulo.edit = false
			}

		},
		onDelete_tag: function (e) {
			console.log(this)
			console.log(e)
			console.log('delete tag')

			this.tags.forEach((v, i) => {
				if (v.id == e){
					console.log(v.id)
					console.log(e)
					this.tags.splice(i, 1)
				}

			})

		},
		onClick_agregarTitulo: function () {
			this.tags.forEach(v => {
				// if (v.id != id)
					v.edit = false

			})
			this.element_titulo.edit = false
			axios.post(_root_lang + 'elearning/formulario/store_pregunta/' + this.data.id + '/titulo_a').then(res => {
				if (res.data.success) {
					res.data.data.edit = true
					this.tags.push(res.data.data)
					// this.tags.push({name: 'b', id: res.data.data.id, edit: false, tag_name: 'texto', })
				}
			})

		},
		onClick_agregarTag: function () {
			this.tags.forEach(v => {
				// if (v.id != id)
					v.edit = false

			})
			this.element_titulo.edit = false
			axios.post(_root_lang + 'elearning/formulario/store_pregunta/' + this.data.id).then(res => {
				if (res.data.success) {
					res.data.data.edit = true
					this.tags.push(res.data.data)
					// this.tags.push({name: 'b', id: res.data.data.id, edit: false, tag_name: 'texto', })
				}
			})

		}
	},
	created: function () {

	},
	mounted: function () {
		axios.get(_root_lang + 'elearning/formulario/preguntas/' + this.data.id).then(res => {

			this.tags = res.data.map((v) => {
				v.edit = false
				return v
			});
		}).catch( err => {

		})
		console.log(this)
		// this.tags.push({name: 'x', id: this.count_tags++, edit: false})
	}
})