/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).on('ready', function () {

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


