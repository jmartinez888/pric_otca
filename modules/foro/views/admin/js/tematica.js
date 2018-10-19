$('#collapse3').collapse()
var app = new Vue({
  el: '#tematica_vue',
  data() {
    return {
      ...data_vue,
      tematica_id: 0,
      tematica_nombre: '',
      // nombre_en: '',
      // nombre_pt: '',
      // nombre_es: '',
      // idioma_actual: 'es',
      estado: true,
      tbl_tematica: null,
      dt_tbl_tematica: null,
      buscar_tematica: ''
    }
  },
  methods: {
    resetForm () {
      for (var x in this.idiomas) {
        this.idiomas[x].tematica = ''
        this.idiomas[x].descripcion = ''
      }
      // this.idiomas.forEach(v => {
      //   v.tematica = ''
      //   v.descripcion = ''
      // })
      this.estado = true
      this.nombre = ''
    },
    onClick_btnAccion (e) {
      let data = e.currentTarget.dataset
      console.log(data)
      switch (data.accion) {
        case 'estado':
          let estado = 0
          if (+data.estado == 0)
            estado = 1
          var formData = new FormData();
          formData.append('id', data.id);
          formData.append('estado', estado);
          formData.append('accion', 'estado');

          axios.post(_root_lang + '/foro/admin/tematica/' + data.id + '/update', formData).then(res => {
            console.log(res)
            if (res.data.success) {
              msg.success(res.data.msg)
              this.dt_tbl_tematica.draw(false)
            } else {
              msg.success(res.data.msg)
            }
          })
          break;
        case 'eliminar':
          this.tematica_id = data.id
          this.tematica_nombre = data.nombre
          $('#mod_eliminar_tematica').modal('show')

          break;
      }
    },
    onSubmit_exportTematica (e) {
      // console.log(e)
      // switch (e) {
      //   case ''
      // }
      window.location.href = _root_lang + 'foro/admin/tematica/datatable?' + $.param(this.dt_tbl_tematica.ajax.params())  + '&export=' + e


      // let p = this.dt_tbl_tematica.ajax.params()
      // p.export = e
      // axios({
      //   url: _root_lang + '/foro/admin/tematica/datatable',
      //   method: 'GET',
      //   params: p,
      //   responseType: 'blob', // important
      // }).then((response) => {
      //   const url = window.URL.createObjectURL(new Blob([response.data]));
      //   const link = document.createElement('a');
      //   link.href = url;
      //   link.setAttribute('download', 'file.pdf');
      //   // document.body.appendChild(link);
      //   link.click();
      // });
    },
    onSubmit_filtrarTematica () {
      this.dt_tbl_tematica.draw()
    },
    onSubmit_eliminarTematica () {
      let formData = new FormData();
      formData.append('id', this.tematica_id);
      axios.post(_root_lang + '/foro/admin/tematica/' + this.tematica_id + '/delete', formData).then(res => {
        console.log(res.data)
        if (res.data.success) {
          this.dt_tbl_tematica.draw(false)
          msg.success(res.data.msg)
          $('#mod_eliminar_tematica').modal('hide')
        }
      })
    },
    anyFill () {
      for(var x in this.idiomas){
        if (this.idiomas[x].tematica.trim()) return true
      }
      return false
    },
  	onSubmit_registrarTematica () {
  		if (this.anyFill()) {
        var formData = {
          nombre: this.nombre,
          estado: this.estado ? 1 : 0,
          idiomas: this.idiomas
        }
	  			axios({
	  				method: 'post',
	  				headers: {
	  					'X-Requested-With': 'XMLHttpRequest'},
  					url: _root_lang + 'foro/admin/tematica/store',
  					// responseType: 'json',
  					data: formData
  				}).then(res => {
						console.log(res.data)
            if (res.data.success) {
              msg.success(res.data.msg)
              this.resetForm()
            } else {
              msg.error(res.data.msg)
            }
					}).catch(err => {
            console.log(err)
						console.log(err.response)
            msg.error(err.response.data, true)
					})
  		}
  	}
  },
  created () {
    console.log(this)
  },
  mounted () {
    // axios.get(_root_lang + '/foro/admin/tematica/datatable').then(res => {
      this.tbl_tematica = $('#tbl_tematica')
      this.dt_tbl_tematica = this.tbl_tematica.DataTable({
        language: datatables_lenguaje,
        data: [],
        dom: "<'table-responsive't><'text-center'p>",
        processing: true,
        ajax: {
          url: _root_lang + '/foro/admin/tematica/datatable',
          data: d => {
            d.buscar = this.buscar_tematica
          }
        },
        serverSide: true,
        columns: [
          {data: 'Lit_Nombre'},
          {data: 'Lit_Descripcion'},
          {data: 'Lit_Estado', render: (d, t, r) => {
            if (+d == 0)
              return `<p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="Denegado" style="color: #DD4B39;"></p>`
          else
            return `<p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="" style="color: #088A08;" data-original-title="Habilitado"></p>`
          }},
          {data: 'Lit_IdLineaTematica', render: (d, t, r) => {
            return Mustache.render(document.getElementById('botones_test').innerHTML, {
              id: d,
              nombre: r.Lit_Nombre,
              estado: r.Lit_Estado,
              url: _root_lang + 'foro/admin/tematica/' + d + '/edit'
            })
            // return `
            //     <button data-toggle="tooltip" data-accion="estado" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-rol btn-acciones" title="" data-estado="${r.Lit_Estado}" data-id="${d}"  data-original-title="${lenguaje.datatable.btns.estado.title}"> </button>
            //     <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="" href="${_root_lang + 'foro/admin/tematica/' + d + '/edit'}" data-original-title="Editar Rol"></a>
            //     <button data-id="${d}"  data-accion="eliminar" class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-rol btn-acciones" data-nombre="${r.Lit_Nombre}" title="Eliminar" data-placement="bottom"> </button>
            //   `
          }}
        ]
      });
      this.dt_tbl_tematica.on('draw', () => {
        $('#tbl_tematica .btn-acciones').tooltip();
      })
      this.tbl_tematica.on('click', '.btn-acciones', this.onClick_btnAccion);

    // })

  }
})