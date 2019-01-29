$(document).ready(function() {
    var panels = $('.user-infos');
    var panelsButton = $('.dropdown-user');
    panels.hide();

    //Click dropdown
    panelsButton.click(function() {
        //get data-for attribute
        var dataFor = $(this).attr('data-for');
        var idFor = $(dataFor);

        //current button
        var currentButton = $(this);
        idFor.slideToggle(400, function() {
            //Completed slidetoggle
            if(idFor.is(':visible'))
            {
                currentButton.html('<i class="glyphicon glyphicon-chevron-up text-muted"></i>');
            }
            else
            {
                currentButton.html('<i class="glyphicon glyphicon-chevron-down text-muted"></i>');
            }
        })
    });
    $("body").on('click', "#btn_editContra", function () {
        editContraDiv($("#idusuario").val());
    });

    $('[data-toggle="tooltip"]').tooltip();

    $('button').click(function(e) {
        e.preventDefault();
        // alert("This is a demo.\n :-)");
    });

    $("#btnCambiarImg").click(function(e){
        e.preventDefault();
        var params = {
            route: "files/usuarios/img",
            pre: $("#idusuario").val()
        };
        InitUploader(function(a){
            var json = JSON.parse(a);
            var url = _root_ + "elearning/usuario/_actualizar_img"; 
            var data = { id: $("#idusuario").val(), img: json.data[0].url };
            //alert(url);
            $.ajax({
                url: url,
                data: data,
                type: "post",
                success: function(a){
                    var data = JSON.parse(a);
                    $("#perfil-img").attr("src", _root_ +
                        "files/usuarios/img/" + data.mensaje);
                }
            });

        }, params);
    });

});

function editContraDiv(idusuario) {        
    $.post(_root_ + 'usuarios/index/divEditContra',
    {        
        idusuario:idusuario
    }, function (data) {
        $("#editarContrasena").html('');
        $("#editarContrasena").html(data);
        $('form').validator();
    });
}