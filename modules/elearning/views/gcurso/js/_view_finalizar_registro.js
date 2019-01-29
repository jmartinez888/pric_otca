// Menu(1);

$(document).on('ready', function () { 
    cargarCKeditor();
    //Objetivos Especificos
    // $("#btnNuevoObjetivo").click(function(e){
    $("body").on('click', "#btnNuevoObjetivo",function(e){
      e.preventDefault();
      var toggle = $("#toggle_NuevoObjetivo").val();
      if(toggle==1){
        $(this).html("Agregar objetivo");
        $(".tmpDivObjetivos").remove();
        $(this).removeClass("btn-danger"); 
        $(this).addClass("btn-warning col-xs-12");
        $("#toggle_NuevoObjetivo").val(0);
      } else {
        var html = "<div class='col col-xs-12 tmpDivObjetivos'><input class='form-control margin-bottom-10' id='tmpNuevoObjetivo' /> </div>" +
                  "<div class='col col-xs-2 tmpDivObjetivos'> " + 
                  "<button type='button' id='btnRegistrarObjetivo' data-togle='tooltip' data-placement='bottom' title='Guardar' class='btn btn-sm btn-success' >" + 
                  "<i class='fa fa-save'></i> Guardar </button> " +
                  "</div>"
        $("#divObjetivosEspecificos").append(html);

        InputValidate("#tmpNuevoObjetivo", 300);
        $("#tmpNuevoObjetivo").unbind("keypress").keypress(function(e){
          if (e.keyCode == 13){
            e.preventDefault();
            var tmpNuevoObjetivo = $("#tmpNuevoObjetivo").val();
            if(tmpNuevoObjetivo==null || tmpNuevoObjetivo.length <= 0 ){
              $.fn.Mensaje({ mensaje: "* Campo vacio de Objetivo Especifico", tamano: "sm"});
              return;
            }
            AsincTaks("gcurso/_registrar_obj_especifico", { id: $("#hidden_curso").val(), obj: tmpNuevoObjetivo },
            function(a){
              $("#divObjetivosEspecificos").html("");
              $("#btnNuevoObjetivo").prop("disabled", false);
              CargarObjetivosEspecificos();
              $("#btnNuevoObjetivo").removeClass("btn-danger"); 
              $("#btnNuevoObjetivo").addClass("btn-warning col-xs-12");
              $("#btnNuevoObjetivo").html("Agregar objetivo");
              $("#toggle_NuevoObjetivo").val(0);
            },false, false);
          }
          return true;
        });
        // Jhon Martinez
        $("#btnRegistrarObjetivo").click(function(e){
          e.preventDefault();
          var tmpNuevoObjetivo = $("#tmpNuevoObjetivo").val();
          if(tmpNuevoObjetivo==null || tmpNuevoObjetivo.length <= 0 ){
            $.fn.Mensaje({ mensaje: "* Campo <b>Objetivo Especifico</b> vacio", tamano: "sm"});
            return;
          }
          AsincTaks("gcurso/_registrar_obj_especifico", { id: $("#hidden_curso").val(), obj: tmpNuevoObjetivo },
            function(a){
              $("#divObjetivosEspecificos").html("");
              $("#btnNuevoObjetivo").prop("disabled", false);
              CargarObjetivosEspecificos();
              $("#btnNuevoObjetivo").removeClass("btn-danger"); 
              $("#btnNuevoObjetivo").addClass("btn-warning col-xs-12");
              $("#btnNuevoObjetivo").html("Agregar objetivo");
              $("#toggle_NuevoObjetivo").val(0);
            },false, false);
          return true;
        });
        $(this).removeClass("btn-warning col-xs-12");
        $(this).addClass("btn-danger"); 

        $("#tmpNuevoObjetivo").focus();
        $(this).html("<i class='glyphicon glyphicon-remove'></i> Cancelar");
        $("#toggle_NuevoObjetivo").val(1);
      }
    });

    // $("#btn_registrar").click(function(e){
    $("body").on('click', "#btn_registrar",function(e){
      e.preventDefault();
      SubmitForm($("#frm_registro"), $(this), function(data, e){
        var DATA = JSON.parse(data);
        // alert("acacaca");
        Mensaje(DATA.mensaje, function(){
          // alert("ooooooooo");
          location.href = _root_ + _modulo + "/gcurso/_view_finalizar_registro/" + $("#hidden_curso").val();
          // CargarPagina("gcurso/_view_finalizar_registro/", { id: $("#hidden_curso").val() }, false, false);
        });
      });
    });

    // Agregar Informacion
    // $("#btnNuevoDetalle").click(function(e){
    $("body").on('click', "#btnNuevoDetalle", function(e) { 
      e.preventDefault();
      var toggle = $("#toggle_NuevoDetalle").val();

      if(toggle==1){
        $(this).html("Agregar Información");
        $(".tmpNuevoDetalle").remove();
        $(this).removeClass("btn-danger"); 
        $(this).addClass("btn-warning col-xs-12");
        $("#toggle_NuevoDetalle").val(0);
      }else{
        var html = "<div class='col-lg-12 tmpNuevoDetalle margin-bottom-10' style='border: 1px solid #d2d6de; padding-top: 10px; padding-bottom: 10px;'>" +
                    "<strong id='tmpttnvinfo'>Título</strong>" +
                    "<input class='form-control margin-bottom-10' id='tmpNvInfoTitulo' />" +
                    "<strong  id='tmpttnvinfod'>Descripción</strong>" +
                    "<textarea class='form-control margin-bottom-10' id='tmpNvInfoDetalle'></textarea>"+
                    "</div>" +
                    "<div class='col-xs-2 tmpNuevoDetalle'>" +
                    "<button type='button' id='btnRegistrarDetalle' class='btn btn-sm btn-success' > <i class='glyphicon glyphicon-floppy-disk'></i> Guardar </button>" +
                    "<div/>"
        $("#divDetallesCursos").append(html);

        InputValidate("#tmpNvInfoTitulo", 300);
        $('#tmpNvInfoDetalle').ckeditor(function() { /* callback code */ 
        }, { toolbar : 'Basic' });

        $("#tmpNvInfoTitulo").unbind("keypress").keypress(function(e){
          if (e.keyCode == 13){
            e.preventDefault();
            $("#tmpNvInfoDetalle").focus();
          }
          return true;
        });
        $("#tmpNvInfoDetalle").unbind("keypress").keypress(function(e){
          if (e.keyCode == 13){
            e.preventDefault();
            var tmpNvInfoTitulo = $("#tmpNvInfoTitulo").val();
            var tmpNvInfoDetalle = $("#tmpNvInfoDetalle").val();
            if(tmpNvInfoTitulo==null || tmpNvInfoTitulo.length <= 0 || tmpNvInfoDetalle==null || tmpNvInfoDetalle.length <= 0){
              var mensaje_ = false;
              if (tmpNvInfoTitulo==null || tmpNvInfoTitulo.length <= 0) {
                mensaje_ = "* Campo <b>Titulo</b> Vacio ";
              }
              if (tmpNvInfoDetalle==null || tmpNvInfoDetalle.length <= 0) {
                if (mensaje_) {
                  mensaje_ = mensaje_ + "<br>* Campo <b>Descripción</b> Vacio "
                } else {
                  mensaje_ = mensaje_ + "* Campo <b>Descripción</b> Vacio "
                }
                
              }
              $.fn.Mensaje({ mensaje: mensaje_, tamano: "sm"});
              return;
            }
            var params = { id: $("#hidden_curso").val(),
                            titulo: $("#tmpNvInfoTitulo").val(),
                            descripcion: $("#tmpNvInfoDetalle").val() };
            AsincTaks("gcurso/_registrar_detalle_curso", params, function(a){
              $("#divDetallesCursos").html("");
              $("#btnNuevoDetalle").prop("disabled", false);
              CargarDetalleCurso();

              $("#btnNuevoDetalle").removeClass("btn-danger"); 
              $("#btnNuevoDetalle").addClass("btn-warning col-xs-12");
              $("#btnNuevoDetalle").html("Agregar Información");
              $("#toggle_NuevoDetalle").val(0);
            },false, false);
          }
          return true;
        });

        // Jhon Martinez
        // $("#btnRegistrarDetalle").click(function(e){
        $("body").on('click', "#btnRegistrarDetalle", function(e) {
          e.preventDefault();
            var tmpNvInfoTitulo = $("#tmpNvInfoTitulo").val();
            var tmpNvInfoDetalle = $("#tmpNvInfoDetalle").val();
            if(tmpNvInfoTitulo==null || tmpNvInfoTitulo.length <= 0 || tmpNvInfoDetalle==null || tmpNvInfoDetalle.length <= 0){
              var mensaje_ = false;
              if (tmpNvInfoTitulo==null || tmpNvInfoTitulo.length <= 0) {
                mensaje_ = "* Campo <b>Titulo</b> Vacio ";
              }
              if (tmpNvInfoDetalle==null || tmpNvInfoDetalle.length <= 0) {
                if (mensaje_) {
                  mensaje_ = mensaje_ + "<br>* Campo <b>Descripción</b> Vacio "
                } else {
                  mensaje_ = mensaje_ + "* Campo <b>Descripción</b> Vacio "
                }
                
              }
              $.fn.Mensaje({ mensaje: mensaje_, tamano: "sm"});
              return;
            }
            var params = { id: $("#hidden_curso").val(),
                            titulo: $("#tmpNvInfoTitulo").val(),
                            descripcion: $("#tmpNvInfoDetalle").val() };
            AsincTaks("gcurso/_registrar_detalle_curso", params,
            function(a){
              $("#divDetallesCursos").html("");
              $("#btnNuevoDetalle").prop("disabled", false);
              CargarDetalleCurso();

              $("#btnNuevoDetalle").removeClass("btn-danger"); 
              $("#btnNuevoDetalle").addClass("btn-warning col-xs-12");
              $("#btnNuevoDetalle").html("Agregar Información");
              $("#toggle_NuevoDetalle").val(0);
            },false, false);
          return true;
        });
        $(this).removeClass("col-xs-12 btn-warning");
        $(this).addClass("btn-danger"); 

        $("#tmpNvInfoTitulo").focus();
        $(this).html("<i class='glyphicon glyphicon-remove'></i> Cancelar");
        $("#toggle_NuevoDetalle").val(1);
      }
    });
    // Jhon Martinez
    // $("#btn-subir-imagen").click(function(e){
    $("body").on('click', "#btn-subir-imagen", function(e) { 
      e.preventDefault();
      var params = {
        route: "files/elearning/cursos/img/portada",
        pre: $("#hidden_curso").val(),
        Idi_Ididioma: $("#idiomaTradu").val()
      };
      InitUploader(function(a){
        var DATA = JSON.parse(a);
        var img = DATA.data[0].url;
        img = img.split("\\");
        img = img[img.length-1];
        // alert($("#idiomaTradu").val()+$("#IdiomaOriginal").val())
        var parametros = { curso: $("#hidden_curso").val(), img : img, IdiomaOriginal : $("#IdiomaOriginal").val(), idiomaTradu : $("#idiomaTradu").val() };
        AsincTaks("gcurso/_actualizar_img", parametros, function(data){
          Mensaje("Se actualizó el banner", function(){
            var DATA = JSON.parse(data);
            $("#img_banner_new").attr("src", _root_ + "files/elearning/cursos/img/portada/" + DATA.data[0].url);
            // CargarPagina("gcurso/_view_finalizar_registro/", { id: $("hidden_curso").val() }, false, false);
          });
        }, false, false);
      }, params);
    });
    // Jhon Martinez
    // $("#btn-guardarVideo").click(function(e){
    $("body").on('click', "#btn-guardarVideo", function (e) { 
        e.preventDefault();
        var parametros = { curso: $("#hidden_curso").val(), video : $("#Cur_UrlVideoPresentacion").val(), IdiomaOriginal : $("#IdiomaOriginal").val(), idiomaTradu : $("#idiomaTradu").val() };
        AsincTaks("gcurso/_actualizar_video", parametros, function(data){
          Mensaje("Se actualizó el Video", function(){
            var DATA = JSON.parse(data);
            reloadObjet(DATA.data[0].url);
            // $("#video_curso_param").val("http://www.youtube.com/v/" + DATA.data[0].url);
            // $("#video_curso_embed").attr("src", "http://www.youtube.com/v/" + DATA.data[0].url);
            // $("#img_banner_new").attr("src", _root_ + "modules/elearning/views/cursos/img/portada/" + DATA.data[0].url);
            // CargarPagina("gcurso/_view_finalizar_registro/", { id: $("hidden_curso").val() }, false, false);
          });
        }, false, false);
    });
    // Jhon Martinez
    // $("#item_presentacion").click(function() {
    $("body").on('click', "#item_presentacion", function (e) { 
      e.preventDefault();
      $(this).removeClass("active");
      $("#item_contenido").removeClass("active");
      $("#item_parametros").removeClass("active");  
      // $(this).css('font-weight', 'bold');
      $(this).addClass("active");
      $('.div_presentacion').css('display', 'block');
      $('.div_contenido').css('display', 'none');
      $('.div_parametros').css('display', 'none');
    });
    // $("#item_contenido").click(function() {
    $("body").on('click', "#item_contenido", function (e) { 
      e.preventDefault();
      $(this).removeClass("active");
      $("#item_presentacion").removeClass("active");
      $("#item_parametros").removeClass("active");
      // $(this).css('font-weight', 'bold');
      $(this).addClass("active");
      $('.div_contenido').css('display', 'block');
      $('.div_presentacion').css('display', 'none');
      $('.div_parametros').css('display', 'none');

      setTimeout(function(){
        CargarDetalleCurso();
        CargarObjetivosEspecificos();
      }, 300);
    });
    // $("#item_parametros").click(function() {
    $("body").on('click', "#item_parametros", function (e) { 
      e.preventDefault();
      $(this).removeClass("active");
      $("#item_contenido").removeClass("active");
      $("#item_presentacion").removeClass("active");
      // $(this).css('font-weight', 'bold');
      $(this).addClass("active");
      $('.div_parametros').css('display', 'block');
      $('.div_contenido').css('display', 'none');
      $('.div_presentacion').css('display', 'none');
    });

    $("#btn_regresar").click(function(e){
      e.preventDefault();
      CargarPagina("gcurso/_view_mis_cursos/", {}, false, false);
    });

    // $(".idioma_s").click(function(){
    $("body").on('click', ".idioma_s", function (e) {
        e.preventDefault();
        var id = $(this).attr("id");
        var idIdioma = $("#hd_" + id).val();
        gestionIdiomas($("#hidden_curso").val(), $("#IdiomaOriginal").val(), idIdioma);
        // buscar($("#palabra").val(), $("#buscarTipo").val(), $("#idPadreIdiomas").val(),idIdioma);
        
    }); 

    
});
    

function gestionIdiomas(Cur_IdCurso, idIdiomaOriginal, idIdioma) {
    $("#cargando").show();
    $.post(_root_  + _modulo + '/gcurso/gestion_idiomas',
            {
                idIdioma: idIdioma,
                Cur_IdCurso: Cur_IdCurso,
                idIdiomaOriginal: idIdiomaOriginal
            }, function (data) {
        $("#gestion_idiomas").html('');
        $("#cargando").hide();
        $("#gestion_idiomas").html(data);

        cargarCKeditor();
        // $('textarea#editor1').ckeditor();
        // $('form').validator();
    });
}
function cargarCKeditor(){
  $('#inDescripcion').ckeditor(function() { }, { toolbar : 'Basic' });
  $('#inContacto').ckeditor(function() { }, { toolbar : 'Basic' });
  $('#inSoftware').ckeditor(function() { }, { toolbar : 'Basic' });
  $('#inHardware').ckeditor(function() { }, { toolbar : 'Basic' });
  $('#inMetodologia').ckeditor(function() { }, { toolbar : 'Basic' });
}
function CargarObjetivosEspecificos(){
  $('[data-toggle="tooltip"]').tooltip(); 
  // alert("aaaa"+$("#hidden_curso").val());
  CargarPagina("gcurso/_partial_objetivos_especificos/",
    { id : $("#hidden_curso").val(), idiomaTradu : $("#idiomaTradu").val()}, $("#divObjetivosEspecificos"), false);
    setTimeout(function(){
      $(".btnEliminarObjetivo").unbind("click").click(function(){
        var value = $(this).parent().find(".Hidden_IdObjetivo").val();
        $.fn.Mensaje({
          mensaje: "¿Está seguro de eliminar este objetivo específico?",
          tipo: "SiNo",
          funcionSi: function(){
            $("#btnNuevoObjetivo").prop("disabled", false);
            AsincTaks("gcurso/_eliminar_obj_especifico", { obj: value },
            function(a){
              CargarObjetivosEspecificos();
              $("#btnNuevoObjetivo").removeClass("btn-danger"); 
              $("#btnNuevoObjetivo").addClass("btn-warning col-xs-12");
              $("#btnNuevoObjetivo").html("Agregar Información");
            },false, false);
          }
        });
      });
    }, 1000);
}

function CargarDetalleCurso(){
    CargarPagina("gcurso/_partial_detalle_curso/",
    { id : $("#hidden_curso").val() }, $("#divDetallesCursos"), false);
    setTimeout(function(){
      $(".btn-detalle").unbind("click").click(function(e){
        e.preventDefault();
        var value = $(this).parent().find(".Hidden_IdDetalle").val();

        $.fn.Mensaje({
          mensaje: "¿Está seguro de eliminar este detalle?",
          tipo: "SiNo",
          funcionSi: function(){
            $("#btnNuevoDetalle").prop("disabled", false);
            AsincTaks("gcurso/_eliminar_det_curso", { obj: value },
            function(a){
              CargarDetalleCurso();
              $("#btnNuevoDetalle").removeClass("btn-danger"); 
              $("#btnNuevoDetalle").addClass("btn-warning col-xs-12");
              $("#btnNuevoDetalle").html("Agregar Información");
            },false, false);
          }
        });
      });
    }, 500);
}

function reloadObjet(url_video){
  var div = document.getElementById('div_video');

  var ooo = document.createElement('object');
  ooo.width = '100%';
  ooo.height = 344;

  var para = document.createElement('param');
  para.name = 'movie';
  para.value='http://www.youtube.com/v/' + url_video;

  var parb = document.createElement('param');
  parb.name = 'allowFullScreen';
  parb.value= true;

  var parc = document.createElement('param');
  parc.name = 'allowscriptaccess';
  parc.value='always';

  var em = document.createElement('embed');
  em.src = 'http://www.youtube.com/v/' + url_video;
  em.type='application/x-shockwave-flash';

  em.allowscriptaccess="always";
  em.allowfullscreen=true;
  em.width="100%";
  em.height=344;

  ooo.appendChild(para);
  ooo.appendChild(parb);
  ooo.appendChild(parc);
  ooo.appendChild(em);
  div.children[0].remove();
  div.append(ooo);
  $(div).removeClass("hidden");
}

InputValidate("#inTitulo", 100);
InputValidate("#inDescripcion", 2000);
InputValidate("#inObjetivo", 300);
InputValidate("#inPublico", 300);
InputValidate("#inSoftware", 300);
InputValidate("#inHardware", 300);
InputValidate("#inMetodologia", 300);
InputValidate("#inPublico", 300);
