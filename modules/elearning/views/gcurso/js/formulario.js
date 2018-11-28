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
				options: []

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
				frm.append('values[obligatorio]', 1)
				frm.append('values[pregunta]', this.values.pregunta)
				frm.append('values[descripcion]', this.values.descripcion)
				let i = 0
				for (var o of this.values.options) {
					frm.append('values[options][' + i + '][id]', o.id)
					frm.append('values[options][' + i + '][opcion]', o.opcion)
					frm.append('values[options][' + i + '][orden]', o.orden)
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
		onClick_removeOption(i, opcion_id) {
			let data = new FormData();
			data.append('opcion_id', opcion_id)
			axios.post(_root_lang + 'elearning/formulario/delete_opcion/' + opcion_id, data).then(res => {
				if (res.data.success) {
					this.values.options.splice(i, 1);
				}
			})

		},
		setStyle: function (value) {
			let target = this.$el.parentElement
			if (value)
				target.classList.add('tag_input_edit_select')
			else
				target.classList.remove('tag_input_edit_select')
		},
		onClick_delete: function () {
			this.$el.parentElement.remove()
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