new Vue({
	el: '#formulario_encuestas_vue',
	methods: {
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
	}
})