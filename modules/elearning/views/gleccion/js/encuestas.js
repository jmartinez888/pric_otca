new Vue({
	el: '#formulario_encuestas_vue',
	data: function () {
		return {
			...JSON.parse(getContentMeta('data-parse')),
			dt_tbl_encuestas: null,
			filter: {
				txt_encuesta: '',
				sel_modulo: -1
			}
		}
	},
	watch: {
		'filter.txt_encuesta': function (nv, ov) {
			if (nv.trim() == '')
				this.dt_tbl_encuestas.draw();
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
				url: base_url('elearning/gleccion/datatable_lecciones/' + this.curso_id + '/' + this.leccion_mode),
				data: d => {
					d.filter = {
						query: this.filter.txt_encuesta,
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
					return Mustache.render(document.getElementById('tpl_btn_encuestas').innerHTML, {
						leccion_id: d,
						is_libre: r.modulo_id == null,
						hash_encuesta: r.hash_encuesta
					})
				}}
			],
			columnDefs: [
				{orderable: false, className: 'text-right', targets: [3]},
			]
		})
		.on('click', '.btn_eliminar', this.onClick_deleteEncuesta)
		.on('draw', (x, datatable) => {
			$('.btn-acciones[data-toggle="tooltip"]').tooltip();
			new ClipboardJS('.btn_copiar');
		});
	}

})