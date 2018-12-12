  <div id="chat-container" class="hidden" >
    <div id="chat-header">
      <span class="name-chat">Chat de Clase</span>
      <div id="btnMinin">
        <span id="btnMinin_Usuarios" class="btnMinin-btn glyphicon glyphicon-user"></span>
        <span id="btnMinin_Close" class="btnMinin-btn glyphicon glyphicon-remove"></span>
        <span id="btnMinin_Open" class="btnMinin-btn glyphicon glyphicon-menu-up"></span>
      </div>
    </div>
    <div class="chat-body">
      <div id="chat-msn-body-usuarios" class="hidden">
      </div>
      <div id="chat-msn-body"></div>
      <div id="chat-text-body">
        <input id="chat-text-input" placeholder="Ingrese un mensaje" />
        <button id="chat-text-send" class="btn btn-default"><i class="glyphicon glyphicon-send"></i></button>
      </div>
    </div>
    <audio id="chatAudio"><source src="{$_layoutParams.root_clear}public/media/notification.mp3" type="audio/mpeg"><source src="{$_layoutParams.root_clear}public/media/notification.wav" type="audio/wav"></audio>
  </div>