<div class="col-lg-9">
  <div class="panel panel-default margin-top-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Datos Lección</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <form></form>
      <form id="form-datos-leccion" action="gleccion/_actualizar_leccion" method="post">
      <label>Titulo</label>
      <input name="titulo" class="form-control" value="{$leccion.Lec_Titulo}" />
      <input name="id" hidden="hidden" value="{$leccion.Lec_IdLeccion}" />
      </form>
      <button class="btn btn-success pull-right margin-top-10" id="btn-actualizar-leccion">Actualizar</button>
    </div>
  </div>
</div>

<script type="text/javascript">
$("#btn-actualizar-leccion").click(function(){
  SubmitForm( $("#form-datos-leccion"), $(this), function(data, e){
    Mensaje("Datos actualizados", function(){
      CargarPagina("gleccion/_view_leccion", {
        curso: $("#hidden_curso").val(),
        modulo : $("#hidden_modulo").val(),
        leccion : $("#hidden_leccion").val(),
      }, false, false);
    })
  });
});
</script>
