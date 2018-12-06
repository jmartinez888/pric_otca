<script type="text/javascript" src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js"></script>
<script src="https://apis.google.com/js/platform.js?onload=onLoadCallback" async defer></script>
<style>
  .sidebar-left{
    padding-top: 0px
  }
  .cursor-on{
    background-color: blue;
  }
  .cursor-off{
    background-color: red;
  }
  .docente-mouse{
    cursor: none;
  }
  .emtpy{
    border: 1px solid gray;
    width: 100px;
    height: 100px;
    position: relative;
  }
  .empty span{
    position: absolute;
    left: 40px;
    top: 40px;
  }
</style>
<input value="{BASE_URL}" id="hiddenURL" hidden="hidden" />
<input value="{BASE_URL}elearning/" id="hidden_url" hidden="hidden" />
<input value="{$modulo.Cur_IdCurso}" id="hiddenCurso" hidden="hidden" />
<input value="{$leccion.Lec_IdLeccion}" id="hiddenLeccion" hidden="hidden" />
<div class="row gradiente">
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
  <div class="col-lg-3">
    {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
  </div>
  <div class="col-lg-9" id="modulo-contenedor">
    <div class="col-lg-12">
      <div class="panel panel-default margin-top-10">
       <div class="panel-heading">
        <h3 class="panel-title">
          <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
          <strong>Lección Dirigida: {$leccion.Lec_Titulo} <div id="icon-conectado"></strong>
        </h3>
        </div>
        <div class="panel-body" style="margin: 0px">


          <div class="col-lg-12 no-seleccionable" style="padding-bottom: 10px" id="leccion-contenido">
            {if $usuario==$ocurso.Usu_IdUsuario}
            <button class="btn btn-success pull-right" id="btn-agregar-pizarra">Agregar Pizarra</button>
             {/if}
            {if isset($pizarra) && count($pizarra) > 0 && $usuario==$ocurso.Usu_IdUsuario }
              <div class="contenedor-mini-pizarras">
                <label>Pizarras</label>
                <div id="tmp_mini_pizarras">
              {foreach from=$pizarra item=p}
                <div class="pizarra-mini">
                  <input value="{$p.Piz_IdPizarra}" class="hidden_IdPizarra" hidden="hidden" />
                  <img class="img-pizarra-mini" 
                  src="{BASE_URL}files/elearning/_pizarra/{$p.Piz_ImgFondo}" />
                </div>
              {/foreach}
                </div>
                <div class="pizarra-mini emtpy">
                  <input value="0" class="hidden_IdPizarra" hidden="hidden" />
                  <span class="glyphicon glyphicon-minus"></span>
                </div>
              </div>
              {include file='modules/elearning/views/clase/menu/pizarra.tpl'}
            {/if}

            <input hidden="hidden" value="{Session::get('usuario')}" id="hiddenUsuarioClase" />
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
                <div id="panel-pizarra-final">
                  {if isset($pizarra) || count($pizarra) > 0 }
                    {foreach from=$pizarra item=p}
                        
                      <img class="pizarra-fondo-item" style="width: {$p.Piz_ImgWidth}px; height: {$p.Piz_ImgHeight}px; 
                        top: {$p.Piz_ImgY}px; left: {$p.Piz_ImgX}px;
                        {if $leccion.Lec_LMSPizarra != $p.Piz_IdPizarra}display:none{/if}" id="pizarra-fondo-{$p.Piz_IdPizarra}" 
                        src="{BASE_URL}files/elearning/_pizarra/{$p.Piz_ImgFondo}" />
                      
                    {/foreach}
                  {/if}
                  <canvas height="400px" width="700px" id="micanvas" class="no-seleccionable"></canvas>
                </div>
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


        </div>
      </div>
    </div>
    <div class="col-lg-6">
      <div class="panel panel-default margin-top-10">
        <div class="panel-heading">
          <h3 class="panel-title">
          <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
          <strong>Opciones</strong>
          </h3>
        </div>
        <div class="panel-body" style="margin: 0px">

          <div id="placeholder-div1"></div>

          {if $usuario==$ocurso.Usu_IdUsuario}
          <a href="{BASE_URL}elearning/clase/finalizar/{$curso}/{$modulo.Moc_IdModuloCurso}/{$leccion.Lec_IdLeccion}">
            <button class="btn btn-success" id="btnFinalizarClase" style="margin-bottom: 10px">
              Finalizar lección
            </button>
          </a>
          {else}
          <!--button class="btn btn-success" id="btnsolicitarPizarra" style="margin-bottom: 10px">
            Solicitar Pizarra
          </button-->
          {/if}

        </div>
      </div>
    </div>

    <div class="col-lg-6">
      <div class="panel panel-default margin-top-10">
        <div class="panel-heading">
          <h3 class="panel-title">
          <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
          <strong>Link Video Conferencia</strong>
          </h3>
        </div>
        <div class="panel-body" style="margin: 0px">
          {if $usuario==$ocurso.Usu_IdUsuario}         
            <div id="placeholder-div2"></div>
            
          <div class="input-group">
            <input name="busqueda" class="form-control" id="in-link-videollamada" value="">
            <span class="input-group-btn">
              <button class="btn btn.btn-success" id="btn-enviar-link">Enviar</button>
            </span>
          </div>
          {else}
          <input value="" id="in-link-videollamada_receive" hidden="hidden" class="form-control" />
          <button class="btn btn.btn-success" id="btn-ir-video">Ir VideoConferencia</button>
          {/if}
        </div>
      </div>
    </div>

    {include file='modules/elearning/views/cursos/menu/info_leccion.tpl'}

    <div id="chat-container" style="height: 40px;">
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
<script type="text/javascript" src="{BASE_URL}modules/elearning/views/clase/js/sockets.js"></script>