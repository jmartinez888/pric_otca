/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
    var params = {
        link: "cursos/data_calendario",
        params: {},
        docente: 0,
        viewDocente: function (div, params) {
            //console.log(params);
        }
    };
    var botones = {
        anterior: function (mes, anio) {
        },
        siguiente: function (mes, anio) {
        }
    };
    var view = {
        titulo: "Cursos del dia",
        header: function () {
            return "";
        },
        footer: function () {
            return "";
        },
        item: function (row) {
            console.log(row);
            var result = "";
            result += "<div class='col-lg-12 panel'>";
            result += "<div class='col-lg-9'>" + row.DET + "</div>";
            if (row.ESTADO == 1) {
                result += "<div class='col-lg-3'>INICIO</div>";
            } else {
                result += "<div class='col-lg-3'>CULMINACIÓN</div>";
            }
            result += "</div>";
            return result;
        }
    };
    StartCalendarioPRIC("#calendario", params, botones, view);
});
