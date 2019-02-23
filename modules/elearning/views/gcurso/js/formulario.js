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
			console.log('remove');
			let data = new FormData();
			if (tipo == 'none' || tipo == 'col') {
				data.append('opcion_id', opcion_id)
				axios.post(_root_lang + 'elearning/formulario/delete_opcion/' + opcion_id, data).then(res => {
					if (res.data.success) {
						this.values.options.splice(i, 1);
						//this.$el.parentElement.remove()
					}
				})
			}
			if (tipo == 'fil') {
				data.append('pregunta_id', opcion_id)
				axios.post(_root_lang + 'elearning/formulario/delete_pregunta/' + opcion_id, data).then(res => {
					if (res.data.success) {
						this.values.preguntas.splice(i, 1);
						//
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
				case 'col':
					data.append('tipo_opc', opc)
					axios.post(_root_lang + 'elearning/formulario/store_opcion/' + this.element.id, data).then(res => {
						if (res.data.success)
							// this.values.preguntas.push(res.data.data)
							this.values.options.push(res.data.data)
					})
					break;
				case 'fil':
					data.append('pregunta_padre', this.element.id)
					axios.post(_root_lang + 'elearning/formulario/store_pregunta/' + this.element.formulario_id + (this.element.tipo == 'cuadricula' ? '/radio' : '/box'), data).then(res => {
						if (res.data.success) {
							// this.values.options.push(res.data.data)
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
Vue.component('input-tags-resume', {
	props: ['data-pregunta', 'data-resumen'],
	template: '#tag-resumen',
	data: function () {
		return {
			objPregunta: null,
		}
	},
	methods: {
		createSeries: function (chart, field, name, stacked) {
			var series = chart.series.push(new am4charts.ColumnSeries());
			series.dataFields.valueY = field;
			series.dataFields.categoryX = "pregunta";
			series.name = name;
			series.columns.template.tooltipText = "{name}: [bold]{valueY}[/]";
			// series.stacked = stacked;
			series.columns.template.width = am4core.percent(95);
		}
	},
	created: function () {
		this.objPregunta = JSON.parse(this.dataPregunta);
		console.log(this.objPregunta)
		console.log(this.dataResumen);
		// console.log(JSON.parse(this.dataResumen))
		// this.dataResumen = JSON.parse(this.dataResumen)
	},
	mounted: function () {
		if (this.objPregunta.tipo == 'select' || this.objPregunta.tipo == 'radio') {
			var chart = am4core.create(this.$refs.chartSelect, am4charts.PieChart);
			chart.logo.scale = 0;
			chart.tooltip.disabled = true
			chart.data = this.dataResumen;

			var series = chart.series.push(new am4charts.PieSeries());
			series.dataFields.value = "total_respuestas";
			series.dataFields.category = "opcion";
			series.labels.template.disabled = true;
			series.ticks.template.disabled = true;
			series.slices.template.tooltipText = "";

			// this creates initial animation
			// series.hiddenState.properties.opacity = 1;
			// series.hiddenState.properties.endAngle = -90;
			// series.hiddenState.properties.startAngle = -90;

			chart.legend = new am4charts.Legend();
			chart.legend.position = 'right'
		}

		if (this.objPregunta.tipo == 'box') {
			var chart = am4core.create(this.$refs.chartBox, am4charts.XYChart);
			chart.logo.scale = 0;
			
			chart.colors.saturation = 0.4;

			chart.data = this.dataResumen;


			var categoryAxis = chart.yAxes.push(new am4charts.CategoryAxis());
			categoryAxis.renderer.grid.template.location = 0;
			categoryAxis.dataFields.category = "opcion";
			categoryAxis.renderer.minGridDistance = 1;

			var valueAxis = chart.xAxes.push(new am4charts.ValueAxis());
			valueAxis.renderer.maxLabelPosition = 0.98;

			var series = chart.series.push(new am4charts.ColumnSeries());
			series.dataFields.categoryY = "opcion";
			series.dataFields.valueX = "total_respuestas";
			series.tooltipText = "{valueX.value}";
			series.sequencedInterpolation = true;
			series.defaultState.transitionDuration = 1000;
			series.sequencedInterpolationDelay = 100;
			series.columns.template.strokeOpacity = 0;

			chart.cursor = new am4charts.XYCursor();
			chart.cursor.behavior = "panY";


			// as by default columns of the same series are of the same color, we add adapter which takes colors from chart.colors color set
			series.columns.template.adapter.add("fill", function (fill, target) {
				return chart.colors.getIndex(target.dataItem.index);
			});
		}

		if (this.objPregunta.tipo == 'cuadricula' || this.objPregunta.tipo == 'casilla') {
			var chart = am4core.create(this.$refs.chartCuadrilla, am4charts.XYChart);
			chart.logo.scale = 0;
			console.log(chart)
			// Add data
			chart.data = this.dataResumen.data;

			// Create axes
			var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
			categoryAxis.dataFields.category = "pregunta";
			// categoryAxis.title.text = "Local country offices";
			categoryAxis.renderer.grid.template.location = 0;
			categoryAxis.renderer.minGridDistance = 20;
			categoryAxis.renderer.cellStartLocation = 0.1;
			categoryAxis.renderer.cellEndLocation = 0.9;

			var  valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
			valueAxis.min = 0;
			// valueAxis.title.text = "Expenditure (M)";
			this.dataResumen.opciones.forEach(v => {
				this.createSeries(chart, v.opcion_id, v.opcion, false);
			})
			// this.createSeries(chart, "namerica", "MEDIO", true);
			// this.createSeries(chart, "asia", "ALTO", false);
			// this.createSeries(chart, "lamerica", "Latin America", true);
			// this.createSeries(chart, "meast", "Middle East", true);
			// this.createSeries(chart, "africa", "Africa", true);

			// Add legend
			chart.legend = new am4charts.Legend();
		}
		
	}
})
new Vue({
	el: '#formulario_respuestas_vue',
	components: {
		'btn-acciones': {
			props: ['formularioRespuestaId'],
			template: '#tpl_btn_frm_encuestas'
		}
	},
	data: function () {
		return {
			...JSON.parse(getContentMeta('data-parse')),//leccion_id
			dt_tbl_respuestas: null,
			filter: {
				txt_query: ''
			}
		}
	},
	watch: {
		'filter.txt_query': function (nv) {
			if (nv.trim() == '')
				this.dt_tbl_respuestas.draw();
		}
	},
	methods: {
		onSubmit_filtrarRespuestas: function () {
			this.dt_tbl_respuestas.draw();
		},
		onClick_deleteRespuesta: function (e) {
			axios.post(_root_lang + 'elearning/formulario/delete_respuesta/' + e.currentTarget.dataset.id).then(res => {
				if (res.data.success) {
					this.dt_tbl_respuestas.draw(false);
				}
			})
		}
	},
	mounted: function () {
		
		this.dt_tbl_respuestas = $(this.$refs.tbl_frm_respuestas).DataTable({
			language: datatables_lenguaje,
			ajax: {
				url: base_url('elearning/gleccion/datatable_encuesta_respuestas/' + this.leccion_id),
				data: d => {
					d.filter = {
						query: this.filter.txt_query
					}
				}
			},
			dom: '<"table-responsive"t>p',
			pageLength: 10,
			serverSide: true,
			columns: [
				{data: 'usuario_id'},
				{data: 'usuario_nombre'},
				{data: 'usuario_cuenta'},
				{data: 'respuesta_fecha'},
				{data: 'formulario_respuesta_id', render: (d, t, r) => {
					// return d;
					return Mustache.render(document.getElementById('tpl_btn_frm_encuestas').innerHTML, {
						formulario_respuesta_id: d,
					})
				}}
			],
			columnDefs: [
				// {orderable: false,  targets: [3, 4]}
			]
		})
		.on('click', '.btn-eliminar', this.onClick_deleteRespuesta)
		.on('draw', (x, datatable) => {
			$('.btn-acciones[data-toggle="tooltip"]').tooltip();
		});
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

new Vue({
	el: '#formulario_reportes_vue',

})