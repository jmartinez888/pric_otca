$(document).ready(function(){
  $("#btnExamen").click(function(){
    $("#leccion-contenido").hide(200);
    $("#examen-contenido").show(200);
    setTimeout(function(){
      $("#leccion-contenido").remove();
    }, 300);
  });

  $("#btnFinalizar").click(function(e){
    e.preventDefault();
    SendExamen();
  });
  
    $('body').on('click', '.btn_login_user', function () {
        $("[name=register-form-link]").removeClass("active");
        $("[name=login-form-link]").addClass("active");
    });

  function BloquearExamen(estado){
    $("#form-examen").find("input").prop("disabled", estado);
    $("#btnFinalizar").prop("disabled", estado);
  }

  function SendExamen(){
    var CONT = $(".contenedor-pregunta");
    var examen = $("#IdExamen").val();
    var resultado = [];

    for(i= 0 ; i < CONT.length ; i++){
      var IdPregunta = CONT.eq(i).find(".IdPregunta").val();
      var Respuesta = CONT.eq(i).find(".IdAlternativa:checked").val();
      if(Respuesta == undefined || Respuesta == null || isNaN(Respuesta)){
        alert("no hay respuesta");
        return;
      }
      var item = { IdPregunta : IdPregunta, Respuesta: Respuesta }
      resultado.push(item);
    }
    BloquearExamen(true);
    $.ajax({
      type: "post",
      url: _root_ + "elearning/cursos/_send_examen",
      data: { data : JSON.stringify(resultado), examen: examen },
      success: function(a){
        var DATA = JSON.parse(a);
        if(DATA.estado==1){
          alert(DATA.mensaje);
          location.href = $("#hiddenURL").val() + "elearning/cursos/curso/"  + $("#hiddenCurso").val();
        }else{
          $("#examen-contenido").hide(200);
          $("#resultados-contenido").show(200);
          setTimeout(function(){
            $("#examen-contenido").remove();
          }, 300);
          ViewErrores(DATA.data);
        }
      }
    });
  }

  function ViewErrores(errores){
    console.log(errores);
    var Porcentaje = errores.Porcentaje;
    errores = errores.ERRORES;

    alert("Solo se respondió un " + Porcentaje + "% de las preguntas");

    var CONTENEDOR = $("#contenido-errores");
    var contenido = "";
    errores.forEach(function(a){
      contenido += "<div class='col-lg-12'>"+
                            "<div><h5>" + a.Pre_Descripcion + "</h5></div>";
      var Alternativas = a["ALTERNATIVAS"];
      Alternativas.forEach(function(e){
        if (e.Alt_Valor === a.USUARIO){
          contenido += "<div style='color: red'>" + e.Alt_Etiqueta + "(Seleccionada)</div>";
        }else if (e.Alt_Valor === a.Pre_Valor){
          contenido += "<div style='color: green'><strong>" + e.Alt_Etiqueta + " (Correcta)</strong></div>";
        }else{
          contenido += "<div>" + e.Alt_Etiqueta + "</div>";
        }
      });
      contenido += "</div>";
    });
    CONTENEDOR.append(contenido);
  }
});
