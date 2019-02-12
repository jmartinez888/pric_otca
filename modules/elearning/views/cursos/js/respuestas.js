new Vue({
  el: '#pb_respuestas_vue',
  data: function () {
    return {
      curso_id: getContentMeta('curso-id'),
      dt_tbl_respuestas: null,
      filter: {
        txt_query: ''
      }
    }
  },
  watch: {
    'filter.txt_query': function (nv) {
      if (nv.trim() == '')
        this.dt_tbl_respuestas.draw();  
    }
  },
  methods: {
    onSubmit_filtrar: function () {
      this.dt_tbl_respuestas.draw();
    }
  },
  mounted: function () {
    this.dt_tbl_respuestas = getDatatable(this.$refs.tbl_respuestas,
      base_url('elearning/cursos/datatable_respuestas_formulario/' + this.curso_id),
      (data) => {
        data.filter = {
          query: this.filter.txt_query
        }
      }, [
        {data: 'usuario_nombre'},
        {data: 'formulario_respuesta_fecha'},
        {data: 'formulario_respuesta_id', render: (d, t, r) => {
          return Mustache.render(document.getElementById('tpl_btn_operacion').innerHTML, {
						formulario_respuesta_id: d,
					})
        }}
      ] 
    ).on('draw', (x, datatable) => {
			$('.btn-acciones[data-toggle="tooltip"]').tooltip();
		});
  }
})