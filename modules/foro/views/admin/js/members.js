var _post = null;
var _Per_IdPermiso_ = 0;
$(document).on('ready', function () {

    $('body').on('click', '.pagina', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"), $(this).attr("total_registros"), $("ul.nav-tabs li.active a.tab_member").attr("id_foro"), $("ul.nav-tabs li.active a.tab_member").attr("rol_member"));
    });
    $('body').on('change', '.s_filas', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"), $(this).attr("total_registros"), $("ul.nav-tabs li.active a.tab_member").attr("id_foro"), $("ul.nav-tabs li.active a.tab_member").attr("rol_member"));
    });
    var paginacion = function (pagina, nombrelista, datos, total_registros, id_foro, rol_member) {
        var pagina = {'pagina': pagina, 'filas': $("#s_filas_" + nombrelista).val(), 'total_registros': total_registros, 'filtro': datos, 'id_foro': id_foro, 'rol_member': rol_member};

        $.post(_root_ + 'foro/admin/_paginacion_' + nombrelista + '/' + datos, pagina, function (data) {
            $("#" + nombrelista).html('');
            $("#cargando").hide();
            $("#" + nombrelista).html(data);
        });
    }
    $('body').on('click', '.tab_member', function () {
        $("#cargando").show();
        cargar_members_tab($(this).attr("id_foro"), $(this).attr("rol_member"));
    });

    $('body').on('click', '#buscar_miembro_foro', function () {
        $("#cargando").show();
        buscar_miembro_foro();
    });

    $('body').on('click', '.cambiar_estado', function () {
        $("#cargando").show();
        cambiarEstadoMember($(this).attr('id_usuario'), $(this).attr('id_foro'), $(this).attr('estado'), "", $(".pagination li.active span").html(), $("#s_filas_listaMembers").attr("total_registros"));
    });
    $('body').on('click', '.eliminar_miembro', function () {
        $("#cargando").show();
        eliminarMember($(this).attr('id_usuario'), $(this).attr('id_foro'), "", $(".pagination li.active span").html(), $("#s_filas_listaMembers").attr("total_registros"));
    });

    $('body').on('click', '#bt_buscar_user_foro', function () {
        $("#cargando").show();
        buscar_user_foro($(this).attr('id_foro'));
    });

    $('body').on('click', '#bt_asignar_usuario', function () {
        $("#cargando").show();
        var ckey_usuario = $("#ckey").val();
        var ckey_guardar = $("#s_lista_rol_foro option:selected").attr("ckey");

        if(ckey_usuario == "facilitador_foro"){
            if(ckey_usuario == "facilitador_foro" && ckey_guardar == "participante_foro"){
                asignar_user_to_member($("input[name='rd_member_select']:checked").val(), $(this).attr("id_foro"), $("#s_lista_rol_foro").val(), $("#s_lista_rol_foro option:selected").attr("ckey"));
            }else{
                alert("Sin permiso");
                $("#cargando").hide();
            }
        }else{
            if(ckey_usuario == "moderador_foro"){
                 if(ckey_usuario == "moderador_foro" && (ckey_guardar == "participante_foro" || ckey_guardar == "facilitador_foro" || ckey_guardar == "moderador_foro") ){
                    asignar_user_to_member($("input[name='rd_member_select']:checked").val(), $(this).attr("id_foro"), $("#s_lista_rol_foro").val(), $("#s_lista_rol_foro option:selected").attr("ckey"));
                }else{
                    alert("Sin permiso");
                    $("#cargando").hide();                    
                }
            }else{
                if(ckey_usuario == "lider_foro"){
                    if(ckey_usuario == "lider_foro" && (ckey_guardar == "participante_foro" || ckey_guardar == "facilitador_foro" || ckey_guardar == "moderador_foro" || ckey_guardar == "lider_foro")){
                        asignar_user_to_member($("input[name='rd_member_select']:checked").val(), $(this).attr("id_foro"), $("#s_lista_rol_foro").val(), $("#s_lista_rol_foro option:selected").attr("ckey"));
                    }else{
                        alert("Sin permiso");
                        $("#cargando").hide();
                    }
                }else{
                    if(ckey_usuario == "administrador_foro"){
                        asignar_user_to_member($("input[name='rd_member_select']:checked").val(), $(this).attr("id_foro"), $("#s_lista_rol_foro").val(), $("#s_lista_rol_foro option:selected").attr("ckey"));
                    }else{
                        if(ckey_usuario == "administrador"){
                            asignar_user_to_member($("input[name='rd_member_select']:checked").val(), $(this).attr("id_foro"), $("#s_lista_rol_foro").val(), $("#s_lista_rol_foro option:selected").attr("ckey"));
                        }else{
                            alert("Sin permiso");
                            $("#cargando").hide();
                        }
                    }
                }                
            }
        }       
             
    });
    $('body').on('click', '.permisos_member', function () {
        $("#cargando").show();
        cargar_permisos_member($(this).attr('id_foro'), $(this).attr('id_usuario'),$(this).attr('id_rol'));
    });
     $('body').on('click', '.rcb_permisos', function () {
        $("#cargando").show();
        actualizar_permisos_member($(this).attr('id_foro'), $(this).attr('id_usuario'),$(this).attr('id_permiso'),$(this).val());
    });

    /*$('#ta_mensaje_usuario' ).ckeditor( {
     creator: 'inline'
     } );
     */



});

function cargar_members_tab(id_foro, rol_member) {
    $.post(_root_ + 'foro/admin/_tab_members',
            {
                'id_foro': id_foro, 
                'rol_member': rol_member
            },
    function (data) {
        $("#listaMembers").html('');
        $("#cargando").hide();
        $("#listaMembers").html(data);
    });
}

function buscar_miembro_foro() {
    $.post(_root_ + 'foro/admin/_tab_members_buscar',
            {
                'filtro': $("#text_busqueda_miembro").val()
            },
    function (data) {
        $("#listaMembers").html('');
        $("#cargando").hide();
        $("#listaMembers").html(data);
    });
}

function cambiarEstadoMember(id_usuario, id_foro, estado_member, criterio, pagina, total_registros) {
    $.post(_root_ + 'foro/admin/_cambiarEstadoMember',
            {
                id_usuario: id_usuario,
                id_foro: id_foro,
                rol_member: $("ul.nav-tabs li.active a.tab_member").attr("rol_member"),
                estado_member: estado_member,
                filtro: criterio,
                pagina: pagina,
                filas: $("#s_filas_listaMembers").val(),
                total_registros: total_registros
            }, function (data) {
        $("#listaMembers").html('');
        $("#cargando").hide();
        $("#listaMembers").html(data);
    });
}
function eliminarMember(id_usuario, id_foro, criterio, pagina, total_registros) {
    $.post(_root_ + 'foro/admin/_eliminarMember',
            {
                id_usuario: id_usuario,
                id_foro: id_foro,
                rol_member: $("ul.nav-tabs li.active a.tab_member").attr("rol_member"),
                filtro: criterio,
                pagina: pagina,
                filas: $("#s_filas_listaMembers").val(),
                total_registros: total_registros

            }, function (data) {
        $("#listaMembers").html('');
        $("#cargando").hide();
        $("#listaMembers").html(data);
    });
}

function buscar_user_foro(id_foro) {
    $.post(_root_ + 'foro/admin/_buscar_user_foro',
            {
                selec_rol: $("#s_lista_rol_foro").val(),
                tb_filtro_bus: $("#tb_buscar_usuario").val(),
                id_foro:id_foro
            }, function (data) {
        $("#lista_member_select").html('');
        $("#cargando").hide();
        $("#lista_member_select").html(data);
    });
}

function asignar_user_to_member(id_usuario, id_foro, id_rol, ckey_rol) {
      $("#lista_member_select").html('');
    $.post(_root_ + 'foro/admin/_asignarUserMember',
            {
                'id_usuario': id_usuario, 
                'id_foro': id_foro, 
                'id_rol': id_rol, 
                'ckey_rol': ckey_rol,
                'mensaje':$('#ta_mensaje_usuario').val()
            },
    function (data) {
        $("#listaMembers").html('');
        $("#cargando").hide();
        $("#listaMembers").html(data);

        $($("ul.nav-tabs li.active a.tab_member").parent()).removeClass("active");
        $($("a[rol_member='" + ckey_rol + "']").parent()).addClass("active");

    });
}

function cargar_permisos_member(id_foro,id_user,id_rol) {
     $.post(_root_ + 'foro/admin/_getPermisosMember',
            {'id_foro': id_foro, 'id_user': id_user, 'id_rol': id_rol},
    function (data) {
        $("#listaPermisosMember").html('');
        $("#cargando").hide();
        $("#listaPermisosMember").html(data);
    });
}
function actualizar_permisos_member(id_foro,id_user,id_permiso,estado) {
     $.post(_root_ + 'foro/admin/_updatePermisoMember',
            {'id_foro': id_foro, 'id_user': id_user, 'id_permiso': id_permiso,'estado':estado},
    function (data) {
         $("#cargando").hide();
        alert(data);
    });
}