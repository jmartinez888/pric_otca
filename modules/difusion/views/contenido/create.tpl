{extends 'difusion_frontend.tpl'}
{block 'css' append}
{/block}

{block 'subcontenido'}
<div class="row">
  <div class="col-sm-12">
      <h2 class="titulo">{$lenguaje.difusion_contenido_index_titulo}</h2>
      <div class="col-lg-12 p-rt-lt-0">
          <hr class="cursos-hr-title-foro">
      </div>
  </div>
</div>
<div class="container-fluid" id="difusion_gestion">
	<form-contenido></form-contenido>
</div>
{/block}
{block 'template'}
<template id="form_contenido">
	  <div class="col-sm-9">
      <form class="form-horizontal" data-toggle="validator"  role="form" @submit.prevent="onSubmit_registrar" novalidate="true">
          <div class="form-group">
              <label class="col-lg-2 control-label">{$lenguaje['str_idioma']} : </label>
              <div class="col-lg-10">
                  <div class="checkbox">
                      {foreach $idiomas as $item}
                      <label>
                          {if $item->Idi_IdIdioma == Cookie::lenguaje()}
                          <input type="radio" name="radio_idioma" value="{$item->Idi_IdIdioma}"  checked="" v-model="idioma_actual">
                          {else}
                          <input type="radio" name="radio_idioma" value="{$item->Idi_IdIdioma}" v-model="idioma_actual">
                          {/if}
                          {$item->Idi_Idioma}
                      </label>
                      {/foreach}
                  </div>
              </div>
          </div>
          <div class="form-group">
              <label class="col-lg-2 control-label" for="titulo">{$lenguaje['str_titulo']} : </label>
              <div class="col-lg-10">
                  {foreach $idiomas as $item}
                  <input v-if="idioma_actual == '{$item->Idi_IdIdioma}'" class="form-control" id="titulo" type="text" name="titulo" placeholder="{$lenguaje['difusion_contenido_index_inp_titulo_ph']}" required="" v-model="idiomas.idioma_{$item->Idi_IdIdioma}.titulo">
                  {/foreach}
              </div>
          </div>
          <div class="form-group">
              <label class="col-lg-2 control-label" for="tipo">{$lenguaje['str_tipo']} : </label>
              <div class="col-lg-10">
                  <select  name="tipo" id="tipo" class="form-control" required="required" v-model="tipo">
                      {foreach $tipo_difusion as $tipo}
                      <option value="{$tipo->ODit_IdTipoDifusion}">{$tipo->ODit_Tipo}</option>
                      {/foreach}
                  </select>
              </div>
          </div>
          <div class="form-group">
              <label class="col-lg-2 control-label" for="tematica">{$lenguaje['str_tematica']} : </label>
              <div class="col-lg-10">
                  <select name="tematica" id="tematica" class="form-control" required="required" v-model="linea_tematica">
                      {foreach $tematicas as $tema}
                      <option value="{$tema->Lit_IdLineaTematica}">{$tema->Lit_Nombre}</option>
                      {/foreach}
                  </select>
              </div>
          </div>
          <div class="form-group">
              <label class="col-lg-2 control-label" for="descripcion">{$lenguaje['str_descripcion']} : </label>
              <div class="col-lg-10">
                  {foreach $idiomas as $item}
                  <textarea rows="2" v-if="idioma_actual == '{$item->Idi_IdIdioma}'" class="form-control" id="descripcion" type="text" name="descripcion" placeholder="{$lenguaje['difusion_contenido_index_inp_descripcion_ph']}" required="" v-model="idiomas.idioma_{$item->Idi_IdIdioma}.descripcion"></textarea>
                  {/foreach}
              </div>
          </div>
          <div class="form-group">
              <label class="col-lg-2 control-label" for="palabras_clave">{$lenguaje['str_palabras_clave']} : </label>
              <div class="col-lg-10">
                  {foreach $idiomas as $item}
                  <input v-if="idioma_actual == '{$item->Idi_IdIdioma}'" class="form-control" id="palabras_clave" type="text" name="palabras_clave" placeholder="{$lenguaje['difusion_contenido_index_inp_titulo_ph']}" required="" v-model="idiomas.idioma_{$item->Idi_IdIdioma}.palabras_clave">
                  {/foreach}
              </div>
          </div>
          <div class="form-group">
              <label class="col-lg-2 control-label" for="imagen">{$lenguaje['str_imagen']} : </label>
              <div class="col-lg-10">
                  <input type="file" ref="imagen" class="form-control" id="imagen" type="text" name="imagen" required="" v-model="imagen">
              </div>
          </div>
          <div class="form-group">
              <label class="col-lg-2 control-label">{$lenguaje['str_activo']} : </label>
              <div class="col-lg-10">
                  <div class="checkbox">
                      <label>
                          <input type="checkbox" v-model="estado">
                          {$lenguaje['str_activo']}
                      </label>
                  </div>
              </div>
          </div>
          <div class="form-group">
              <label class="col-lg-2 control-label" for="contenido">{$lenguaje['str_contenido']} : </label>
              <div class="col-lg-10">
                  {* {foreach $idiomas as $item} *}
                  {* <div class="guarder_{$item->Idi_Idioma}" v-if="idioma_actual == '{$item->Idi_IdIdioma}'" > *}
                      <textarea rows="2"  class="form-control contenidos" id="contenido" type="text" name="contenido_{$item->Idi_Idioma}" required=""></textarea>
                  {* </div> *}
                  {* {/foreach} *}
              </div>
          </div>
          <div class="form-group">
              <div class="col-lg-offset-2 col-lg-10">
                  <button class="btn btn-success" type="submit" id="bt_guardarRol" name="bt_guardarRol" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje['str_guardar']}</button>
              </div>
          </div>
      </form>
  </div>
</template>
<template id="botones_test">
    <a target="_blank" data-toggle="tooltip" data-placement="bottom" class="btn btn-default  btn-sm glyphicon glyphicon-eye-open" title="" href="{$_layoutParams.root}difusion/contenido/{literal}{{id}}{/literal}" data-original-title="Ver Ficha "></a>
    <button data-toggle="tooltip" data-placement="bottom" data-accion="estado" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-rol btn-acciones"  data-estado="{literal}{{estado}}{/literal}" data-id="{literal}{{id}}{/literal}"  data-nombre="{literal}{{nombre}}{/literal}" title="{$lenguaje['str_cambiar_estado']}"> </button>
    <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-acciones btn-sm glyphicon glyphicon-edit" title="{$lenguaje['str_editar']}" href="{literal} {{url}} {/literal}"></a>
    <button data-toggle="tooltip" data-id="{literal} {{id}} {/literal}"  data-accion="eliminar" class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-rol btn-acciones" data-nombre="{literal}{{nombre}}{/literal}" title="{$lenguaje['str_eliminar']}" data-placement="bottom"> </button>
</template>
{/block}
{block 'js' append}
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript" src="{BASE_URL}public/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="{BASE_URL}public/ckeditor/adapters/jquery.js"></script>
<script type="text/javascript" src="{BASE_URL}public/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="{BASE_URL}public/js/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript">
var data_vue = {json_encode($data_vue)};
</script>
<script type="text/javascript" src="{BASE_URL}modules/difusion/views/contenido/js/create.js"></script>
{/block}