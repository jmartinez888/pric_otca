Vue.component('form-banner', {
  template: '#form_banner',
  data: function () {
    return {
      ...data_vue,
      // estado: true,
      // image_banner: null,
      // nombre_difusion: '',

      cropper: null,
      cropper_opciones: {
        aspectRatio: 21/7.2
      },
      image_blob: null,
      difusiones: [],
      // difusion_id: 0,
      difusion_selected: null,
      image_change: false,
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
    image_banner: function (nv, ov) {
      console.log(nv)
      console.log(ov)
    }
  },
  methods: {
    resetBuscar: function () {
      this.difusion_id = 0
      this.nombre_difusion = ''
      this.descripcion_difusion = ''
      this.difusiones = []
      this.saved_difusion = false
    },
    onClick_saveDifusion: function () {
      this.saved_difusion = true
      $('#mod_difusion').modal('hide')
      this.difusiones = []
      this.nombre_difusion = this.difusion_selected.ODif_Titulo
      this.descripcion_difusion = this.difusion_selected.ODif_Descripcion
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
      // $('#mod_difusion').modal('show')
    },
    onClick_btnAccion: function (e) {

      switch (e.currentTarget.dataset.accion) {
        case 'ok':
          if (this.$refs.image.cropper != undefined) {
            this.cropper.getCroppedCanvas().toBlob((blob) => {
              this.image_blob = blob
              this.$refs.image.src = this.cropper.getCroppedCanvas().toDataURL('image/jpeg').toString();
              this.cropper.destroy();
            })
          }
          // this.cropper = new Cropper(this.$refs.image, this.cropper_opciones);
          break;
      }



    },
    resetForm: function () {
      for (var x in this.idiomas) {
        this.idiomas[x].titulo = ''
        this.idiomas[x].descripcion = ''
      }
      this.estado = true
      this.difusiones = []
      this.difusion_id = 0
      this.difusion_selected = null
      this.image_blob = null
      this.nombre_difusion = ''
      this.descripcion_difusion = ''
      this.$refs.imagen.value = null
      this.$refs.image.src = ''
      this.cropper = null
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
      loading.show()
      let form = new FormData();
      for(var i in this.idiomas) {
        for (var s in this.idiomas[i])
          form.append('idiomas['+i+']['+s+']', this.idiomas[i][s])
      }
      if (this.change_image)
        form.append('imagen', this.$refs.imagen.files[0])
      form.append('estado', this.estado ? 1 : 0)
      form.append('id', this.elemento_id)

      $.ajax({
            url: _root_lang + (this.edit ? 'difusion/indicadores/' + this.elemento_id + '/update/index' : 'difusion/indicadores/store'), // point to server-side controller method
            dataType: 'json', // what to expect back from the server
            cache: false,
            contentType: false,
            processData: false,
            data: form,
            type: 'post',
            success: (response) => {
              $('#cargando').hide();
                console.log(response)
                if (response.success) {
                  msg.success(response.msg)
                  if (!this.edit) {
                    this.resetForm()
                  }
                }
                else
                  msg.error(response.msg)
            },
            error: function (response) {
                loading.hide()
            }
      });



    },
    onChange_imagenBanner (e, i) {
      var files = this.$refs.imagen.files;
      var file;
      if (files && files.length) {
        file = files[0];
        if (/^image\/\w+/.test(file.type)) {

          let t = new Image();
          t.onload = () => {
            if ((t.width.toFixed(0) >= 32 && t.width.toFixed(0) <=64) && (t.height.toFixed(0) <= 64 && t.height.toFixed(0) >= 32)) {
              this.$refs.image.src  = URL.createObjectURL(file);
              this.change_image = true
            } else {
              $('#error_img').removeClass('hidden')
              setTimeout(() => {
                $('#error_img').addClass('hidden')
              }, 2000)
            }
          }
          t.src = URL.createObjectURL(file)


        }
      }
    }
  },
  created: function () {
    console.log(this)
  },
  mounted: function () {
    autosize(this.$refs.descripcion);
    $('.btn-acciones').on('click', this.onClick_btnAccion)
    this.$refs.imagen.onchange = this.onChange_imagenBanner
    autosize(document.getElementById('descripcion'))
  }
})

new Vue({el: '#banner_create'});