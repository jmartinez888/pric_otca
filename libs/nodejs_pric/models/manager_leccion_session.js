module.exports = {
  sessiones: [],
  agregarNuevaSession: function (data) {
    this.sessiones.push({
      data: data,
      real_conections: 0,
      list_usuarios: []
    })
  },
  existeSession: function (leccion_session_id) {
    return this.getSession(leccion_session_id) != undefined ? true : false;
  },
  getSession: function (leccion_session_id) {
    return this.sessiones.find(v => {
      return v.data.Les_IdLeccSess == leccion_session_id
    });
  },
  agregarUsuarioEnSession: function (leccion_session_id, data) {
    let objSes = this.getSession(leccion_session_id);
    objSes.list_usuarios.push(data);
  },
  getUsuarioEnSession: function (usuario_id, leccion_session_id) {
    let objSes = this.getSession(leccion_session_id);
    if (objSes != undefined) {
      return objSes.list_usuarios.find(v => {
        return v.Usu_IdUsuario == usuario_id
      })
    }
    return undefined;
  },
  eliminarActivo: function (usuario_id, leccion_session_id) {
    let s = this.getSession(leccion_session_id);
    if (s != undefined) {
      s.list_usuarios.forEach((v, i) => {
        if (v.Usu_IdUsuario == usuario_id)
          s.list_usuarios.splice(i, 1);
        
      })
    }
  },
  getUsuarioBySocketID: function (socket) {
    let x = [];
    this.sessiones.forEach(v => {
      v.list_usuarios.forEach(vv => {
        if (socket == vv.IDSOCKET)
          x.push(vv)
      })
    })
    return x;
  },
  getUsuariosEnSession: function (leccion_session_id, parse= false) {
    
    let s = this.getSession(leccion_session_id);
    if (s != undefined) {
      if (parse) {
        return s.list_usuarios.map(v => {
          // console.log(v)
          return {
            inicio_asistencia: v.Lea_Inicio,
            inicio_asistencia_detalles: v.Lead_Ingreso,
            usuario_id: v.Usu_IdUsuario,
            session_id: v.Les_IdLeccSess,
            leccion_id: v.Lec_IdLeccion,
            usuario_nombres: v.Usu_Nombre,
            usuario_apellidos: v.Usu_Apellidos,
            usuario_image_url: v.Usu_URLImage
          }
        });
      } else {
        return s.list_usuarios;
      }
    } else return [];
    
      

  }
}