var _db = require('./db');
var Sequelize = require('sequelize');

var data = {
  base: null,
  model: function () {
    if (this.base == null) {
      this.base = _db.define('curso', {
        Cur_IdCurso: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true },
        Usu_IdUsuario: { type: Sequelize.INTEGER },
      }, {
        timestamps: false,
        tableName: 'curso'
      });
    }
    return this.base
  },
  getByID: function (id, force_get = true) {
    return this.model().findById(id).then(res => {
      return res != null ? (force_get ? res.get({plain: true}) : res) : res;
    })
  }
}

module.exports = data;