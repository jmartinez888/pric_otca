/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var msg = {
    success: function (text, stringify = false) {
        if (text)
            mensaje([['ok', stringify ? JSON.stringify(text) : text]])
    },
    error: function (text, stringify = false) {
        if (text)
            mensaje([['error', stringify ? JSON.stringify(text) : text]])
    }
}

function mensaje(resultado) {
    console.log(resultado)
    var error = "<div class='alert  alert-error alert-msg'><label class='label-msg'></label><a class='close' data-dismiss='alert'>x</a></div>"
    var ok = "<div class='alert alert-success alert-msg'><label class='label-msg'></label><a class='close' data-dismiss='alert'>x</a></div>"
    $("#_mensaje").removeClass("hide");

    if ($.isArray(resultado) && (!$.isEmptyObject(resultado))) {
        $.each(resultado, function(key, value) {

            if ($.isArray(value) && (!$.isEmptyObject(value))) {
                if (value[0] == "error") {
                    var div=$(error)
                    div.find('label').html(value[1]);
                    $("#_mensaje").append(div);
                } else if (value[0] == "ok") {
                    var div=$(ok)
                    div.find('label').html(value[1]);
                     $("#_mensaje").append(div);
                }
            } else {
                var div=$(error)
                if (value == "") {
                     div.find('label').html("Ocurrio un error vuelva a intentarlo luego: Error: " + value);
                } else {
                     div.find('label').html(resultado);
                }
                 $("#_mensaje").append(div);
            }
        });
    } else {
        $("#_mensaje").html(error);
        if (resultado == "") {
            $("#_mensaje").find('div').find('label').html("Ocurrio un error vuelva a intentarlo luego: Error: " + resultado);
        } else {
            $("#_mensaje").find('div').find('label').html(resultado);
        }
    }


}

function limpiarmensaje() {
    $("#_mensaje").html("");
}
