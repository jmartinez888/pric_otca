{extends 'difusion_frontend.tpl'}
{block 'css' append}
{/block}

{block 'subcontenido'}
<div class="row">
  <div class="col-sm-12">
      <h2 class="titulo">{$titulo}</h2>
      <div class="col-lg-12 p-rt-lt-0">
          <hr class="cursos-hr-title-foro">
      </div>
  </div>
</div>
<div class="container-fluid" id="vue_container">
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
              <label class="col-lg-2 control-label" for="difusion">{$lenguaje['str_difusion']} : </label>
              <div class="col-lg-10">
                <div class="input-group">
                  <input  class="form-control" id="difusion" type="text" name="difusion" placeholder="{$lenguaje['str_seleccione_buscar']}"  required="" v-model="nombre_difusion" ref="difusion">
                  <span class="input-group-btn"><button @click="onClick_openModDifusion" class="btn btn-default" type="button"><i class="fa fa-search"></i></button></span>
                </div>


              </div>
          </div>
          <div class="form-group">
              <label class="col-lg-2 control-label" for="indicador">{$lenguaje['str_indicador']} : </label>
              <div class="col-lg-10">
                  <select  name="indicador" id="indicador" class="form-control" required="required" v-model="indicador">
                      {foreach $indicadores as $item}
                      <option value="{$item->OInd_IdIndicadores}">{$item->OInd_Titulo}</option>
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
              <label class="col-lg-2 control-label" for="url_ref">Url : </label>
              <div class="col-lg-10">
                  <input  class="form-control" id="url_ref" type="text" name="url_ref" placeholder="Url" required="" v-model="url">
              </div>
          </div>
          <div class="form-group">
              <label class="col-lg-2 control-label" for="latitude">{$lenguaje['str_latitud']} : </label>
              <div class="col-lg-10">
                  <input  class="form-control" id="latitude" type="text" name="latitude" placeholder="{$lenguaje['str_latitud']}" required="" v-model="latitude">
              </div>
          </div>
          <div class="form-group">
              <label class="col-lg-2 control-label" for="longitude">{$lenguaje['str_longitud']} : </label>
              <div class="col-lg-10">
                  <input  class="form-control" id="longitude" type="text" name="longitude" placeholder="{$lenguaje['str_longitud']}" required="" v-model="longitude">
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
              <div class="col-lg-offset-2 col-lg-10">
                  <button class="btn btn-success" type="submit" id="bt_guardarRol" name="bt_guardarRol" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje['str_guardar']}</button>
              </div>
          </div>
      </form>
      {include 'mod_difusion.tpl'}
  </div>
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
<script type="text/javascript" src="{$_layoutParams.rutas.js}create.js"></script>
{/block}