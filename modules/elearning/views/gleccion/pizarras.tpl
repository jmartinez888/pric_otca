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
        <div class="panel-body" style=" margin: 15px 25px">
          <div class="col-lg-12" id="formulario_encuestas_vue">
          	<a href="{$_layoutParams.root}elearning/gleccion/agregar_pizarra/{$curso['Cur_IdCurso']}" class="btn btn-success margin-t-10 " id="" ><i class="glyphicon glyphicon-triangle-plus"></i> {$lang->get('elearning_cursos_agregar_pizarra')}</a>
            <div class="table-responsive" style="width: 100%">
              <table class="table" id="tblMisCursos">
                <thead>
                  <tr>
                    <th>{$lang->get('str_encuesta')}</th>
                    <th>{$lang->get('str_descripcion')}</th>
                    <th>{$lang->get('str_modulo')}</th>
                    <th width="150">{$lang->get('str_operacion')}</th>
                  </tr>
                </thead>
                <tbody>
                  {foreach $pizarras as $item}
                    <tr>
                      <td>{$item->Lec_Titulo}</td>
                      <td>{str_limit($item->Lec_Descripcion, 50)}</td>
                      <td>{$item->modulo->Moc_Titulo}</td>
                      <td>
                        <a href="{$_layoutParams.root}elearning/gleccion/_view_leccion/{$curso['Cur_IdCurso']}/{$item->Moc_IdModuloCurso}/{$item->Lec_IdLeccion}" class="btn btn-default  btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_ver_respuestas')}"><i class="glyphicon glyphicon-pencil"></i></a>
                        <a href="{$_layoutParams.root}elearning/gleccion/asistencia/{$item->Lec_IdLeccion}" class="btn btn-default  btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_asistencia')}"><i class="glyphicon glyphicon-user"></i></a>
                        <button data-id="{$item->Lec_IdLeccion}" @click="onClick_deleteEncuesta({$item->Lec_IdLeccion})" class="btn btn-default  btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_eliminar')}"><i class="glyphicon glyphicon-trash"></i></button>
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