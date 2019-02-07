var _db = require('./db');
var Sequelize = require('sequelize');
var ModCurso = require('./curso');

var data = {
  base: null,
  model: function () {
    if (this.base == null) {
      this.base = _db.define('modulo_curso', {
        Moc_IdModuloCurso: { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true },
        Cur_IdCurso: { type: Sequelize.INTEGER },
      }, {
        timestamps: false,
        tableName: 'modulo_curso'
      });
      this.base.belongsTo(ModCurso.model(), {as: 'obj_curso', foreignKey: 'Cur_IdCurso'})
    }
    return this.base
  },
  getByID: function (id, force_get = true) {
    return this.model().findById(id, {include: [{model: ModCurso.model(), as: 'obj_curso'}]}).then(res => {
      return res != null ? (force_get ? res.get({plain: true}) : res) : res;
    })
  }
}

module.exports = data;