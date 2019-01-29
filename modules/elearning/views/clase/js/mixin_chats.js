var MIXIN_CHAT = {
  methods: {
    loadConectados: function (leccion_id) {
      // axios.get(base_url(''))
    },
    onSubmit_registrarAsistencia: function (data_values) {
      
      console.log(data_values)
      let data_frm = new FormData();
      data_frm.append('leccion_id', data_values.leccion_id);
      data_frm.append('alumno_id', data_values.alumno_id);
      data_frm.append('docente_id', data_values.docente_id);
      data_frm.append('hash', data_values.hash);
      axios.post(base_url('elearning/clase/registrar_asistencia'), data_frm).then( res => {
        console.log(res)
      })
    }
  }
}