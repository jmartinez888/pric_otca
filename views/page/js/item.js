$(document).on('ready', function () {

    if (!!($('#attachments').attr('title'))) {
        $("#cargando").show();
        var palabra = 'palabra=' + $('#attachments').attr('title');
        $.post(_root_ + 'page/attachments', palabra, function (data) {
            $("#attachments").html(''); 
            $("#cargando").hide();
            $("#attachments").html(data);
            attach_dublin();
            attach_legal();
            attach_geografico();
            attach_otros_recursos();
           
        });
    };

});

function attach_dublin()
{
     if (!!($('#attachments_dublin').attr('title'))) {
        //$("#cargando").show();
        var palabra = 'palabra=' + $('#attachments_dublin').attr('title');
        $.post(_root_ + 'dublincore/documentos/embed_dublincore', palabra, function (data) {
            $("#attachments_dublin").html(''); 
            //$("#cargando").hide();
            $("#attachments_dublin").html(data);
             $('[data-toggle="tooltip"]').tooltip();
            });
        };

}

function attach_legal(){
    if (!!($('#attachments_legal').attr('title'))) {
        //$("#cargando").show();
        var palabra = 'palabra=' + $('#attachments_legal').attr('title');
        $.post(_root_ + 'legislacion/legal/embed_legal', palabra, function (data) {
            $("#attachments_legal").html(''); 
            //$("#cargando").hide();
            $("#attachments_legal").html(data);
           $('[data-toggle="tooltip"]').tooltip();
            });
        };

}

function attach_geografico(){
    if (!!($('#attachments_inf_geografica').attr('title'))) {
        //$("#cargando").show();
        var palabra = 'palabra=' + $('#attachments_inf_geografica').attr('title');
        $.post(_root_ + 'mapa/embed_info_geografica', palabra, function (data) {
            $("#attachments_inf_geografica").html(''); 
            //$("#cargando").hide();
            $("#attachments_inf_geografica").html(data);
           $('[data-toggle="tooltip"]').tooltip();
            });
        };

}
function attach_otros_recursos(){
    if (!!($('#attachments_otros_recursos').attr('title'))) {
        //$("#cargando").show();
        var palabra = 'palabra=' + $('#attachments_otros_recursos').attr('title');
        $.post(_root_ + 'bdrecursos/index/embed_otros_recursos', palabra, function (data) {
            $("#attachments_otros_recursos").html(''); 
            //$("#cargando").hide();
            $("#attachments_otros_recursos").html(data);
           $('[data-toggle="tooltip"]').tooltip();
            });
        };
}