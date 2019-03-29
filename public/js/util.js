function makeTemplate (template_id, view_object = {}) {
    let template_tag = document.getElementById(template_id)
    if (typeof Mustache != 'undefined' && template_tag != null) {
        return Mustache.render(template_tag.innerHTML, view_object)
    }
    return ''
}

function parseData(data) {
    let f = new FormData();
    for(let x in data) {
        f.append(x, data[x])
    }
    return f;
}
/**
 * [getContentMeta obtiene contenido en meta-tag]
 *
 * @return  {[String]}  [return String]
 */
function getContentMeta (name, return_dom_object = false) {
    return return_dom_object ? document.head.querySelector(`meta[name="${name}"]`) : document.head.querySelector(`meta[name="${name}"]`).content
}
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

function decodeHTML (html) {
	var txt = document.createElement('textarea');
	txt.innerHTML = html;
	return txt.value;
};
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
                if (value[3] !== undefined && value[3] != ''){
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
