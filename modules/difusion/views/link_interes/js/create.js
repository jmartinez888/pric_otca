-Vue.component('form-links', {
	template: '#form_links',
	data: function () {
		return {
			...data_vue,
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
    },
		findIdioma: function (idioma) {
			for(var x in this.idiomas){
				if (this.idiomas[x].id == idioma) {
					return this.idiomas[x];
					break;
				}
			}
		},
	  onSubmit_registrar: function () {
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
			loading.show()
			$.ajax({
	          url: this.edit ? _root_lang + 'difusion/link_interes/' + this.elemento_id + '/update/index' : _root_lang + 'difusion/link_interes/store', // point to server-side controller method
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
	              	loading.hide()
	              }
	          },
	          error: function (response) {
	              console.log(response)
	          }
	      });

	  }

	},
	created () {
	},
	mounted: function () {
		// this.editor = $('#contenido').ckeditor();
	}
})

new Vue({el: '#vue_container'})