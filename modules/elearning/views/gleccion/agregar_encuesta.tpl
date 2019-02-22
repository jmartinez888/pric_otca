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
      <a href="{$_layoutParams.root}elearning/gleccion/{$modo}/{$idcurso}" class="btn btn-danger margin-t-10 " id="btn_nuevo" ><i class="glyphicon glyphicon-triangle-left"></i> {$lang->get('str_regresar')}</a>
    </div>

		<div class="col-sm-12">
			 <div class="panel panel-default">
        <div class="panel-heading cabecera-titulo">
          <h3 class="panel-title">
            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
            <strong>{$lang->get('str_registro')}</strong>
          </h3>
        </div>
        <div class="panel-body" style=" margin: 15px 25px">
        	<form action="{$target_url_store}" method="POST" class="form-horizontal" role="form">
        		<div class="form-group">
					    <label for="titulo">{$lang->get('str_titulo')}</label>
					    <input type="text" class="form-control" name="titulo" id="titulo" placeholder="{$lang->get('str_titulo')}" required="required">
					  </div>
        		<div class="form-group">
					    <label for="descripcion">{$lang->get('str_descripcion')}</label>
					    <textarea name="descripcion" id="descripcion" class="form-control" rows="3" required="required" placeholder="{$lang->get('str_descripcion')}"></textarea>
					  </div>
        		<div class="form-group">
					    <label for="tiempo">{$lang->get('str_tiempo')}</label>
					    <input type="text" class="form-control" id="tiempo" name="tiempo" placeholder="{$lang->get('str_tiempo')}">
					  </div>
					  <div class="form-group">
					    <label for="modulo">{$lang->get('str_modulo')}</label>
					    <select name="modulo" id="modulo" class="form-control" required="required">
								{if $modo == 'encuestas'}
								<option value="{App\Formulario::hashEncuestaLibre()}">{$lang->get('str_encuesta_libre')}</option>
								{/if}
					    	{foreach $modulos as $mod}
					    		<option value="{$mod.Moc_IdModuloCurso}">{$mod.Moc_Titulo}</option>
					    	{/foreach}
					    </select>
					  </div>
					  <button type="submit" class="btn btn-default">{$lang->get('str_registrar')}</button>
        	</form>
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
{block 'js' append}

<script src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript" src="{BASE_URL}modules/elearning/views/gleccion/js/encuestas.js"></script>


{/block}