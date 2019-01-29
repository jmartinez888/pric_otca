var _db = require('./db');
var ModLAD = require('./leccion_asistencia_detalles');
var ModLeccionSession = require('./leccion_session');
var ModUsuarios = require('./usuarios');

var Sequelize = require('sequelize');
// const User = sequelize.define('user', {
//   firstName: {
//     type: Sequelize.STRING
//   },
//   lastName: {
//     type: Sequelize.STRING
//   }
// });
var data = {
  base: null,
  model: function () {
    // console.log(ModLeccionAsistenciaDetalles)
    if (this.base == null) {
      this.base = _db.define('leccion_asistencia', {
        Lea_IdLeccAsis: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true },
        Lec_IdLeccion: { type: Sequelize.INTEGER },
        Les_IdLeccSess: { type: Sequelize.INTEGER },
        Usu_IdUsuario: { type: Sequelize.INTEGER },
        Lea_Modo: { type: Sequelize.ENUM('none', 'presencial', 'post_presencial') },
        Lea_Inicio: { type: Sequelize.DATE }
      }, {
        timestamps: true,
        createdAt: 'Lea_CreatedAt',
        updatedAt: 'Lea_UpdatedAt'
      });
    }
    return this.base
  },
  existeAsistencia: function (usuario_id, leccion_id, leccions_session, getobject = false) {
    //consultar solo query tipo SELECT COUNT, pues está detornando todas las coincidencias
    return this.model().findAndCountAll({
      where:{
      Usu_IdUsuario: usuario_id,
      Lec_IdLeccion: leccion_id,
      Les_IdLeccSess: leccions_session
    }}).then(res => {
      // console.log(res.rows[0].get({plain: true}))
      return getobject ? res :  res.count > 0;
    })
  },
  registrarAsistencia: function (usuario_id, leccion_id, leccions_session, obj_less_sess) {
    //SE REQUIERE DE UN REGISTRO EN ASISTENCIA(presencial|leccion_espera) PARA EL REGISTRO DE LOS DETALLES
    let res = {success: false, data_la: null, data_lad: null};
    // return ModLeccionSession.getByID(leccions_session).then(obj_less_sess => {
    //   if (obj_less_sess != null) {
        return this.existeAsistencia(usuario_id, leccion_id, leccions_session, true)
          .then(existe => {
            if (existe.count == 0) {
              return this.model().create({
                Usu_IdUsuario: usuario_id,
                Lec_IdLeccion: leccion_id,
                Les_IdLeccSess: leccions_session,
                Lea_Inicio: Date.now(),
                Lea_Modo: obj_less_sess.Les_Tipo == ModLeccionSession.TIPO.ONLINE ? 'presencial' : (obj_less_sess.Les_Tipo == ModLeccionSession.TIPO.ESPERA ? 'leccion_espera' : 'none')
              }).then(data => {
                if (data != null) {
                  res.success = true;
                  res.data_la = data.get({plain: true});
                }
                return res;
                // return data != null ? data.get({plain: true}) : null
              }).then(parse_data => {
                return ModLAD.create(parse_data.data_la.Lea_IdLeccAsis, parse_data.data_la.Lea_Inicio, obj_less_sess.Les_Tipo == ModLeccionSession.TIPO.ONLINE ? 'chat_leccion' : (obj_less_sess.Les_Tipo == ModLeccionSession.TIPO.ESPERA ? 'chat_leccion_espera' : 'none')).then(data_lad => {
                  parse_data.data_lad = data_lad
                  return parse_data;
                });
              }).catch(err => {
                console.log(err);
                return res;
              })
            } else {
              return ModLAD.create(existe.rows[0].Lea_IdLeccAsis, Date.now(), obj_less_sess.Les_Tipo == ModLeccionSession.TIPO.ONLINE ? 'chat_leccion' : (obj_less_sess.Les_Tipo == ModLeccionSession.TIPO.ESPERA ? 'chat_leccion_espera' : 'none')).then(data_lad => {
                // res.data_la = {
                //   Lea_IdLeccAsis: existe.rows[0].Lea_IdLeccAsis
                // }
                res.data_la = existe.rows[0].get({plain: true})
                res.data_lad = data_lad;
                res.success = true;
                return res;
              })
            }
          })
          .then(prepro => {
            return ModUsuarios.getByID(usuario_id).then(usuario => {
              if (usuario) {
                res.data_la.Usu_Nombre = usuario.Usu_Nombre
                res.data_la.Usu_Apellidos = usuario.Usu_Apellidos
                res.data_la.Usu_URLImage = usuario.Usu_URLImage
              }
              return res;
            })
            // console.log('PREEEE')
            // console.log(prepro)
            // console.log('PREEEE')
            // return prepro;
          })
    //   }
    //   return res;
    // })
  }
}
module.exports = data;