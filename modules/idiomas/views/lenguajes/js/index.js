autosize(document.getElementById('descripcion'));
new Vue({
	el: '#container_vue',
	data: function () {
		return {
			nombre: '',
			descripcion: '',
			buscar: '',
			tbl_datatable: null,
			dt_tbl_datatable: null,
			file_id: 0,
			edit: false
		}
	},
	methods: {
		resetForm: function () {
			this.nombre = ''
			this.descripcion = ''
			this.file_id = 0
			this.edit = false
		},
		onClick_generateFiles: function () {

			loading.show();
			axios.get(_root_lang + 'idiomas/lenguajes/generate_files').then( res => {
				if (res.data.success) {
					msg.success(res.data.msg)
				} else {
					msg.error(res.data.msg)
				}
				loading.hide()
			}).catch( err => {
				loading.hide()
			})
		},
		onClick_btnAccion: function (e) {
			let dataset = e.currentTarget.dataset;
			switch (dataset.accion) {
				case 'editar':
					this.loadDataElement(dataset.id)
					break;
				case 'eliminar':
					loading.show()
					let params = new FormData();
					params.append('file_id', dataset.id)
					axios.post(_root_lang + 'idiomas/lenguajes/delete/' + dataset.id, params).then( res => {
						if (res.data.success) {
							msg.success(res.data.msg)
						} else {
							msg.error(res.data.msg)
						}
						loading.hide()
					}).catch( err => {
						loading.hide()
					})
					break;
			}
		},
		loadDataElement (variable_id) {
			this.file_id = variable_id
			if (this.file_id != 0) {
				axios.get(_root_lang + 'idiomas/lenguajes/' + variable_id).then( res => {
					if (res.data.success) {
						this.file_id = res.data.data.id
						this.nombre = res.data.data.titulo
						this.descripcion = res.data.data.descripcion
						$('#collapse_registro').collapse('show')
						this.edit = true
					}
				})
			}
		},
		onSubmit_registrar: function () {
			loading.show()
			let params = new FormData();
			params.append('nombre', this.nombre)
			params.append('descripcion', this.descripcion)
			params.append('file_id', this.file_id)
			let url = this.edit ? _root_lang + 'idiomas/lenguajes/update/' + this.file_id : _root_lang + 'idiomas/lenguajes/store'
			axios.post(url, params).then( res => {
				loading.hide()
				if (res.data.success) {
					this.dt_tbl_datatable.draw(false)
					msg.success(res.data.msg)
					this.resetForm()
				} else msg.error(res.data.msg)
			}).catch( err => {
				loading.hide()
			})
		}

	},
	mounted: function () {
		console.log(this)

		this.tbl_datatable = $('#tbl_datatable')
    this.dt_tbl_datatable = this.tbl_datatable.DataTable({
        language: datatables_lenguaje,
        data: [],
        dom: "<'table-responsive't><'text-center'p>",
        processing: true,
        ajax: {
          url: _root_lang + '/idiomas/lenguajes/datatable',
          data: d => {
            d.buscar = this.buscar
          }
        },
        serverSide: true,
        columns: [
          {data: 'titulo'},
          {data: 'descripcion'},
          // {data: 'estado_item', render: (d, t, r) => {
          // 	return DatatableUtil.textEstado(+d)
          // }},
          {data: 'id', render: (d, t, r) => {
            return Mustache.render(document.getElementById('botones_opcion').innerHTML, {
              id: d,
              nombre: r.titulo,
              estado: 'estado',
              url: 'asdasd'
            })
          }}
        ],
	      columnDefs: [
	      	{className: 'text-center',  targets: [2]}
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