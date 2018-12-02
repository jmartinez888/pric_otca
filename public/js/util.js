/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

var msg = {
    count: 0,
    success: function (text, stringify = false, redirect = '') {
        if (text)
            mensaje([['ok', stringify ? JSON.stringify(text) : text, this.count++, redirect]])
    },
    error: function (text, stringify = false, redirect = '') {
        if (text)
            mensaje([[
                'error',
                stringify ? JSON.stringify(text) : text, this.count++, redirect]])
    }
}
var loading = {
    el: $('#cargando'),
    show: function () {
        this.el.show()
    },
    hide: function () {
      this.el.hide()
    }
}
function mensaje(resultado) {
    var error = "<div class='alert  alert-error alert-msg'><label class='label-msg'></label><a class='close' data-dismiss='alert'>x</a></div>"
    var ok = "<div class='alert alert-success alert-msg'><label class='label-msg'></label><a class='close' data-dismiss='alert'>x</a></div>"
    $("#_mensaje").removeClass("hide");

    if ($.isArray(resultado) && (!$.isEmptyObject(resultado))) {
        $.each(resultado, function(key, value) {
            var div;
            if ($.isArray(value) && (!$.isEmptyObject(value))) {
                if (value[0] == "error") {
                    div=$(error)
                    div.find('label').html(value[1]);
                    $("#_mensaje").append(div);
                } else if (value[0] == "ok") {
                    var div=$(ok)
                    div.find('label').html(value[1]);
                     $("#_mensaje").append(div);
                }
            } else {
                div=$(error)
                if (value == "") {
                     div.find('label').html("Ocurrio un error vuelva a intentarlo luego: Error: " + value);
                } else {
                     div.find('label').html(resultado);
                }
                 $("#_mensaje").append(div);
            }

            setTimeout(() => {
                div.remove()
                console.log(value)
                if (x !== "undefined" && value[3] != ''){
                    console.log('vere')
                    window.location.href = value[3]
                }
            }, 5000)
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
