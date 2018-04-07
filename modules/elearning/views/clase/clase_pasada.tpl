<style>
  .sidebar-left{
    padding-top: 0px
  }
</style>
<div class="row">
    <div class="col-lg-7 tittle-modulo ">
       <h4><strong> Módulo {$modulo["Index"]}: {$modulo["Mod_Titulo"]}</strong></h4>
    </div>
    <div class="col-lg-3 derecha">
      <span>Lección {$leccion["Index"]} de {count($lecciones)}</span>
      {if $leccion["Index"] > 1 }
      <form method="post" action="{BASE_URL}elearning/cursos/_previous_leccion/" style="display: inline-block">
        <input value="{$curso}" name="curso" hidden="hidden"/>
        <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
        <button class="course-students-amount btn btn-danger"> Anterior</button>
      </form>
      {/if}
      {if $leccion["Index"] < {count($lecciones)} }
      <form method="post" action="{BASE_URL}elearning/cursos/_next_leccion/" style="display: inline-block">
        <input value="{$curso}" name="curso" hidden="hidden"/>
        <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
        <button class="course-students-amount btn btn-danger"> Siguiente</button>
      </form>
      {else}
        <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
          <button class="course-students-amount btn btn-danger"> Ir a curso</button>
        </a>
      {/if}
    </div>
    <div class="col-lg-2">
      <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
        <button class="course-students-amount btn btn-danger"> Volver a curso</button>
      </a>
    </div>
</div>
<div class="row">
  <div class="col-lg-3">    
    {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
  </div>
  <div class="col-lg-9" id="modulo-contenedor">
    
    <div class="panel panel-default margin-top-10">
     <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Lección Dirigida: {$leccion.Lec_Titulo}</strong>
      </h3>
      </div>
      <div class="panel-body" style="margin: 15px 25px">
        La clase se desarrolló
      </div>
    </div>

  </div>
</div>