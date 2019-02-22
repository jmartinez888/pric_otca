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
  h2.tag-custom {
    margin-top: 8px;
    margin-bottom: 4px;

  }
  h3.tag-custom {
    margin-top: 4px;
    margin-bottom: 2px;

  }
</style>
<!-- <link href="{$_url}gcurso/css/_view_finalizar_registro.css" rel="stylesheet" type="text/css"/> -->
{/block}
{block 'subcontenido'}
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}

  {if ($formulario == null)}
    <div class="col-lg-12">
      <h3>{$lang->get('elearning_cursos_no_posee_formulario')}</h3>
    </div>
  {else}

      <div class="col-lg-12 ">
        <div class="panel panel-default tab-content" role="" style="">
          <div class="panel-body form-horizontal tab-pane active" role="tabpanel"  id="formulario_editar">
            {include 'respuestas_format.tpl'}
          </div>
        </div>
      </div>



  {/if}

{/block}
{block 'js' append}
<!-- <script >
$("#hidden_curso").val("{Session::get('learn_param_curso')}");
</script> -->
{if ($formulario != null)}
{* <script type="text/javascript">
  var data_frm = {json_encode($formulario->formatToArray())};
</script> *}
{* <script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript" src="{$_layoutParams.rutas.js}formulario.js"></script> *}

{/if}
{/block}