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
      this.base = _db.define('usuario', {
        Usu_IdUsuario: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true },
        Usu_Nombre: {type: Sequelize.STRING},
        Usu_Apellidos: {type: Sequelize.STRING},
        Usu_URLImage: {type: Sequelize.STRING}
      }, {
        timestamps: false,
        tableName: 'usuario'
      });
    }
    return this.base
  },
  getByID: function (id) {
    return this.model().findById(id).then(res => {
      return res != null ? res.get({plain: true}) : res;
    })
  }
};