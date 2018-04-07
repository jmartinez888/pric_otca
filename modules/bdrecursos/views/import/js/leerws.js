var _post = null;
$(document).ready(function() {

    //Para el Modal
    $("body").on('click', "#agregar-form-link", function (e) {
        $("#agregar-form").delay(100).fadeIn(100);
        $("#buscar-form").fadeOut(100);
        $('#buscar-form-link').removeClass('active');
        $(this).addClass('active');
        e.preventDefault();
    });

    $("body").on('click', "#buscar-form-link", function (e) {
        $("#buscar-form").delay(100).fadeIn(100);
        $("#agregar-form").fadeOut(100);
        $('#agregar-form-link').removeClass('active');
        $(this).addClass('active');
        e.preventDefault();
    });


    $("body").on('click', "#bt_buscar_filter", function() {
        filtroRecurso();
    });
    $("body").on('change', "#sl_fuente_filtro", function() {
        filtroRecurso();
    });
    // $("body").on('change', "#sl_estandar_recurso_filtro", function() {
    //     filtroRecurso();
    // });
    $("body").on('change', "#sl_origen_filtro", function() {
        filtroRecurso();
    });
    $("body").on('change', "#sl_herramienta_filtro", function() {
        filtroRecurso();
    });

    $('#modal-recurso').on('show.bs.modal', function (e) {
        filtroRecurso();
    });

    var filtroRecurso = function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _tipo = "Tabular";
        if (_tipo === undefined) {
            _tipo = "";
        }

        _post = $.post(_root_ + 'bdrecursos/index/_filtroRecursosDublin/webservices',
                {
                    tipo: _tipo,
                    nombre: $("#tb_nombre_filter").val(),
                    estandar: 3,
                    fuente: $("#sl_fuente_filtro").val(),
                    origen: $("#sl_origen_filtro").val(),
                    herramienta: $("#sl_herramienta_filtro").val()
                },
        function(data) {
            $("#cargando").hide();
            $("#lista_recursos_dublin").html('');
            $("#lista_recursos_dublin").html(data);
        });
    }
    //Fin modal, para seleccionar recurso


    $('body').on('click', '.bt_invocar', function() {
        //  var padre = this.parentElement;
        var r_tabla=0;
        var padre = this.parentElement;
        $(padre).find(".parametro");
        invocarWS($(this).attr("metodo"), $(padre).find(".parametro"), r_tabla);
    });
    $('body').on('click', '.bt_invocar_2', function() {
        //  var padre = this.parentElement;
        var r_tabla=$("#r_tabla").val();
        var padre = this.parentElement;
        $(padre).find(".parametro");
        invocarWS($(this).attr("metodo"), $(padre).find(".parametro"), r_tabla);
    });
});

function invocarWS(funcion, parametros, r_tabla) {
    var params = [];
    $(parametros).each(function(index) {
        params.push([$(this).attr("id"), $(this).val()]);
    });
    $("#cargando").show();
    $.post(_root_ + 'bdrecursos/import/_invocarWS',
            {ifuncion: funcion,
                iparametros: JSON.stringify(params),
                urlws:$("#hd_url_ws").val(),
                idrecurso:$("#hd_idrecurso").val(),
                r_tabla:r_tabla
            }, function(data, status, xhr) {
        $("#cargando").hide();
        $("#resultado_ws").html(data);
    });

}
