{extends 'index_elearning.tpl'}
{block 'css' append}
<style>
  .div-detalle{
  border: 1px solid gray;
  border-radius: 5px;
  position: relative;
  padding-top: 10px;
  padding-bottom: 10px;
  }
  .div-detalle .btn-detalle{
  position: absolute;
  top: 10px;
  right: 10px;
  }
  .img-banner{
  padding: 10px !important;
  border: 2px solid #02969b;
  }
  .div_presentacion{
  display: block;
  }
  .div_contenido{
  display: none;
  }
  .div_parametros{
  display: none;
  }
  .display-block{
  display: block;
  }
  .nav-tabs > .active{
  font-weight: bold;
  }
  .nav-tabs > li.active > a{
  color: #009640 !important;
  }
</style>
<style type="text/css" media="screen">
  .tags_input_edit:hover {
    /*border: 2px solid black;*/
  }
  .tags_input_edit {
    border-left: 2px solid white;
    padding: 10px 5px;
  }
  .tag_input_edit_select {
    border-left: 2px solid black;
    padding: 10px 5px;
    box-shadow: 2px 0px 1px 1px rgba(100, 100, 100, 0.7);
  }
  .container_select {

  }

.container_select input.form-control{
    border: 0px;
    border-bottom: 1px solid black;
}

.container_select .input-group-addon{
    border: 0px;

}
#btn_agregar {

}
</style>
<!-- <link href="{$_url}gcurso/css/_view_finalizar_registro.css" rel="stylesheet" type="text/css"/> -->
{/block}
{block 'subcontenido'}
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}

{if ($formulario == null)}
<div class="col-lg-12">
  <h3>No posee formulario</h3>
  <form action="{$_layoutParams.root}elearning/formulario/store" method="post" accept-charset="utf-8">
    <input type="hidden" name="mode" value="unique">
    <input type="hidden" name="curso_id" value="{$curso['Cur_IdCurso']}">
    <button type="submit" class="btn btn-success">Crear formulario</button>
  </form>
</div>
{else}
<div class="col-lg-12">
  <ul class="nav nav-tabs" role="tablist">
    <li role="formulario" class="active" id="item_editar"><a href="#formulario_editar" aria-controls="formulario_editar" role="tab" data-toggle="tab">{$lang->get('elearning_gcurso_preguntas')}</a></li>
    <li role="formulario" id="item_respuestas" ><a href="#formulario_respuestas" aria-controls="formulario_respuestas" role="tab" data-toggle="tab">{$lang->get('elearning_gcurso_respuestas')}</a></li>
  </ul>
</div>
<div class="col-lg-12 ">
  <div class="panel panel-default tab-content" role="" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
    <div class="panel-body form-horizontal tab-pane active" role="tabpanel"  id="formulario_editar">

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
    </div>
    <div class="panel-body form-horizontal tab-pane" role="tabpanel"  id="formulario_respuestas">
      <div class="panel panel-default">
        <div class="panel-heading cabecera-titulo">
          <h3 class="panel-title">
            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
            <strong>{$lang->get('elearning_formulario_responder_alumnos_inscritos')}</strong>
          </h3>
        </div>
        <div class="panel-body" style=" margin: 15px 25px">
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
</div>
{/if}
{/block}
{block 'template' append}
  {include 'input_tags.tpl'}

{/block}
{block 'js' append}
<!-- <script >
$("#hidden_curso").val("{Session::get('learn_param_curso')}");
</script> -->
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
<script type="text/javascript" src="{$_layoutParams.rutas.js}formulario.js"></script>

{/if}
{/block}