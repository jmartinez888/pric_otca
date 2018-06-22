var _post = null;
var _Per_IdPermiso_ = 0;
$(document).on('ready', function () {   
    $('#form3').validator().on('submit', function (e) {
    if (e.isDefaultPrevented()) {

    } else {

    }
    });
    // $('#tablas').dataTable( {
    //     responsive: true
    // } );
    // $('.mitooltip').tooltip();
    // $(function() {
    //     $("[data-toggle='tooltip']").tooltip();
    // });
    
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
        
        $.post(_root_ + 'elearning/certificado/_paginacion_' + nombrelista + '/' + datos, pagina, function (data) {
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

    //PERMISOS
    $("body").on('click', "#buscarcertificado", function () { 
        $("#cargando").show();       
        buscarPermiso($("#palabracertificado").val());
    }); 

    $("body").on('click', "#buscarcertificadootros", function () { 
        $("#cargando").show();       
        buscarOtros($("#palabracertificado").val());
    }); 

   
});

function buscarPermiso(criterio) {
    $("#cargando").show();
    $.post(_root_ + 'elearning/certificado/_buscarcertificado',
    {
        palabra:criterio
        
    }, function (data) {
        $("#listarcertificados").html('');
        $("#cargando").hide();
        $("#listarcertificados").html(data);
    });
}

function buscarOtros(criterio) {
    $("#cargando").show();
    $.post(_root_ + 'elearning/certificado/_buscarcertificadootros',
    {
        palabra:criterio
        
    }, function (data) {
        $("#listarcertificados").html('');
        $("#cargando").hide();
        $("#listarcertificados").html(data);
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
