{extends 'difusion_frontend.tpl'}
{block 'css' append}
<link rel="stylesheet" type="text/css" href="{BASE_URL}public/vendors/cropperjs/dist/cropper.min.css">
<style type="text/css" media="screen">
  #image {
    max-width: 100% !important;
    /*padding: 40px;*/
  }
  .cropper-container {
    /*max-width: 100% !important;*/
  }
  #opciones-imagen {
    margin-bottom: 8px;
  }
</style>
{/block}
{block 'subcontenido'}
<div class="row" id="banner_create">
  <div class="col-sm-12">
    <div class="row">

      <div class="col-sm-12">
          <h2 class="titulo">{$lenguaje['difusion_contenido_index_banner_crear']}</h2>
          <div class="col-lg-12 p-rt-lt-0">
              <hr class="cursos-hr-title-foro">
          </div>
      </div>
    </div>

    <div class="row">
      <div class="col-sm-10">
        <form-banner></form-banner>

      </div>
    </div>
  </div>
</div>
{/block}
{block 'template'}
<template id="form_banner">
  <div>
    <form  id="frm_buscar_difusion" @submit.prevent="onSubmit_buscarDifusion"></form>
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
                                  <input v-if="idioma_actual == '{$item->Idi_IdIdioma}'" class="form-control" id="titulo" type="text" name="titulo" placeholder="{$lenguaje['str_ingrese_texto']}" required="" v-model="idiomas.idioma_{$item->Idi_IdIdioma}.titulo">
                                  {/foreach}
                              </div>
                          </div>
                          <div class="form-group">
                              <label class="col-lg-2 control-label" for="difusion">{$lenguaje['str_difusion']} : </label>
                              <div class="col-lg-10">
                                <div class="input-group">
                                  <input form="frm_buscar_difusion"  class="form-control" id="difusion" type="text" name="difusion" placeholder="{$lenguaje['str_seleccione_buscar']}"  required="" v-model="nombre_difusion" ref="difusion" :readonly="difusion_id != 0">
                                  <span class="input-group-btn">

                                    <button v-if="difusion_id == 0" form="frm_buscar_difusion" class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
                                    <button v-else @click="resetBuscar" form="frm_buscar_difusion" class="btn btn-default" type="button"><i class="fa fa-edit" ></i></button>
                                  </span>
                                </div>


                              </div>
                          </div>

                          <div class="form-group" v-if="difusion_id != 0 && saved_difusion">
                            <div class="col-lg-10 col-lg-offset-2">
                              <blockquote style="font-size:1em">
                                <p>{literal}{{descripcion_difusion}}{/literal}</p>
                              </blockquote>
                            </div>
                          </div>


                          <div class="form-group">
                              <label class="col-lg-2 control-label" for="descripcion">{$lenguaje['str_descripcion']} : </label>
                              <div class="col-lg-10">
                                  {foreach $idiomas as $item}
                                  <textarea rows="2" v-if="idioma_actual == '{$item->Idi_IdIdioma}'" class="form-control" id="descripcion" type="text" ref="descripcion" name="descripcion" placeholder="{$lenguaje['difusion_banner_inp_descripcion_ph']}" required="" v-model="idiomas.idioma_{$item->Idi_IdIdioma}.descripcion"></textarea>
                                  {/foreach}
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
                              <label class="col-lg-2 control-label" for="image">{$lenguaje['str_descripcion']} : </label>
                              <div class="col-lg-10">
                                <div class="row">
                                  <div class="col-sm-12">
                                    <div id="opciones-imagen">
                                      <button type="button" style="padding: 7px 10px" data-toggle="tooltip" data-placement="top" data-accion="ok" class="btn btn-default btn-sm fa fa-save estado-rol btn-acciones"  title="{$lenguaje['str_guardar_imagen']}"></button>
                                      <label class="btn btn-default btn-sm" for="input_banner"  data-toggle="tooltip" title="{$lenguaje['str_importar_imagen']}" data-placement="top">
                                        <input type="file" class="sr-only" id="input_banner" ref="input_banner" name="input_banner" accept="image/*">
                                        <span class="docs-tooltip"  >
                                          <span class="fa fa-upload"></span>
                                        </span>
                                      </label>
                                    </div>
                                  </div>
                                </div>
                                <div class="row">
                                  <div class="col-sm-12">
                                    <table>
                                      <tbody>
                                        <tr>
                                          <td>
                                            <img id="image" :src="image_banner" ref="image">
                                            {* <img id="image" src="http://local.github/pric_otca/views/layout/frontend/img/slider_noticias/noticia1.jpg" ref="image" v-model="image_banner"> *}
                                          </td>
                                        </tr>
                                      </tbody>
                                    </table>

                                  </div>
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
<script type="text/javascript">
  var data_vue = {json_encode($data_vue)};
</script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script src="{BASE_URL}public/vendors/cropperjs/dist/cropper.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/vendors/autosize/autosize.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_layoutParams.rutas.js}create.js"></script>
{/block}