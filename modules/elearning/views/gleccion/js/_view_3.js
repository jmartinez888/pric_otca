Menu(1);
RefreshTagUrl();

$("#btn_actualizar").click(function(e){
  e.preventDefault();
  SubmitForm($("#frm-actualizar-examen"), $(this), function(data, e){
    Mensaje("Se actualizaron los datos", function(){
      CargarPagina("gleccion/_view_leccion", {
        curso: $("#hidden_curso").val(),
        modulo : $("#hidden_modulo").val(),
        leccion : $("#hidden_leccion").val(),
      }, false, false);
    });
  });
});
$("#btn_agregar_pregunta").click(function(){
  $("#panelNuevaPregunta").modal("show");
  setTimeout(function(){
    $("#in_pregunta").focus();
  }, 300);
});
$("#btn_registrar_pregunta").click(function(){
  var leccion = $("#hidden_leccion");
  var Pregunta = $("#in_pregunta");
  var Alt1 = $("#inPreg1");
  var Alt2 = $("#inPreg2");
  var Alt3 = $("#inPreg3");
  var Alt4 = $("#inPreg4");
  var Alt5 = $("#inPreg5");
  var Valor = $("input[name=valor_preg]:checked").val();

  if(!ValidateInput(Pregunta)){ return; }
  if(!ValidateInput(Alt1)){ return; }
  if(!ValidateInput(Alt2)){ return; }
  if(!ValidateInput(Alt3)){ return; }
  if(!ValidateInput(Alt4)){ return; }
  if(!ValidateInput(Alt5)){ return; }

  var params = {
    leccion: leccion.val(),
    pregunta: Pregunta.val(),
    alt1: Alt1.val(),
    alt2: Alt2.val(),
    alt3: Alt3.val(),
    alt4: Alt4.val(),
    alt5: Alt5.val(),
    valor: Valor
  };
  $.fn.Mensaje({
    mensaje: "¿Esta seguro de guardar la pregunta?",
    tamano: "sm",
    tipo: "SiNo",
    funcionSi: function(){
      AsincTaks("gleccion/_registrar_pregunta", params, function(a){
        $("#panelNuevaPregunta").modal("show");
        setTimeout(function(){
            Mensaje("Se agregó la pregunta", function(){
              CargarPagina("gleccion/_view_leccion", {
                curso: $("#hidden_curso").val(),
                modulo : $("#hidden_modulo").val(),
                leccion : $("#hidden_leccion").val(),
              }, false, false);
            });
        }, 300);

      }, false, false);
    }
  });
});


function ValidateInput(input){
  if(input.val().toString().length==0){
    Mensaje("Llene todo los campos", function(){
      input.focus();
    })
    return false;
  }else{
    return true;
  }
}







$(".btnEliminarPregunta").click(function(){
  var Pregunta = $(this).parent().find(".hidden_IdPregunta").val();

  $.fn.Mensaje({
    mensaje: "¿Esta seguro de eliminar esta pregunta?",
    tipo: "SiNo",
    funcionSi: function(){
      AsincTaks("gleccion/_eliminar_pregunta", { id : Pregunta }, function(a){
        CargarPagina("gleccion/_view_leccion", {
          curso: $("#hidden_curso").val(),
          modulo : $("#hidden_modulo").val(),
          leccion : $("#hidden_leccion").val(),
        }, false, false);
      }, null);
    }
  });
});

$(".btnDeshabilitarPreg").click(function(e){
  e.preventDefault();
  var Pregunta = $(this).parent().find(".hidden_IdPregunta").val();
  ToggleEstado(Pregunta, "0");
});
$(".btnHabilitarPreg").click(function(e){
  e.preventDefault();
  var Pregunta = $(this).parent().find(".hidden_IdPregunta").val();
  ToggleEstado(Pregunta, "1");
});

function ToggleEstado(pregunta, _estado){
  AsincTaks("gleccion/_estado_pregunta", { id : pregunta, estado : _estado }, function(a){

    CargarPagina("gleccion/_view_leccion", {
      curso: $("#hidden_curso").val(),
      modulo : $("#hidden_modulo").val(),
      leccion : $("#hidden_leccion").val(),
    }, false, false);
  });
}

$(".btnEditarPregunta").click(function(e){
  e.preventDefault();
  var Id = $(this).parent().find(".hidden_IdPregunta").val();
  var Alternativas = $(this).parent().find(".hidden_Alternativas").val();
  var Descripcion = $(this).parent().find(".hidden_DescripcionPre").val();
  var Valor = $(this).parent().find(".hidden_ValorPre").val();
  var Alternativas = JSON.parse(Alternativas);
  var In = "#in_rd_valor_" + Valor;
  $(In).prop('checked', true);

  $("#panelModificarPregunta").modal("show");
  setTimeout(function(){
    $("#in_idpregunta_edit").val(Id);
    $("#in_descpregunta_edit").val(Descripcion);

    for(i=0; i < Alternativas.length; i++){
      $("#inPreg" + (i+1) + "Edit").val(Alternativas[i]["Alt_Etiqueta"]);
      $("#inIdAlt" + (i+1) + "Edit").val(Alternativas[i]["Alt_IdAlternativa"]);
    }
  }, 300);
});

$("#btn_modificar_pregunta").click(function(){
  var Pregunta = $("#in_idpregunta_edit");
  var Descripcion = $("#in_descpregunta_edit");
  var Alt1 = $("#inPreg1Edit");
  var Alt2 = $("#inPreg2Edit");
  var Alt3 = $("#inPreg3Edit");
  var Alt4 = $("#inPreg4Edit");
  var Alt5 = $("#inPreg5Edit");
  var AltID1 = $("#inIdAlt1Edit");
  var AltID2 = $("#inIdAlt2Edit");
  var AltID3 = $("#inIdAlt3Edit");
  var AltID4 = $("#inIdAlt4Edit");
  var AltID5 = $("#inIdAlt5Edit");
  var Valor = $("input[name=alt_valor_edit]:checked").val();

  if(!ValidateInput(Pregunta)){ return; }
  if(!ValidateInput(Descripcion)){ return; }
  if(!ValidateInput(Alt1)){ return; }
  if(!ValidateInput(Alt2)){ return; }
  if(!ValidateInput(Alt3)){ return; }
  if(!ValidateInput(Alt4)){ return; }
  if(!ValidateInput(Alt5)){ return; }

  var params = {
    pregunta: Pregunta.val(),
    descripcion: Descripcion.val(),
    alt1: Alt1.val(),
    alt2: Alt2.val(),
    alt3: Alt3.val(),
    alt4: Alt4.val(),
    alt5: Alt5.val(),
    id_alt1: AltID1.val(),
    id_alt2: AltID2.val(),
    id_alt3: AltID3.val(),
    id_alt4: AltID4.val(),
    id_alt5: AltID5.val(),
    valor: Valor
  };


  $.fn.Mensaje({
    mensaje: "¿Esta seguro de actualizar la pregunta?",
    tamano: "sm",
    tipo: "SiNo",
    funcionSi: function(){
      AsincTaks("gleccion/_modificar_pregunta", params, function(a){
        $("#panelModificarPregunta").modal("hide");

        setTimeout(function(){
            Mensaje("Se actualizó la pregunta", function(){
              CargarPagina("gleccion/_view_leccion", {
                curso: $("#hidden_curso").val(),
                modulo : $("#hidden_modulo").val(),
                leccion : $("#hidden_leccion").val(),
              }, false, false);
            });
        }, 300);
      }, false, false);
    }
  });
});
