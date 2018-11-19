<div class="modal fade" id="panelEditarTrabajo" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-xs">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Modificar Tarea</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">
        <form id="frm_actualizar_trabajo" method="POST" action="gtrabajo/_actualizar_trabajo">
          <div class="col-lg-12 margin-top-10"><strong>Titulo</strong></div>
          <input hidden="hidden" id="inUpdIdTrabajo" name="trabajo"/>
          <div class="col-lg-12">
            <input class="form-control" name="titulo" id="inUpdTituloTra" />
          </div>
          <div class="col-lg-12 margin-top-10"><strong>Tipo Tarea</strong></div>
          <div class="col-lg-12">
            <select class="form-control" name="tipo" id="slUpdTipoTra">
              <option value="-1" selected="selected" disabled="disabled">Seleccione una opción</option>
              {foreach from=$tipo_trabajo item=c}
              <option value="{$c.Con_Valor}">{$c.Con_Descripcion}</option>
              {/foreach}
            </select>
          </div>
          <div class="col-lg-12 margin-top-10"><strong>Descripción</strong></div>
          <div class="col-lg-12">
            <textarea class="form-control" name="descripcion" id="inUpdDescTra" rows="4" maxlength="300"></textarea>
          </div>
          <div class="col-lg-6" style="margin-top: 10px">
            <label>Activo desde: </label>
            <input class="form-control" name="desde" id="inUpdDesdeTraDate" readonly="true" style="cursor: pointer;"/>
          </div>
          <div class="col-lg-6" style="margin-top: 10px">
            <label>Activo hasta: </label>
            <input class="form-control" name="hasta" id="inUpdHastaTraDate" readonly="true" style="cursor: pointer;"/>
          </div>
          <div class="col-lg-12" style="margin-top: 10px">
            <label>Archivos adjuntos: </label>
            <div id="divArcAdjTrabajo"></div>
            <button class="btn btn-default" id="btnAgregarArchivoTrabajo">Adjuntar archivo</button>
          </div>
          <div class="col-lg-12 margin-top-10">
            <button class="btn btn-success" id="btn_actualizar_trabajo">Actualizar</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>