{extends 'template.tpl'}
{* <script src="https://apis.google.com/js/platform.js?onload=onLoadCallback" async defer></script> *}
{block 'css'}
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
{/block}
{block 'contenido'}
<input value="{BASE_URL}" id="hiddenURL" hidden="hidden" />
<input value="{BASE_URL}elearning/" id="hidden_url" hidden="hidden" />
<input value="{$modulo.Cur_IdCurso}" id="hiddenCurso" hidden="hidden" />
<input value="{$leccion.Lec_IdLeccion}" id="hiddenLeccion" hidden="hidden" />
<div class="row gradiente">
  <div class="col-lg-5 titulo-modulo">
     <h4><strong> {$lang->get('str_modulo')} {$mod_datos.INDEX}:ss {$modulo["Moc_Titulo"]}</strong></h4>
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
    <a class="course-students-amount btn btn-danger pull-right" href="{BASE_URL}elearning/cursos/curso/{$curso}">
      <span class="glyphicon glyphicon-book" aria-hidden="true"></span>&nbsp;Volver a curso
    </a>
  </div>
</div>

<div class="row">
  <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
    {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
  </div>
  <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9 pr-0 pl-0" id="modulo-contenedor">
    <div class="col-lg-12">
      <div class="panel panel-default margin-top-10">
       <div class="panel-heading">
        <h3 class="panel-title">
          <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
          <strong>Lección Dirigida: {$leccion.Lec_Titulo} <span id="icon-conectado"></span>&nbsp;&nbsp;<span id="totales_conectados">--</span> en línea.</strong>
        </h3>
        </div>
        <div class="panel-body" style="margin: 0px">


          <div class="row no-seleccionable" style="padding-bottom: 10px" id="leccion-contenido">

            {if isset($pizarra) && count($pizarra) > 0 && $usuario==$ocurso.Usu_IdUsuario }
              <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12  contenedor-mini-pizarras">
                <label>Pizarras</label>

                  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" id="tmp_mini_pizarras">

                  {foreach from=$pizarra item=p key=i}
                    <div class="panel-item-pizarra" @click="onClick_seleccionPizarra({$p.Piz_IdPizarra})">
                      <div class="panel item-pizarra">
                        <img ref="pizarrabg_{$p.Piz_IdPizarra}" src="{BASE_URL}files/elearning/_pizarra/{$p.Piz_ImgFondo}" />
                        <strong class="number_pizarra">{$i + 1}</strong>
                      </div>
                    </div>
                    {* <div class="pizarra-mini">
                      <input value="{$p.Piz_IdPizarra}" class="hidden_IdPizarra" hidden="hidden" />
                      <img class="img-pizarra-mini"
                      src="{BASE_URL}files/elearning/_pizarra/{$p.Piz_ImgFondo}" />
                    </div> *}
                  {/foreach}
                  </div>
                {* <div class="pizarra-mini emtpy">
                  <input value="0" class="hidden_IdPizarra" hidden="hidden" />
                  <span class="glyphicon glyphicon-minus"></span>
                </div> *}
              </div>
              {if $usuario==$ocurso.Usu_IdUsuario}
              <div class="col-sm-12">

                <button class="btn btn-success pull-right" id="btn-agregar-pizarra">Agregar Pizarra</button>
              </div>
              {/if}
              {include file='modules/elearning/views/clase/menu/pizarra.tpl'}
            {else}

                  {foreach from=$pizarra item=p key=i}
                        <img ref="pizarrabg_{$p.Piz_IdPizarra}" src="{BASE_URL}files/elearning/_pizarra/{$p.Piz_ImgFondo}" class="hidden"/>
                  {/foreach}
            {/if}
            {* <div class="col-sm-12">
              <canvas height="400px" width="650px" id="micanvasdos" style="border: 1px solid red" class=""></canvas>
            </div> *}
            <div class="col-sm-12">
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
            </div>
            <div id="col-xs-12 col-sm-12 col-md-12 col-lg-12 CONTROL_PIZARRA" class="no-seleccionable">
              <center>
                {if $ocurso.Usu_IdUsuario!=$usuario}
                {* <div id="mouse-helper">
                  <img id="mouse_on" src="{BASE_URL}modules/elearning/views/clase/img/mouse_on.png" style="display: none"/>
                  <img id="mouse_off" src="{BASE_URL}modules/elearning/views/clase/img/mouse_off.png"/>
                </div> *}
                {/if}
                <div id="cursor-helper"></div>
                <div id="borrador-helper"></div>
                <div id="back-texto"></div>
                <input id="texto-helper" />
                <div id="marcador">{Session::get('usuario')}</div>
              {*   <div id="herramientas-canvas" style="" class="no-seleccionable">
                  <button class="btnHerramienta herr_piz" id="btnLapiz"><span class="glyphicon glyphicon-minus"></span></button>
                  <button class="btnHerramienta herr_piz" id="btnCuadrado"><span class="glyphicon glyphicon-unchecked"></span></button>
                  <button class="btnHerramienta" id="btnEtiqueta"><span class="glyphicon glyphicon-tag"></span></button>
                  <button class="btnHerramienta herr_piz" id="btnTexto"><span class="glyphicon glyphicon-text-color"></span></button>
                  <button class="btnHerramienta herr_piz" id="btnBorrador"><span class="glyphicon glyphicon-erase"></span></button>
                  <button class="btnHerramienta herr_piz" id="btnImagen"><span class="glyphicon glyphicon-picture"></span></button>
                  <button class="btnHerramienta herr_piz" id="btnCaptura"><span class="glyphicon glyphicon-facetime-video"></span></button>
                  <button class="btnHerramienta herr_piz" id="btnBorrarPizarra"><span class="glyphicon glyphicon-trash"></span></button>
                </div> *}

              </center>
              <center>

                <div id="panel-pizarra-final" class="hidden" ref="panel_pizarra_final">
                   {if $is_docente}
                    <div id="herramientas-canvas" style="" class="no-seleccionable">
                      <div @mouseleave="show_tools = false">
                      {* <div> *}
                        <button :class="{ hidden: !show_tools }" class="toolscanvas" @click="onClick_createObject('normal')"><i class="glyphicon glyphicon-screenshot"></i></button>
                        <button :class="{ hidden: !show_tools }" class="toolscanvas" @click="onClick_createObject('lapiz')"><span class="glyphicon glyphicon-pencil"></span></button>
                        {* <button :class="{hidden: !show_tools}" class="toolscanvas" @click="onClick_openCuadrado">animate</button> *}
                        <button :class="{ hidden: !show_tools }" type="button" class="toolscanvas" @click="onClick_createObject('rect')" ><i class="glyphicon glyphicon-unchecked"></i></button>
                        <button :class="{ hidden: !show_tools }" type="button" class="toolscanvas" @click="onClick_createObject('circulo')" ><i class="glyphicon glyphicon-record"></i></button>
                        <button :class="{ hidden: !show_tools }" class="toolscanvas" @click="onClick_createObject('texto')"><i class="glyphicon glyphicon-text-color"></i></button>
                        <button :class="{ hidden: !show_tools }" class="toolscanvas" @click="onClick_createObject('image')">
                          <input @change="onChange_loadImage" ref="fileimg" id="fileimg" type="file" name="" value="" placeholder="" class="hidden">
                          <label class="toolscanvas" style="font-weight: 100; margin-bottom: inherit;" for="fileimg"/><i class="glyphicon glyphicon-picture"></i></button>
                        <button :class="{ hidden: !show_tools }" type="button" class="toolscanvas" @click="onClick_eliminarObjecto"><i class="glyphicon glyphicon-erase"></i></button>
                        <button :class="{ hidden: !show_tools }" type="button" class="toolscanvas" @click="onClick_eliminarLimpiar"><i class="glyphicon glyphicon-trash"></i></button>
                        {* <button class="btnHerramienta herr_piz" id="btnCuadrado"><span class="glyphicon glyphicon-unchecked"></span></button>
                        <button class="btnHerramienta" id="btnEtiqueta"><span class="glyphicon glyphicon-tag"></span></button>
                        <button class="btnHerramienta herr_piz" id="btnTexto"><span class="glyphicon glyphicon-text-color"></span></button>
                        <button class="btnHerramienta herr_piz" id="btnBorrador"><span class="glyphicon glyphicon-erase"></span></button>
                        <button class="btnHerramienta herr_piz" id="btnImagen"><span class="glyphicon glyphicon-picture"></span></button>
                        <button class="btnHerramienta herr_piz" id="btnCaptura"><span class="glyphicon glyphicon-facetime-video"></span></button>
                        <button class="btnHerramienta herr_piz" id="btnBorrarPizarra"><span class="glyphicon glyphicon-trash"></span></button> *}
                        <button id="btn_show_tool" :class="{ hidden: show_tools }" @mouseenter="onMouseenter_showTools" type="button" class=""><i class="glyphicon glyphicon-triangle-right"></i></button>
                      </div>
                    </div>



                    {/if}
                  {if isset($pizarra) || count($pizarra) > 0 }
                    {foreach from=$pizarra item=p}

                     {*  <img class="pizarra-fondo-item" style="width: {$p.Piz_ImgWidth}px; height: {$p.Piz_ImgHeight}px;
                        top: {$p.Piz_ImgY}px; left: {$p.Piz_ImgX}px;
                        {if $leccion.Lec_LMSPizarra != $p.Piz_IdPizarra}display:none{/if}" id="pizarra-fondo-{$p.Piz_IdPizarra}"
                        src="{BASE_URL}files/elearning/_pizarra/{$p.Piz_ImgFondo}" /> *}

                    {/foreach}
                  {/if}
                  <canvas height="400px" width="650px" id="micanvas" class="no-seleccionablex"></canvas>
                  <img ref="temporal" src="" alt="" height="400px" width="650px">
                </div>
              </center>
            </div>
            {if $is_docente}
            <div id="opciones_canvas" ref="opciones_canvas" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 hidden">
              <form class="form-inline" role="form" @submit.prevent="onClick_renderCanvas">
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" v-if="showIn(['text', 'rect', 'circle'])">
                  <label class="label_options_object col-sm-6 col-md-6 col-lg-6" for="">Color borde</label>
                  <div class="col-sm-6 col-md-6 col-lg-6">
                    <input type="color" class="col-xs-12 col-md-12 col-sm-12 col-lg-12 form-controlxx" style="" v-model="opcelements.stroke">
                  </div>
                </div>

                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" v-if="current_type != 'none'">
                  <label class="label_options_object col-sm-6 col-md-6 col-lg-6" for="" v-if="showIn(['lapiz'])">Color</label>
                  <label class="label_options_object col-sm-6 col-md-6 col-lg-6" for="" v-else>Color relleno</label>
                  <div class="col-sm-6 col-md-6 col-lg-6">
                    <input type="color" class="col-xs-12 col-md-12 col-sm-12 col-lg-12 form-controlxx" style="" v-model="opcelements.fill">
                  </div>
                </div>

                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" v-if="showIn(['text', 'rect', 'circle'])">
                  <label class="label_options_object col-sm-6 col-md-6 col-lg-6" for="">Ancho borde</label>
                  <div class="col-sm-6 col-md-6 col-lg-6">
                    <input v-if="showIn(['rect', 'circle'])"  type="number" min="0" step="0.1" class="col-xs-12 col-md-12 col-sm-12 col-lg-12 form-controlxx" style="" v-model="opcelements.strokeWidth">
                    <input v-if="showIn(['text'])"  type="number" min="0" step="0.1" class="col-xs-12 col-md-12 col-sm-12 col-lg-12 form-controlxx" style="" v-model="opcelements.strokeWidth">
                  </div>
                </div>

                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" v-if="showIn(['lapiz'])">
                  <label class="label_options_object col-sm-6 col-md-6 col-lg-6" for="">Ancho</label>
                  <div class="col-sm-6 col-md-6 col-lg-6">
                    <input type="number" min="1" step="1" class="col-xs-12 col-md-12 col-sm-12 col-lg-12 form-controlxx" style="" v-model="opcelements.strokeWidth">
                  </div>
                </div>

                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4"  v-if="showIn(['rect', 'circle'])">
                  <label class="label_options_object col-sm-6 col-md-6 col-lg-6" for="">Ángulo</label>
                  <div class="col-sm-6 col-md-6 col-lg-6">
                    <input type="number" class="col-xs-12 col-md-12 col-sm-12 col-lg-12 form-controlxx" style="" v-model="opcelements.angle">
                  </div>
                </div>

                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" v-if="showIn(['text'])">
                  <label class="label_options_object col-sm-6 col-md-6 col-lg-6" for="">Fuente</label>
                  <div class="col-sm-6 col-md-6 col-lg-6">
                    <input type="number" step="1" min="1" v-model="opcelements.fontSize" class="col-xs-12 col-md-12 col-sm-12 col-lg-12 form-controlxx" id="" placeholder="00">
                  </div>
                </div>

                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4" v-if="showIn(['text'])">
                  <label class="label_options_object col-xs-12 col-sm-5 col-md-4 col-lg-4" for="">Texto</label>
                  <div class="col-xs-12 col-sm-7 col-md-8 col-lg-8">
                    <input type="text"  v-model="opcelements.text" class="col-xs-12 col-md-12 col-sm-12 col-lg-12 form-controlxx"  placeholder="Ingresar texto">
                  </div>
                </div>




                <div class="clearfix"></div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                  <button type="submit" v-if="current_type != 'none'" class="btn btn-primary btm-sm">Actualizar</button>
                </div>

              </form>

            </div>
           {*  <div id="opciones-canvas" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 pt-10 no-seleccionable ">
              Densidad: <input value="1" id="hiddenGrosor" disabled="disabled"/>
                        <input type="range" value="1" max="50" min="1" step="1" id="iHiddenGrosor"/>
              Fuente: <input value="10" id="hiddenFuente" disabled="disabled"/>
                        <input type="range" value="10" id="iHiddenFuente" max="100" min="10" step="1"/>
              Color: <input value="#000000" id="hiddenColor" onclick="ClickColor(this);"/>
            </div> *}
            {/if}
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
    <div id="chat-base-leccion">
      {* <div id="chat-container" class="hidden" style="height: 40px;">
        <div id="chat-header">
          <span class="name-chat">Chat de Clase</span>
          <div id="btnMinin">
            <span id="btnMinin_Usuarios" class="btnMinin-btn glyphicon glyphicon-user"></span>
            <span id="btnMinin_Close" class="btnMinin-btn glyphicon glyphicon-remove"></span>
            <span id="btnMinin_Open" class="btnMinin-btn glyphicon glyphicon-menu-up"></span>
          </div>
        </div>
        <div class="chat-body">
          <div id="chat-msn-body"></div>
          <div id="chat-msn-body-usuarios" class="hidden">
          </div>
          <div id="chat-text-body">
            <input id="chat-text-input" placeholder="Ingrese un mensaje" />
            <button id="chat-text-send" class="btn btn-default"><i class="glyphicon glyphicon-send"></i></button>
          </div>
        </div>
      </div> *}
      {include 'chat.tpl'}
    </div>

  </div>
  <div class="col-lg-1">
  </div>
</div>
{/block}
{block 'js'}
<script type="text/javascript">
  ALUMNOS = [];CHAT = [];
  {foreach from=$alumnos item=a}ALUMNOS.push({ id: {$a.Usu_IdUsuario}, usuario: "{$a.Usu_Nombre} {$a.Usu_Apellidos}", url: "{$a.Usu_URLImage}", docente: {$a.Docente} });{/foreach}
  {foreach from=$chat item=c}
    CHAT.push({
      usuario: {$c.Usu_IdUsuario},
      msn: `{nl2br($c.Men_Descripcion)})`,
      fecha: "{$c.Men_Fecha}"
    });
  {/foreach}
  USUARIO = {
    id: {$usuario}, curso: {$curso}, docente: {if $is_docente}1{else}0{/if}
  };
  LMS_CURSO = {$ocurso.Cur_IdCurso};
  LMS_LECCION = {$leccion.Lec_IdLeccion};
  LMS_URL = "{BASE_URL}";
  var VIEW_ESPERA = false;
</script>
<script type="text/javascript" src="{$_layoutParams.root_clear}public/js/socket.io/socket.io.js"></script>
<script type="text/javascript" src="{$_layoutParams.root_clear}public/js/socket.io/socket.client.js"></script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
modulo-contenedor
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/vendors/fabric/fabric.beautified.js"></script>
{* <script type="text/javascript" src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js"></script> *}
{if $is_docente}
  <script src="{BASE_URL}modules/elearning/views/clase/js/canvasdos.js"></script>
{else}
  <script src="{BASE_URL}modules/elearning/views/clase/js/canvasalumno.js"></script>
{/if}

<script src="{BASE_URL}modules/elearning/views/clase/js/chat.js"></script>


{* <script type="text/javascript" src="{BASE_URL}modules/elearning/views/clase/js/sockets.js"></script> *}
{/block}