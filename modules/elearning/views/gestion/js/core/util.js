window.onload = function(){

(function ($)
{
    $.fn.Ventana = function (m) {
        m = m || {};
        m.id = m.id || ""; //OK
        m.titulo = m.titulo || "Ventana - Sin Titulo"; //OK
        m.funcion = m.funcion || function () { };
        m.funcionCerrar = m.funcionCerrar || function () { };
        m.tamano = m.tamano || "";
        m.cuerpo = m.cuerpo || "";
        m.mod_pric = m.mod_pric || false;
        m.icon = m.icon || "th-large";
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
                               '<span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-' + m.icon + '"></span>' +
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


        if (m.mod_pric) {
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


(function ($) {
    $.fn.Mensaje = function (m) {
        m = m || {};
        m.titulo = m.titulo || "Aviso";
        m.tamano = m.tamano || "";
        m.mensaje = m.mensaje || "";
        m.tipo = m.tipo || "Aceptar";
        m.funcionCerrar = m.funcionCerrar || function () { };
        m.funcionAceptar = m.funcionAceptar || function () { };
        m.funcionSi = m.funcionSi || function () { };
        m.funcionNo = m.funcionNo || function () { };
        m.indice = m.indice || 0;
        m.icon = m.icon || "th-large";
        m.mod_pric = m.mod_pric || false;

        var html = '<div class="row"><div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"><h4 class="text-center">' + m.mensaje + '</h4></div></div>';

        switch (m.tipo) {
            case "Aceptar":
                html = html + '<div class="row"> <div class="col-xs-3 col-sm-4 col-md-4 col-lg-4"></div> <div class="col-xs-6 col-sm-4 col-md-4 col-lg-4"> <button type="button" id="btnAceptarMen" class="btn btn-default" style="width: 100% !important">Aceptar</button> </div> <div class="col-xs-3  col-sm-4 col-md-4 col-lg-4"></div> </div>';
                break;
            case "SiNo":
                html = html + '<div class="row"> <div class="hidden-xs col-sm-3 col-md-3 col-lg-3"></div> <div class="col-xs-6 col-sm-3 col-md-3 col-lg-3"> <button type="button" id="btnSiMen" class="btn btn-default" style="width: 100% !important">Si</button> </div> <div class="col-xs-6 col-sm-3 col-md-3 col-lg-3"> <button type="button" id="btnNoMen" class="btn btn-default" style="width: 100% !important">No</button> </div> <div class="hidden-xs col-sm-3 col-md-3 col-lg-3"></div> </div>';
                break;
        }

        $.fn.Ventana({
            id: "vntMensaje",
            titulo: m.titulo,
            tamano: m.tamano,
            cuerpo: html,
            mod_pric: m.mod_pric,
            icon: m.icon,
            funcionCerrar: m.funcionCerrar
        });

        $("#btnAceptarMen").bind("click", function () {
            $("#vntMensaje").modal('hide');
            $('#vntMensaje').on('hidden.bs.modal', function (e) {
                m.funcionAceptar(m.indice);
            });
        });

        $("#btnSiMen").bind("click", function () {
            $("#vntMensaje").modal('hide');
            $('#vntMensaje').on('hidden.bs.modal', function (e) {
                m.funcionSi(m.indice);
            });
        });

        $("#btnNoMen").bind("click", function () {
            m.funcionNo();
            $("#vntMensaje").modal('hide');
        });

        $('#vntMensaje').modal('show');
    }
})(jQuery);

};


