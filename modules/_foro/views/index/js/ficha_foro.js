/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).on('ready', function () {

    $('body').on('click', '.foro_coment', function () {
        regitrar_comentario($(this).attr("id_foro"), $(this).attr("id_usuario"), $("#text_comentario_" + $(this).attr("id_foro") + "_" + $(this).attr("id_padre")).val(), $(this).attr("id_padre"));
        $("#text_comentario_" + $(this).attr("id_foro") + "_" + $(this).attr("id_padre")).val("");
        $("#div_loading_" + $(this).attr("id_foro") + "_" + $(this).attr("id_padre")).html("");
        $("#div_loading_" + $(this).attr("id_foro") + "_" + $(this).attr("id_padre")).removeClass("d-block");
        $("#div_loading_" + $(this).attr("id_foro") + "_" + $(this).attr("id_padre")).addClass("d-none");

    });
    $('body').on('click', '.coment_coment', function () {

        $("#comen_comen_" + $(this).attr("id_comentario")).css("display", "block");
    });
    $('body').on('click', '.btn_registro_user', function () {
        $("[name=register-form-link]").addClass("active");
        $("[name=login-form-link]").removeClass("active");
    });
    $('body').on('click', '.btn_login_user', function () {
        $("[name=register-form-link]").removeClass("active");
        $("[name=login-form-link]").addClass("active");
    });
    $('body').on('click', '.inscribir_foro', function () {
        inscribir_participante_foro($(this).attr("id_foro"));
    });
    $('body').on('change', '.files_coment', function () {
        load_files_coment($(this)[0].files, $($(($($(this).parent()).parent()).parent()).parent()).find(".load_files"));
    });

    $('body').on('click', '.file_close', function () {
        id_padre = $($($(this).parent()).parent()).attr("id");
        $($(this).parent()).remove();
        if ($("#" + id_padre).html().trim() == "") {
            $("#" + id_padre).removeClass()("d-block")
            $("#" + id_padre).addClass("d-none")
        }
    });

    $("#hd_login_modulo").val("foro");
});
function regitrar_comentario(id_foro, id_usuario, descripcion, id_padre) {
    $("#cargando").show();
    var files={};
    jQuery.each($("[name=attach_"+id_padre+"]"), function (i, file) {
        files[$(file).attr("id")]={"name":$(file).val(),"size":$(file).attr("f-size"),"type":$(file).attr("f-type")};
    })
    att_files=JSON.stringify(files);
    $.post(_root_ + 'foro/index/_registro_comentario',
            {
                id_foro: id_foro,
                id_usuario: id_usuario,
                descripcion: descripcion,
                id_padre: id_padre,
                att_files:att_files
            }, function (data) {
        $("#lista_comentarios").html('');
        $("#cargando").hide();
        $("#lista_comentarios").html(data);
    });

}
function inscribir_participante_foro(id_foro) {
    $("#cargando").show();
    $.post(_root_ + 'foro/index/_inscribir_participante_foro',
            {
                id_foro: id_foro
            }, function (data) {
        result = JSON.parse(data);
        location.href = _root_ + "foro/index/ficha/" + result["id_foro"];
    });
}

function load_files_coment(file, div_conte) {
    var formData = new FormData();
    $(div_conte).removeClass("d-none");
    $(div_conte).addClass("d-block");
    var add_div = $(div_conte).html();
    jQuery.each(file, function (i, file) {
        id = 'file-' + Math.random().toFixed(0) + i;
        formData.append(id, file);
        str_size = "";
        fileSizeInBytes = file["size"]
        // Convert the bytes to Kilobytes (1 KB = 1024 Bytes)
        fileSizeInKB = fileSizeInBytes / 1024;
        if (fileSizeInKB < 1) {
            str_size = fileSizeInKB.toFixed(3) + " K"
        } else {
            fileSizeInMB = fileSizeInKB / 1024;
            str_size = fileSizeInMB.toFixed(3) + " M"
        }
        // Convert the KB to MegaBytes (1 MB = 1024 KBytes)

        add_div += div_file(file["name"], str_size, id,$(div_conte).attr("id_padre"));
    });
    $(div_conte).html(add_div);
    $.ajax({
        url: _root_ + 'foro/index/_load_file_coment',
        type: 'POST',
        data: formData,
        processData: false, // tell jQuery not to process the data
        contentType: false, // tell jQuery not to set contentType
        success: function (data) {
            $(".file_loading").removeClass("on");
            $(".file_loading").addClass("off");
            result = JSON.parse(data);
            jQuery.each(result, function (i, file) {
                id_file = file["id"];
                $("#" + id_file).val(file["name"]);
                $("#" + id_file).attr("f-size", file["size"]);
                $("#" + id_file).attr("f-type", file["type"]);


            });
        }
    });

}

function div_file(titulo, peso, id,id_padre) {
    div = "<div class='files' tabindex='-1' id='' >";
    div += "<input id='" + id + "' name='attach_"+id_padre+"' type='hidden' value='' checked=''>";
    div += "<div class='file_titulo'>" + titulo + "</div>";
    div += "<div class='file_size'>(" + peso + ")</div>";
    div += "<div class='file_loading on'></div>";
    div += "<div  role='button' class='file_close' tabindex='-1'></div>"
    div += "</div>";

    return div;

}
