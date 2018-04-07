<style>
  .item-referencia{
    position: relative;
    margin-bottom: 10px;
    border-bottom: 1px solid #ddd;
  }
  .btnEliminar{
    position: absolute; top: 0px; right: 0px;
  }
</style>
<div class="col-lg-3">
  <div class="panel panel-default margin-top-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Referencias</strong>
      </h3>
    </div>
    <div class="panel-body">
      {if isset($referencias) && count($referencias) > 0 }
        {foreach from=$referencias item=r}
          <div class="item-referencia">
            <input class="Hidden_IdReferencia" hidden="hidden" value="{$r.Ref_IdReferencia}" />
            <strong>{$r.Ref_Titulo}</strong>
            <div>{$r.Ref_Descripcion}</div>
            <button class="btnEliminar"><i class="glyphicon glyphicon-trash"></i></button>
          </div>
        {/foreach}
      {else}
        <div>No tienes referencias</div>
      {/if}
      <button class="btn btn-default" id="btn_agregar_referencia">Agregar</button>
    </div>
  </div>

  <div class="panel panel-default margin-top-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Material Didáctico</strong>
      </h3>
    </div>
    <div class="panel-body">
        <div>No tienes material didáctico</div>
        <button class="btn btn-default">Agregar</button>
    </div>
  </div>
</div>



<div class="modal" id="panelNuevaReferencia" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-xs">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Referencia</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">
        <form id="frm_registro_referencia" method="post" action="gleccion/_registrar_referencia">
          <div class="col-lg-12 margin-top-10"><strong>Titulo</strong></div>
          <input hidden="hidden" value="{$leccion.Lec_IdLeccion}" name="leccion"/>
          <div class="col-lg-12"><input class="form-control" name="titulo" id="inTituloRef" /></div>
          <div class="col-lg-12 margin-top-10"><strong>Referencia</strong></div>
          <div class="col-lg-12"><input class="form-control" name="descripcion" id="inDescripcionRef" /></div>
          <div class="col-lg-12 margin-top-10"><button class="btn btn-success" id="btn_registrar_referencia">Registrar</button></div>
        <form>
      </div>
    </div>
  </div>
</div>


<script type="text/javascript">
  $("#btn_agregar_referencia").click(function(){
    $("#panelNuevaReferencia").modal("show");
    $("#inTituloRef").focus();
  });
  $("#btn_registrar_referencia").click(function(e){
    e.preventDefault();
    $.fn.Mensaje({ mensaje: "¿Desea registrar esta referencia?", tipo: "SiNo",
      funcionSi: function(){
        SubmitForm($("#frm_registro_referencia"), $(this), function(data, e){
          CargarPagina("gleccion/_view_leccion", {
            curso: $("#hidden_curso").val(),
            modulo : $("#hidden_modulo").val(),
            leccion : $("#hidden_leccion").val(),
          }, false, false);
        });
      }
    });
  });
  $(".btnEliminar").click(function(){
    var IdRef = $(this).parent().find(".Hidden_IdReferencia").val();
    $.fn.Mensaje({ mensaje: "¿Seguro de quitar esta referencia?", tipo: "SiNo",
      funcionSi: function(){
        AsincTaks("gleccion/_eliminar_referencia", { id : IdRef }, function(a){
          CargarPagina("gleccion/_view_leccion", {
            curso: $("#hidden_curso").val(),
            modulo : $("#hidden_modulo").val(),
            leccion : $("#hidden_leccion").val(),
          }, false, false);
        }, null);
      }
    });
  });
</script>
