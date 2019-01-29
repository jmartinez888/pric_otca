const Sequelize = require('sequelize');
const sequelize = new Sequelize('pric_otca', 'root', 'pric', {
  host: 'localhost',
  dialect: 'mysql',
  operatorsAliases: false,
  // pool: {
  //   max: 5,
  //   min: 0,
  //   acquire: 30000,
  //   idle: 10000
  // },
});
console.log('hola!!!!!');
sequelize.authenticate().then(() => {
  console.log('>>>SUCCESS MYSQL')
}).catch(err => {
  console.error('>>>>ERROR MYSQL', err)
})
module.exports = sequelize;