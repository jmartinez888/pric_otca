var _post = null;
var _Per_IdPermiso_ = 0;
$(document).on('ready', function () {  
    $('.select2').select2(); 
    $('#form3').validator().on('submit', function (e) {
    if (e.isDefaultPrevented()) {

    } else {

    }
    });
    // $('.mitooltip').tooltip();
    // $(function() {
    //     $("[data-toggle='tooltip']").tooltip();
    // });
    
    $('body').on('click', '.pagina', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });
    $('body').on('change', '.s_filas', function () {
        $("#cargando").show();
        paginacion($(this).attr("pagina"), $(this).attr("nombre"), $(this).attr("parametros"),$(this).attr("total_registros"));
    });
    var paginacion = function (pagina, nombrelista, datos,total_registros) {
        var pagina = {'pagina':pagina,'filas':$("#s_filas_"+nombrelista).val(),'total_registros':total_registros};
        
        $.post(_root_ + 'oferta/instituciones/_paginacion_' + nombrelista + '/' + datos, pagina, function (data) {
            $("#" + nombrelista).html('');
            $("#cargando").hide();
            $("#" + nombrelista).html(data);
        });
    }
    $('body').on('change', '#pais', function () {
        $("#cargando").show();
        mostrarciudades($(this).val());
    });
    var mostrarciudades = function (idpais) {
        $.post(_root_ + 'oferta/registro/_mostrarciudades' + '/' + idpais, function (data) {
            $("#mostrarciudades").html('');
            $("#cargando").hide();
            $("#mostrarciudades").html(data);
        });
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
function buscarPalabraDocumentos(palabra,pais) { 
    var palabra = $('#'+palabra).val();     
    if(!palabra){palabra='all'}
    var filtro_pais = $('#filtro_pais').val();
    pais=filtro_pais;
    if(pais==null || pais ==''){
        pais = 'all';
    }

    document.location.href = _root_ + 'oferta/instituciones/buscarporpalabras/' + palabra + '/'+ pais
    
}


$(document).ready(function(){
$("#pais").change(function(){
    var mapa = $('select[id=pais]').val();
//  $("div.ciudad").html("<select name='ciudad' id='ciudad' class='form-control'> {if isset($paises) && count($paises)} {foreach from=$paises item=c} {foreach from=$c.Ciudades item=d} {if $d.Pai_IdPais == "+mapa+"} <option value="">{$d.Ter_Nombre}</option> {/if} {/foreach} {/foreach} {/if} </select>");
    $("div.ciudad").html("<select name='ciudad' class='form-control'>{foreach from=$paises item=b}<option>{$b.Nombre}</option>{/foreach}</select>");
    });
});
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
 
var marker;          //variable del marcador
var coords = {};    //coordenadas obtenidas con la geolocalización
 
//Funcion principal
initMap = function () 
{
 
    //usamos la API para geolocalizar el usuario
        navigator.geolocation.getCurrentPosition(
          function (position){
            coords =  {
              lng: position.coords.longitude,
              lat: position.coords.latitude
            };
            setMapa(coords);  //pasamos las coordenadas al metodo para crear el mapa
            
           
          },function(error){console.log(error);});
    
}
 
function setMapa (coords)
{   
      //Se crea una nueva instancia del objeto mapa
      var map = new google.maps.Map(document.getElementById('map'),
      {
        zoom: 13,
        center:new google.maps.LatLng(coords.lat,coords.lng),
 
      });
 
      //Creamos el marcador en el mapa con sus propiedades
      //para nuestro obetivo tenemos que poner el atributo draggable en true
      //position pondremos las mismas coordenas que obtuvimos en la geolocalización
      marker = new google.maps.Marker({
        map: map,
        draggable: true,
        animation: google.maps.Animation.DROP,
        position: new google.maps.LatLng(coords.lat,coords.lng),
 
      });
      //agregamos un evento al marcador junto con la funcion callback al igual que el evento dragend que indica 
      //cuando el usuario a soltado el marcador
      marker.addListener('click', toggleBounce);
      
      marker.addListener( 'dragend', function (event)
      {
        //escribimos las coordenadas de la posicion actual del marcador dentro del input #coords
        document.getElementById("latX").value = this.getPosition().lat();
        document.getElementById("latY").value = this.getPosition().lng();
      });
}
 
//callback al hacer clic en el marcador lo que hace es quitar y poner la animacion BOUNCE
function toggleBounce() {
  if (marker.getAnimation() !== null) {
    marker.setAnimation(null);
  } else {
    marker.setAnimation(google.maps.Animation.BOUNCE);
  }
}