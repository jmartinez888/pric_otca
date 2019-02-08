new Vue({
	el: '#formulario_encuestas_vue',
	data: function () {
		return {
			dt_tbl_encuestas: null,
			filter: {
				txt_encuesta: '',
				sel_modulo: -1
			}
		}
	},
	methods: {
		onSubmit_filtrarEncuestas: function () {
			this.dt_tbl_encuestas.draw();
		},
		onClick_deleteEncuesta: function (encuesta_id) {
			console.log(event)
			let target = event.target
			$.fn.Mensaje({
		    mensaje: "¿Esta seguro de eliminar esta lección?",
		    tipo: "SiNo",
		    funcionSi: () => {
		    	axios.post(_root_ + 'elearning/gleccion/eliminar_encuesta/' + encuesta_id).then(res => {
						 $.fn.Mensaje({
						 	mensaje: res.data.msg,
						 	tipo: 'Aceptar',
						 	funcionAceptar: () => {
						 		$(target).parents('tr').remove()
						 	}
						 });
					})
		    }
		  });

		}
	},
	mounted: function () {
		this.dt_tbl_encuestas = $(this.$refs.tbl_encuestas).DataTable({
			language: datatables_lenguaje,
			ajax: {
				url: base_url('elearning/gleccion/datatable_lecciones/' + CURSO_ID + '/' + MODO_LECCION),
				data: d => {
					d.filter = {
						query: this.filter.txt_encuesta
					}
					
				}
			},
			dom: '<"table-responsive"t>p',
			pageLength: 10,
			serverSide: true,
			columns: [
				{data: 'leccion_titulo'},
				{data: 'leccion_descripcion'},
				{data: 'modulo_titulo'},
				{data: 'leccion_id', render: (d, t, r) => {
					return Mustache.render(document.getElementById('tpl_btn_encuestas').innerHTML, {
						leccion_id: d,
					})
				}}
			],
			columnDefs: [
				// {orderable: false,  targets: [3, 4]}
			]
		})
		// .on('click', '.btn-marcar-asistencia', this.onClick_marcarAsistencia)
		.on('draw', (x, datatable) => {
			$('.btn-acciones[data-toggle="tooltip"]').tooltip();
		});
	}

})