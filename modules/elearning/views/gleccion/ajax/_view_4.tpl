{extends 'index_elearning.tpl'}
{block 'css' append}
<link rel="stylesheet" href="{BASE_URL}modules/elearning/views/gleccion/css/_view_4.css" />
{/block}

{block 'subcontenido'}
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
<!--  Tabs-->
<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  <ul class="nav nav-tabs">
    <li role="presentation" class="active" id="item_titulo"><a href="#">TÍTULO</a></li>
    <li role="presentation" id="item_contenido" ><a href="#">CONTENIDO</a></li>
    <li role="presentation" id="item_referencias"><a href="#">REFERENCIAS</a></li>
    <li role="presentation" id="item_materiales" ><a href="#">MATERIAL DIDÁCTICO</a></li>
  </ul>
</div>

{include file='modules/elearning/views/gleccion/menu/lec_titulo.tpl'}
{include file='modules/elearning/views/gleccion/menu/lec_ref_mat.tpl'}

<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
  <div class="panel panel-default margin-t-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Pizarra Interactiva</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" id="container-img-pizarra">
        {if isset($pizarras) && count($pizarras) > 0}

          {foreach from=$pizarras item=p key=i}
            <div class="panel-item-pizarra">
              <div class="panel item-pizarra">
                <input class="hidden_IdPizarra" value="{$p.Piz_IdPizarra}" hidden="hidden"/>
                {if trim($p.Piz_ImgFondo) == ''}
                <img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAQAAADa613fAAAAaElEQVR42u3PQREAAAwCoNm/9CL496ABuREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREWkezG8AZQ6nfncAAAAASUVORK5CYII=" />
                {else}
                <img src="{BASE_URL}files/elearning/_pizarra/{$p.Piz_ImgFondo}" />
                {/if}
                <button class="btn btn-default btn-quitar-pizarra"><span class="glyphicon glyphicon-trash"></span></button>
                <strong class="number_pizarra">{$i + 1}</strong>
              </div>
            </div>
          {/foreach}
        {else}
          <div>{$lang->get('elearning_cursos_no_se_encontro_pizarra_en_leccion')}</div>
        {/if}
      </div>
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <button class="btn btn-success pull-right" type="button" id="btn_nueva_pizarra">
          <i class="glyphicon glyphicon-book"></i> Agregar Pizarra
      </button>
    </div>
  </div>
  </div>
</div>

{if $curso.Moa_IdModalidad == 2}
  {include file='modules/elearning/views/gleccion/menu/lec_calendario.tpl'}
{/if}

<div class="modal fade" id="panelNuevaPizarra" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-lg" style="width: 700px !important">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Pizarra</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body" style="padding: 10px !important; text-align: center">
        <center>
          <div class="contenido-pizarra">
            <canvas width="650px" id="micanvas" class="no-seleccionable"></canvas>
          </div>
        </center>
        <button class="btn btn-success" id="btn-cargar-img-pizarra">{$lang->get('elearning_cursos_cargar_imagen')}</button>
        <button class="btn btn-success" id="btn-quitar-imagen">{$lang->get('elearning_cursos_quitar_imagen')}</button>
        <button class="btn btn-success" id="btn-limpiar-pizarra">{$lang->get('elearning_cursos_limpiar_imagen')}</button>
        <button class="btn btn-success" id="btn-guardar-pizarra">{$lang->get('elearning_cursos_guardar_imagen')}</button>
        <label id="click_img" class="hidden" for="file_img"></label>
        <input id="file_img" type="file" class="hidden">
        <button class="btn btn-info" id="btn-cancelar-nueva-pizarra">{$lang->get('str_cancelar')}</button>
      </div>
    </div>
  </div>
</div>
{/block}
{block 'js' append}
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/vendors/fabric/fabric.beautified.min.js"></script>
<script type="text/javascript" src="{$_url}gleccion/js/_view_2.js"></script>
<script type="text/javascript" src="{$_url}gleccion/js/_view_4.js"></script>
<script type="text/javascript" src="{$_url}gleccion/js/_view_canvas.js"></script>
{/block}