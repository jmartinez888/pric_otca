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
            <strong>{$lang->get('elearning_cursos_asistencia_alumno')}</strong>
          </h3>
        </div>
        <div class="panel-body" id="asistencia_leccion_vue">
          <div class="col-lg-12">
            <form class="form-inline" role="form" @submit.prevent="onSubmit_filtrar">
              <div class="form-group">
                <!-- <label class="" for="">label</label> -->
                <input type="text" v-model="txt_buscar_alumno" class="form-control" id="" placeholder="{$lang->get('elearning_cursos_ingrese_nombre_alumno')}">
              </div>
              
              <div class="form-group">
                <label class="" for="">{$lang->get('str_session')}</label>
                <select name=""  class="form-control" v-model="sel_session_leccion">
                  <option value="-1">{$lang->get('str_todas')}</option>
                  {foreach $sessiones as $item}
                  <option value="{$item->Les_IdLeccSess}">{fill_zeros($item->Les_IdLeccSess)}</option>
                  {/foreach}
                </select>
              </div>
              
              <button type="submit" class="btn btn-primary">{$lang->get('str_buscar')}</button>
            </form>
            
          </div>
          <div class="col-lg-12">
            <table class="table wi-100" id="tbl_asistencia" ref="tbl_asistencia">
              <thead>
                <tr>
                  <th>{$lang->get('str_alumno')}</th>
                  <th>{$lang->get('str_hora_inicio')}</th>
                  <th>{$lang->get('str_hora_fin')}</th>
                  <th>{$lang->get('str_sessiones')}</th>
                  <th width="150">{$lang->get('str_operacion')}</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
              <tfoot>
                <tr>
                  <td colspan="5" class="hidden view-pre-loader">
                    <p>{$lang->get('str_asistencias')}: {literal}{{resumen_confirmados}}{/literal} {$lang->get('str_confirmadas')}, {literal}{{resumen_sin_confirmar}}{/literal} {$lang->get('str_sin_confirmar')}, {literal}{{resumen_total}}{/literal} {$lang->get('str_total')}</p>
                  </td>
                </tr>
              </tfoot>
            </table>
            
          </div>
        </div>
      </div>
		</div>

</div>








{/block}
{block 'template' append}
  <template id="btn_opciones_asistencia">
  		<button type="button" data-id="{literal}{{id}}{/literal}"  class="btn btn-default  btn-sm btn-marcar-asistencia" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('elearning_cursos_marcar_asistencia')}"><i data-id="{literal}{{id}}{/literal}" class="fa fa-{literal}{{asistencia}}{/literal}"></i></button>
  </template>
  <template id="btn_opciones_ir">
    <a href="{$_layoutParams.root}elearning/gleccion/asistencia/{literal}{{leccion}}{/literal}/usuario/{literal}{{usuario}}{/literal}" class="btn btn-default  btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_detalles')}"><i class="glyphicon glyphicon-th-list"></i></a>
  </template>
{/block}
{block 'js' append}
<script type="text/javascript">
  var LECCION_ID = {$obj_leccion->Lec_IdLeccion};
  var LECCION_ONLINE = {App\LeccionSession::TIPO_ONLINE};
</script>
<script src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript" src="{BASE_URL}modules/elearning/views/gleccion/js/asistencia.js"></script>


{/block}