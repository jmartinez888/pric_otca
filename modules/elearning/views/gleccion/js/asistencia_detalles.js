Vue.component('table-asistencia-detalles', {
	template: '#tpl-tbl-asistencia-detalles',
	props: ['leccion-asistencia', 'leccion-session'],
	created: function () {

	},
	mounted: function () {

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