var _post = null;
var _Per_IdPermiso_ = 0;
$(document).on('ready', function () {   
    $('#seccion_filtros').hide();
    $('#desactivar_avanzado').hide();
    
    // $('.mitooltip').tooltip();
    // $(function() {
    //     $("[data-toggle='tooltip']").tooltip();
    // });
    
    $('#selectPais').on('change', function () {

        // var src='public/img/legal/';
        // if($("#selectPais").val()=='Perú')
        //     src=src+'Perú.png';
        // else if($("#selectPais").val()=='Brasil')
        //     src=src+'Brasil.png';

            $("#banderita").attr('src', _root_+'public/img/legal/'+$("#selectPais").val()+'.png');
            if ($("#selectPais").val()=='--Seleccione--') {$("#banderita").attr('src', '');}
    });
    
    $('body').on('click', '.pagina', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });
    $('body').on('change', '.s_filas', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });
    var paginacion = function (pagina, nombrelista, datos,total_registros) {
        
        var pais_buscado = $('#pais_buscado').val(); 
        var datos_buscado = $('#datos_buscado').val();  
        var proyectos_buscado = $('#proyectos_buscado').val();
        var ofertas_buscado = $('#ofertas_buscado').val();
        var especializaciones = $('#especializaciones').val();
        var maestrias = $('#maestrias').val();
        var doctorados = $('#doctorados').val();
        
        if(!pais_buscado && !datos_buscado && !proyectos_buscado && !ofertas_buscado && !especializaciones && !maestrias && !doctorados){
            
            var pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros};

            $.post(_root_ + 'oferta/index/_paginacion_' + nombrelista + '/' + datos, pagina, function (data) {
                $("#" + nombrelista).html('');
                $("#cargando").hide();
                $("#" + nombrelista).html(data);
            });  

        }else{
            if(!pais_buscado){pais_buscado='all'}
            if(!datos_buscado){datos_buscado='all'}
            if(!proyectos_buscado){proyectos_buscado='all'}
            if(!ofertas_buscado){ofertas_buscado='all'}
            if(!especializaciones){especializaciones='all'}
            if(!maestrias){maestrias='all'}
            if(!doctorados){doctorados='all'}

            var pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros};
            /*var _post_ = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'pais_buscado':pais_buscado,'datos_buscado':datos_buscado,'proyectos_buscado':proyectos_buscado,
            'ofertas_buscado':ofertas_buscado,'especializaciones':especializaciones,'maestrias':maestrias,'doctorados':doctorados,'total_registros':total_registros};
            */
            $.post(_root_ + 'oferta/index/_paginacion_' + nombrelista + '/' + pais_buscado + '/' + datos_buscado + '/'+ proyectos_buscado + '/'+ ofertas_buscado + '/'+ especializaciones + '/'+ maestrias + '/'+ doctorados, pagina, function (data) {
                $("#listarInstituciones").html('');
                $("#cargando").hide();
                $("#listarInstituciones").html(data);
            });
        }
    }  
    
    $("body").on('click', ".idioma_s", function () {
        var id = $(this).attr("id");
        var idIdioma = $("#hd_" + id).val();
        gestionIdiomas($("#idRol").val(), $("#idIdiomaOriginal").val(), idIdioma);
    });

    $('#confirm-delete').on('show.bs.modal', function(e) { 
        var bookId = $(e.relatedTarget).data('book-id'); 
         $(e.currentTarget).find("#texto_").html(bookId);
    }); 

    //PERMISOS
    $("body").on('click', "#buscarPermiso", function () { 
        $("#cargando").show();       
        buscarPermiso($("#palabraPermiso").val());
    }); 

    $("body").on('click', '.estado-permiso', function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_permiso = $(this).attr("id_permiso");
        if (_id_permiso === undefined) {
            _id_permiso = 0;
        }
        _estado = $(this).attr("estado");
        if (_estado === undefined) {
            _estado = 0;
        }
        if (!_estado) {
            _estado = 0;
        }

        _post = $.post(_root_ + 'acl/index/_cambiarEstadoPermisos',
                {                    
                    _Per_IdPermiso: _id_permiso,
                    _Per_Estado: _estado,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraPermiso").val(),
                    filas:$("#s_filas_"+'listarPermisos').val()
                },
        function(data) {
            $("#listarPermisos").html('');
            $("#cargando").hide();
            $("#listarPermisos").html(data);
            // mensaje(JSON.parse(data));
        });
    });

    $("body").on('click', '.confirmar-eliminar-permiso', function() {
        
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_permiso = $(this).attr("id_permiso");
        if (_id_permiso === undefined) {
            _id_permiso = 0;
        }

        _Per_IdPermiso_ = _id_permiso;
        _Per_Eliminar_ = 0;
    });

    $("body").on('click', '.eliminar_permiso', function() {
        $("#cargando").show();
        // _Per_IdPermiso = _eliminar;
        _post = $.post(_root_ + 'acl/index/_eliminarPermiso',
                {                    
                    _Per_IdPermiso: _Per_IdPermiso_,
                    _Per_Eliminar: _Per_Eliminar_,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraPermiso").val(),
                    filas:$("#s_filas_"+'listarPermisos').val()
                },
        function(data) {
            $("#listarPermisos").html('');
            $("#cargando").hide();
            $("#listarPermisos").html(data);
        });
    });

    $("body").on('click', '.confirmar-habilitar-permiso', function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_permiso = $(this).attr("id_permiso");
        if (_id_permiso === undefined) {
            _id_permiso = 0;
        }

        _Per_IdPermiso_ = _id_permiso;
        _Per_Eliminar_ = 1;
        
        _post = $.post(_root_ + 'acl/index/_eliminarPermiso',
                {                    
                    _Per_IdPermiso: _Per_IdPermiso_,
                    _Per_Eliminar: _Per_Eliminar_,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraPermiso").val(),
                    filas:$("#s_filas_"+'listarPermisos').val()
                },
        function(data) {
            $("#listarPermisos").html('');
            $("#cargando").hide();
            $("#listarPermisos").html(data);
        });
    });


    //----------------------ROLES-------------------//
    $("body").on('click', "#buscar", function () {  
        $("#cargando").show();     
        buscarRol($("#palabraRol").val());
    });

    $("body").on('click', '.estado-rol', function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_rol = $(this).attr("id_rol");
        if (_id_rol === undefined) {
            _id_rol = 0;
        }
        _estado = $(this).attr("estado");
        if (_estado === undefined) {
            _estado = 0;
        }
        if (!_estado) {
            _estado = 0;
        }

        _post = $.post(_root_ + 'acl/index/_cambiarEstadoRol',
                {                    
                    _Rol_IdRol: _id_rol,
                    _Rol_Estado: _estado,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraRol").val(),
                    filas:$("#s_filas_"+'listarRoles').val()
                },
        function(data) {
            $("#listarRoles").html('');
            $("#cargando").hide();
            $("#listarRoles").html(data);
            // mensaje(JSON.parse(data));
        });
    });

    $("body").on('click', '.confirmar-eliminar-rol', function() {
        
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_rol = $(this).attr("id_rol");
        if (_id_rol === undefined) {
            _id_rol = 0;
        }

        _Rol_IdRol_ = _id_rol;
        _Rol_Eliminar_ = 0;
    });

    $("body").on('click', '.eliminar_rol', function() {
        $("#cargando").show();
        // _Per_IdPermiso = _eliminar;
        _post = $.post(_root_ + 'acl/index/_eliminarRol',
                {                    
                    _Rol_IdRol: _Rol_IdRol_,
                    _Rol_Eliminar: _Rol_Eliminar_,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraRol").val(),
                    filas:$("#s_filas_"+'listarRoles').val()
                },
        function(data) {
            $("#listarRoles").html('');
            $("#cargando").hide();
            $("#listarRoles").html(data);
        });
    });

    $("body").on('click', '.confirmar-habilitar-rol', function() {
        $("#cargando").show();
        if (_post && _post.readyState != 4) {
            _post.abort();
        }

        _id_rol = $(this).attr("id_rol");
        if (_id_rol === undefined) {
            _id_rol = 0;
        }

        _Rol_IdRol_ = _id_rol;
        _Rol_Eliminar_ = 1;
        
        _post = $.post(_root_ + 'acl/index/_eliminarRol',
                {                    
                    _Rol_IdRol: _Rol_IdRol_,
                    _Rol_Eliminar: _Rol_Eliminar_,
                    pagina: $(".pagination .active span").html(),
                    palabra: $("#palabraRol").val(),
                    filas:$("#s_filas_"+'listarRoles').val()
                },
        function(data) {
            $("#listarRoles").html('');
            $("#cargando").hide();
            $("#listarRoles").html(data);
        });
    });


});
function buscarRol(criterio) {
    $.post(_root_ + 'acl/index/_buscarRol',
    {
        palabra:criterio
        
    }, function (data) {
        $("#listaregistros").html('');
        $("#cargando").hide();
        $("#listarRoles").html(data);
    });
}
function buscarPermiso(criterio) {
    $("#cargando").show();
    $.post(_root_ + 'acl/index/_buscarPermiso',
    {
        palabra:criterio
        
    }, function (data) {
        $("#listarPermisos").html('');
        $("#cargando").hide();
        $("#listarPermisos").html(data);
    });
}
function buscarPalabraDocumentos(palabra) { 
    var palabra = $('#'+palabra).val();     
    if(!palabra){palabra='all'}
    document.location.href = _root_ + 'oferta/index/buscarporpalabras/' + palabra
    
}
function buscarPais(pais){
    document.location.href = _root_ + 'oferta/index/busquedaAvanzada/' + pais + '/all/all/all/all/all/all'
}
function busquedaAvanzada(){
    var selectPais = $('#selectPais').val();
    var datos = $('#datos').val();
    var proyectos = $('#proyectos').val();
    var ofertas = $('#ofertas').val();
    var esp = 'no';
    var mae = 'no';
    var doc = 'no';
        if($('#esp').is(':checked')){
            esp = 'especializaciones';
        }
        if($('#mae').is(':checked')){
            mae = 'maestrias';
        }
        if($('#doc').is(':checked')){
            doc = 'doctorados';
        }
    if(selectPais=="--Seleccione--" || selectPais=="--Selecione--" || selectPais=="--Select--" ){selectPais="all"}
    if(datos==""){datos="all"}
    if(proyectos==""){proyectos="all"}
    if(ofertas==""){ofertas="all"}
        if(selectPais=="all" && datos=="all" && proyectos=="all" && ofertas=="all" && esp=="no" && mae=="no" && doc=="no" ){
            alert('Llene al menos un campo');
            document.location.href = _root_ + 'oferta'            
        }else{
            document.location.href = _root_ + 'oferta/index/busquedaAvanzada/' + selectPais + '/' + datos + '/' + proyectos + '/' + ofertas + '/' + esp + '/' + mae + '/' + doc            
        }

    
}
function mostrar_seccion(){
    $("#seccion_filtros").show();
    $("#activar_avanzado").hide();
    $("#desactivar_avanzado").show();
}
function quitar_seccion(){
    $("#seccion_filtros").hide();
    $("#activar_avanzado").show();
    $("#desactivar_avanzado").hide();
}
function asignarFiltroPais(pais){
    var filtro_pais; 
    filtro_pais = pais;
    $('#filtro_pais').val(filtro_pais);
    $("div.demo-filtro").html("<a class='badge'><label id='label_pais'>Pais: "+filtro_pais+"<i onclick='quitarFiltro()' class='fa fa-times'></i></label></a>");
}
function quitarFiltro(){
    $('#filtro_pais').val('');
    $("div.demo-filtro").html("");   
}


$(document).ready(function(){
    $("input[name=nombre1]").change(function(){
        alert($('input[name=nombre1]').val());
    });
    $("#nombre2").change(function(){
        alert($('input[id=nombre2]').val());
    });
    $(".nombre3").change(function(){
        alert($('input[class=nombre3]').val());
    });
});
function initMap() {
    var uluru = {lat: -25.363, lng: 131.044};
    var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 4,
    center: uluru
    });
    var marker = new google.maps.Marker({
    position: uluru,
    map: map
    });
}

$(document).ready(function(){
// $("#selectPais").change(function(){
//         var mapa = $('select[id=selectPais]').val();
//         $("div.mapita").html("<img style='width:30px; padding-top: 5px;' src='http://localhost:8080/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/"+ mapa + ".png' alt=''>");
//     });
});
function asignarFiltro2(dato){
    var filtro_2; 
    filtro_2 = dato;
    $('#filtro_2').val(filtro_2);
    $("div.demo-filtro2").html("<a class='badge'><label id='label_pais'>Buscar por: "+filtro_2+"<i onclick='quitarFiltro2()' class='fa fa-times'></i></label></a>");
}
function quitarFiltro2(){
    $('#filtro_2').val('');
    $("div.demo-filtro2").html("");   
}
function gestionIdiomas(idrol, idIdiomaOriginal, idIdioma) {
    $("#cargando").show();
    $.post(_root_ + 'acl/index/gestion_idiomas_rol',
            {
                idrol: idrol,        
                idIdioma: idIdioma,
                idIdiomaOriginal: idIdiomaOriginal
            }, function (data) {
        $("#gestion_idiomas_rol").html('');
        $("#cargando").hide();
        $("#gestion_idiomas_rol").html(data);
        $('form').validator();
    });
}
