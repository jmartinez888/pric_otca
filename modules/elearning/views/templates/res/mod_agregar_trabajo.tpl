<div class="modal fade" id="panelNuevoTrabajo" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-xs">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Tarea</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">        
        <form id="frm_registro_trabajo" method="POST" action="gtrabajo/_registrar_trabajo">
          <div class="col-lg-12 margin-t-10"><strong>Titulo</strong></div>
          <input hidden="hidden" value="{$leccion.Lec_IdLeccion}" name="leccion"/>
          <div class="col-lg-12">
            <input class="form-control" name="titulo" id="inTituloTra" />
          </div>
          <div class="col-lg-12 margin-t-10"><strong>Tipo Tarea</strong></div>
          <div class="col-lg-12">
            <select class="form-control" name="tipo" id="slTipoTra">
              <option value="-1" selected="selected" disabled="disabled">Seleccione una opción</option>
              {foreach from=$tipo_trabajo item=c}
              <option value="{$c.Con_Valor}">{$c.Con_Descripcion}</option>
              {/foreach}
            </select>
          </div>
          <div class="col-lg-12 margin-t-10"><strong>Descripción</strong></div>
          <div class="col-lg-12">
            <textarea class="form-control" name="descripcionTra" id="inDescTra" rows="4" maxlength="300"></textarea>
          </div>
          <div class="col-lg-6" style="margin-top: 10px">
            <label>Activo desde: </label>
            <input class="form-control" name="desde" id="inDesdeTraDate" readonly="true" style="cursor: pointer;"/>
          </div>
          <div class="col-lg-6" style="margin-top: 10px">
            <label>Activo hasta: </label>
            <input class="form-control" name="hasta" id="inHastaTraDate" readonly="true" style="cursor: pointer;"/>
          </div>
          <div class="col-lg-12 margin-t-10">
            <button class="btn btn-success" id="btn_registrar_trabajo">Registrar</button>
          </div>
        <form>
      </div>
    </div>
  </div>
</div>