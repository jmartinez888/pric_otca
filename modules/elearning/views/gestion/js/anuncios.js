var _post = null;
var _Per_IdPermiso_ = 0;
$(document).on('ready', function () { 
$('#descripcion').ckeditor(function() { }, { });  
    $('#form3').validator().on('submit', function (e) {
    if (e.isDefaultPrevented()) {

    } else {

    }
    });
    
    $('body').on('click', '.pagina', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });
    $('body').on('change', '.s_filas', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });
    var paginacion = function (pagina, nombrelista, datos,total_registros) {
        var pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros,'idCurso':$("#idCurso").val(),'tipo':$("#tipo").val()};
        
        $.post(_root_ + 'elearning/gestion/_paginacion_' + nombrelista + '/' + datos, pagina, function (data) {
            $("#" + nombrelista).html('');
            $("#cargando").hide();
            $("#" + nombrelista).html(data);
        });
    }  
    
    $("body").on('click', ".idioma_s", function () {
        var id = $(this).attr("id");
        var idIdioma = $("#hd_" + id).val();
        gestionIdiomas($("#idRol").val(), $("#idIdiomaOriginal").val(), idIdioma);
    });

    $('#confirm-delete').on('show.bs.modal', function(e) { 
        var bookId = $(e.relatedTarget).data('book-id'); 
         $(e.currentTarget).find("#texto_").html(bookId);
    }); 

    $('#confirm-leer').on('hidden.bs.modal', function(e) {  
        // $.post(_root_ + 'elearning/gestion/_actualizar'+'/'+ bookId, function (data) { });
        $.post(_root_ + 'elearning/gestion/_actualizar',
                {                    
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraanuncio").val(),
                    filas:$("#s_filas_"+'listaranuncios').val(),
                    idCurso:$("#idCurso").val(),
                    tipo:$("#tipo").val()
                },
        function(data) {
            $("#listaranuncios").html('');
            $("#cargando").hide();
            $("#listaranuncios").html(data);
            // mensaje(JSON.parse(data));
        });
    }); 

    $('#confirm-leer').on('show.bs.modal', function(e) { 
        var bookId = $(e.relatedTarget).data('book-id'); 
         $(e.currentTarget).find("#titulo_").html(bookId);
         var bookTexto = $(e.relatedTarget).data('book-texto'); 
         $(e.currentTarget).find("#texto_").html(bookTexto);
         var bookIdAnuncio= $(e.relatedTarget).data('book-id-anuncio'); 
        $.post(_root_ + 'elearning/gestion/_marcar_leido' +'/'+ bookIdAnuncio, function (data) { });
    }); 

    //PERMISOS
    $("body").on('click', "#buscaranuncio", function () { 
        $("#cargando").show();       
        buscarAnuncio($("#palabraanuncio").val(),$("#idCurso").val(), $("#tipo").val());
    }); 

    $("body").on('click', '.estado-anuncio', function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_permiso = $(this).attr("id_anuncio");
        if (_id_permiso === undefined) {
            _id_permiso = 0;
        }
        _estado = $(this).attr("estado");
        if (_estado === undefined) {
            _estado = 0;
        }
        if (!_estado) {
            _estado = 0;
        }

        _post = $.post(_root_ + 'elearning/gestion/_cambiarEstadoAnuncio',
                {                    
                    _Anc_IdAnuncio: _id_permiso,
                    _Anc_Estado: _estado,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraanuncio").val(),
                    filas:$("#s_filas_"+'listaranuncios').val(),
                    idCurso:$("#idCurso").val(),
                    tipo:$("#tipo").val()
                },
        function(data) {
            $("#listaranuncios").html('');
            $("#cargando").hide();
            $("#listaranuncios").html(data);
            // mensaje(JSON.parse(data));
        });
    });

    $("body").on('click', '.confirmar-eliminar-anuncio', function() {
        
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_permiso = $(this).attr("id_anuncio");
        if (_id_permiso === undefined) {
            _id_permiso = 0;
        }

        _Anc_IdAnuncio_ = _id_permiso;
        _Row_Estado_ = 0;
    });

    $("body").on('click', '.eliminar_anuncio', function() {
        $("#cargando").show();
        // _Per_IdPermiso = _eliminar;
        _post = $.post(_root_ + 'elearning/gestion/_eliminarAnuncio',
                {                    
                    _Anc_IdAnuncio: _Anc_IdAnuncio_,
                    _Row_Estado: _Row_Estado_,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraanuncio").val(),
                    filas:$("#s_filas_"+'listaranuncios').val(),
                    idCurso:$("#idCurso").val(),
                    tipo:$("#tipo").val()
                },
        function(data) {
            $("#listaranuncios").html('');
            $("#cargando").hide();
            $("#listaranuncios").html(data);
        });
    });

    $("body").on('click', '.confirmar-habilitar-anuncio', function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_permiso = $(this).attr("id_anuncio");
        if (_id_permiso === undefined) {
            _id_permiso = 0;
        }

        _Per_IdPermiso_ = _id_permiso;
        _Row_Estado_ = 1;
        
        _post = $.post(_root_ + 'elearning/gestion/_eliminarAnuncio',
                {                    
                    _Anc_IdAnuncio: _Per_IdPermiso_,
                    _Row_Estado: _Row_Estado_,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraPermiso").val(),
                    filas:$("#s_filas_"+'listaranuncios').val(),
                    idCurso:$("#idCurso").val(),
                    tipo:$("#tipo").val()
                },
        function(data) {
            $("#listaranuncios").html('');
            $("#cargando").hide();
            $("#listaranuncios").html(data);
        });
    });
});

function buscarAnuncio(criterio,idCurso,tipo) {
    $("#cargando").show();
    $.post(_root_ + 'elearning/gestion/_buscarAnuncio',
    {
        palabra:criterio,
        idCurso:idCurso,
        tipo:tipo
    }, function (data) {
        $("#listaranuncios").html('');
        $("#cargando").hide();
        $("#listaranuncios").html(data);
    });
}

function gestionIdiomas(idrol, idIdiomaOriginal, idIdioma) {
    $("#cargando").show();
    $.post(_root_ + 'acl/index/gestion_idiomas_rol',
            {
                idrol: idrol,        
                idIdioma: idIdioma,
                idIdiomaOriginal: idIdiomaOriginal
            }, function (data) {
        $("#gestion_idiomas_rol").html('');
        $("#cargando").hide();
        $("#gestion_idiomas_rol").html(data);
        $('form').validator();
    });
}
