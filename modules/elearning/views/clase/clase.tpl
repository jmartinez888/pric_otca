{extends 'template.tpl'}
{* <script src="https://apis.google.com/js/platform.js?onload=onLoadCallback" async defer></script> *}
{block 'css'}
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/elearning/views/clase/css/style-show-modules.css">
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
<input type="hidden" value="{$hash_session_activa}" id="hash_session">
<div class="container-curso col-xs-12 panel panel-default" style="margin-top:20px;">
  <div class="row gradiente">
    <div class="col-xs-12 col-md-12 col-sm-12 col-lg-12 titulo-modulo">
      <h4><strong> {$lang->get('str_modulo')} {$mod_datos.INDEX}: {$modulo["Moc_Titulo"]}</strong></h4>
      <div class="container-btn-curso">
        <a class="btn btn-sm btn-default btn-group" href="{BASE_URL}elearning/gestion/matriculados/{$curso}">
          <span class="glyphicon glyphicon-book" aria-hidden="true"></span>
          {$lang->get('elearning_cursos_gestion_curso')}
        </a>
        
        <a class="btn btn-sm btn-success btn-group pull-right" href="{BASE_URL}elearning/cursos/curso/{$curso}">
          <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
          {$lang->get('elearning_cursos_volver_curso')}
        </a>
      </div>
    </div>
    <div class="section-paginador col-xs-12 col-md-12 col-sm-12 col-lg-12 mb-4 ">
      {if $leccion["Index"] > 1 }
      <form method="post" class="container-btn-previous" action="{BASE_URL}elearning/cursos/_previous_leccion/">
        <input value="{$curso}" name="curso" hidden="hidden" />
        <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden" />
        <button class="btn btn-sm btn-next-previous">
          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
          {$lang->get('str_anterior')}
        </button>
      </form>
      {else}
      <div class="container-btn-previous">
        <button class=" btn btn-sm btn-default" disabled="disabled">
          <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
          {$lang->get('str_anterior')}
        </button>
      </div>
      {/if}
      <span class="text-current-leccion">{$lang->get('str_leccion')} {$leccion["Index"]} {$lang->get('str_de')}
        {count($lecciones)}</span>
      {if $leccion["Index"] < {count($lecciones)} } 
      <form method="post" class="container-btn-next" action="{BASE_URL}elearning/cursos/_next_leccion/">
        <input value="{$curso}" name="curso" hidden="hidden" />
        <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden" />
        <button class="btn btn-sm btn-next-previous">
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
        <input value="{$curso}" name="curso" hidden="hidden" />
        <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden" />
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
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 pr-0 pl-0" id="modulo-contenedor">
      <div class="col-lg-12">
        <div class="panel modulo-contenedor panel-default margin-top-10">
          <div class="panel-heading">
            <h3 class="panel-title">
              <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
              <strong>{$lang->get('str_leccion_dirigida')}: {$leccion.Lec_Titulo} <span id="icon-conectado"></span>&nbsp;&nbsp;<span id="totales_conectados">--</span>
                {$lang->get('str_en_linea')}.</strong>
            </h3>
          </div>
          <div class="panel-body" style="margin: 0px">


            <div class="row no-seleccionable" style="padding-bottom: 10px" id="leccion-contenido">

              {if isset($pizarra) && count($pizarra) > 0 && $usuario==$ocurso.Usu_IdUsuario }
              <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12  contenedor-mini-pizarras">
              </div>
              {/if}
              <div class="col-sm-12 p-0 hola">
                <div class="col-sm-3 container-chat-pizarra" id="ref-container-chat-pizarra" ref="refContainerChatPizarra">



                  <div role="tabpanel">
                    <ul class="nav nav-tabs" role="tablist" ref="navsPanel">
                      <li role="presentation" class="active">
                        <a href="#chat-panel" aria-controls="chat-panel" role="tab" data-toggle="tab"><span>{$lang->get('str_usuario')}</span></a>
                      </li>
                      {if ($is_docente)}
                      <li role="presentation">
                        <a href="#pizarra-panel" aria-controls="pizarra-panel" role="tab" data-toggle="tab"><span>{$lang->get('str_pizarras')}</span></a>
                      </li>
                      {/if}
                    </ul>
                    <div class="tab-content">
                      <div role="tabpanel" class="tab-pane active hidden" id="chat-panel" ref="chatPanel">
                        <div id="chat-derecha-leccion">
                          {include 'chat_derecha.tpl'}
                        </div>
                      </div>
                      {if ($is_docente)}
                      <div role="tabpanel" class="tab-pane hidden" id="pizarra-panel" ref="pizarraPanel">
                       {if $usuario==$ocurso.Usu_IdUsuario}
                          <div class="col-sm-12" style="display:grid; margin-bottom: 8px">

                            <button @click="onClick_agregarPizarra" type="button" class="btn btn-success pull-right" id="btn-agregar-pizarra">{$lang->get('elearning_cursos_agregar_pizarra')}</button>
                          </div>
                          {include file='modules/elearning/views/clase/menu/pizarra.tpl'}
                          {/if}
                        {if isset($pizarra) && count($pizarra) > 0 && $usuario==$ocurso.Usu_IdUsuario }
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12  contenedor-mini-pizarras">
                          {* <label>Pizarras</label> *}
                          <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" id="tmp_mini_pizarras">
                            {* {foreach from=$pizarra item=p key=i} *}
                            <div v-for="(piz, index) in PIZARRAS" class="panel-item-pizarra" @click="onClick_seleccionPizarra(piz.Piz_IdPizarra)">
                              <div class="panel item-pizarra">
                                
                                <img v-if="piz.Piz_ImgFondo == ''" :id="'pizarrabg_' + piz.Piz_IdPizarra" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABkCAQAAADa613fAAAAaElEQVR42u3PQREAAAwCoNm/9CL496ABuREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREREWkezG8AZQ6nfncAAAAASUVORK5CYII=" />
                                
                                <img v-else :id="'pizarrabg_' + piz.Piz_IdPizarra" :src="base_url('files/elearning/_pizarra/' + piz.Piz_ImgFondo, true)" />
                                

                                <strong class="number_pizarra">{literal}{{index + 1}}{/literal}</strong>
                              </div>
                            </div>
                            {* {/foreach} *}
                          </div>
                        </div>

                         
                        {/if}
                      </div>
                      {/if}
                    </div>
                  </div>




                </div>
                <div class="col-sm-9 container-canvas-pizarra">
                  <div id="panel-pizarra-final" class="w-100" ref="panel_pizarra_final">
                    <div class="canvas-ssss">
                      <canvas height="0px" width="0px" ref="micanvas" id="micanvas" class="no-seleccionablex"></canvas>
                    </div>
                    {* <img ref="temporal" src="" alt="" height="495px" width="796px"> *}
                    {if $is_docente}
                    <div id="herramientas-canvas_v2" style="" class="no-seleccionable">
                      {* <div @mouseleave="show_tools = false"> *}
                      <div>

                        <button :class="{ hidden: !show_tools }" class="toolscanvas" @click="onClick_createObject('normal')"><i class="glyphicon glyphicon-screenshot"></i></button>
                        <button :class="{ hidden: !show_tools }" class="toolscanvas" @click="onClick_createObject('lapiz')"><span class="glyphicon glyphicon-pencil"></span></button>
                        {* <button :class="{hidden: !show_tools}" class="toolscanvas" @click="onClick_openCuadrado">animate</button>
                        *}
                        <button :class="{ hidden: !show_tools }" type="button" class="toolscanvas" @click="onClick_createObject('rect')"><i class="glyphicon glyphicon-unchecked"></i></button>
                        <button :class="{ hidden: !show_tools }" type="button" class="toolscanvas" @click="onClick_createObject('circulo')"><i class="glyphicon glyphicon-record"></i></button>
                        <button :class="{ hidden: !show_tools }" class="toolscanvas" @click="onClick_createObject('texto')"><i class="glyphicon glyphicon-text-color"></i></button>
                        <button :class="{ hidden: !show_tools }" class="toolscanvas" @click="onClick_createObject('image')">
                          <input @change="onChange_loadImage" ref="fileimg" id="fileimg" type="file" name="" value="" placeholder="" class="hidden">
                          <label class="toolscanvas" style="font-weight: 100; margin-bottom: inherit;" for="fileimg" /><i class="glyphicon glyphicon-picture"></i></button>
                        <button :class="{ hidden: !show_tools }" type="button" class="toolscanvas" @click="onClick_eliminarObjecto"><i class="glyphicon glyphicon-erase"></i></button>
                        <button :class="{ hidden: !show_tools }" type="button" class="toolscanvas" @click="onClick_eliminarLimpiar"><i class="glyphicon glyphicon-trash"></i></button>
                        {* <button class="btnHerramienta herr_piz" id="btnCuadrado"><span class="glyphicon glyphicon-unchecked"></span></button>
                        <button class="btnHerramienta" id="btnEtiqueta"><span class="glyphicon glyphicon-tag"></span></button>
                        <button class="btnHerramienta herr_piz" id="btnTexto"><span class="glyphicon glyphicon-text-color"></span></button>
                        <button class="btnHerramienta herr_piz" id="btnBorrador"><span class="glyphicon glyphicon-erase"></span></button>
                        <button class="btnHerramienta herr_piz" id="btnImagen"><span class="glyphicon glyphicon-picture"></span></button>
                        <button class="btnHerramienta herr_piz" id="btnCaptura"><span class="glyphicon glyphicon-facetime-video"></span></button>
                        <button class="btnHerramienta herr_piz" id="btnBorrarPizarra"><span class="glyphicon glyphicon-trash"></span></button>
                        *}
                        {* <button id="btn_show_tool" :class="{ hidden: show_tools }" @mouseenter="onMouseenter_showTools" type="button" class=""><i class="glyphicon glyphicon-triangle-right"></i></button> *}
                      </div>
                    </div>
                    <div id="opciones_canvas" ref="opciones_canvas" class="col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                      {* <form class="form-inline" role="form" @submit.prevent="onClick_renderCanvas"> *}
                        {* <div class="tool-option tool-option-color-border" v-if="showIn(['text', 'rect', 'circle'])"> *}
                        <div class="tool-option tool-option-color-border" v-if="showIn('all')">
                          <label class="" for="">Borde</label>
                          <div class="">
                            <input type="color" class="" style="" v-model="opcelements.stroke">
                          </div>
                        </div>

                        <div class="tool-option tool-option-color-relleno">
                          <label class="label_options_object " for="" v-if="showIn(['lapiz'])">Color</label>
                          <label class="label_options_object " for="" v-else>Relleno</label>
                          {* <label class="label_options_object " for="" v-if="showIn('all')">Relleno</label> *}
                          <div class="">
                            <input type="color" class=" form-controlxx" style="" v-model="opcelements.fill">
                          </div>
                        </div>

                        {* <div class="tool-option tool-option-border-ancho" v-if="showIn(['text', 'rect', 'circle'])"> *}
                        <div class="tool-option tool-option-border-ancho" v-if="showIn('all')">
                          <label class="label_options_object " for="">Ancho borde</label>
                          <div class="">
                            {* <input v-if="showIn(['rect', 'circle'])" type="number" min="0" step="0.1" class=" form-controlxx" style="" v-model="opcelements.strokeWidth">
                            <input v-if="showIn(['text'])" type="number" min="0" step="0.1" class=" form-controlxx" style="" v-model="opcelements.strokeWidth"> *}
                            <input v-if="showIn('all')" type="number" min="0" step="0.1" class=" form-controlxx" style="" v-model="opcelements.strokeWidth">
                          </div>
                        </div>

                        {* <div class="tool-option tool-option-ancho" v-if="showIn(['lapiz'])"> *}
                        {* ANCHO DE CAJA *}
                        {* <div class="tool-option tool-option-ancho" v-if="showIn('all')">
                          <label class="label_options_object " for="">Ancho</label>
                          <div class="">
                            <input type="number" min="1" step="1" class=" form-controlxx" style="" v-model="opcelements.strokeWidth">
                          </div>
                        </div> *}

                        {* <div class="tool-option tool-option-angulo" v-if="showIn(['rect', 'circle'])"> *}
                        {* NO HY AFUNCTION *}
                        {* <div class="tool-option tool-option-angulo" v-if="showIn('all')">
                          <label class="label_options_object " for="">Ángulo</label>
                          <div class="">
                            <input type="number" class=" form-controlxx" style="" v-model="opcelements.angle">
                          </div>
                        </div> *}

                        {* <div class="tool-option tool-option-fuente-size" v-if="showIn(['text'])"> *}
                        <div class="tool-option tool-option-fuente-size" v-if="showIn('all')">
                          <label class="label_options_object " for="">Tamaño letra</label>
                          <div class="">
                            <input type="number" step="1" min="1" v-model="opcelements.fontSize" class=" form-controlxx" id="" placeholder="00">
                          </div>
                        </div>

                        {* <div class="tool-option tool-option-texto" v-if="showIn(['text'])"> *}
                        <div class="tool-option tool-option-texto" v-if="showIn('all')">
                          <label class="label_options_object" for="">Texto</label>
                          <div class="">
                            <input type="text" v-model="opcelements.text" class="form-controlxx" placeholder="Ingresar texto">
                          </div>
                        </div>




                        {* <div class="clearfix"></div> *}
                        {* <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">

                          <button type="submit" v-if="current_type != 'none'" class="btn btn-primary btm-sm">Actualizar</button>
                        </div> *}

                      {* </form> *}

                    </div>
                    {/if}
                  </div>
                </div>
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
              <strong>{$lang->get('str_opciones')}</strong>
            </h3>
          </div>
          <div class="panel-body" style="margin: 0px">

            <div id="placeholder-div1"></div>

            {if $usuario==$ocurso.Usu_IdUsuario}
            <a href="{BASE_URL}elearning/clase/finalizar/{$curso}/{$modulo.Moc_IdModuloCurso}/{$leccion.Lec_IdLeccion}">
              <button class="btn btn-success" id="btnFinalizarClase" style="margin-bottom: 10px">
                {$lang->get('elearning_cursos_finalizar_leccion')}
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
              <strong>{$lang->get('elearning_cursos_link_video_conferencia')}</strong>
            </h3>
          </div>
          <div class="panel-body" style="margin: 0px">
            {if $usuario==$ocurso.Usu_IdUsuario}
            <div id="placeholder-div2"></div>

            <div class="input-group">
              <input name="busqueda" class="form-control" id="in-link-videollamada" value="">
              <span class="input-group-btn">
                <button class="btn btn.btn-success" id="btn-enviar-link">{$lang->get('str_enviar')}</button>
              </span>
            </div>
            {else}
            <input value="" id="in-link-videollamada_receive" hidden="hidden" class="form-control" />
            <button class="btn btn.btn-success" id="btn-ir-video">{$lang->get('elearning_cursos_ir_a_video')}</button>
            {/if}
          </div>
        </div>
      </div>



      {* {include file='modules/elearning/views/cursos/menu/info_leccion.tpl'} *}
      {* <div id="chat-base-leccion">
        {include 'chat.tpl'}
      </div> *}

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
{block 'template'}
  {include file='modules/elearning/views/clase/utils_chats.tpl'}
{/block}
{block 'js'}
<script type="text/javascript">
  var HASH_LECCION = '{$hash_leccion}';
  var HASH_SESSION = '{$hash_session_activa}';
  
  var PIZARRAS = {json_encode($pizarra)}
    DOCENTE_ID = {$docente_id};
    USUARIO = {
            id: {$usuario},
            curso: {$curso},
            docente: {if $is_docente}1{else}0{/if}
          };
    LMS_CURSO = {$ocurso.Cur_IdCurso};
    LMS_LECCION = {$leccion.Lec_IdLeccion};
    LMS_URL = "{BASE_URL}";
    var VIEW_ESPERA = false;
</script>
<script src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_layoutParams.root_clear}public/js/socket.io/socket.io.js"></script>
<script type="text/javascript" src="{$_layoutParams.root_clear}public/js/socket.io/socket.client.js"></script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>
  moment.locale('{Cookie::lenguaje()}')
</script>

<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/vendors/fabric/fabric.beautified.js"></script>
{* <script type="text/javascript" src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js"></script> *}
<script src="{BASE_URL}modules/elearning/views/clase/js/menu-interactive.js"></script>
{if $is_docente}
<script src="{BASE_URL}modules/elearning/views/clase/js/canvasdos.js"></script>
<script src="{BASE_URL}modules/elearning/views/clase/js/mixin_chats.js"></script>
{else}
<script src="{BASE_URL}modules/elearning/views/clase/js/canvasalumno.js"></script>
{/if}

<script src="{BASE_URL}modules/elearning/views/clase/js/chat_v2.js"></script>


{* <script type="text/javascript" src="{BASE_URL}modules/elearning/views/clase/js/sockets.js"></script> *}
{/block}