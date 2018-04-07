function CalendarioPRIC(funcion, params, view, base, botones){
  var enrutar = function(mes, anio, evento, params, view, base, botones){
    var docente = params.docente || 0;
    $.ajax({
      url: base + "calendario/calendario",
      data: { mes: mes, anio: anio, eventos: evento, docente: docente },
      type: "post",
      success: function(a){
        funcion(a);
        CalendarioPRIC(funcion, params, view, base, botones);
      }
    });
  };

  $(".dia-calendario").click(function(){
    var dia = $(this).find(".calendario-dia").val();
    var mes = $(this).find(".calendario-mes").val();
    var anio = $(this).find(".calendario-anio").val();
    var eventos = $(this).find(".calendario-eventos").val();

    if(eventos != 0){
      if(params.docente == 1){
        var result = { dia: dia, mes: mes, anio: anio, eventos: eventos };
        params.viewDocente($(this), result);
      }else{
        $("#panel-dia-calendario").modal("show");

        var CONTENT = $("#content-p-e-c");
        var json = JSON.parse(eventos);
        var view_titulo = view.titulo || "Fecha";
        $("#panel-calendario-titulo").html(view_titulo);
        CONTENT.html("");
        var view_header = view.header || "";
        CONTENT.append(view_header);
        json.forEach(function(row){
          var view_content = view.item(row) || "";
          CONTENT.append(view_content);
        });
        var view_footer = view.footer || "";
        CONTENT.append(view_footer);
      }
    }else{
      if(params.docente == 1 && params.viewDocente!=null){
        var result = { dia: dia, mes: mes, anio: anio, eventos: eventos };
        params.viewDocente($(this), result);
      }
    }
  });

  $("#btn_calend_anterior").click(function(){
    var anio = $("#hiddenCalend_AntAnio").val();
    var mes = $("#hiddenCalend_AntMes").val();

    if(params==null){
      enrutar(mes, anio, "", params, view, base, botones);
    }else{
      params.params.anio = anio;
      params.params.mes = mes;
      $.ajax({ url: base + params.link, data: params.params, type: "post",
        success: function(a){
          enrutar(mes, anio, a, params, view, base, botones);
        }
      });
    }
    if(botones!=null){
      botones.anterior(anio, mes);
    }
  });

  $("#btn_calend_siguiente").click(function(){
    var anio = $("#hiddenCalend_SigAnio").val();
    var mes = $("#hiddenCalend_SigMes").val();

    if(params==null){
      enrutar(mes, anio, "", params, view, base, botones);
    }else{
      params.params.anio = anio;
      params.params.mes = mes;
      $.ajax({ url: base + params.link, data: params.params, type: "post",
        success: function(a){
          enrutar(mes, anio, a, params, view, base, botones);
        }
      });
    }
    if(botones!=null){
      botones.siguiente(anio, mes);
    }
  });
}
