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
var data = {
  base: null,
  model: function () {
    if (this.base == null) {
      this.base = _db.define('leccion_asistencia_detalles', {
        Lead_IdLecAsDet: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true },
        Lea_IdLeccAsis: { type: Sequelize.INTEGER, allowNull: true },
        Lead_Ingreso: { type: Sequelize.DATE },
        Lead_Salida: { type: Sequelize.DATE },
        Lead_Fuente: { type: Sequelize.ENUM('php','nodejs', 'none', 'chat', 'chat_leccion') }
      }, {
        timestamps: false
        // createdAt: 'Lea_CreatedAt',
        // updatedAt: 'Lea_UpdatedAt'
      });
    }
    return this.base
  },
  create: function (leccion_asistencia_id, ingreso, fuente) {
    return this.model().create({
      Lea_IdLeccAsis: leccion_asistencia_id,
      Lead_Ingreso: ingreso,
      Lead_Fuente: fuente
    }).then(data => {
      return data != null ? data.get({plain: true}) : data;
    });
  },
  finalizarConexionActiva: function (lecc_asis_det_id) {
    this.model().update({
      Lead_Salida: Date.now()
    }, {
      where: {
        Lead_IdLecAsDet: lecc_asis_det_id
      }
    })
  }
}

module.exports = data;