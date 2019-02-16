
new Vue({
	el: '#formulario_pizarras_vue',
	data: function () {
		return {
			...JSON.parse(getContentMeta('data-parse')),
			dt_tbl_pizarras: null,
			filter: {
				txt_query: '',
				sel_modulo: -1
			}
		}
	},
	watch: {
		'filter.txt_query': function (nv, ov) {
			if (nv.trim() == '')
				this.dt_tbl_pizarras.draw();
		}
	},
	methods: {
		onSubmit_filtrarEncuestas: function () {
			this.dt_tbl_pizarras.draw();
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
		this.dt_tbl_pizarras = $(this.$refs.tbl_pizarras).DataTable({
			language: datatables_lenguaje,
			ajax: {
				url: base_url('elearning/gleccion/datatable_lecciones/' + this.curso_id + '/' + this.leccion_mode),
				data: d => {
					d.filter = {
						query: this.filter.txt_query,
						modulo_id: this.filter.sel_modulo
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
					return Mustache.render(document.getElementById('tpl_btn_pizarras').innerHTML, {
						leccion_id: d,
						modulo_id: r.modulo_id
					})
				}}
			],
			columnDefs: [
				// {orderable: false,  targets: [3, 4]}
			]
		})
		// .on('click', '.btn-marcar-asistencia', this.onClick_marcarAsistencia)
		.on('draw', () => {
			$('.btn-acciones[data-toggle="tooltip"]').tooltip();
		});
	}

})