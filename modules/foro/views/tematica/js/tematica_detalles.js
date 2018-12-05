if (typeof locale_set == 'string')
	moment.locale(locale_set)
const recientes = {
	template: '#recientes',
	props: ['foro'],
	data: function () {
		return {
			foro: {
				For_Descripcion: ''
			}
		}
	}
}

new Vue({
  el: '#tematica_detalles',
  data: function () {
  	return {
  		filter: {
  			text: '',
  			funcion: 'todo'

  		},
  		list_recientes: [],
  		list_agenda: [],
  		pagination: {
  			start: 0,
  			length: 5,
        active:true
  		},
  		pagination_agenda: {
  			start: 0,
  			length: 5,
  		},
  		existeData: false,
  		existeDataAgenda: false,
  		buscando: false

  	}
  },
  methods: {
  	onClick_loadRecientes () {
  		this.pagination.start += this.pagination.length
  		this.loadRecientes()
  	},
  	onSubmit_filtrarResultados () {
  		this.pagination.start = 0;
  		this.buscando = true
  		this.loadRecientes()
  	},
  	loadRecientes () {
	  	axios.get(window.location.href, {params: {
	  		evento: 'recientes',
	  		start: this.pagination.start,
	  		length: this.pagination.length,
	  		buscar: this.filter.text,
	  		funcion: this.filter.funcion
	  	}}).then(res => {
	  		console.log(res.data)
	  		let temp = res.data.data.map(v => {
  				//v.format_creacion = moment(v.For_FechaCreacion).fromNow()
          v.format_creacion = v.For_FechaCreacion;
  				return v
  			});
	  		if (res.data.data.length >= this.pagination.length){
	  				this.existeData = true            
	  			}else {
            this.existeData = false
            
          }

        if (res.data.data.length==0){
             this.pagination.active=false
        }

	  		if (this.buscando) {
	  			this.list_recientes = temp
	  			this.buscando = false
	  		} else {
	  			this.list_recientes.push(...temp)
	  		}
	  	}).catch(err => {
	  		console.log(err.response.data)
	  	})
  	},
  	loadAgenda () {
	  	axios.get(window.location.href, {params: {
	  		evento: 'agenda',
	  		start: this.pagination_agenda.start,
	  		length: this.pagination_agenda.length,
	  		now: moment().format('YYYY-MM-DD')

	  	}}).then(res => {
	  		console.log(res.data)
	  		let temp = res.data.data.map(v => {
  				//v.format_creacion = moment(v.For_FechaCreacion).fromNow()
          v.format_creacion = v.For_FechaCreacion
          return v
  			});
	  		if (res.data.data.length >= this.pagination.length)
	  				this.existeDataAgenda = true
	  			else this.existeDataAgenda = false

	  			this.list_agenda.push(...temp)

	  	}).catch(err => {
	  		console.log(err.response.data)
	  	})
  	}
  },
  components: {
  	recientes
  }, 
  created: function () {
  	this.loadRecientes()
  },
  mounted: function () {
  	// this.list_recientes.push({id: 'asd'})
  	// this.list_recientes.push({id: 'asds'})
  	// this.list_recientes.push({id: 'asddd'})
    $("#ver_mas").removeClass("hidden");
  },
  updated: function () {
    $("#ver_mas").removeClass("hidden");
  }
});