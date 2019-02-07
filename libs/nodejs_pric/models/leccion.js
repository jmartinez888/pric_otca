var _db = require('./db');
var Sequelize = require('sequelize');
var ModLeccionSession = require('./leccion_session');
var ModModuloCurso = require('./modulo_curso');

var data = {
  base: null,
  model: function () {
    if (this.base == null) {
      this.base = _db.define('leccion', {
        Lec_IdLeccion:      { type: Sequelize.INTEGER, primaryKey: true, autoIncrement: true },
        Moc_IdModuloCurso:  { type: Sequelize.INTEGER },
      }, {
        timestamps: false,
        tableName: 'leccion'
      });
      
      

      this.base.belongsTo(ModModuloCurso.model(), {as: 'obj_modulo_curso', foreignKey: 'Moc_IdModuloCurso'})
      
      
    }
    return this.base
  },
  getByID: function (id, force_get = true) {
    return this.model().findById(id, {include: [{model: ModModuloCurso.model(), as: 'obj_modulo_curso'}]}).then(res => {
      return res != null ? (force_get ? res.get({plain: true}) : res) : res;
    })
  }
}

module.exports = data;