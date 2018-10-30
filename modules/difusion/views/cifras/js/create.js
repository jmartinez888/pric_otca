Vue.component('form-contenido', {
	template: '#form_contenido',
	data: function () {
		return {
			...data_vue,
			// estado: true,
			// url: '',
			// difusion_id: 0,
			buscar: '',
			difusiones: [],
			difusion_selected: null,
			saved_difusion: false
		}
	},
	watch: {
		nombre_difusion: function (nv, ov) {
      if (nv.trim() == '') {
        this.difusion_selected = null
        difusion_id: 0
      }
    },
    difusion_id: function(nv, ov) {
      console.log(nv)
      this.difusion_selected = this.difusiones.find(v => {
        return v.ODif_IdDifusion == nv
      })
    },
	},
	methods: {
		resetBuscar: function () {
      this.difusion_id = 0
      this.nombre_difusion = ''
      this.descripcion_difusion = ''
      this.difusiones = [],
      this.saved_difusion = false
    },
		resetForm: function () {
      for (var x in this.idiomas) {
        // this.idiomas[x].titulo = ''
        this.idiomas[x].descripcion = ''
      }
      this.estado = true
      this.url = ''
      this.nombre_difusion = ''
      this.descripcion_difusion = ''
      this.difusion_id = 0
      this.difusiones = []
      this.latitude = 0
      this.longitude = 0
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
    onClick_saveDifusion: function () {
    	this.saved_difusion = true
      $('#mod_difusion').modal('hide')
      // this.nombre_difusion
      this.difusiones = []
      this.nombre_difusion = this.difusion_selected.ODif_Titulo
      this.descripcion_difusion = this.difusion_selected.ODif_Descripcion

      // this.$refs.filter_difusion_name.value = ''
      //ostrar en el menu principal
    },
    onSubmit_buscarDifusion: function () {
      loading.show();
      axios.get(_root_lang + 'difusion/contenido/buscar/' + this.nombre_difusion).then(res => {

        this.difusiones = res.data;
        if (res.data.length > 0) {
          $('#mod_difusion').modal('show')
          this.difusion_id = res.data[0].ODif_IdDifusion
        }
        loading.hide();
      })
    },
		onClick_openModDifusion: function (e) {
      $('#mod_difusion').modal('show')
    },
	  onSubmit_registrar: function () {
	  	let form = new FormData();
	  	if (this.difusion_id != 0 && this.indicador != 0) {
		    for(var i in this.idiomas) {
		    	for (var s in this.idiomas[i])
		    		form.append('idiomas['+i+']['+s+']', this.idiomas[i][s])
		    }

				form.append('estado', this.estado ? 1 : 0)
				form.append('url', this.url)
				form.append('difusion', this.difusion_id)
				form.append('indicador', this.indicador)
				form.append('latitude', this.latitude)
				form.append('longitude', this.longitude)
				if (this.edit) {

					form.append('id', this.elemento_id)
				}
				// form.append('linea_tematica', this.linea_tematica)
				// form.append('imagen', this.$refs.imagen.files[0])

				// form.append('datos', this.datos_interes)
				// form.append('evento', this.eventos_interes)
				loading.show()
				$.ajax({
		          url: this.edit ? _root_lang + 'difusion/cifras/' + this.elemento_id + '/update/index' : _root_lang + 'difusion/cifras/store', // point to server-side controller method
		          dataType: 'json', // what to expect back from the server
		          cache: false,
		          contentType: false,
		          processData: false,
		          data: form,
		          type: 'post',
		          success: (response) => {
		              if (response.success) {
		              	msg.success(response.msg)
		              	if (!this.edit)
		              		this.resetForm()
		              }
		              loading.hide()
		          },
		          error: function (response) {
		              console.log(response)
		              msg.error(response.msg)
		              loading.hide()
		          }
		    });
	  	}

	  }

	},
	created () {
	},
	mounted: function () {
		// this.editor = $('#contenido').ckeditor();
		autosize(document.getElementById('descripcion'))
		$('#mod_difusion').on('hidden.bs.modal',  (e) => {
			if (!this.saved_difusion)
		  	this.resetBuscar()
		})
	}
})

new Vue({el: '#vue_container'})