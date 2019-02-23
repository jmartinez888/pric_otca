{extends 'template.tpl'}

{block 'meta'}
<meta name="data-parse" content='{json_encode(['leccion_id' => $idLeccion])}'>
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
            {if isset($idLeccion) && $idLeccion > 0}
                {include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
            {else}
                {$titulo}
            {/if}
            </div>
        </div>
    </div>
    <div class="col-sm-12 pb-4">
      <a href="{$_layoutParams.root}elearning/gleccion/encuestas/{$idcurso}" class="btn btn-danger margin-t-10 " id="btn_nuevo" ><i class="glyphicon glyphicon-triangle-left"></i> {$lang->get('str_regresar')}</a>
    </div>

	{if $formulario != null}

    <div class="col-xs-12">
		  <ul class="nav nav-tabs" role="tablist">
		    <li role="presentation" class="" id="item_modulo"><a data-toggle="tab" href="#item" aria-controls="item">{strtoupper($lang->get('str_encuesta'))}</a></li>
		    <li role="presentation" id="item_lecciones" ><a data-toggle="tab" href="#respuestas" aria-controls="respuestas">{strtoupper($lang->get('str_respuestas'))}</a></li>
		    <li role="presentation" class="active" id="item_reporte" ><a data-toggle="tab" href="#reportes" aria-controls="respuestas">{strtoupper($lang->get('str_reportes'))}</a></li>
		  </ul>
		</div>

		<div class="tab-content">
			<div class="col-xs-12 div_lecciones tab-pane " id="item" role="tabpanel">
			  <div class="panel panel-default" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
			    <!-- <div class="panel-heading">
			      <h3 class="panel-title">
			        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
			        <strong>Lecciones del Módulo</strong>
			      </h3>
			    </div> -->
			    <div class="panel-body" >
			    	{if $formulario != null}
							<div id="formulario_editar_vue">

				        <button class="btn btn-success" type="" @click.prevent="onClick_agregarTag" id="btn_agregar">{$lang->get('elearning_formulario_responder_add_pregunta')}</button>
				        <button class="btn btn-success" type="" @click.prevent="onClick_agregarTitulo" id="btn_agregar">{$lang->get('elearning_formulario_responder_add_titulo')}</button>
				        <hr>
				        <div class="" id="container_tags">
				          <div class="tags_input_edit col-sm-12 hh" @click="onClick_editar(event, 'titulo_frm')">
				            <input-tags   v-key="'titulo_frm'" v-bind:element="element_titulo" class="col-sm-12 yy" ></input-tags>
				          </div>
				          <div class="tags_input_edit col-sm-12 hh" v-for="(tag, index) in tags" :id="'tag_edit_' + tag.id"  :ref="'tag_edit_' + tag.id" @click="onClick_editar(event, tag.id)">
				            <input-tags   v-key="tag.id" v-bind:element="tag" v-on:delete_tag="tags.splice(index, 1)" class="col-sm-12 yy" ></input-tags>
				          </div>
				        </div>

				      </div>

			      {/if}

			    </div>
			  </div>
			</div>
			<div class="col-xs-12 div_lecciones tab-pane" id="respuestas" role="tabpanel">
			  <div class="panel panel-default" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
			    <!-- <div class="panel-heading">
			      <h3 class="panel-title">
			        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
			        <strong>Lecciones del Módulo</strong>
			      </h3>
			    </div> -->
			    <div class="panel-body" id="formulario_respuestas_vue">
						<div class="col-lg-12">
							<form class="form-inline" role="form" @submit.prevent="onSubmit_filtrarRespuestas">
								<div class="form-group">
									<input type="text" v-model="filter.txt_query" class="form-control" id="" placeholder="{$lang->get('str_alumno')}">
								</div>
								<button type="submit" class="btn btn-primary">{$lang->get('str_buscar')}</button>
							</form>
						</div>
	          <div class="col-lg-12" >
	            
							<table class="table wi-100" id="tbl_frm_respuestas" ref="tbl_frm_respuestas">
								<thead>
									<tr>
										<th>Id</th>
										<th>{$lang->get('str_alumnos')}</th>
										<th>{$lang->get('str_usuarios')}</th>
										<th>{$lang->get('str_fecha')}</th>
										<th>{$lang->get('str_operacion')}</th>
									</tr>
								</thead>
								<tbody></tbody>
							</table>
	            
	          </div>

			    </div>
			  </div>
			</div>
			<div class="col-xs-12 div_lecciones tab-pane active" id="reportes" role="tabpanel">
				<div class="panel panel-default" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
					<div class="panel-body" id="formulario_reportes_vue">
						<div class="col-lg-12">
							
							<a href="{$_layoutParams.root}elearning/gleccion/encuesta_resumen_export/{$idLeccion}/excel" class="btn btn-success">{$lang->get('elearning_cursos_descargar_resumen')}</a>
							<hr>	
						</div>
						
						<div class="col-lg-12">
								<form role="form" >
									{foreach $formulario->preguntas as $pre}
										<input-tags-resume 
										data-pregunta='{json_encode($pre->formatToArray(['descripcion']))}'
										data-resumen='{json_encode($pre->resumenRespuesta())}'
										></input-tags-resume>
									{/foreach}
								</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	{else}
		<h3>{$lang->get('elearning_cursos_no_posee_encuesta')}</h3>
	{/if}
</div>








{/block}
{block 'template' append}
	{if $formulario != null}
  	{include 'input_tags.tpl'}
	{/if}}
<template id="tag-resumen">
		<div class="form-group">
				<label class="control-label">{literal}{{objPregunta.pregunta}}{/literal}</label>
				<span style="display: block;">{$formulario->respuestas()->count()} {strtolower($lang->get('str_respuestas'))}</span>
				<div class="container-resumen">
					<div class="display-resumen" v-if="objPregunta.tipo == 'texto' || objPregunta.tipo == 'parrafo' || objPregunta.tipo == 'fecha' || objPregunta.tipo == 'hora'">
						<table class="table table-condensed table-hover">
							<tbody>
								<tr v-for="textos in dataResumen">
									<td v-html="textos.respuesta"></td>	
								</tr>
							</tbody>
						</table>
						
					</div>
					<div class="display-resumen fn-select fn-radio" v-if="objPregunta.tipo == 'select' || objPregunta.tipo == 'radio'">
						<div class="chart-select" ref="chartSelect"></div>
					</div>
					<div class="display-resumen fn-box" v-if="objPregunta.tipo == 'box'">
						<div ref="chartBox"></div>
					</div>
					<div class="display-resumen" v-if="objPregunta.tipo == 'cuadricula'" >
							<div ref="chartCuadrilla" style="height: 500px"></div>
					</div>
					<div class="display-resumen" v-if="objPregunta.tipo == 'casilla'" >
							<div ref="chartCuadrilla" style="height: 500px"></div>
					</div>
				</div>
				<hr>
		</div>
		
	
	</div>
</template>
<template id="tpl_btn_frm_encuestas">
	<a href="{$_layoutParams.root}elearning/formulario/respuesta/{literal}{{formulario_respuesta_id}}{/literal}" class="btn btn-default btn-acciones btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_ver_respuestas')}"><i class="glyphicon glyphicon-file"></i></a>
	<button data-id="{literal}{{formulario_respuesta_id}}{/literal}" class="btn btn-default btn-acciones btn-eliminar  btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_eliminar')}"><i class="glyphicon glyphicon-trash" data-id="{literal}{{formulario_respuesta_id}}{/literal}"></i></button>
</template>
{/block}
{block 'js' append}
{if ($formulario != null)}
<script type="text/javascript">
  var data_frm = {json_encode($formulario->formatToArray())};
</script>

<script src="{BASE_URL}public/vendors/amcharts/core.js" type="text/javascript"></script>
<script src="{BASE_URL}public/vendors/amcharts/charts.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript" src="{BASE_URL}modules/elearning/views/gcurso/js/formulario.js"></script>

{/if}
{/block}