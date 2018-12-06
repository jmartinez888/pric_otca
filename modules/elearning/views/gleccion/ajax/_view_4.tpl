{extends 'index_elearning.tpl'}
{block 'css' append}
<link rel="stylesheet" href="{BASE_URL}modules/elearning/views/gleccion/css/_view_4.css" />
{/block}

{block 'subcontenido'}
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
<!--  Tabs-->
<div class="col-lg-12">
  <ul class="nav nav-tabs">
    <li role="presentation" class="active" id="item_titulo"><a href="#">TÍTULO</a></li>
    <li role="presentation" id="item_contenido" ><a href="#">CONTENIDO</a></li>
    <li role="presentation" id="item_referencias"><a href="#">REFERENCIAS</a></li>
    <li role="presentation" id="item_materiales" ><a href="#">MATERIAL DIDÁCTICO</a></li>
  </ul>
</div>

{include file='modules/elearning/views/gleccion/menu/lec_titulo.tpl'}
{include file='modules/elearning/views/gleccion/menu/lec_ref_mat.tpl'}

<div class="col-lg-12">
  <div class="panel panel-default margin-t-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Pizarra Interactiva</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <div class="col-lg-12">
        {if isset($pizarras) && count($pizarras) > 0}
          {foreach from=$pizarras item=p}
            <div class="col-lg-6">
              <div class="panel item-pizarra">
                <input class="hidden_IdPizarra" value="{$p.Piz_IdPizarra}" hidden="hidden"/>
                <img src="{BASE_URL}files/elearning/_pizarra/{$p.Piz_ImgFondo}" />
                <button class="btn btn-default btn-quitar-pizarra"><span class="glyphicon glyphicon-trash"></span></button>
              </div>
            </div>
          {/foreach}
        {else}
          <div>No se ha creado ninguna pizarra para esta lección</div>
        {/if}
      </div>
      <div class="col-lg-12">
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
  <div class="modal-dialog modal-lg">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Pizarra</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body" style="padding: 10px !important">
        <!--label>Título</label>
        <input class="form-control" value="" id="tmp_titulo_pizarra" /-->
        <label id="lb_help">Haga click en un punto y deslice el mouse para dibujar la imagen</label>
        <input hidden="hidden" value="" id="tmp_img_url" />
        <input hidden="hidden" value="" id="tmp_piz_x" />
        <input hidden="hidden" value="" id="tmp_piz_y" />
        <input hidden="hidden" value="" id="tmp_piz_width" />
        <input hidden="hidden" value="" id="tmp_piz_height" />
        <center>
          <div class="contenido-pizarra">
            <canvas height="400px" width="700px" id="micanvas" class="no-seleccionable"></canvas>
          </div>
        </center>
        <button class="btn btn-success" id="btn-guardar-pizarra">Guardar Pizarra</button>
        <button class="btn btn-success" id="btn-cargar-img-pizarra">Cargar Imagen</button>
        <button class="btn btn-info" id="btn-cancelar-nueva-pizarra">Cancelar</button>
      </div>
    </div>
  </div>
</div>
{/block}
{block 'js' append}
<script type="text/javascript" src="{$_url}gleccion/js/_view_2.js"></script>
<script type="text/javascript" src="{$_url}gleccion/js/_view_4.js"></script>
<script type="text/javascript" src="{$_url}gleccion/js/_view_canvas.js"></script>
{/block}