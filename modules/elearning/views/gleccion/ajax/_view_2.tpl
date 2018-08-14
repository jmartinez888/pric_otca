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
        <strong>{$leccion.Lec_Titulo}</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      {if isset($contenido[0].CL_Descripcion) && count($contenido[0].CL_Descripcion) >0 }
      <div class="col-lg-12">
        <iframe width="100%" height="400" src="{$contenido[0].CL_Descripcion}" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen> </iframe>
      </div>
      {/if}
      <div class="col-lg-12">
        <label>Link video</label>
        <input hidden="hidden" value="{$contenido[0].CL_IdContenido}" id="in_id_video" />
        <input class="form-control" value="{$contenido[0].CL_Descripcion}" id="in_link_video" />
      </div>
      <div class="col-lg-12 margin-top-10">
        <label>Descripcion</label>
        <textarea class="form-control"  id="in_descripcion_video" rows="5">{$leccion.Lec_Descripcion}</textarea>
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

<script type="text/javascript" src="{$_url}gleccion/js/_view_2.js"></script>
