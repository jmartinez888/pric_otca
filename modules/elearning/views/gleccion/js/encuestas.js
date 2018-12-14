new Vue({
	el: '#formulario_encuestas_vue',
	methods: {
		onClick_deleteEncuesta: function (encuesta_id) {
			console.log(event)
			axios.post(_root_ + 'elearning/').then(res => {

				 Mensaje('eliminado', function(){

        }, "",'exclamation-sign');
			})
		}
	}
})