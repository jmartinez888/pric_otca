/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

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
        var pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'ajax':nombrelista,'total_registros':total_registros,'filtro':datos,'tipo':$("#hdd_tipo").val()};
        
        $.post(_root_ + 'foro/index/_paginacion_ListaForo/' + datos, pagina, function (data) {
            $("#" + nombrelista).html('');
            $("#cargando").hide();
            $("#" + nombrelista).html(data);
        });
    } 

    $('body').on('click', '#buscar_foro', function () {
        buscarForo($("#text_busqueda").val(), $(this).attr("for_funcion"), $(this).attr("ajax"));
    });
});

function buscarForo(text_busqueda, for_funcion, ajax) {
    $("#cargando").show();
    $.post(_root_ + 'foro/index/_buscarForo',
    {
        text_busqueda:text_busqueda,
        for_funcion:for_funcion,
        ajax:ajax
    }, function (data) {
        $("#"+ajax).html('');
        $("#cargando").hide();
        $("#"+ajax).html(data);
    });
}

function tecla_enter_foro(evento)
{
    var iAscii;
    if (evento.keyCode)
    {
        iAscii = evento.keyCode;
    }  
    if (iAscii == 13) 
    {
        // buscarForo($("#text_busqueda").val());
        buscarForo($("#text_busqueda").val(), $("#hdd_tipo").val(),"lista_buscar_"+$("#hdd_tipo").val());
        evento.preventDefault();
    }
}


