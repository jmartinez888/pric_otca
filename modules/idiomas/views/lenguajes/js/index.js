autosize(document.getElementById('descripcion'));
new Vue({
	el: '#container_vue',
	data: function () {
		return {
			nombre: '',
			descripcion: '',
			buscar: '',
			tbl_datatable: null,
			dt_tbl_datatable: null

		}
	},
	methods: {
		resetForm: function () {
			this.nombre = ''
			this.descripcion = ''
		},
		onClick_btnAccion: function () {
			console.log('asd')
		},
		onSubmit_registrar: function () {
			loading.show()
			let params = new FormData();
			params.append('nombre', this.nombre)
			params.append('descripcion', this.descripcion)

			axios.post(_root_lang + 'idiomas/lenguajes/store', params).then( res => {
				loading.hide()
				if (res.data.success) msg.success(res.data.msg)
				else msg.error(res.data.msg)
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