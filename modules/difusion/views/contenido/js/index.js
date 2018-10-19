

new Vue({
	el: '#difusion_gestion',
	data: function () {
		return {
			tbl_difusion: null,
			dt_tbl_difusion: null,
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
	watch: {
		idioma_actual: function (nv, ov) {
			this.saveContenidoByIdioma(ov)
			this.loadContenidoByIdioma(nv)

		}
	},
	methods: {
		onSubmit_export: function (e) {
			window.location.href = _root_lang + 'difusion/contenido/datatable?zone='+zone_datatable+'&' + $.param(this.dt_tbl_difusion.ajax.params())  + '&export=' + e
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
					this.dt_tbl_difusion.draw(false)

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

			let temp_dif = this.dt_tbl_difusion.ajax.json().data.find(v => {
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
      this.dt_tbl_difusion.draw()
    },
	},
	mounted: function () {

		this.tbl_difusion = $('#tbl_difusion')
    this.dt_tbl_difusion = this.tbl_difusion.DataTable({
        language: datatables_lenguaje,
        data: [],
        dom: "<'table-responsive't><'text-center'p>",
        processing: true,
        ajax: {
          url: _root_lang + '/difusion/contenido/datatable?zone=' + zone_datatable,
          data: d => {
            d.buscar = this.buscar
          }
        },
        serverSide: true,
        columns: [
          {data: 'ODif_Titulo'},
          {data: 'ODif_Descripcion'},
          {data: 'ODif_Estado', render: (d, t, r) => {
            if (+d == 0)
              return `<p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="Denegado" style="color: #DD4B39;"></p>`
          else
            return `<p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="" style="color: #088A08;" data-original-title="Habilitado"></p>`
          }},
          {data: 'ODif_IdDifusion', render: (d, t, r) => {
          	let a = `<span class="label params-label label-primary">B</span>`
          	let b = `<span class="label params-label label-primary">D</span>`
          	let c = `<span class="label params-label label-primary">E</span>`
          	let rr = ''
          	if (+r.ODif_Banner == 1)
          		rr += a
          	if (+r.ODif_Datos == 1)
          		rr += b
          	if (+r.ODif_Evento == 1)
          		rr += c
          	return rr

          }},
          {data: 'ODif_IdDifusion', render: (d, t, r) => {
            return Mustache.render(document.getElementById('botones_test').innerHTML, {
              id: d,
              nombre: r.ODif_Titulo,
              estado: r.ODif_Estado,
              url: _root_lang + 'difusion/contenido/' + d + '/edit'
            })
            // return `
            //     <button data-toggle="tooltip" data-accion="estado" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-rol btn-acciones" title="" data-estado="${r.Lit_Estado}" data-id="${d}"  data-original-title="${lenguaje.datatable.btns.estado.title}"> </button>
            //     <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="" href="${_root_lang + 'foro/admin/tematica/' + d + '/edit'}" data-original-title="Editar Rol"></a>
            //     <button data-id="${d}"  data-accion="eliminar" class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-rol btn-acciones" data-nombre="${r.Lit_Nombre}" title="Eliminar" data-placement="bottom"> </button>
            //   `
          }}
        ]
      });
    this.dt_tbl_difusion.on('draw', () => {
      // $('#tbl_difusion .btn-acciones').tooltip();
    })
    this.tbl_difusion.on('click', '.btn-acciones', this.onClick_btnAccion);
    this.tbl_difusion.tooltip({
      selector: '[data-toggle="tooltip"]'
    });

	}
})