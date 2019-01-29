var _db = require('./db');
var Sequelize = require('sequelize');
// const User = sequelize.define('user', {
//   firstName: {
//     type: Sequelize.STRING
//   },
//   lastName: {
//     type: Sequelize.STRING
//   }
// });
module.exports = {
  base: null,
  model: function () {
    if (this.base == null) {
      this.base = sequelize.define('mensaje', {
        Men_IdMensaje: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true },
        Usu_IdUsuario: {type: Sequelize.INTEGER},
        Lec_IdLeccion: {type: Sequelize.INTEGER},
        Men_Descripcion: {type: Sequelize.STRING},
        Men_Fecha: {type: Sequelize.DATE},
        Les_IdLeccSess: {type: Sequelize.INTEGER},
      }, {
        timestamps: false,
        tableName: 'mensaje'
      });
    }
    return this.base
  },
  registrarMensaje: function (usuario_id, curso_id, leccion_id, mensaje, leccion_session) {

  }
};