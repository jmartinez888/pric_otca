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
                                  <input  class="form-control" id="difusion" type="text" name="difusion" placeholder="{$lenguaje['str_seleccione_buscar']}"  required="" v-model="nombre_difusion" ref="difusion">
                                  <span class="input-group-btn"><button @click="onClick_openModDifusion" class="btn btn-default" type="button"><i class="fa fa-search"></i></button></span>
                                </div>


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
{*
      <div class="modal fade" id="mod_difusion" tabindex="-1" role="dialog" aria-labelledby="mod_difusion">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Estado</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" data-toggle="validator" @submit.prevent="onSubmit_buscarDifusion"  role="form"  novalidate="true" id="actualizar_attr">
                        <div class="form-group">
                            <div class="col-sm-8">
                              <input type="text" ref="filter_difusion_name" name="filter_difusion_name" id="filter_difusion_name" class="form-control" value="" required="required"  placeholder="Buscar difusión">
                            </div>
                            <div class="col-sm-4">
                              <button type="submit" class="btn btn-primary"><i class="fa fa-search"></i>&nbsp;Buscar</button>
                            </div>

                        </div>
                        <table class="table table-hover table-minimal">
                          <thead>
                            <tr>
                              <th width="40">#</th>
                              <th>Disufio</th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr v-for="item in difusiones">
                              <td><input type="radio" name="difusion_selected" :value="item.ODif_IdDifusion" v-model="difusion_id"></td>
                              <td>{literal}{{item.ODif_Titulo}}{/literal}</td>
                            </tr>
                          </tbody>
                        </table>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    <button type="button"  class="btn btn-primary" @click="onClick_saveDifusion">Guardar</button>
                </div>
            </div>
        </div>
      </div> *}

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