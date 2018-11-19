<div class="col-xs-12  div_titulo">
  <div class="panel panel-default " style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
    <!-- <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Datos Lección</strong>
      </h3>
    </div> -->
    <div class="panel-body" >
      <form id="form-datos-leccion" action="gleccion/_actualizar_leccion" method="post">
      <label>Titulo</label>
      <input name="titulo" class="form-control" value="{$leccion.Lec_Titulo}" />
      <div class="col-xs-12 margin-top-10">
          <label class="">Descripción</label>
          <textarea name="descripcion" class="form-control" rows="5">{$examen.Exa_Descripcion}</textarea>
        </div>
      <input hidden="hidden" id="hidden_curso" name="id_curso" value="{$curso.Cur_IdCurso}" />
      <input name="id_modulo" id="hidden_modulo" hidden="hidden" value="{$modulo.Moc_IdModuloCurso}" />
      <input name="id_leccion" id="hidden_leccion" hidden="hidden" value="{$leccion.Lec_IdLeccion}" />
      </form>
      <button class="btn btn-success pull-right margin-top-10" id="btn-actualizar-leccion">Actualizar</button>
    </div>
  </div>
</div>

<script type="text/javascript">
$("#btn-actualizar-leccion").click(function(){
  SubmitForm( $("#form-datos-leccion"), $(this), function(data, e){
    Mensaje("Datos actualizados", function(){
      location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + $("#hidden_curso").val() + "/" + $("#hidden_modulo").val() + "/" + $("#hidden_leccion").val();      
      // CargarPagina("gleccion/_view_leccion", {
      //   curso: $("#hidden_curso").val(),
      //   modulo : $("#hidden_modulo").val(),
      //   leccion : $("#hidden_leccion").val(),
      // }, false, false);
    })
  });
});
</script>
