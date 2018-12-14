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
      <a href="{$_layoutParams.root}elearning/gleccion/encuestas/{$idcurso}" class="btn btn-danger margin-t-10 " id="btn_nuevo" ><i class="glyphicon glyphicon-triangle-left"></i> Regresar</a>
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
        	<form action="{$_layoutParams.root}elearning/gleccion/store_encuesta/{$idcurso}" method="POST" class="form-horizontal" role="form">
        		<div class="form-group">
					    <label for="titulo">Titulo</label>
					    <input type="text" class="form-control" name="titulo" id="titulo" placeholder="Título" required="required">
					  </div>
        		<div class="form-group">
					    <label for="descripcion">Descripción</label>
					    <textarea name="descripcion" id="descripcion" class="form-control" rows="3" required="required" placeholder="Descripción"></textarea>
					  </div>
        		<div class="form-group">
					    <label for="tiempo">Tiempo</label>
					    <input type="text" class="form-control" id="tiempo" name="tiempo" placeholder="Tiempo">
					  </div>
					  <div class="form-group">
					    <label for="modulo">Módulo</label>
					    <select name="" id="modulo" class="form-control" required="required">
					    	{foreach $modulos as $mod}
					    		<option value="{$mod.Moc_IdModuloCurso}">{$mod.Moc_Titulo}</option>
					    	{/foreach}
					    </select>
					  </div>
					  <button type="submit" class="btn btn-default">Registrar</button>
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