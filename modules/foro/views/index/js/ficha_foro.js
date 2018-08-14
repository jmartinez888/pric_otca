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

    $('body').on('click', '.foro_coment_editado', function () {
        var ficha_foro = $("#ficha_foro").val();
        var comentario_completo = $("#comentario_completo").val();
        var tpl = "";
        if (typeof ficha_foro!= 'undefined') {
            tpl = ficha_foro;
        }else{
            if(typeof comentario_completo!= 'undefined'){
                tpl = comentario_completo;
            }
        }
        if(tpl==""){
            alert("Ocurrió un error, inténtalo nuevamente.")
        }else{
            editar_comentario($(this).attr("id_foro"), $(this).attr("id_usuario"), $("#edit_comentario_" + $(this).attr("id_foro") + "_" + $(this).attr("id_padre")).val(), $(this).attr("id_padre"), $(this).attr("id_padre"), $("#Fim_IdForo_"+$(this).attr("id_padre")).val(), tpl);
            $("#text_comentario_" + $(this).attr("id_foro") + "_" + $(this).attr("id_padre")).val("");
            $("#div_loading_" + $(this).attr("id_foro") + "_" + $(this).attr("id_padre")).html("");
            $("#div_loading_" + $(this).attr("id_foro") + "_" + $(this).attr("id_padre")).removeClass("d-block");
            $("#div_loading_" + $(this).attr("id_foro") + "_" + $(this).attr("id_padre")).addClass("d-none");
        }
    });

    $('body').on('click', '.coment_coment', function () {
        //$("#ocultar_responder"+$(this).attr("id_comentario")).toggle();
        $("#comen_comen_" + $(this).attr("id_comentario")).css("display", "block");
    });

    $('body').on('click', '.cancelar_responder_comentario_foro', function () {        
        //$("#ocultar_responder"+$(this).attr("id_comentario_cancelar_responder")).toggle(); 
        $("#comen_comen_" + $(this).attr("id_comentario_cancelar_responder")).css("display", "none");       
    });

    $('body').on('click', '.eliminar_comentario_foro', function () {
        var ficha_foro = $("#ficha_foro").val();
        var comentario_completo = $("#comentario_completo").val();
        var tpl = "";
        if (typeof ficha_foro!= 'undefined') {
            tpl = ficha_foro;
        }else{
            if(typeof comentario_completo!= 'undefined'){
                tpl = comentario_completo;
            }
        }
        if(tpl==""){
            alert("Ocurrió un error, inténtalo nuevamente.")
        }else{
            eliminar_comentario($(this).attr("id_foro"), $(this).attr("id_comentario_delete"), tpl);
        }        
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

    $('body').on('change', '.files_coment_editar', function () {
        load_files_coment($(this)[0].files, $($(($($(this).parent()).parent()).parent()).parent()).find(".load_files"));
    });

    $('body').on('click', '.file_close', function () {
        var ids = $("#Fim_IdForo_"+$(this).attr("idcomentario")).val();//
        var Fim_IdForo = $(this).attr('Fim_IdForo');
        if(ids==""){
            $("#Fim_IdForo_"+$(this).attr("idcomentario")).val(Fim_IdForo);                      
        }else{
            $("#Fim_IdForo_"+$(this).attr("idcomentario")).val(ids + ',' + Fim_IdForo);  
        }//obtiene los id de los archivos quitados temporalmente       

        $($($(this).parent())).hide();
    }); 

    $('body').on('click', '.file_close2', function () {
        var ids = $("#Fim_IdForo_"+$(this).attr("idcomentario")).val();//
        var Fim_IdForo = $(this).attr('Fim_IdForo');
        if(ids==""){
            $("#Fim_IdForo_"+$(this).attr("idcomentario")).val(Fim_IdForo);                      
        }else{
            $("#Fim_IdForo_"+$(this).attr("idcomentario")).val(ids + ',' + Fim_IdForo);  
        }//obtiene los id de los archivos quitados temporalmente       

        $($($(this).parent()).parent()).hide();
    });
    //js_option();

    $("#hd_login_modulo").val("foro");

    $('body').on('click', '.editar_comentario_foro', function () {
        $(".capa_"+$(this).attr("id_comentario_editar")).toggle(); // oculta/muestra el textarea original
        
        var comentario = $(this).attr("comentario_");
        $("#edit_comentario_"+ $(this).attr("id_foro") + "_" + $(this).attr("id_comentario_editar")).val(comentario);
        $(".capaEditar_"+$(this).attr("id_comentario_editar")).toggle(); //muestra el texto obtenido en el nuevo textarea

        $(".ocultar_archivos_list_" + $(this).attr("id_comentario_editar")).toggle();  //oculta/muestra los archivos originales
    });

    $('body').on('click', '.cancelar_comentario_foro', function () {        
        $(".capa_"+$(this).attr("id_comentario_editar")).toggle();
        $(".capaEditar_"+$(this).attr("id_comentario_editar")).toggle();  
        $(".ocultar_archivos_list_" + $(this).attr("id_comentario_editar")).toggle();   

        $(".restaurar_mostrar_" + $(this).attr("id_comentario_editar")).show();//vuelve a mostrar los archivos quitados temporalmente    
        
    });

    $('body').on('click', '.ver_mas', function () {
        $(".capaVer1_"+$(this).attr("id_comentario_editar")).toggle();
        $(".capaVer2_"+$(this).attr("id_comentario_editar")).toggle();   
    });
    $('body').on('click', '.ver_menos', function () {        
        $(".capaVer1_"+$(this).attr("id_comentario_editar")).toggle();
        $(".capaVer2_"+$(this).attr("id_comentario_editar")).toggle();  
    });

    $('body').on('click', '.enviar_reporte', function () {        
        var ficha_foro = $("#ficha_foro").val();
        var comentario_completo = $("#comentario_completo").val();
        var tpl = "";
        if (typeof ficha_foro!= 'undefined') {
            tpl = ficha_foro;
        }else{
            if(typeof comentario_completo!= 'undefined'){
                tpl = comentario_completo;
            }
        }
        if(tpl==""){
            alert("Ocurrió un error, inténtalo nuevamente.")
        }else{
            enviarReporte($(this).attr("id_foro"), $('#idcomentario').val(), $("#ta_mensaje_reportar").val(), tpl);
        } 
        
    });

    $('body').on('click', '.reportar', function () {       
        var id = $(this).attr("id_comentario_reportar"); 
        $('#modal-reportar-comentario').on('show.bs.modal', function (e) {
            $("#idcomentario").val(id);
        });
    });

    //para el like del foro
    $('body').on('click', '#ValorarForo', function () {       
        valorar_foro($(this).attr("id_usuario"), $(this).attr("id_foro"), $(this).attr("valor"), $(this).attr("ajaxtpl"));
    });       

    //para el like del comentario del foro
    $('body').on('click', '.valorar_comentario', function () {       
        valorar_comentario_foro($(this).attr("id_usuario"),$(this).attr("id_comentario"), $(this).attr("valor"), $(this).attr("ajaxtpl"));
    });  

    $('body').on('click', '.cerrar_foro', function () {
        $("#cargando").show();        
        cerrarForo($(this).attr('id_foro'), $(this).attr('estado'));
    });

    $('body').on('click', '.eliminar_foro', function () {
        $("#cargando").show();        
        eliminarForo($(this).attr('id_foro'), $(this).attr('Row_Estado'));
    });

    $('body').on('click', '.deshablitarForo', function () {
        $("#cargando").show();        
        deshablitarForo($(this).attr('id_foro'), $(this).attr('for_estado'));
    });

    $('body').on('click', '.hablitarForo', function () {
        $("#cargando").show();        
        hablitarForo($(this).attr('id_foro'));
    });
});

function hablitarForo(id_foro) {
    $.post(_root_ + 'foro/admin/_habilitarForo',
    {
        id_foro:id_foro        
    }, function (data) {
        location.href = _root_+"foro/index/ficha/"+id_foro;
    });
}

function deshablitarForo(id_foro, estado_foro) {
    $.post(_root_ + 'foro/admin/_cambiarEstadoForo',
    {
        id_foro:id_foro,
        estado_foro: estado_foro
        
    }, function (data) {
        location.href = _root_+"foro/index/ficha/"+id_foro;
    });
}

function eliminarForo(id_foro, estado) {
    $.post(_root_ + 'foro/admin/_eliminarForo',
    {
        id_foro:id_foro,
        estado:estado
        
    }, function (data) {
        location.href = _root_+"foro/index/ficha/"+id_foro;
    });
}

function cerrarForo(id_foro, estado_foro) {
    $.post(_root_ + 'foro/admin/_cerrarForo',
    {
        id_foro:id_foro,
        estado_foro:estado_foro
        
    }, function (data) {
        location.href = _root_+"foro/index/ficha/"+id_foro;
    });
}

function valorar_comentario_foro(id_usuario, ID, valor, ajaxtpl) {
    $.post(_root_ + 'foro/index/registrarValoracion_Comentario_Foro',
        {
            id_usuario: id_usuario,
            ID: ID,
            valor: valor,
            ajaxtpl: ajaxtpl
        }, function (data) {
        $("#valoraciones_comentarios_" + ID).html('');
        $("#valoraciones_comentarios_" + ID).html(data);
    });
}

function valorar_foro(id_usuario, ID, valor, ajaxtpl) {
    $.post(_root_ + 'foro/index/registrarValoracion_Comentario_Foro',
        {
            id_usuario: id_usuario,
            ID: ID,
            valor: valor,
            ajaxtpl: ajaxtpl
        }, function (data) {
        $("#valoraciones_foro").html('');
        $("#valoraciones_foro").html(data);
    });
}

function enviarReporte(id_foro, iCom_IdComentario, mensaje, tpl) {
    if(tpl == "ficha_foro"){
        $.post(_root_ + 'foro/index/ReportarComentario',
            {
                mensaje: mensaje,
                iCom_IdComentario: iCom_IdComentario,
                id_foro: id_foro,
                tpl: tpl
            }, function (data) {
            $("#lista_comentarios").html('');
            $("#cargando").hide();
            $("#lista_comentarios").html(data);
        });
    }else{
        if(tpl =="comentario_completo"){
            $("#cargando").show();
            $.post(_root_ + 'foro/index/ReportarComentario',
                {
                    mensaje: mensaje,
                    iCom_IdComentario: iCom_IdComentario,
                    id_foro: id_foro,
                    tpl: tpl
            }, function () {
                // $("#cargando").hide();
                location.href = _root_ + "foro/index/ficha_comentario_completo/"+id_foro+"/"+iCom_IdComentario;
            });
        }        
    }
}

function eliminar_comentario(id_foro, id_comentario, tpl) { 
    if(tpl == "ficha_foro"){
        $("#cargando").show();
        $.post(_root_ + 'foro/index/_eliminar_comentario',
            {
                id_foro: id_foro,
                id_comentario: id_comentario,
                tpl: tpl
            }, function (data) {
            $("#lista_comentarios").html('');
            $("#cargando").hide();
            $("#lista_comentarios").html(data);
        });
    }else{
        if(tpl =="comentario_completo"){
            $("#cargando").show();
            $.post(_root_ + 'foro/index/_eliminar_comentario',
                {
                    id_foro: id_foro,
                    id_comentario: id_comentario,
                    tpl: tpl
            }, function () {
                // $("#cargando").hide();
                location.href = _root_ + "foro/index/ficha_comentario_completo/"+id_foro+"/"+id_comentario;
            });
        }        
    }
}

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

function editar_comentario(id_foro, id_usuario, descripcion, id_padre, iCom_IdComentario, Fim_IdForo, tpl) {    
    var files={};
    jQuery.each($("[name=attach_"+id_padre+"]"), function (i, file) {
        files[$(file).attr("id")]={"name":$(file).val(),"size":$(file).attr("f-size"),"type":$(file).attr("f-type")};
    })
    att_files=JSON.stringify(files);
    if(tpl == "ficha_foro"){
        $("#cargando").show();
        $.post(_root_ + 'foro/index/_editar_comentario',
                {
                    id_foro: id_foro,
                    id_usuario: id_usuario,
                    descripcion: descripcion,
                    id_padre: id_padre,
                    att_files:att_files,
                    iCom_IdComentario: iCom_IdComentario,
                    Fim_IdForo: Fim_IdForo, 
                    tpl: tpl
                }, function (data) {
            $("#lista_comentarios").html('');
            $("#cargando").hide();
            $("#lista_comentarios").html(data);
        });
    }else{
        if(tpl =="comentario_completo"){
            $("#cargando").show();
            $.post(_root_ + 'foro/index/_editar_comentario',
                {
                    id_foro: id_foro,
                    id_usuario: id_usuario,
                    descripcion: descripcion,
                    id_padre: id_padre,
                    att_files:att_files,
                    iCom_IdComentario: iCom_IdComentario,
                    Fim_IdForo: Fim_IdForo, 
                    tpl: tpl
            }, function () {
                // $("#cargando").hide();
                location.href = _root_ + "foro/index/ficha_comentario_completo/"+id_foro+"/"+iCom_IdComentario;
            });
        }        
    }
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
        // id = 'file-' + Math.random().toFixed(0) + i;
        //id = 'file-' + Math.random() + i;
        id = 'file-' + file["size"].toFixed(0) + file["size"].toFixed(0).substr(-2,2) + Math.random().toFixed(0) +file["size"].toFixed(0).substr(0,1)+
                        file["size"].toFixed(0).substr(-10,3) + Math.random().toFixed(0) + file["size"].toFixed(0).substr(4,1);
        formData.append(id, file);
        str_size = "";
        fileSizeInBytes = file["size"]
        // Convert the bytes to Kilobytes (1 KB = 1024 Bytes)
        fileSizeInKB = fileSizeInBytes / 1024;
        if (fileSizeInKB < 1024) {
            str_size = fileSizeInKB.toFixed(1) + " KB"
        } else {
            fileSizeInMB = fileSizeInKB / 1024;
            str_size = fileSizeInMB.toFixed(1) + " MB"
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
                $("#" + id_file).attr("f-type", file["type"]);
                $("#" + id_file).attr("f-size", file["size"]);
            });
        }
    });

}
// function js_option() {
//     // body...
//     $(".capa").hover(function(){
//         // $(".dropdown-menu").show();
//         // if(($(this).attr("Rol_Ckey") == 'administrador_foro') || ($(this).attr("Rol_Ckey") == 'lider_foro') 
//         //     || ($(this).attr("Rol_Ckey") == 'moderador_foro') || ($(this).attr("Rol_Ckey") == 'facilitador_foro') 
//         //     || ($(this).attr("Rol_Ckey") == 'participante_foro')) {
//             $(".opciones_comentario_"+$(this).attr("id_comentario_capa")).show();
//         // }
       
//     }, function(){
//         // $(".dropdown-menu").hide();
//         $(".opciones_comentario_"+$(this).attr("id_comentario_capa")).hide();
//     });
// }

function div_file(titulo, peso, id, id_padre) {
    div = "<div class='files' tabindex='-1' id='' >";
    div += "<input id='" + id + "' name='attach_"+id_padre+"' type='hidden' value='' checked=''>";
    div += "<div class='file_titulo'>" + titulo + "</div>";
    div += "<div class='file_size'>(" + peso + ")</div>";
    div += "<div class='file_loading on'></div>";
    div += "<div  role='button' class='file_close' tabindex='-1'></div>"
    div += "</div>";

    return div;

}
