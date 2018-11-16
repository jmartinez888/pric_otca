
new Vue({
	el: '#container_vue',
	data: function () {
		return {
			...data_vue,
			nombre: '',
			descripcion: '',
			buscar: '',
			tbl_datatable: null,
			dt_tbl_datatable: null,
			edit: false,
			variable_id: 0
		}
	},
	methods: {
		resetForm: function () {
			this.nombre = ''
			for (var x in this.idiomas) {
				this.idiomas[x] = ''
			}
			this.variable_id = 0
			this.edit = false

		},
		onClick_generateFile: function (file_id) {
			loading.show();
			axios.get(_root_lang + 'idiomas/variables/generate_file/' + file_id).then( res => {
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
			console.log(e)
			let dataset = e.currentTarget.dataset;
			switch (dataset.accion) {
				case 'editar':
					this.loadDataElement(dataset.id)
					break;
				case 'eliminar':
					break;
			}
		},
		loadDataElement (variable_id) {
			this.variable_id = variable_id
			if (this.variable_id != 0) {
				axios.get(_root_lang + 'idiomas/variables/' + variable_id).then( res => {
					if (res.data.success) {
						this.nombre = res.data.data.variable
						res.data.data.body.forEach(v => {
							this.idiomas['idioma_' + v.idioma_id] = v.body
							// console.log(v)
						})
						$('#collapse_registro').collapse('show')
						this.edit = true
						// for(var x in this.idiomas) {
						// 	this.idiomas[x] =
						// }
					}
				})
			}
		},
		onSubmit_registrar: function () {
			loading.show()
			let params = new FormData();
			params.append('nombre', this.nombre)
			params.append('file_id', this.file_id)
			params.append('variable_id', this.variable_id)
			let i = 0;
			for(var x in this.idiomas) {
				params.append('idiomas[' + i + '][idioma]', x)
				params.append('idiomas[' + i + '][body]', this.idiomas[x])
				i++;
			}
			let url = this.edit ? _root_lang + 'idiomas/variables/update/' + this.variable_id : _root_lang + 'idiomas/variables/store'
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
          url: _root_lang + '/idiomas/lenguajes/datatable_file/' + this.file_id,
          data: d => {
            d.buscar = this.buscar
          }
        },
        serverSide: true,
        columns: [
          {data: 'variable'},
          {data: 'id', render: (d, t, r) => {
          	return Mustache.render(document.getElementById('listar_body').innerHTML, {
              idiomas: r.body
            })
          }},
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