{include file='modules/elearning/views/gleccion/menu/leccion.tpl'}
<div class="col-lg-9">
  <div class="panel panel-default margin-top-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>{$leccion.Lec_Titulo}</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <div class="col-lg-12">
        {if isset($contenido) && count($contenido) > 0 }
          {foreach from=$contenido item=c}
            <div class="margin-top-10">
              <strong>{$c.CL_Titulo}</strong>
              <div>{$c.CL_Descripcion}</div>
            </div>
              {print_r($c)}
          {/foreach}
        {else}
          <div>Esta lección esta vacía</div>
        {/if}
      </div>
    </div>
  </div>
  <div class="col-lg-12">
    <button class="btn btn-success" type="button" id="btn_nuevo_contenido">
      <i class="glyphicon glyphicon-book"></i> Agregar Contenido
    </button>
  </div>
</div>


<div class="modal" id="panelNuevoContenido" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-lg">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Contenido</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">
        <form method="post" action="gleccion/_registrar_contenido">
          <div class="col-lg-12 margin-top-10"><strong>Titulo</strong></div>
          <input hidden="hidden" value="{$leccion.Lec_IdLeccion}" name="leccion"/>
          <div class="col-lg-12"><input class="form-control" name="titulo" id="inTituloCon" /></div>
          <div class="col-lg-12 margin-top-10"><strong>Contenido</strong></div>
          <div class="col-lg-12"><textarea class="form-control" id="inContenidoCon" name="contenido" rows="15" placeholder="Ingrese contenido html, a excepción de etiquetas Javascript"></textarea></div>
          <div class="col-lg-12 margin-top-10"><button class="btn btn-success" id="btn_registrar_contenido">Registrar</button></div>
        </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="{$_url}gleccion/js/_view_1.js"></script>
