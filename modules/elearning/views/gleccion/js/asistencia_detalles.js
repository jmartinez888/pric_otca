Vue.component('table-asistencia-detalles', {
	template: '#tpl-tbl-asistencia-detalles',
	props: ['leccion-asistencia', 'leccion-session', 'leccion-session-format'],
	data: function () {
		return {
			dt_tbl_detalles_horas: null
		}
	},
	created: function () {

	},
	mounted: function () {
		this.dt_tbl_detalles_horas = $(this.$refs.tbl_detalles_horas).DataTable({
			language: datatables_lenguaje,
			ajax: {
				url: base_url('elearning/gleccion/datatable_asistencia_detalles/' + this.leccionAsistencia),
				data: d => {

				}
			},
			dom: '<"table-responsive"t>p',
			pageLength: 10,
			serverSide: true,
			columns: [
				{data: 'ingreso'},
				{data: 'salida'}
			]
		})
	}
})

new Vue({
	el: '#asistencia_leccion_vue',
	data: function () {
		return {
			refids: [],
		}
	},
	methods: {
		onClick_marcarAsistencia: function (e) {}
	},
	created: function () {
		
	},
	mounted: function () {
		this.refids = ASISTENCIAS_REF;
	}
})