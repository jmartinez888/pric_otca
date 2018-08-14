var _post = null;
var _Per_IdPermiso_ = 0;
$(document).on('ready', function () {   
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
        var pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros};
        
        $.post(_root_ + _modulo_ + '/cursos/_paginacion_' + nombrelista + '/' + datos, pagina, function (data) {
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

    
    $("body").on('click', "#btn_gestion", function () { 
        // $("#cargando").show();       
        gestionCurso($(this).attr("id_curso"));
        alert($(this).attr("id_curso"))
    }); 

    $("body").on('click', '.estado-permiso', function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_permiso = $(this).attr("id_permiso");
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

        _post = $.post(_root_ + 'acl/index/_cambiarEstadoPermisos',
                {                    
                    _Per_IdPermiso: _id_permiso,
                    _Per_Estado: _estado,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraPermiso").val(),
                    filas:$("#s_filas_"+'listarPermisos').val()
                },
        function(data) {
            $("#listarPermisos").html('');
            $("#cargando").hide();
            $("#listarPermisos").html(data);
            // mensaje(JSON.parse(data));
        });
    });
});
function gestionCurso(id_curso) {
    location.href = _root_ + _modulo_ + "/gestion/matriculados/" + id_curso;
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
