Vue.component('form-contenido', {
	template: '#form_contenido',
	data: function () {
		return {
			...data_vue,
			estado: true,
			// tipo: 0,
			// linea_tematica: 0,
			tbl_difusion: null,
			dt_tbl_difusion: null,
			editor: null,
			nombre: '',
			difusion_id: 0,
			buscar: '',
			editar_attr: {
				estado: false,
				datos: false,
				banner: false,
				evento: false,
				id: 0
			}
		}
	},
	methods: {
		resetForm: function () {
      for (var x in this.idiomas) {
        this.idiomas[x].titulo = ''
        this.idiomas[x].descripcion = ''
        this.idiomas[x].contenido = ''
        this.idiomas[x].palabras_clave = ''
        this.idiomas[x].contenido = ''
      }
      this.estado = true
      this.nombre = ''
      this.editor.val('')
    },
		loadContenidoByIdioma: function (idioma) {
			this.editor.val(this.findIdioma(idioma).contenido)
		},
		findIdioma: function (idioma) {
			for(var x in this.idiomas){
				if (this.idiomas[x].id == idioma) {
					return this.idiomas[x];
					break;
				}
			}
		},
		saveContenidoByIdioma: function (idioma) {
			this.findIdioma(idioma).contenido = this.editor.val();
		},
	  onSubmit_registrar: function () {
	  	this.saveContenidoByIdioma(this.idioma_actual)
	  	console.log(this.$refs.imagen.files[0])

	  	let form = new FormData();

	    for(var i in this.idiomas) {
	    	for (var s in this.idiomas[i])
	    		form.append('idiomas['+i+']['+s+']', this.idiomas[i][s])
	    }

			form.append('estado', this.estado ? 1 : 0)
			form.append('tipo', this.tipo)
			form.append('linea_tematica', this.linea_tematica)
			form.append('imagen', this.$refs.imagen.files[0])

			form.append('datos', this.datos_interes)
			form.append('evento', this.eventos_interes)

			$.ajax({
	          url: _root_lang + 'difusion/contenido/store', // point to server-side controller method
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
	},
	mounted: function () {
		this.editor = $('#contenido').ckeditor();
	}
})

new Vue({el: '#difusion_gestion'})