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
            {if isset($idLeccion) && $idLeccion > 0}
                {include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
            {else}
                {$titulo}
            {/if}
            </div>
        </div>
    </div>
    <div class="col-sm-12 pb-4">
      <a href="{$_layoutParams.root}elearning/gleccion/_view_lecciones_modulo/{$idcurso}/{$modulo.Moc_IdModuloCurso}" class="btn btn-danger margin-t-10 " id="btn_nuevo" ><i class="glyphicon glyphicon-triangle-left"></i> Regresar</a>
    </div>

	{if $formulario != null}

    <div class="col-xs-12">
		  <ul class="nav nav-tabs" role="tablist">
		    <li role="presentation" class="active" id="item_modulo"><a data-toggle="tab" href="#item" aria-controls="item">ENCUESTA</a></li>
		    <li role="presentation" id="item_lecciones" ><a data-toggle="tab" href="#respuestas" aria-controls="respuestas">RESPUESTAS</a></li>
		  </ul>
		</div>

		<div class="tab-content">
			<div class="col-xs-12 div_lecciones tab-pane active" id="item" role="tabpanel">
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
			    <div class="panel-body" >

	          <div class="col-lg-12" id="formulario_respuestas_vue">
	            <div class="table-responsive" style="width: 100%">
	              <table class="table" id="tblMisCursos">
	                <thead>
	                  <tr>
	                    <th>Id</th>
	                    <th>{$lang->get('str_alumnos')}</th>
	                    <th>{$lang->get('str_usuarios')}</th>
	                    <th>{$lang->get('str_fecha')}</th>
	                    <th>{$lang->get('str_operacion')}</th>
	                  </tr>
	                </thead>
	                <tbody>
	                  {foreach $respuestas as $res}
	                    <tr>
	                      <td>{$res->usuario->Usu_IdUsuario}</td>
	                      <td>{$res->usuario->Usu_Nombre} {$res->usuario->Usu_Apellidos}</td>
	                      <td>{$res->usuario->Usu_Usuario}</td>
	                      <td>{$res->Fur_CreatedAt}</td>
	                      <td>
	                        <a href="{$_layoutParams.root}elearning/formulario/respuesta/{$res->Fur_IdFrmUsuRes}" class="btn btn-default  btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_ver_respuestas')}"><i class="glyphicon glyphicon-file"></i></a>
	                        <button data-id="{$res->Fur_IdFrmUsuRes}" @click="onClick_deleteRespuesta({$res->Fur_IdFrmUsuRes})" class="btn btn-default  btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_ver_respuestas')}"><i class="glyphicon glyphicon-trash"></i></button>
	                      </td>
	                    </tr>
	                  {/foreach}
	                </tbody>
	              </table>
	            </div>
	          </div>

			    </div>
			  </div>
			</div>
		</div>
	{else}
		<h3>No posee encuesta</h3>
	{/if}
</div>








{/block}
{block 'template' append}
	{if $formulario != null}
  	{include 'input_tags.tpl'}
	{/if}}

{/block}
{block 'js' append}
{if ($formulario != null)}
<script type="text/javascript">
  var data_frm = {json_encode($formulario->formatToArray())};
</script>
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