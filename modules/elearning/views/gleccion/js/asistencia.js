new Vue({
	el: '#asistencia_leccion_vue',
	data: function () {
		return {
			td_tbl_asistencia: null
		}
	},
	methods: {
		onClick_marcarAsistencia: function (e) {
			console.log(e)
			let target = event.target
			$.fn.Mensaje({
		    mensaje: "¿Marcar asistencia de este alumno?",
		    tipo: "SiNo",
		    funcionSi: () => {
		    	axios.post(base_url('elearning/gleccion/registrar_asistencia'), parseData({
						leccion_asistencia_id: target.dataset.id
					})).then(res => {
						console.log(res.data)
						if (res.data.success) {
							 $.fn.Mensaje({
							 	mensaje: res.data.msg,
							 	tipo: 'Aceptar',
							 	funcionAceptar: () => {
									window.location.reload();
							 	}
							 });
						}
					})
		    }
		  });

		}
	},
	mounted: function () {
		this.td_tbl_asistencia = $(this.$refs.tbl_asistencia).DataTable({
			language: datatables_lenguaje,
			ajax: {
				url: base_url('elearning/gleccion/datatable_asistencia/' + LECCION_ID),
				data: d => {

				}
			},
			dom: '<"table-responsive"t>p',
			pageLength: 10,
			serverSide: true,
			columns: [
				{data: 'nombre_completo'},
				{data: 'inicio'},
				{data: 'fin'},
				{data: 'sessiones_format', render: (d, t, r) => {
					let h = '';
					d.forEach(v => {
						h += `<span class="label label-primary">${v.tipo == LECCION_ONLINE ? 'S.O' : 'S.E'}:${v.format_id}</span>`
					})
					return h;
				}},
				{data: 'id', render: (d, t, r) => {
				
					return Mustache.render(document.getElementById('btn_opciones_asistencia').innerHTML, {
						id: d,
						asistencia: r.asistencia == 1 ? 'check-circle' : 'circle'
					}) + Mustache.render(document.getElementById('btn_opciones_ir').innerHTML, {
						id: d,
						usuario: r.usuario_id,
						leccion: r.leccion_id,
					}) 
				}}

			]		}).on('click', '.btn-marcar-asistencia', this.onClick_marcarAsistencia);
	}
})