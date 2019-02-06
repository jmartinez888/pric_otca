
<template id="msg_chat_v2">
  <div class="content-msn">
    <div :class="{
      ctn-mensaje: true,
      'mensaje-me': tipo == msg.propio,
      'mensaje-other': tipo == msg.otro,
    }">
      <div class="mensaje-chat-text">
          <div class="sujeto-link">
            <div class="avatar">
              <img class="img-circle-msn" />
            </div>
            <strong>{literal}{{usuario}}{/literal}</strong>
          </div>
          <p class="p-mensaje">{literal}{{mensaje}}{/literal}</p>
          <p class="p-time"><small data-time-message="{literal}{{fecha_format}}{/literal}">{literal}{{fecha_now}}{/literal}</small></p>
      </div>
    </div>
  </div>
</template>


<template id="msg_propio">
  <div class="content-msn">
    <div class="mensaje-me ctn-mensaje">
      <div class="mensaje-chat-text">
          <div class="sujeto-link">
            <div class="avatar">
              <img class="img-circle-msn" src="{literal}{{usuario_img_url}}{/literal}"/>
            </div>
            <strong>{literal}{{usuario}}{/literal}</strong>
          </div>
          <p class="p-mensaje">{literal}{{mensaje}}{/literal}</p>
          <p class="p-time"><small data-time-message="{literal}{{fecha_format}}{/literal}">{literal}{{fecha_now}}{/literal}</small></p>
      </div>
    </div>
  </div>
</template>
<template id="msg_otro">
  <div class="content-msn">
    <div class="mensaje-other ctn-mensaje">
    <div class="mensaje-chat-text">
        <div class="sujeto-link">
          <div class="avatar">
              <img class="img-circle-msn" src="{literal}{{usuario_img_url}}{/literal}"/>
          </div>
          <strong>{literal}{{usuario}}{/literal}</strong>
        </div>
        <p class="p-mensaje">{literal}{{mensaje}}{/literal}</p>
        <p class="p-time"><small data-time-message="{literal}{{fecha_format}}{/literal}">{literal}{{fecha_now}}{/literal}</small></p>
    </div>
    </div>
  </div>
</template>

<template id="status_conectado">
  <div class="content-msn">
    <div class="mensaje-me ctn-mensaje">
      <div class="mensaje-chat-text">
          <div class="sujeto-link">
            <div class="avatar">
              <img class="img-circle-msn">
            </div>
            <strong>{literal}{{nombre}}{/literal}</strong>
          </div>
          <p class="p-time"><small>{literal}{{fecha_from_now}}{/literal}</small></p>
      </div>
      {* {if (isset($is_docente) && $is_docente == true)}
      <div class="option_supervisor">
        <i data-usuario-id="{literal}{{usuario_id}}{/literal}" class="btnAsistencia cursor-pointer fa fa-{literal}{{faMode}}{/literal}" aria-hidden="true" title="{literal}{{title}}{/literal}"></i>
      </div> 
      {/if} *}
    </div>
  </div>
</template>

