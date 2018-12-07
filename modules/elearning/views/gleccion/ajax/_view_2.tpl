{extends 'index_elearning.tpl'}
{block 'css' append}
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
  /*Tabs*/
  .div_titulo{
    display: block;
  }
  .div_contenido{
    display: none;
  }
  .div_referencias{
    display: none;
  }
  .div_materiales{
    display: none;
  }
  .div_tareas{
    display: none;
  }


  .nav-tabs > .active{
    font-weight: bold;
  }
  .nav-tabs > li.active > a{
    color: #009640 !important;
  }
</style>
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
{include file='modules/elearning/views/gleccion/menu/lec_ref_mat.tpl'}
{include file='modules/elearning/views/gleccion/menu/lec_titulo.tpl'}
<!-- <div class="col-lg-9">
  <div class="panel panel-default margin-top-10"> -->
<div class="col-lg-12 div_contenido ">
  <div class="panel panel-default " style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
    <!-- <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>{$leccion.Lec_Titulo}</strong>
      </h3>
    </div> -->
    <div class="panel-body" >
      {if isset($contenido[0].CL_Descripcion) && count($contenido[0]) >0 }
      <!-- <div class="col-lg-12">
        <iframe width="100%" height="400" src="{$contenido[0].CL_Descripcion}" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen> </iframe>
      </div> -->

      <div class="col-md-12">
        {if strlen({$contenido[0].CL_Descripcion})>0}
              <div class="col-md-offset-1 col-md-10 " id="div_video" style="padding: 5px; border: 2px solid #00a65a;">
                  <object width="100%" height="344">
                    <param name="movie" id="video_curso_param"  value="http://www.youtube.com/v/{$contenido[0].CL_Descripcion}"></param>
                    <param name="allowFullScreen" value="true"></param>
                    <param name="allowscriptaccess" value="always"></param>
                    <embed id="video_curso_embed" src="http://www.youtube.com/v/{$contenido[0].CL_Descripcion}" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="100%" height="344"></embed>
                  </object>
              </div>
          {else}
              <div class="col-md-offset-3 col-md-6 hidden" id="div_video" style="padding: 5px; border: 2px solid #00a65a;">
                  <object width="100%" height="344">
                    <param name="movie" id="video_curso_param" value=""></param>
                    <param name="allowFullScreen" value="true"></param>
                    <param name="allowscriptaccess" value="always"></param>
                    <embed id="video_curso_embed" src="" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="100%" height="344"></embed>
                  </object>
              </div>
          {/if}
      </div>

      {/if}
      <div class="col-lg-12">
        <label>Link video</label>
        <input hidden="hidden" value="{$contenido[0].CL_IdContenido}" id="in_id_video" />
        <input class="form-control" value="https://www.youtube.com/watch?v={$contenido[0].CL_Descripcion}" id="in_link_video" />
      </div>
      <div class="col-lg-12 margin-top-10">
        <label>Descripcion</label>
        <textarea class="form-control" id="in_descripcion_video" rows="5">{$leccion.Lec_Descripcion}</textarea>
      </div>
      <div class="col-lg-12 margin-top-10">
        <button class="btn btn-success pull-right" type="button" id="btn_nuevo_contenido">
          <i class="glyphicon glyphicon-book"></i> Actualizar
        </button>
      </div>
    </div>
  </div>
</div>
{if $curso.Moa_IdModalidad == 2}
  {include file='modules/elearning/views/gleccion/menu/lec_calendario.tpl'}
{/if}

{/block}

{block 'js' append}
<script type="text/javascript" src="{$_url}gleccion/js/_view_2.js"></script>
{/block}
