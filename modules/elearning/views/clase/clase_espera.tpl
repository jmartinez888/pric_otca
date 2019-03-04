{extends 'template.tpl'}
{block 'css'}
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/elearning/views/clase/css/style-show-modules.css">
<style>
  .sidebar-left{
    padding-top: 0px
  }
</style>
{/block}
{block 'contenido'}
<div class="container-curso col-xs-12 panel panel-default" style="margin-top:20px;">
  <div class="row gradiente">
    <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 titulo-modulo">
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
    <div class="section-paginador col-xs-12 col-md-12 col-sm-12 col-lg-12 mb-4">
        {if $leccion["Index"] > 1 }
        <form method="post" class="container-btn-previous" action="{BASE_URL}elearning/cursos/_previous_leccion/" >
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
        <form method="post" class="container-btn-next" action="{BASE_URL}elearning/cursos/_next_leccion/" >
          <input value="{$curso}" name="curso" hidden="hidden"/>
          <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
          <button type="submit" class=" btn btn-sm btn-next-previous">
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            {$lang->get('str_siguiente')}
          </button>
        </form>
        {else}
          {* <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
            <button class=" btn btn-danger">
              <span class="glyphicon glyphicon-book" aria-hidden="true"></span>
              Ir a curso
            </button>
          </a> *}
           <form class="container-btn-next" method="post" action="{BASE_URL}elearning/cursos/_next_leccion/">
            <input value="{$curso}" name="curso" hidden="hidden"/>
            <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
            <button class="btn btn-sm btn-next-previous">
              <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
              {$lang->get('str_siguiente')}
            </button>
          </form>
        {/if}
    </div>
  </div>
  <div class="row contenido-lecciones">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
      <div id="leccionar-container" data-open-menu="false">
        {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
      </div>
    </div>
  </div>

  <div class="row contenido-leccion">

    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" id="modulo-contenedor">

      <div class="panel panel-leccion panel-default margin-top-10">
       <div class="panel-heading">
        <h3 class="panel-title">
          <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
          <strong>{$lang->get('elearning_cursos_leccion_dirigida')}: {$leccion.Lec_Titulo}</strong>
        </h3>
        </div>
        <div class="panel-body" style="margin: 15px 25px">
          {if $ocurso.Usu_IdUsuario == $usuario}
            {$lang->get('elearning_cursos_clase_programada_para_hoy')}!
            <br/>
            <br/>

              <button class="btn btn-success" id="btnIniciarClase" data-url="{BASE_URL}elearning/clase/iniciar/{$curso}/{$modulo.Moc_IdModuloCurso}/{$leccion.Lec_IdLeccion}">
                <span class="glyphicon glyphicon-play-circle" aria-hidden="true"></span>
                {$lang->get('elearning_cursos_iniciar_clase')}
              </button>
              <button class="btn btn-success" id="btnIniciarFinalizarLeccion" data-url="{BASE_URL}elearning/clase/finalizar_leccion/{$leccion.Lec_IdLeccion}">
                <span class="fa fa-lock" aria-hidden="true"></span>
                {$lang->get('elearning_cursos_finalizar_leccion')}
              </button>

          {else}
            <div id="divMensaje">{$lang->get('elearning_cursos_docente_no_inicio_clase')}</div>
          {/if}
        </div>
      </div>
      <div class="panel panel-default margin-top-10">
       <div class="panel-heading">
        <h3 class="panel-title">
          <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
          <strong>{$lang->get('str_usuarios')} (<span id="totales_conectados">0</span> {$lang->get('str_conectados')})</strong>
        </h3>
        </div>
        <div class="panel-body" style="padding: 0px">
          <div id="loader_circle">
              <div class="lds-ring"><div></div><div></div><div></div><div></div></div>
          </div>
          <div id="chat-base-espera" class="hidden-custom">
            {include 'chat.tpl'}
          </div>
        </div>
      </div>

    </div>
  </div>
</div>
{/block}
{block 'template'}
  {include file='modules/elearning/views/clase/utils_chats.tpl'}
{/block}
{block 'js'}
<script type="text/javascript">
  var HASH_SESSION = '{$hash_session_activa}';
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
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL}modules/elearning/views/clase/js/menu-interactive.js"></script>
<script src="{BASE_URL}modules/elearning/views/clase/js/chat_v2.js"></script>
{/block}