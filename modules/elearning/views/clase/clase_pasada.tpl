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
        {if $is_docente}
        <a class="btn btn-sm btn-default btn-group" href="{BASE_URL}elearning/gestion/matriculados/{$curso}">
          <span class="glyphicon glyphicon-book" aria-hidden="true"></span>
          {$lang->get('elearning_cursos_gestion_curso')}
        </a>
        {/if}
        <a class="btn btn-sm btn-success btn-group pull-right" href="{BASE_URL}elearning/cursos/curso/{$curso}">
            <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
            {$lang->get('elearning_cursos_volver_curso')}
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
        <form method="post" id="frm-next-leccion" class="container-btn-next" action="{BASE_URL}elearning/cursos/_next_leccion/">
          <input value="{$curso}" name="curso" hidden="hidden"/>
          <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
          <button type="submit" class="btn btn-sm btn-next-previous">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            {$lang->get('str_siguiente')}
          </button>
        </form>
        {else}
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
              <div class="alert" role="alert" style="background-color: #007cbe">
                  <h3 style="color: #fff; text-transform: uppercase"><strong>{$lang->get('elearning_cursos_la_clase_finalizo_con_exito')}</strong></h3>
                  <h4 style="color: #fff;font-weight: normal">{$lang->get('str_para_continuar_presione')} <a id="goto-next" href="">{$lang->get('str_siguiente')}</a></h4>
              </div>
              <p style="text-align: center;"><span class="glyphicon glyphicon-exclamation-sign" style="font-size: 13em;color: #007cbe;"></span></p>
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
<script>
  $('#goto-next').on('click', function(e) {
    e.preventDefault()
    $('#frm-next-leccion').submit()
  })
</script>
{/block}