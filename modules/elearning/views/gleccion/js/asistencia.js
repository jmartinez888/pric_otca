new Vue({
	el: '#asistencia_leccion_vue',
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
	}
})