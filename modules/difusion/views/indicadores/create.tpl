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
          <h2 class="titulo">{$titulo}</h2>
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
                              <label class="col-lg-2 control-label" for="descripcion">{$lenguaje['str_descripcion']} : </label>
                              <div class="col-lg-10">
                                  {foreach $idiomas as $item}
                                  <textarea rows="2" v-if="idioma_actual == '{$item->Idi_IdIdioma}'" class="form-control" id="descripcion" type="text" ref="descripcion" name="descripcion" placeholder="{$lenguaje['str_descripcion']}" required="" v-model="idiomas.idioma_{$item->Idi_IdIdioma}.descripcion"></textarea>
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
                              <label class="col-lg-2 control-label" for="imagen">{$lenguaje['str_imagen']} : </label>
                              <div class="col-lg-10">
                                  <input type="file" ref="imagen" class="form-control" id="imagen" type="text" name="imagen" required="" v-model="imagen" accept="image/png">
                                  <p>{$lenguaje['str_msg_imagen_regla']}</p>
                                  <p id="error_img" class="hidden"><span class="label label-danger">{$lenguaje['str_imagen_no_valida']}</span></p>
                              </div>
                          </div>
                          <div class="form-group">
                            <label class="col-lg-2 control-label" for="imagen"></label>
                            <div class="col-lg-10">
                              <table>
                                <tbody>
                                  <tr>
                                    <td>
                                      <img class="w-100" id="image" :src="image" ref="image">
                                    </td>
                                  </tr>
                                </tbody>
                              </table>
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
{/block}
{block 'js' append}
<script type="text/javascript">
  var data_vue = {json_encode($data_vue)};
</script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
{* <script src="{BASE_URL}public/vendors/cropperjs/dist/cropper.min.js" type="text/javascript"></script> *}
<script src="{BASE_URL}public/vendors/autosize/autosize.min.js" type="text/javascript"></script>
<script type="text/javascript" src="{$_layoutParams.rutas.js}create.js"></script>
{/block}