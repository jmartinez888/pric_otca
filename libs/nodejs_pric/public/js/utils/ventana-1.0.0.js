﻿(function ($)
{
    $.fn.Ventana = function (m) {
        m = m || {};
        m.id = m.id || ""; //OK
        m.titulo = m.titulo || "Ventana - Sin Titulo"; //OK
        m.funcion = m.funcion || function () { };
        m.funcionCerrar = m.funcionCerrar || function () { };
        m.tamano = m.tamano || "";
        m.cuerpo = m.cuerpo || "";
        m.modjaox = m.modjaox || false;
        var cssModal = "modal-dialog";

        switch (m.tamano) {
            case "sm": cssModal += " modal-sm"; break
            case "lg": cssModal += " modal-lg"; break
            case "xl": cssModal += " modal-xl"; break
        }

        var html = "";
        html += '<div class="modal fade" id="' + m.id + '" tabindex="-5" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-focus-on="input:first">' +
                    '<div class="' + cssModal + '">' +
                       '<div class="panel panel-cmacm">' +
                           '<div class="panel-heading">' +
                               '<img src="../Content/img/icono.png" style="height: 20px; width: 20px; margin-right: 5px;" />' +
                                    m.titulo +
                               '<button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>' +
                           '</div>' +
                           '<div class="panel-body">' + m.cuerpo +
                           '</div>' +
                       '</div>' +
                   '</div>' +
               '</div>'

        $(html).appendTo('body');

        $("div#" + m.id).on('hidden.bs.modal', function (e)
        {
            $("div#" + m.id).remove();
            m.funcionCerrar();
        });


        if (!m.modjaox) {
            $('.modal').on('show.bs.modal', function (event) {
                var idx = $('.modal:visible').length;
                $(this).css('z-index', 1050 + (10 * idx));
            });
    
            $('.modal').on('shown.bs.modal', function (event) {
                var idx = ($('.modal:visible').length) - 1; // raise backdrop after animation.
                $('.modal-backdrop').not('.stacked').css('z-index', 1049 + (10 * idx));
                $('.modal-backdrop').not('.stacked').addClass('stacked');
            });

            $('.modal').on('hide.bs.modal', function (event) {
                var idx = ($('.modal:visible').length) - 2; // raise backdrop after animation.
                $('.modal-backdrop').not('.stacked').css('z-index', 1049 + (10 * idx));
                $('.modal-backdrop').not('.stacked').addClass('stacked');
            });
        }
    }
})(jQuery);