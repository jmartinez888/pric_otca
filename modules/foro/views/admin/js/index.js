var _post = null;
var _Per_IdPermiso_ = 0;
$(document).on('ready', function () {   

    $('body').on('click', '.pagina', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });
    $('body').on('change', '.s_filas', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });
    var paginacion = function (pagina, nombrelista, datos,total_registros) {
        var pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros,'filtro':datos};
        
        $.post(_root_ + 'foro/admin/_paginacion_' + nombrelista + '/' + datos, pagina, function (data) {
            $("#" + nombrelista).html('');
            $("#cargando").hide();
            $("#" + nombrelista).html(data);
        });
    } 
    
     $('body').on('click', '#buscar_foro', function () {
        $("#cargando").show();
        buscarForo($("#text_busqueda").val(), $("#select_busqueda").val());
    });

     $('body').on('change', '#select_busqueda', function () {
        $("#cargando").show();
        buscarForo($("#text_busqueda").val(), $("#select_busqueda").val());
    });
    $('body').on('click', '.cerrar_foro', function () {
        $("#cargando").show();        
        cerrarForo($(this).attr('id_foro'), $(this).attr('estado'), $("#text_busqueda").val(),$(".pagination li.active span").html(),$(".pagination li a.pagina").attr("total_registros"));
    });
    $('body').on('click', '.cambiar_estado', function () {
        $("#cargando").show();        
        cambiarEstadoForo($(this).attr('id_foro'),$(this).attr('estado'),$("#text_busqueda").val(),$(".pagination li.active span").html(),$(".pagination li a.pagina").attr("total_registros"));
    });
    $('body').on('click', '.eliminar_foro', function () {
        $("#cargando").show();        
        eliminarForo($(this).attr('id_foro'),$("#text_busqueda").val(),$(".pagination li.active span").html(),$(".pagination li a.pagina").attr("total_registros"), $(this).attr("estado"));
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
        var pagina = {'pagina':pagina,'filtro2':$("#select_busqueda").val(),'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros};
        
        $.post(_root_ + 'foro/admin/_paginacion_' + nombrelista + '/' + datos, pagina, function (data) {
            $("#" + nombrelista).html('');
            $("#cargando").hide();
            $("#" + nombrelista).html(data);
        });
    }  
    
});
function buscarForo(criterio, criterio2) {
    $.post(_root_ + 'foro/admin/_buscarForo',
    {
        filtro:criterio,
        filtro2:criterio2
        
    }, function (data) {
        $("#listarForo").html('');
        $("#cargando").hide();
        $("#listarForo").html(data);
    });
}
function cerrarForo(id_foro,estado_foro,criterio,pagina,total_registros) {
    $.post(_root_ + 'foro/admin/_cerrarForo',
    {
        id_foro:id_foro,
        estado_foro:estado_foro,
        filtro:criterio,
        pagina:pagina,
        filas:$("#s_filas_listarForo").val(),
        total_registros:total_registros
        
    }, function (data) {
        $("#listarForo").html('');
        $("#cargando").hide();
        $("#listarForo").html(data);
    });
}

function cambiarEstadoForo(id_foro,estado_foro,criterio,pagina,total_registros) {
    $.post(_root_ + 'foro/admin/_cambiarEstadoForo',
    {
        id_foro:id_foro,
        estado_foro:estado_foro,        
        filtro:criterio,
        pagina:pagina,
        filas:$("#s_filas_listarForo").val(),
        total_registros:total_registros
        
        
    }, function (data) {
        $("#listarForo").html('');
        $("#cargando").hide();
        $("#listarForo").html(data);
    });
}
function eliminarForo(id_foro,criterio,pagina,total_registros, estado) {
    $.post(_root_ + 'foro/admin/_eliminarForo',
    {
        id_foro:id_foro,
        filtro:criterio,
        pagina:pagina,
        filas:$("#s_filas_listarForo").val(),
        total_registros:total_registros,
        estado: estado
        
    }, function (data) {
        $("#listarForo").html('');
        $("#cargando").hide();
        $("#listarForo").html(data);
    });
}
