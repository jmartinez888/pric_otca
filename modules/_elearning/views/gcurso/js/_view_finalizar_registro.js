Menu(1);

$("#btn_regresar").click(function(){
  CargarPagina("gcurso/_view_mis_cursos/", {}, false, false);
});

function CargarObjetivosEspecificos(){
    CargarPagina("gcurso/_partial_objetivos_especificos/",
    { id : $("#hiddenIdCurso").val() }, $("#divObjetivosEspecificos"), false);
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
            },false, false);
          }
        });
      });
    }, 500);
}



function CargarDetalleCurso(){
    CargarPagina("gcurso/_partial_detalle_curso/",
    { id : $("#hiddenIdCurso").val() }, $("#divDetallesCursos"), false);
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
            },false, false);
          }
        });
      });
    }, 500);
}


$("#btnNuevoObjetivo").click(function(e){
  e.preventDefault();
  var toggle = $("#toggle_NuevoObjetivo").val();

  if(toggle==1){
    $(this).html("Agregar objetivo");
    $("#tmpNuevoObjetivo").remove();
    $("#toggle_NuevoObjetivo").val(0);
  }else{
    var html = "<input class='form-control margin-bottom-10' id='tmpNuevoObjetivo' />"
    $("#divObjetivosEspecificos").append(html);

    InputValidate("#tmpNuevoObjetivo", 300);
    $("#tmpNuevoObjetivo").unbind("keypress").keypress(function(e){
      if (e.keyCode == 13){
        e.preventDefault();
        AsincTaks("gcurso/_registrar_obj_especifico", { id: $("#hiddenIdCurso").val(), obj: $("#tmpNuevoObjetivo").val() },
        function(a){
          $("#divObjetivosEspecificos").html("");
          $("#btnNuevoObjetivo").prop("disabled", false);
          CargarObjetivosEspecificos();

          $("#btnNuevoObjetivo").html("Agregar objetivo");
          $("#toggle_NuevoObjetivo").val(0);
        },false, false);
      }
      return true;
    });

    $("#tmpNuevoObjetivo").focus();
    $(this).html("Cancelar");
    $("#toggle_NuevoObjetivo").val(1);
  }
});

$("#btn_registrar").click(function(e){
  e.preventDefault();
  SubmitForm($("#frm_registro"), $(this), function(data, e){
    var DATA = JSON.parse(data);
    Mensaje(DATA.mensaje, function(){
      CargarPagina("gcurso/_view_finalizar_registro/", { id: $("#hiddenIdCurso").val() }, false, false);
    });
  });
});

$("#btnNuevoDetalle").click(function(e){
  e.preventDefault();
  var toggle = $("#toggle_NuevoDetalle").val();

  if(toggle==1){
    $(this).html("Agregar Información");
    $("#tmpNvInfoTitulo").remove();
    $("#tmpNvInfoDetalle").remove();
    $("#tmpttnvinfo").remove();
    $("#tmpttnvinfod").remove();
    $("#toggle_NuevoDetalle").val(0);
  }else{
    var html = "<div class='col-lg-12'>" +
                "<strong id='tmpttnvinfo'>Título</strong>" +
                "<input class='form-control margin-bottom-10' id='tmpNvInfoTitulo' />" +
                "<strong  id='tmpttnvinfod'>Descripción</strong>" +
                "<textarea class='form-control margin-bottom-10' id='tmpNvInfoDetalle'></textarea>"+
                "<div>"
    $("#divDetallesCursos").append(html);

    InputValidate("#tmpNvInfoTitulo", 300);
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
        var params = { id: $("#hiddenIdCurso").val(),
                        titulo: $("#tmpNvInfoTitulo").val(),
                        descripcion: $("#tmpNvInfoDetalle").val() };
        AsincTaks("gcurso/_registrar_detalle_curso", params,
        function(a){
          $("#divDetallesCursos").html("");
          $("#btnNuevoDetalle").prop("disabled", false);
          CargarDetalleCurso();

          $("#btnNuevoDetalle").html("Agregar Información");
          $("#toggle_NuevoDetalle").val(0);
        },false, false);
      }
      return true;
    });

    $("#tmpNvInfoTitulo").focus();
    $(this).html("Cancelar");
    $("#toggle_NuevoDetalle").val(1);
  }
});

CargarDetalleCurso();
CargarObjetivosEspecificos();

InputValidate("#inTitulo", 100);
InputValidate("#inDescripcion", 2000);
InputValidate("#inObjetivo", 300);
InputValidate("#inPublico", 300);
InputValidate("#inSoftware", 300);
InputValidate("#inHardware", 300);
InputValidate("#inMetodologia", 300);
InputValidate("#inPublico", 300);
