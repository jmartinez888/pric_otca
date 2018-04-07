<style>
  .btnEditar{
    position: absolute;top: 0px; right: 0px;
  }
  .item-contenido{
    position: relative;
    color: #333;
    border-bottom: 1px solid #ddd;
    padding-bottom: 10px;
  }
</style>

{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}

{include file='modules/elearning/views/gleccion/menu/lec_ref_mat.tpl'}
{include file='modules/elearning/views/gleccion/menu/lec_titulo.tpl'}
<div class="col-lg-9">
  <div class="panel panel-default margin-top-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Contenido: {$leccion.Lec_Titulo}</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <div class="col-lg-12">
        {if isset($contenido) && count($contenido) > 0 }
          {foreach from=$contenido item=c}
            <div class="margin-top-10 item-contenido">
              <strong>{$c.CL_Titulo}</strong>
              <div>{substr($c.CL_Descripcion, 0, 100)}...</div>
              <input class="hidden_IdContenido estado" value="{$c.CL_IdContenido}"/>
              <input class="hidden_TituloContenido estado" value="{$c.CL_Titulo}"/>
              <input class="hidden_Contenido estado" value="{$c.CL_Descripcion}"/>
              <button class="btnEditar"><i class="glyphicon glyphicon-pencil"></i></button>
            </div>
          {/foreach}
        {else}
          <div>Esta lección esta vacía</div>
        {/if}
      </div>
      <div class="col-lg-12">
        <button class="btn btn-success margin-top-10 pull-right" type="button" id="btn_nuevo_contenido">
          <i class="glyphicon glyphicon-book"></i> Agregar Contenido
        </button>
      </div>
    </div>
  </div>
</div>
{if $curso.Mod_IdModCurso == 2}
  {include file='modules/elearning/views/gleccion/menu/lec_calendario.tpl'}
{/if}
<div class="modal" id="panelNuevoContenido" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-lg">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Contenido</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">
        <form ></form>
        <form method="POST" action="gleccion/_registrar_contenido" id="frm_registro_contenido">
          <div class="col-lg-12 margin-top-10"><strong>Titulo</strong></div>
          <input hidden="hidden" value="{$leccion.Lec_IdLeccion}" name="leccion"/>
          <div class="col-lg-12"><input class="form-control" name="titulo" id="inTituloCon"/></div>
          <div class="col-lg-12 margin-top-10"><strong>Contenido</strong></div>
          <div class="col-lg-12">
            
            <textarea class="form-control" id="inContenidoCon" name="contenido" rows="15" placeholder="Ingrese contenido html, a excepción de etiquetas Javascript"></textarea></div>
          <div class="col-lg-12 margin-top-10"><button class="btn btn-success" id="btn_registrar_contenido">Registrar</button></div>
        </form>
      </div>
    </div>
  </div>
</div>


<div class="modal" id="panelEditarContenido" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-lg">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Editar Contenido</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">
        <form ></form>
        <form method="POST" action="gleccion/_modificar_contenido" id="frm_modificar_contenido">
          <div class="col-lg-12 margin-top-10"><strong>Titulo</strong></div>
          <input hidden="hidden" name="id" id="inEditId"/>
          <div class="col-lg-12"><input class="form-control" name="titulo" id="inEditTitulo"/></div>
          <div class="col-lg-12 margin-top-10"><strong>Contenido</strong></div>
          <div class="col-lg-12">
            <textarea class="form-control" id="inEditContenido" name="contenido" rows="15" placeholder="Ingrese contenido html, a excepción de etiquetas Javascript"></textarea>
          </div>
          <div class="col-lg-12 margin-top-10"><button class="btn btn-success" id="btn_editar_contenido">Actualizar</button></div>
        </form>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="{$_url}gleccion/js/_view_1.js"></script>
