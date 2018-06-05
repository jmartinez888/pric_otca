<style>
  .sidebar-left{
    padding-top: 0px
  }
</style>
<div class="col-lg-12 panel panel-default" style="margin-top:20px;">
  <div class="row gradiente">
    <br>
    <div class="col-lg-5 titulo-modulo">
       <h4><strong> Módulo {$modulo.Index}: {$modulo["Mod_Titulo"]}</strong></h4>
    </div>
    <div class="col-lg-5 derecha" style="margin-top: 5px !important">
        <span>Lección {$leccion["Index"]} de {count($lecciones)}</span>
        {if $leccion["Index"] > 1 }
        <form method="post" action="{BASE_URL}elearning/cursos/_previous_leccion/" style="display: inline-block">
          <input value="{$curso}" name="curso" hidden="hidden"/>
          <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
          <button class="course-students-amount btn btn-next-previous"> 
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
          <button class="course-students-amount btn btn-next-previous"> 
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            Siguiente
          </button>
        </form>
        {else}
          <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
            <button class="course-students-amount btn-regresar btn btn-group"> 
              <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
              Ir a curso
            </button>
          </a>
        {/if}
    </div>
    <div class="col-lg-2" style="margin-top: 5px !important">
      <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
      <button class="course-students-amount btn-regresar btn btn-group"> 
        <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
        Volver a curso
      </button>
    </a>
    </div>
  </div>
  <div class="row">
    <div class="col-lg-12 leccion-container">
      <div class="col-lg-3" style="padding-left:0px; padding-right:0px;">    
        {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
      </div>
      <div class="col-lg-9" style="padding-left:0px; padding-right:0px;">
        
        <div class="panel panel-default margin-top-10">
         <div class="panel-heading cabecera-titulo">
          <h3 class="panel-title">
            <strong>Lección Dirigida: {$leccion.Lec_Titulo}</strong>
          </h3>
          </div>
          <div class="panel-body contenedor-clase">
            La clase se desarrolló
          </div>
        </div>
      </div>

    </div>
  </div>
</div>