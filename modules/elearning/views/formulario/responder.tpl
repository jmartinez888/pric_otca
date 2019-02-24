{extends 'index_elearning.tpl'}
{block 'css' append}
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/elearning/views/cursos/css/jp-curso.css">
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
</div>
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
{if $obj_curso == null}
  <div class="col-lg-12">
    <h3>{$lang->get('elearning_cursos_no_existe_curso')}</h3>
    {* <form action="{$_layoutParams.root}elearning/formulario/store" method="post" accept-charset="utf-8">
      <input type="hidden" name="mode" value="unique">
      <input type="hidden" name="curso_id" value="{$curso['Cur_IdCurso']}">
      <button type="submit" class="btn btn-success">{$lang->get('elearning_cursos_crear_formulario')}</button>
    </form> *}
  </div>
{else}
  {if ($formulario == null)}
    <div class="col-lg-12">
      <h3>{$lang->get('elearning_cursos_no_posee_formulario')}</h3>
    </div>
  {else}
    {if $respuesta_sin_responder}
      <div class="col-lg-12 ">
        <div class="panel panel-default tab-content" role="" style="">
          <div class="panel-body form-horizontal tab-pane active" role="tabpanel"  id="formulario_editar">

            <div id="formulario_editar_vue">
              <div class="col-sm-12">
                {include 'format_respuestas.tpl'}
              </div>
            </div>
          </div>
        </div>
      </div>
    {else}
      <div class="col-lg-12">
        <h3>{$lang->get('elearning_cursos_formulario_fue_respondido')}</h3>
      </div>
    {/if}
  {/if}
{/if}
{/block}
{block 'template' append}
{/block}
{block 'js' append}
<!-- <script >
$("#hidden_curso").val("{Session::get('learn_param_curso')}");
</script> -->

{/block}