

new Vue({
	el: '#difusion_cifras',
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
		findItem (id) {
			return this.dt_tbl_difusion.ajax.json().data.find( item => {
				return item.id == id
			})
		},
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
			let item = this.findItem(e.currentTarget.dataset.id)
			switch (e.currentTarget.dataset.accion) {
				case 'estado':
					if (item != undefined) {
						let params = new FormData()
						params.append('id', e.currentTarget.dataset.id)
						loading.show()
						axios.post(_root_lang + 'difusion/cifras/' + e.currentTarget.dataset.id + '/update/estado', params).then( res => {
							if (res.data.success) {
								msg.success(res.data.msg)
								this.dt_tbl_difusion.draw(false)
							}
							loading.hide()
						})
					}
					break
				case 'eliminar':

					if (item != undefined) {
						let params = new FormData()
						params.append('id', e.currentTarget.dataset.id)
						loading.show()
						axios.post(_root_lang + 'difusion/cifras/' + e.currentTarget.dataset.id + '/delete', params).then( res => {
							if (res.data.success) {
								msg.success(res.data.msg)
								this.dt_tbl_difusion.draw(false)
							}
							loading.hide()
						})
					}
					break
			}
			// console.log(e.currentTarget)
			// this.nombre = e.currentTarget.dataset.nombre

			// let temp_dif = this.dt_tbl_difusion.ajax.json().data.find(v => {
			// 	return v.ODif_IdDifusion == e.currentTarget.dataset.id
			// })
			// if (temp_dif != undefined) {
			// 	this.editar_attr.estado = +temp_dif.ODif_Estado == 0 ? false : true
			// 	this.editar_attr.datos = +temp_dif.ODif_Datos == 0 ? false : true
			// 	this.editar_attr.evento = +temp_dif.ODif_Evento == 0 ? false : true
			// 	this.editar_attr.banner = +temp_dif.ODif_Banner == 0 ? false : true
			// 	this.editar_attr.id = +temp_dif.ODif_IdDifusion

			// 	$('#mod_estado').modal('show')
			// }

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
        url: _root_lang + '/difusion/cifras/datatable',
        data: d => {
          d.buscar = this.buscar
        }
      },
      serverSide: true,
      columns: [
        {data: 'descripcion'},
        {data: 'indicador.titulo'},
        {data: 'latitude'},
        {data: 'longitude'},
        {data: 'estado_item', render: (d, t, r) => {
          if (+d == 0)
            return `<p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="Denegado" style="color: #DD4B39;"></p>`
        else
          return `<p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="" style="color: #088A08;" data-original-title="Habilitado"></p>`
        }},
        {data: 'id', render: (d, t, r) => {
          return Mustache.render(document.getElementById('botones_test').innerHTML, {
            id: d,
            nombre: r.descripcon,
            estado: r.estado_item,
            url_edit: _root_lang + 'difusion/cifras/' + d + '/edit',
            url_view: _root_lang + 'difusion/cifras/' + d
          })
        }}
      ],
      columnDefs: [
      	{className: 'text-center',  targets: [1, 4, 5]},
      	{className: 'text-left',  targets: [0]},
      	{className: 'text-center',  targets: [2, 3]},
      ]
    })
    this.tbl_difusion.on('click', '.btn-acciones', this.onClick_btnAccion);
    this.tbl_difusion.tooltip({
      selector: '[data-toggle="tooltip"]'
    });

	}
})