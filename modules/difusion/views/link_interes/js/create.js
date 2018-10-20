Vue.component('form-links', {
	template: '#form_links',
	data: function () {
		return {
			...data_vue,
			// estado: true,
			// url: '',
			// difusion_id: 0,
			buscar: ''
		}
	},
	methods: {
		resetForm: function () {
      for (var x in this.idiomas) {
        this.idiomas[x].titulo = ''
        this.idiomas[x].descripcion = ''
      }
      this.estado = true
      this.url = ''
      // this.nombre = ''
      // this.editor.val('')
    },
		// loadContenidoByIdioma: function (idioma) {
		// 	this.editor.val(this.findIdioma(idioma).contenido)
		// },
		findIdioma: function (idioma) {
			for(var x in this.idiomas){
				if (this.idiomas[x].id == idioma) {
					return this.idiomas[x];
					break;
				}
			}
		},
		// saveContenidoByIdioma: function (idioma) {
		// 	this.findIdioma(idioma).contenido = this.editor.val();
		// },
	  onSubmit_registrar: function () {
	  	// this.saveContenidoByIdioma(this.idioma_actual)
	  	// console.log(this.$refs.imagen.files[0])

	  	let form = new FormData();

	    for(var i in this.idiomas) {
	    	for (var s in this.idiomas[i])
	    		form.append('idiomas['+i+']['+s+']', this.idiomas[i][s])
	    }

			form.append('estado', this.estado ? 1 : 0)
			form.append('url', this.url)
			if (this.edit) {

				form.append('id', this.elemento_id)
			}
			// form.append('linea_tematica', this.linea_tematica)
			// form.append('imagen', this.$refs.imagen.files[0])

			// form.append('datos', this.datos_interes)
			// form.append('evento', this.eventos_interes)

			$.ajax({
	          url: this.edit ? _root_lang + 'difusion/link_interes/' + this.elemento_id + '/update/index' : _root_lang + 'difusion/link_interes/store', // point to server-side controller method
	          dataType: 'json', // what to expect back from the server
	          cache: false,
	          contentType: false,
	          processData: false,
	          data: form,
	          type: 'post',
	          success: (response) => {
	              console.log(response)
	              if (response.success) {
	              	msg.success(response.msg)
	              	if (!this.edit)
	              		this.resetForm()
	              }
	          },
	          error: function (response) {
	              console.log(response)
	          }
	      });

	  }

	},
	created () {
		console.log(this)
		// axios.get(_root_lang + 'difusion/link_interes/' + )
	},
	mounted: function () {
		// this.editor = $('#contenido').ckeditor();
	}
})

new Vue({el: '#vue_container'})