{extends 'template.tpl'}
{block 'css'}
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/elearning/views/clase/css/style-show-modules.css">
<style>
  /*.sidebar-left{
    padding-top: 0px
  }*/
</style>
{/block}
{block 'contenido'}
<div class="container-curso col-lg-12 panel panel-default" style="margin-top:20px;">
  <div class="row gradiente">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 titulo-modulo">
      <h4><strong> {$lang->get('str_modulo')} {$modulo.Index}: {$modulo["Moc_Titulo"]}</strong></h4>
      <div class="container-btn-curso">
        <a class="btn btn-sm btn-success btn-group pull-right" href="{BASE_URL}elearning/cursos/curso/{$curso}">
          {* <button class="btn-regresar btn btn-group"> *}
            <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
            {$lang->get('elearning_cursos_volver_curso')}
          {* </button> *}
        </a>
      </div>
    </div>
    <div class="section-paginador col-xs-12 col-sm-12 col-md-12 col-lg-12 mb-4">

        {if $leccion["Index"] > 1 }
        <form method="post" class="container-btn-previous" action="{BASE_URL}elearning/cursos/_previous_leccion/">
          <input value="{$curso}" name="curso" hidden="hidden"/>
          <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
          <button type="submit" class="btn btn-sm btn-next-previous">
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            {$lang->get('str_anterior')}
          </button>
        </form>
        {else}
        <div class="container-btn-previous">
          <button class="btn btn-sm btn-default" disabled="disabled">
              <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
              {$lang->get('str_anterior')}
          </button>
        </div>
        {/if}
        <span class="text-current-leccion">{$lang->get('str_leccion')} {$leccion["Index"]} {$lang->get('str_de')} {count($lecciones)}</span>
        {if $leccion["Index"] < {count($lecciones)} }
        <form method="post" class="container-btn-next" action="{BASE_URL}elearning/cursos/_next_leccion/">
          <input value="{$curso}" name="curso" hidden="hidden"/>
          <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
          <button type="submit" class="btn btn-sm btn-next-previous">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            {$lang->get('str_siguiente')}
          </button>
        </form>
        {else}
          {* <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
            <button class="btn-regresar btn btn-group">
              <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
              Ir a curso
            </button>
          </a> *}
          <form method="post" class="container-btn-next" action="{BASE_URL}elearning/cursos/_next_leccion/">
            <input value="{$curso}" name="curso" hidden="hidden"/>
            <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
            <button type="submit" class="btn btn-sm btn-next-previous">
              <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
              {$lang->get('str_siguiente')}
            </button>
          </form>
        {/if}
    </div>
    {* <div class="col-lg-2" style="margin-top: 5px !important">
      <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
      <button class="btn-regresar btn btn-group">
        <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
        Volver a curso
      </button>
    </a>
    </div> *}
  </div>
  <div class="row contenido-lecciones">

      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
        <div id="leccionar-container" data-open-menu="false">
          {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
        </div>
      </div>


  </div>
  <div class="row contenido-leccion">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 " >
      <div class="panel panel-leccion panel-default">
        <div class="panel-body contenedor-clase">
          
            <div class="col-xs-12">
              <p style="text-align: center;"><span class="fa fa-check-circle" style="font-size: 13em;color: #00c0ef;"></span></p>
              <div class="alert alert-info" role="alert" style="text-align: center;">
                  <h3>La clase se desarrolló</h3>
              </div>
            </div>
        </div>
      </div>
    </div>
  </div>
  <div class="row descripcion-leccion">
    <div class="panel-footer" style="background-color: transparent;">
      <div class="row" style="padding-left:0px; padding-right: 0px;">
        {include file='modules/elearning/views/cursos/menu/info_leccion.tpl'}
      </div>
    </div>
  </div>
</div>
{/block}

{block 'js'}
<script src="{BASE_URL}modules/elearning/views/clase/js/menu-interactive.js"></script>
{/block}