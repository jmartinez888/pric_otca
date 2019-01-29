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
  TIPO: {
    NINGUNO: 0,
    ESPERA:  1,
    ONLINE:  2,
  },
  model: function () {
    if (this.base == null) {
      this.base = _db.define('leccion_session', {
        Les_IdLeccSess: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true },
        Les_Hash: { type: Sequelize.STRING },
        Lec_IdLeccion: { type: Sequelize.INTEGER },
        Les_Tipo: { type: Sequelize.INTEGER }
      }, {
        timestamps: false,
        tableName: 'leccion_session'
      });
    }
    return this.base
  },
  getByID: function (id) {
    return this.model().findById(id).then(res => {
      return res != null ? res.get({plain: true}) : res;
    })
  }
}

module.exports = data;