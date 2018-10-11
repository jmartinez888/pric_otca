// $('#collapse3').collapse()

var app = new Vue({
  el: '#tematica_edit_vue',
  data: {
    ...data_vue,
    // estado: true
  },
  methods: {
    anyFill () {
      for(var x in this.idiomas){
        if (this.idiomas[x].tematica.trim()) return true
      }
      return false
    },
  	onSubmit_actualizarTematica () {
  		if (this.anyFill()) {
        var formData = {
          estado: this.estado ? 1 : 0,
          idiomas: this.idiomas
        }
  			axios.put(_root_ + '/es/foro/admin/tematica/' + this.tematica_id + '/update', formData).then(res => {
  				console.log(res.data)
          if (res.data.success) {
            msg.success(res.data.msg);
          }
  			}).catch(err => {
  				console.log(err.response)
  			})
	  		// 	axios({
	  		// 		method: 'post',
	  		// 		headers: {
	  		// 			'X-Requested-With': 'XMLHttpRequest'},
  			// 		url: _root_ + '/es/foro/admin/tematica/1/update',
  			// 		// responseType: 'json',
  			// 		data: formData
  			// 	}).then(r => {
					// 	console.log(r.data)
					// }).catch(err => {
					// 	console.log(err.response)
					// })
  		}
  	}
  }
})