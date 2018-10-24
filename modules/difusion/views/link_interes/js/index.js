

new Vue({
	el: '#vue_container',
	data: function () {
		return {
			tbl_datatable: null,
			dt_tbl_datatable: null,
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
		onSubmit_export: function (e) {
			window.location.href = _root_lang + 'difusion/link_interes/datatable?' + $.param(this.dt_tbl_datatable.ajax.params())  + '&export=' + e
		},
		onSubmit_actualizar_attr: function() {
			$.post(_root_lang + 'difusion/contenido/' + this.editar_attr.id + '/update?metodo=estado', {
				estado: +this.editar_attr.estado ? 1 : 0,
				datos: +this.editar_attr.datos ? 1 : 0,
				banner: +this.editar_attr.banner ? 1 : 0,
				evento: +this.editar_attr.evento ? 1 : 0,
				id: this.editar_attr.id,
			}, (res) => {
				console.log(res)
				if (res.success) {
					msg.success(res.msg);
					$('#mod_estado').modal('hide')
					this.dt_tbl_datatable.draw(false)

					this.editar_attr.estado = false
					this.editar_attr.datos = false
					this.editar_attr.banner = false
					this.editar_attr.evento = false
					this.editar_attr.id = 0
				}
			})
		},
		onClick_btnAccion: function (e) {
			let params = new FormData()
			switch (e.currentTarget.dataset.accion) {
				case 'estado':

					params.append('id', e.currentTarget.dataset.id)
					params.append('estado', e.currentTarget.dataset.estado >= 1 ? 0 : 1)
					axios.post(_root_lang + 'difusion/link_interes/' + e.currentTarget.dataset.id + '/update/estado', params).then( res => {
						console.log(res)
						if (res.data.success) {
							msg.success(res.data.msg)
							this.dt_tbl_datatable.draw(false)
						}
					})
					break;
				case 'eliminar':
					params.append('id', e.currentTarget.dataset.id)
					axios.post(_root_lang + 'difusion/link_interes/' + e.currentTarget.dataset.id + '/delete', params).then( res => {
						console.log(res)
						if (res.data.success) {
							msg.success(res.data.msg)
							this.dt_tbl_datatable.draw(false)
						}
					})
					break;
			}




		},
		onSubmit_filtrarTematica: function () {
      this.dt_tbl_datatable.draw()
    },
	},
	mounted: function () {

		this.tbl_datatable = $('#tbl_datatable')
    this.dt_tbl_datatable = this.tbl_datatable.DataTable({
        language: datatables_lenguaje,
        data: [],
        dom: "<'table-responsive't><'text-center'p>",
        processing: true,
        ajax: {
          url: _root_lang + '/difusion/link_interes/datatable',
          data: d => {
            d.buscar = this.buscar
          }
        },
        serverSide: true,
        columns: [
          {data: 'titulo'},
          {data: 'descripcion'},
          {data: 'url'},
          {data: 'estado_item', render: (d, t, r) => {
          	return DatatableUtil.textEstado(+d)
          }},
          {data: 'id', render: (d, t, r) => {
            return Mustache.render(document.getElementById('botones_test').innerHTML, {
              id: d,
              nombre: r.titulo,
              estado: r.estado_item,
              url: r.url
            })
          }}
        ]
      });
    this.dt_tbl_datatable.on('draw', () => {
      // $('#tbl_datatable .btn-acciones').tooltip();
    })
    this.tbl_datatable.on('click', '.btn-acciones', this.onClick_btnAccion);
    this.tbl_datatable.tooltip({
      selector: '[data-toggle="tooltip"]'
    });

	}
})