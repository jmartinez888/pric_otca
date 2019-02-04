{extends 'template.tpl'}


{block 'css' append}
<style type="text/css">
    .tag-url{
        color: #75ACE5;
        display: inline-block;
        cursor: pointer;
    }
</style>
{/block}
{block 'contenido'}


{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-xs-12 col-sm-12 col-md-9 col-lg-10">


    <div class="col-xs-12">
        <div class=" " style="margin-bottom: 0px !important">
            <div class="text-center text-bold" style="margin-top: 20px; margin-bottom: 20px; color: #267161;">

                {include file='modules/elearning/views/gestion/menu/tag_url.tpl'}

            </div>
        </div>
    </div>
    <div class="col-sm-12 pb-4">
      <a href="{$_layoutParams.root}elearning/gleccion/asistencia/{$objLeccion->Lec_IdLeccion}" class="btn btn-danger margin-t-10 " id="btn_nuevo" ><i class="glyphicon glyphicon-triangle-left"></i> {$lang->get('str_regresar')}</a>
    </div>

		<div class="col-sm-12">
			 <div class="panel panel-default">
        <div class="panel-heading cabecera-titulo">
          <h3 class="panel-title">
            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
            <strong>{$lang->get('elearning_cursos_detalles_asistencia_alumno')}</strong>
          </h3>
        </div>
        <div class="panel-body" style=" margin: 15px 25px">
          <div class="col-lg-12" id="asistencia_leccion_vue">
            <table-asistencia-detalles v-for="tad in refids" 
            :leccion-asistencia="tad.leccion_asistencia_id" 
            :leccion-session="tad.leccion_session_id"
            :leccion-session-format="tad.leccion_session_id_format"></table-asistencia-detalles>
          </div>
        </div>
      </div>
		</div>

</div>








{/block}
{block 'template' append}
	{if $formulario != null}
  	{include 'input_tags.tpl'}
	{/if}}

{/block}
{block 'template'}
<template id="tpl-tbl-asistencia-detalles">
  <table ref="tbl_detalles_horas" class="table table-bordered table-hover">
    <thead>
      <tr>
        <th colspan="2">{$lang->get('str_session')}&nbsp;:{literal}{{leccionSessionFormat}}{/literal}</th>
      </tr>
      <tr>
        <th>{$lang->get('str_inicio')}</th>
        <th>{$lang->get('str_fin')}</th>
      </tr>
    </thead>
    <tbody>
    </tbody>
  </table>
  
</template>
{/block}
{block 'js' append}
<script>
  var ASISTENCIAS_REF = {$asistencia_ref->toJson()};
</script>
<script src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript" src="{BASE_URL}modules/elearning/views/gleccion/js/asistencia_detalles.js"></script>


{/block}