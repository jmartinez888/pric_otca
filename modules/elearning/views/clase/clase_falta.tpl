{extends 'template.tpl'}
{block 'css'}
<style>
  .sidebar-left{
    padding-top: 0px
  }
</style>
{/block}
{block 'contenido'}
<div class="row">
  <div class="col-lg-5 tittle-modulo ">
     <h4><strong> Módulo {$modulo.Index}: {$modulo["Moc_Titulo"]}</strong></h4>
  </div>
  <div class="col-lg-5 derecha" style="margin-top: 5px !important">
      <span>Lección {$leccion["Index"]} de {count($lecciones)}</span>
      {if $leccion["Index"] > 1 }
      <form method="post" action="{BASE_URL}elearning/cursos/_previous_leccion/" style="display: inline-block">
        <input value="{$curso}" name="curso" hidden="hidden"/>
        <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
        <button class="course-students-amount btn btn-danger">
          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
          Anterior
        </button>
      </form>
      {else}
      <button class="course-students-amount btn btn-default" disabled="disabled">
          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
          Anterior
      </button>
      {/if}
      {if $leccion["Index"] < {count($lecciones)} }
      <form method="post" action="{BASE_URL}elearning/cursos/_next_leccion/" style="display: inline-block">
        <input value="{$curso}" name="curso" hidden="hidden"/>
        <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
        <button class="course-students-amount btn btn-danger">
          <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
          Siguiente
        </button>
      </form>
      {else}
        <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
          <button class="course-students-amount btn btn-danger">
            <span class="glyphicon glyphicon-book" aria-hidden="true"></span>
            Ir a curso
          </button>
        </a>
      {/if}
  </div>
  <div class="col-lg-2" style="margin-top: 5px !important">
    <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
    <button class="course-students-amount btn btn-danger">
      <span class="glyphicon glyphicon-book" aria-hidden="true"></span>
      Volver a curso
    </button>
  </a>
  </div>
</div>
<div class="row">
  <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
    {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
  </div>
  <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9 pr-0 pl-0" id="modulo-contenedor">

    <div class="panel panel-default margin-top-10">
     <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Lección Dirigida: {$leccion.Lec_Titulo}</strong>
      </h3>
      </div>
      <div class="panel-body" style="margin: 15px 25px">
        La clase aun no se ha realizado
      </div>
    </div>

  </div>
</div>
{/block}
