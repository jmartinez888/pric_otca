<script src="https://apis.google.com/js/platform.js?onload=onLoadCallback" async defer></script>
<style>
  .cursor-on{
    background-color: blue;
  }
  .cursor-off{
    background-color: red;
  }
  .docente-mouse{
    cursor: none;
  }
</style>
<input value="{BASE_URL}" id="hiddenURL" hidden="hidden" />
<input value="{$modulo}" id="hiddenCurso" hidden="hidden" />
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
    <div class="col-lg-2"></div>
</div>

<div class="row">
  <div class="col-lg-3">
    <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
      <button class="course-students-amount btn btn-danger"> Volver a curso</button>
    </a>
    {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
  </div>
  <div class="col-lg-9" style="padding-top: 35px;" id="modulo-contenedor">
    <div class="col-lg-12 contenedor no-seleccionable" style="padding-bottom: 10px" id="leccion-contenido">
      <div class="col-lg-12"><center><h4><strong>Pizarra de Clase<div id="icon-conectado"></div></strong></h4></center></div>
      <input hidden="hidden" value="{Session::get('usuario')}" id="hiddenUsuarioClase" />
      <input hidden="hidden" value="{if $usuario== $ocurso.Usu_IdUsuario}1{else}0{/if}" id="hiddenDocente" />
      <input hidden="hidden" value="0" id="hiddenConexion" />
      <input hidden="hidden" value="{if $usuario== $ocurso.Usu_IdUsuario}1{else}0{/if}" id="hiddenActividad" />
      <input hidden="hidden" value="1" id="hiddenEnabled" />
      <input hidden="hidden" value="0" id="hiddenEtiqueta" />
      <input hidden="hidden" value="0" id="hiddenHerramienta" />
      <input hidden="hidden" value="0" id="hiddenClick" />
      <input hidden="hidden" value="0" id="hiddenOver" />
      <input hidden="hidden" value="0" id="hiddenX1" />
      <input hidden="hidden" value="0" id="hiddenY1" />
      <input hidden="hidden" value="0" id="hiddenX2" />
      <input hidden="hidden" value="0" id="hiddenY2" />
      <div id="CONTROL_PIZARRA" class="no-seleccionable">
        <center>
          {if $ocurso.Usu_IdUsuario!=$usuario}
          <div id="mouse-helper">
            <img id="mouse_on" src="{BASE_URL}modules/elearning/views/clase/img/mouse_on.png" style="display: none"/>
            <img id="mouse_off" src="{BASE_URL}modules/elearning/views/clase/img/mouse_off.png"/>
          </div>
          {/if}
          <div id="cursor-helper"></div>
          <div id="borrador-helper"></div>
          <div id="back-texto"></div>
          <input id="texto-helper" />
          <div id="marcador">{Session::get('usuario')}</div>
          <div id="herramientas-canvas" style="display: none" class="no-seleccionable">
            <button class="btnHerramienta herr_piz" id="btnLapiz"><span class="glyphicon glyphicon-minus"></span></button>
            <button class="btnHerramienta herr_piz" id="btnCuadrado"><span class="glyphicon glyphicon-unchecked"></span></button>
            <button class="btnHerramienta" id="btnEtiqueta"><span class="glyphicon glyphicon-tag"></button>
            <button class="btnHerramienta herr_piz" id="btnTexto"><span class="glyphicon glyphicon-text-color"></button>
            <button class="btnHerramienta herr_piz" id="btnBorrador"><span class="glyphicon glyphicon-erase"></button>
            <button class="btnHerramienta herr_piz" id="btnImagen"><span class="glyphicon glyphicon-picture"></button>
            <button class="btnHerramienta herr_piz" id="btnCaptura"><span class="glyphicon glyphicon-facetime-video"></button>
            <button class="btnHerramienta herr_piz" id="btnBorrarPizarra"><span class="glyphicon glyphicon-trash"></button>
          </div>
          <canvas height="400px" width="700px" id="micanvas" class="no-seleccionable"></canvas>
        </center>
      </div>
      <div id="opciones-canvas" class="col-lg-12 no-seleccionable {if $ocurso.Usu_IdUsuario==$usuario}docente-mouse{/if}" style="content-align: right; display: none">
        Densidad: <input value="1" id="hiddenGrosor" disabled="disabled"/>
                  <input type="range" value="1" max="50" min="1" step="1" id="iHiddenGrosor"/>
        Fuente: <input value="10" id="hiddenFuente" disabled="disabled"/>
                  <input type="range" value="10" id="iHiddenFuente" max="100" min="10" step="1"/>
        Color: <input value="#000000" id="hiddenColor" onclick="ClickColor(this);"/>
      </div>
    </div>
    {if $usuario==$ocurso.Usu_IdUsuario}
    <div class="col-lg-6  contenedor no-seleccionable">
      <h5>VideoLlamada</h5>
      <div id="placeholder-div1"></div>
    </div>
    <div class="col-lg-6  contenedor no-seleccionable">
      <h5>Acciones</h5>
      <a href="{BASE_URL}elearning/clase/finalizar/{$curso}/{$modulo.Mod_IdModulo}/{$leccion.Lec_IdLeccion}">
        <button class="btn btn-success" id="btnFinalizarClase" style="margin-bottom: 10px">
          Finalizar lección
        </button>
      </a>
    </div>
    <div class="col-lg-6  contenedor no-seleccionable">
      <h5>Solicitudes de Pizarra</h5>
      <div class="col-lg-12" id="divSolicitudes">
      </div>
    </div>
    {else}
    <div class="col-lg-6  contenedor no-seleccionable">
      <h5>Acciones</h5>
      <button class="btn btn-success" id="btnsolicitarPizarra" style="margin-bottom: 10px">
        Solicitar Pizarra
      </button>
    </div>
    {/if}

    <div id="chat-container">
      <div id="chat-header">
        Chat de Clase
        <div id="btnMinin">
          <span id="btnMinin_Close" class="glyphicon glyphicon-remove"></span>
          <span id="btnMinin_Open" class="glyphicon glyphicon-menu-up"></span>
        </div>
      </div>
      <div class="chat-body">
        <div id="chat-msn-body"></div>
        <div id="chat-text-body">
          <input id="chat-text-input" placeholder="Ingrese un mensaje" />
          <button id="chat-text-send" class="btn btn-default"></button>
        </div>
      </div>
    </div>

  </div>
  <div class="col-lg-1">
  </div>
</div>

<script src="{BASE_URL}modules/elearning/views/clase/js/canvas.js"></script>
<script type="text/javascript">
  ALUMNOS = [];CHAT = [];
  {foreach from=$alumnos item=a}ALUMNOS.push({ id: {$a.Usu_IdUsuario}, usuario: "{$a.Usu_Nombre} {$a.Usu_Apellidos}", url: "{$a.Usu_URLImage}", docente: {$a.Docente} });{/foreach}
  {foreach from=$chat item=c}CHAT.push({ usuario: {$c.Usu_IdUsuario}, msn: "{$c.Men_Descripcion}", fecha: "{$c.Men_Fecha}" });{/foreach}
  USUARIO = { id: {$usuario}, curso: {$curso} };
  LMS_CURSO = {$ocurso.Cur_IdCurso};
  LMS_LECCION = {$leccion.Lec_IdLeccion};
  LMS_URL = "{BASE_URL}";
</script>
<script src="{BASE_URL}modules/elearning/views/clase/js/sockets.js"></script>
