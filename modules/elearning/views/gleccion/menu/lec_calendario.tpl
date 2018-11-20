<div class="col-lg-12">
<div class="panel panel-default margin-top-10">
  <div class="panel-heading">
    <h3 class="panel-title">
      <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
      <strong>¿Lección Dirigida? - Programar Lección</strong>
    </h3>
  </div>
  <div class="panel-body" style=" margin: 15px 25px">
    <div class="col-lg-4">
      <label>Fecha Registrada</label>
      <input class="form-control" value="{substr($leccion.Lec_FechaDesde, 0, 10)}" disabled/>
    </div>
    <div class="col-lg-12"></br></div>
    <div class="col-lg-12">
      <form></form>
      <form id="form-fecha" method="post" action="gleccion/_actualizar_fecha">
        <input name="dia" value="0" id="hidden_calend_dia" hidden="hidden"/>
        <input name="mes" value="0" id="hidden_calend_mes" hidden="hidden"/>
        <input name="anio" value="0" id="hidden_calend_anio" hidden="hidden"/>
        <input name="leccion" value="{$leccion.Lec_IdLeccion}" hidden="hidden"/>
      </form>
    </div>
    <div id="calendario"></div>
    <div class="col-lg-12">
      <button class="btn btn-success pull-right" id="btn_guardar_fecha">Guardar</button>
    </div>
  </div>
</div>
</div>

<script>
$(document).ready(function(){
  var params = {
    link: "gleccion/_fechas_leccion",
    params: { modulo: $("#hidden_modulo").val() },
    docente: 1,
    viewDocente: function(div, params){
      if($("#hidden_calend_dia").val() == params.dia
        && $("#hidden_calend_mes").val() == params.mes
        && $("#hidden_calend_anio").val() == params.anio){
      }else{
        $(".dia-calendario").css({ "background-color": "white"});
        $("#tmp-programacion-leccion").remove();
        $("#hidden_calend_dia").val(params.dia);
        $("#hidden_calend_mes").val(params.mes);
        $("#hidden_calend_anio").val(params.anio);
        div.css({ "background-color": "whitesmoke"});
        div.append("<div id='tmp-programacion-leccion'>Programar para este día</div>");
      }
    }
  };
  var botones = {
    anterior: function(mes, anio){ /*alert("holi");*/ }
  };
  var view = {
    titulo: "",
    header: function(){ return ""; },
    footer: function(){ return ""; },
    item: function(row){ return ""; }
  };
  StartCalendarioPRIC("#calendario", params, botones, view);

  $("#btn_guardar_fecha").click(function(){
    var dia = $("#hidden_calend_dia").val();
    var mes = $("#hidden_calend_mes").val();
    var anio = $("#hidden_calend_anio").val();

    if(dia == 0 && mes == 0 && anio == 0){
      Mensaje("No se ha seleccionado ninguna fecha", function(){});
      return;
    }
    $.fn.Mensaje({
      mensaje: "¿Desea registrar la lección para el " + dia + "-" + mes + "-" + anio + "?",
      tipo: "SiNo",
      funcionSi: function(){
        SubmitForm($("#form-fecha"), false, function(data, a){
          Mensaje("Se actualizó la fecha de la lección", function(){
            location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();
          
            // CargarPagina("gleccion/_view_leccion", {
            //   curso: $("#hidden_curso").val(),
            //   modulo : $("#hidden_modulo").val(),
            //   leccion : $("#hidden_leccion").val(),
            // }, false, false);
          })
        });
      }
    });
  });
});
</script>
