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
  <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9" id="modulo-contenedor">

    <div class="panel panel-default margin-top-10">
     <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Lección Dirigida: {$leccion.Lec_Titulo}</strong>
      </h3>
      </div>
      <div class="panel-body" style="margin: 15px 25px">
        {if $ocurso.Usu_IdUsuario == $usuario}
          Esta clase esta programada para el dia de hoy!
          <br/>
          <br/>

            <button class="btn btn-success" id="btnIniciarClase" data-url="{BASE_URL}elearning/clase/iniciar/{$curso}/{$modulo.Moc_IdModuloCurso}/{$leccion.Lec_IdLeccion}">
              <span class="glyphicon glyphicon-play-circle" aria-hidden="true"></span>
              Iniciar clase
            </button>

        {else}
          <div id="divMensaje">El docente aun no inició la clase</div>
        {/if}
      </div>
    </div>
    <div class="panel panel-default margin-top-10">
     <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Usuarios (<span id="totales_conectados">0</span> conectados)</strong>
      </h3>
      </div>
      <div class="panel-body" style="padding: 0px">
        <div id="chat-base-espera">
          {include 'chat.tpl'}
        </div>
        {* {if $ocurso.Usu_IdUsuario == $usuario}
          Esta clase esta programada para el dia de hoy!
          <br/>
          <br/>
          <a href="{BASE_URL}elearning/clase/iniciar/{$curso}/{$modulo.Moc_IdModuloCurso}/{$leccion.Lec_IdLeccion}">
            <button class="btn btn-success" id="btnIniciarClase">
              <span class="glyphicon glyphicon-play-circle" aria-hidden="true"></span>
              Iniciar clase
            </button>
          </a>
        {else}
          <div id="divMensaje">El docente aun no inició la clase</div>
        {/if} *}
      </div>
    </div>

  </div>
</div>
{/block}
{block 'js'}
<script type="text/javascript">
  var USUARIO = {
    id: {$usuario},
    curso: {$curso},
    docente: {if $is_docente}1{else}0{/if}
  };
  var LMS_CURSO = {$ocurso.Cur_IdCurso};
  var LMS_LECCION = {$leccion.Lec_IdLeccion};
  var LMS_URL = "{BASE_URL}";
  var ALUMNOS = {$alumnos_json};
  var CHAT = [];
  var VIEW_ESPERA = true;
  $(document).ready(function(){
    var COUNT = 1;
  });
</script>
<script type="text/javascript" src="{$_layoutParams.root_clear}public/js/socket.io/socket.io.js"></script>
<script type="text/javascript" src="{$_layoutParams.root_clear}public/js/socket.io/socket.client.js"></script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
modulo-contenedor
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL}modules/elearning/views/clase/js/chat.js"></script>
{/block}