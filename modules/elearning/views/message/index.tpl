<input hidden="hidden" id="hidden_root" value="{$_url}" />
<input hidden="hidden" id="hidden_url" value="{$learn_url}" />
<input type="´text" id="inTipoChat" hidden="hidden">
<input type="´text" id="inID1Chat" hidden="hidden">
<input type="´text" id="inID2Chat" hidden="hidden">

<input value="600" type="´text" id="viewAlto" hidden="hidden"/>


<div id="item-view-1" style="display: none"></div>
<div id="item-view-2" style="display: none"></div>

<div class="chat_lateral">
	<div class="chat_lateral__cabecera">
		<a href="{BASE_URL}elearning/cursos/cursos" class="btn btn-success">Regresar a cursos</a>
		<button class="btn btn-success pull-right" style="margin-right: 10px" id="btnNuevo">Nuevo Mensaje</button>
	</div>
	<div class="chat_lateral__busqueda">
		<input placeholder="Buscar conversación" class="form-control" id="inBusquedaChat" />
	</div>
	<div class="chat_conv_container">
		{include file='modules/elearning/views/message/menu/lateral.tpl'}
	</div>
</div>
<div class="chat_content">
	<div class="chat_content__clean" style="padding-top: 300px">
		<div style="color: #525F67"><h3>Seleccione un chat o inicie uno nuevo</h3></div>
		<div style="color: #525F67"><h5>Puedes interactuar con usuario de la plataforma directamente <br/>o conversar en los chats de cada lección</h5></div>
	</div>
	<div class="chat_content__active" style="display: none">
		<div class="chat_content__active__header">
			<div class="chat_content__active__header__text"></div>
			<div class="chat_content__active__header__subtext"></div>
			<span class="glyphicon glyphicon-resize-full" id="btnFullScreen" tag="0"></span>
		</div>
		<div class="chat_content__active__area">
			<div class="chat_content__active__area__contrapeso"></div>
		</div>
		<div class="chat_content__active__footer">
			<input type="text" id="inNuevoMensaje" class="form-control" max="390">
			<button class="btn btn-success" id="btnEnviarMensaje">Enviar</button>
		</div>
	</div>
</div>

<div class="modal" id="panelNuevoChat" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-md">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Nuevo Chat</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body">
        <form></form>
        <form method="POST" action="message/_usuario" id="frm_busqueda_usuario">
          <div class="col-lg-12 margin-top-10">
						<strong>Usuario: </strong>
					</div>
          <input hidden="hidden" value="{$leccion.Lec_IdLeccion}" name="leccion"/>
					<div class="col-lg-12">
						<input id="inBusquedaCampo" class="form-control" type="text" name="usuario" autocomplete="off"/>
					</div>
          <div class="col-lg-12">
						<div id="zoneAutocomplete">
							Ingrese el nombre de contacto
						</div>
					</div>
          <div class="col-lg-12 margin-top-10" style="margin-top: 10px">
          	<button class="btn btn-success" id="btn_registrar_contenido">
          		Aceptar
          	</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>
