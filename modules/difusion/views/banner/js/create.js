Vue.component('form-banner', {
  template: '#form_banner',
  data: function () {
    return {
      ...data_vue,
      estado: true,
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
      image_change: false
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
    onClick_saveDifusion: function () {
      $('#mod_difusion').modal('hide')
      // this.nombre_difusion
      this.difusiones = []
      this.nombre_difusion = this.difusion_selected.ODif_Titulo
      this.$refs.filter_difusion_name.value = ''
      //ostrar en el menu principal
    },
    onSubmit_buscarDifusion: function () {
      axios.get(_root_lang + 'difusion/contenido/buscar/' + this.$refs.filter_difusion_name.value).then(res => {
        console.log(res.data)
        this.difusiones = res.data;
        if (res.data.length > 0)
          this.difusion_id = res.data[0].ODif_IdDifusion
      }).catch(err => {
        console.log(err.response)
      })
    },
    onClick_openModDifusion: function (e) {
      $('#mod_difusion').modal('show')
    },
    onClick_btnAccion: function (e) {
      console.log(e.currentTarget.dataset.accion)

      switch (e.currentTarget.dataset.accion) {
        case 'ok':
          if (this.$refs.image.cropper != undefined) {
            this.cropper.getCroppedCanvas().toBlob((blob) => {
              console.log(blob)
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
      if (this.difusion_id != 0) {
        let form = new FormData();

        for(var i in this.idiomas) {
          for (var s in this.idiomas[i])
            form.append('idiomas['+i+']['+s+']', this.idiomas[i][s])
        }
        form.append('estado', this.estado ? 1 : 0)
        form.append('difusion', this.difusion_id)
        form.append('id', this.elemento_id)
        if (this.image_change)
          form.append('imagen', this.image_blob)

        $.ajax({
              url: _root_lang + (this.edit ? 'difusion/banner/' + this.elemento_id + '/update/index' : 'difusion/banner/store'), // point to server-side controller method
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
                    if (!this.edit) {
                      this.resetForm()
                      this.nombre_difusion = ''
                    }
                  }
                  else
                    msg.error(response.msg)
              },
              error: function (response) {
                  console.log(response)
              }
          });
      } else {
        console.log('no se pue')
      }

    },
    onChange_imagenBanner (e, i) {
      var files = this.$refs.input_banner.files;
      var file;
      if (files && files.length) {
        file = files[0];
        if (/^image\/\w+/.test(file.type)) {
          this.$refs.image.src = uploadedImageURL = URL.createObjectURL(file);
          if (this.cropper != null) {
            console.log('destroy')
            this.cropper.destroy();
          }
          this.cropper = new Cropper(this.$refs.image, this.cropper_opciones);
          this.$refs.input_banner.value = null
          this.image_change = true
        } else {
          window.alert('Please choose an image file.');
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
    // this.image_banner = this.$refs.image;
    this.$refs.input_banner.onchange = this.onChange_imagenBanner
    // new Cropper(this.$refs.image, {
    //   aspectRatio: 16/9,
    //   crop: function (event) {
    //     console.log(event.detail.x);
    //     console.log(event.detail.y);
    //     console.log(event.detail.width);
    //     console.log(event.detail.height);
    //     console.log(event.detail.rotate);
    //     console.log(event.detail.scaleX);
    //     console.log(event.detail.scaleY);
    //   },
    // })


  }
})

new Vue({el: '#banner_create'});