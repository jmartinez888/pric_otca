

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
			console.log(e.currentTarget)
			this.nombre = e.currentTarget.dataset.nombre

			let temp_dif = this.dt_tbl_datatable.ajax.json().data.find(v => {
				return v.ODif_IdDifusion == e.currentTarget.dataset.id
			})
			if (temp_dif != undefined) {
				this.editar_attr.estado = +temp_dif.ODif_Estado == 0 ? false : true
				this.editar_attr.datos = +temp_dif.ODif_Datos == 0 ? false : true
				this.editar_attr.evento = +temp_dif.ODif_Evento == 0 ? false : true
				this.editar_attr.banner = +temp_dif.ODif_Banner == 0 ? false : true
				this.editar_attr.id = +temp_dif.ODif_IdDifusion

				$('#mod_estado').modal('show')
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
            // return `
            //     <button data-toggle="tooltip" data-accion="estado" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-rol btn-acciones" title="" data-estado="${r.Lit_Estado}" data-id="${d}"  data-original-title="${lenguaje.datatable.btns.estado.title}"> </button>
            //     <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="" href="${_root_lang + 'foro/admin/tematica/' + d + '/edit'}" data-original-title="Editar Rol"></a>
            //     <button data-id="${d}"  data-accion="eliminar" class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-rol btn-acciones" data-nombre="${r.Lit_Nombre}" title="Eliminar" data-placement="bottom"> </button>
            //   `
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