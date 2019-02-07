var _db = require('./db');
var Sequelize = require('sequelize');
var ModLeccion = require('./leccion');
var ModModuloCurso = require('./modulo_curso');
var ModCurso = require('./curso');
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
      this.base.belongsTo(ModLeccion.model(), {as: 'obj_leccion', foreignKey: 'Lec_IdLeccion'})
    }
    return this.base
  },
  getByID: function (id) {
    return this.model().findById(id, {include: [
      {
        model: ModLeccion.model(), as: 'obj_leccion',
        include: [{
          model: ModModuloCurso.model(), as: 'obj_modulo_curso',
          include: [{model: ModCurso.model(), as: 'obj_curso'}]
        }]
      }
      
    ]}).then(res => {
      // return this.model().findById(id).then(res => {
      // console.log(res.obj_leccion.obj_modulo_curso.obj_curso)
      return res != null ? res.get({plain: true}) : res;
    })
  }
}

module.exports = data;