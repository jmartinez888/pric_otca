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
    {if $leccion["Index"] < count($lecciones) }
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
        {if $ocurso.Usu_IdUsuario == $usuario}
          Esta clase esta programada para el dia de hoy!
          <br/>
          <br/>
          <a href="{BASE_URL}elearning/clase/iniciar/{$curso}/{$modulo.Mod_IdModulo}/{$leccion.Lec_IdLeccion}">
            <button class="btn btn-success" id="btnIniciarClase">
              <span class="glyphicon glyphicon-play-circle" aria-hidden="true"></span>
              Iniciar clase
            </button>
          </a>
        {else}
          <div id="divMensaje">El docente aun no inició la clase</div>
        {/if}
      </div>
    </div>

  </div>
</div>
<script type="text/javascript">
  $(document).ready(function(){
    var COUNT = 1;
    USUARIO = { id: {$usuario}, curso: {$curso} };

    InitSocket(USUARIO);
    var CONTENEDOR_CONT = $("#leccion-contenido");
    var SOCKET_CLASE = SocketInstance("INICIO_CLASE", function(){
    }, function(){

    }, function(msg){
      if(msg.estado == 1){
        setInterval(function(){
          puntitos = "";
          for(i=1; i <=COUNT; i++){ puntitos+="."; }
          $("#divMensaje").html("Iniciando clase" + puntitos);
          COUNT++;
          if(COUNT > 3){ COUNT = 1}
        }, 500);
        setTimeout(function(){
          location.reload();
        }, 3000);
      }
    }, function(){});

    $("#btnIniciarClase").click(function(){
      var msg = { estado: 1 };
      SOCKET_CLASE.send(msg);
    });

    AddSocketInstance(SOCKET_CLASE);
    StartServer();
  });
</script>
