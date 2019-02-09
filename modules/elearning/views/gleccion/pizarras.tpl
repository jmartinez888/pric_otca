{extends 'template.tpl'}

{block 'meta'}
<meta name="data-parse" content='{json_encode($data_vue)}'>
{/block}

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
      <a href="{$_layoutParams.root}elearning/gcurso/_view_finalizar_registro/{$idcurso}" class="btn btn-danger margin-t-10 " id="btn_nuevo" ><i class="glyphicon glyphicon-triangle-left"></i> {$lang->get('str_regresar')}</a>
    </div>

		<div class="col-sm-12">
			 <div class="panel panel-default">
        <div class="panel-heading cabecera-titulo">
          <h3 class="panel-title">
            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
            <strong>{$lang->get('str_pizarras')}</strong>
          </h3>
        </div>
        <div class="panel-body" id="formulario_pizarras_vue">
          
          <div class="col-lg-12">
            <form class="form">
              <div class="form-group">
                  <a href="{$_layoutParams.root}elearning/gleccion/agregar_pizarra/{$curso['Cur_IdCurso']}" class="btn btn-success margin-t-10 " id="" ><i class="glyphicon glyphicon-triangle-plus"></i> {$lang->get('elearning_cursos_agregar_pizarra')}</a>
              </div>
            </form>
          </div>
          <div class="col-sm-12">
            <form class="form-inline" role="form" @submit.prevent="onSubmit_filtrarEncuestas">
              <div class="form-group">
                <input type="text" v-model="filter.txt_encuesta" class="form-control" id="" placeholder="{$lang->get('str_encuesta')}">
              </div>
                
              <div class="form-group">
                <label for="sel_modulos">{$lang->get('str_modulos')}</label>
                <select id="sel_modulos"  class="form-control" v-model="filter.sel_modulo">
                  <option value="-1">{$lang->get('str_todas')}</option>
                  {foreach $modulos as $item}
                  <option value="{$item.Moc_IdModuloCurso}">{$item.Moc_Titulo}</option>
                  {/foreach}
                </select>
              </div>
              <button type="submit" class="btn btn-primary">{$lang->get('str_buscar')}</button>
            </form>
          </div>

          <div class="col-lg-12">
            
            <table class="table wi-100" id="tbl_pizarras" ref="tbl_pizarras">
              <thead>
                <tr>
                  <th>{$lang->get('str_encuesta')}</th>
                  <th>{$lang->get('str_descripcion')}</th>
                  <th>{$lang->get('str_modulo')}</th>
                  <th width="150">{$lang->get('str_operacion')}</th>
                </tr>
              </thead>
              <tbody></tbody>
            </table>
            
          </div>
        </div>
      </div>
		</div>

</div>








{/block}
{block 'template' append}
<template id="tpl_btn_pizarras">
  <a href="{$_layoutParams.root}elearning/gleccion/_view_leccion/{$curso['Cur_IdCurso']}/{$item->Moc_IdModuloCurso}/{literal}{{leccion_id}}{/literal}" class="btn btn-default  btn-acciones  btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_ver_respuestas')}"><i class="glyphicon glyphicon-pencil"></i></a>
  <a href="{$_layoutParams.root}elearning/gleccion/asistencia/{literal}{{leccion_id}}{/literal}" class="btn btn-default btn-acciones btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_asistencia')}"><i class="glyphicon glyphicon-user"></i></a>
  <button data-id="{literal}{{leccion_id}}{/literal}" class="btn  btn-acciones btn-default btn-acciones btn-eliminar btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_eliminar')}"><i class="glyphicon glyphicon-trash"></i></button>
</template>
{/block}
{block 'js' append}

<script src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript" src="{BASE_URL}modules/elearning/views/gleccion/js/pizarras.js"></script>


{/block}