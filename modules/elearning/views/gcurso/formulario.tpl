{extends 'index_elearning.tpl'}
{block 'css' append}
<style>
  .div-detalle{
  border: 1px solid gray;
  border-radius: 5px;
  position: relative;
  padding-top: 10px;
  padding-bottom: 10px;
  }
  .div-detalle .btn-detalle{
  position: absolute;
  top: 10px;
  right: 10px;
  }
  .img-banner{
  padding: 10px !important;
  border: 2px solid #02969b;
  }
  .div_presentacion{
  display: block;
  }
  .div_contenido{
  display: none;
  }
  .div_parametros{
  display: none;
  }
  .display-block{
  display: block;
  }
  .nav-tabs > .active{
  font-weight: bold;
  }
  .nav-tabs > li.active > a{
  color: #009640 !important;
  }
</style>
<style type="text/css" media="screen">
  .tags_input_edit:hover {
    /*border: 2px solid black;*/
  }
  .tags_input_edit {
    border-left: 2px solid white;
    padding: 10px 5px;
  }
  .tag_input_edit_select {
    border-left: 2px solid black;
    padding: 10px 5px;
    box-shadow: 2px 0px 1px 1px rgba(100, 100, 100, 0.7);
  }
  .container_select {

  }

.container_select input.form-control{
    border: 0px;
    border-bottom: 1px solid black;
}

.container_select .input-group-addon{
    border: 0px;

}
#btn_agregar {

}
</style>
<!-- <link href="{$_url}gcurso/css/_view_finalizar_registro.css" rel="stylesheet" type="text/css"/> -->
{/block}
{block 'subcontenido'}
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
{if ($formulario == null)}
<div class="col-lg-12">
  <h3>No posee formulario</h3>
  <form action="{$_layoutParams.root}elearning/formulario/store" method="post" accept-charset="utf-8">
    <input type="hidden" name="mode" value="unique">
    <input type="hidden" name="curso_id" value="{$curso['Cur_IdCurso']}">
    <button type="submit" class="btn btn-success">Crear formulario</button>
  </form>
</div>
{else}
<div class="col-lg-12">
  <ul class="nav nav-tabs" role="tablist">
    <li role="formulario" class="active" id="item_editar"><a href="#formulario_editar" aria-controls="formulario_editar" role="tab" data-toggle="tab">PREGUNTAS</a></li>
    <li role="formulario" id="item_respuestas" ><a href="#formulario_respuestas" aria-controls="formulario_respuestas" role="tab" data-toggle="tab">RESPUESTAS</a></li>
  </ul>
</div>
<div class="col-lg-12 ">
  <div class="panel panel-default tab-content" role="" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
    <div class="panel-body form-horizontal tab-pane active" role="tabpanel"  id="formulario_editar">

      <div id="formulario_editar_vue">

        <button type="" @click.prevent="onClick_agregarTag" id="btn_agregar">AGREGAR TAG</button>
        <hr>
        <div class="" id="container_tags">
          <div class="tags_input_edit col-sm-12 hh" @click="onClick_editar(event, 'titulo_frm')">
            <input-tags   v-key="'titulo_frm'" v-bind:element="element_titulo" class="col-sm-12 yy" ></input-tags>
          </div>
          <div class="tags_input_edit col-sm-12 hh" v-for="(tag, index) in tags" :id="'tag_edit_' + tag.id"  :ref="'tag_edit_' + tag.id" @click="onClick_editar(event, tag.id)">
            <input-tags   v-key="tag.id" v-bind:element="tag" v-on:delete_tag="tags.splice(index, 1)" class="col-sm-12 yy" ></input-tags>
          </div>
        </div>

      </div>
    </div>
    <div class="panel-body form-horizontal tab-pane" role="tabpanel"  id="formulario_respuestas">
      <h1>DOS</h1>
    </div>
  </div>
</div>
{/if}
{/block}
{block 'template' append}
<template id="inputs">
  <div>
    <div class="col-sm-12 xx" v-if="element.tag_name != 'titulo' && element.edit">
      {* <h2>{literal}{{element.id}}{/literal}</h2> *}
      <div class="col-sm-6">

        <div class="form-group">

          <select name="" id="tipo" class="form-control" required="required" v-model="tipo">
            <option value="titulo">TITU</option>
            <option value="texto">TEXTO</option>
            <option value="parrafo">PARRAFO</option>
            <option value="select">SELECT</option>
            <option value="radio">RADIO</option>
            <option value="box">BOX</option>
            <option value="upload">UPLOAD</option>
            <option value="fecha">FECHA</option>
            <option value="hora">HORA</option>
          </select>
        </div>
      </div>
    </div>
    {* <button type="button" @click.prevent="show_me">show me</button> *}

      <div class="col-sm-12 uu" v-if="tipo == 'titulo'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <h1>{literal}{{values.pregunta == '' ? 'Formulario sin título' : values.pregunta}}{/literal}</h1>
              <p>{literal}{{ values.descripcion }}{/literal}</p>
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="Formulario sin título" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="text" name=""  class="form-control"   placeholder="Descripción" v-model="values.descripcion">
            </div>
          </form>
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'texto'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? 'Pregunta' : values.pregunta}}{/literal}</label>
              <input type="text" name=""  class="form-control"   placeholder="Texto de respuesta corta">
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="Pregunta" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="text" name=""  class="form-control"   placeholder="Texto de respuesta corta">
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          <button type="button" @click.prevent="onClick_delete">D</button>
          <button type="button" @click.prevent="onClick_delete">O</button>
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'parrafo'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? 'Pregunta' : values.pregunta}}{/literal}</label>
              <textarea class="form-control" rows="3" required="required" placeholder="">Texto de respuesta larga</textarea>
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="Pregunta" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <textarea class="form-control" rows="3" required="required" placeholder="">Texto de respuesta larga</textarea>
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          <button type="button" @click.prevent="onClick_delete">D</button>
          <button type="button" @click.prevent="onClick_delete">O</button>
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'select'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? 'Pregunta' : values.pregunta}}{/literal}</label>
              {* <select class="form-control" required="required">
                <option value="" v-for="opc in values.options">{literal}{{opc}}{/literal}</option>
              </select> *}
              <ol>
                <li v-for="opc in values.options">{literal}{{opc.opcion == null || opc.opcion.trim() == '' ? 'Opción' : opc.opcion}}{/literal}</li>
              </ol>
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="Pregunta" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <ol class="container_select">
                <li v-for="(opc, index) in values.options">
                  <div class="input-group">
                    <input type="text"  class="form-control"  v-model="values.options[index].opcion" placeholder="Opción">
                    <div class="input-group-addon">
                      <button type="button" @click="onClick_removeOption(index, opc.id)">X</button>
                    </div>
                  </div>
                </li>
                <li>
                  <div class="input-group" style="padding: 10px 5px">
                    {* <input type="text"  class="form-control" placeholder="Añadir opción" @click="onClick_agregarOptionSelect"> *}
                    <span style="" @click="onClick_agregarOptionSelect">Añadir opción</span>
                  </div>
                </li>
              </ol>
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          <button type="button" @click.prevent="onClick_delete">D</button>
          <button type="button" @click.prevent="onClick_delete">O</button>
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'radio'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? 'Pregunta' : values.pregunta}}{/literal}</label>
              {* <select class="form-control" required="required">
                <option value="" v-for="opc in values.options">{literal}{{opc}}{/literal}</option>
              </select> *}


                  <div class="radio" v-for="opc in values.options">
                    <label>
                      <input type="radio" name=""  value="" >
                      {literal}{{opc.opcion == '' ? 'Opción' : opc.opcion}}{/literal}
                    </label>
                  </div>
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="Pregunta" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <ol class="container_select">
                <li v-for="(opc, index) in values.options">
                  <div class="input-group">
                    <input type="text"  class="form-control"  v-model="values.options[index].opcion" placeholder="Opción">
                    <div class="input-group-addon">
                      <button type="button" @click="onClick_removeOption(index, opc.id)">X</button>
                    </div>
                  </div>
                </li>
                <li>
                  <div class="input-group" style="padding: 10px 5px">
                    {* <input type="text"  class="form-control" placeholder="Añadir opción" @click="onClick_agregarOptionSelect"> *}
                    <span style="" @click="onClick_agregarOptionSelect">Añadir opción</span>
                  </div>
                </li>
              </ol>
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          <button type="button" @click.prevent="onClick_delete">D</button>
          <button type="button" @click.prevent="onClick_delete">O</button>
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'box'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? 'Pregunta' : values.pregunta}}{/literal}</label>
              {* <select class="form-control" required="required">
                <option value="" v-for="opc in values.options">{literal}{{opc}}{/literal}</option>
              </select> *}


                  <div class="radio" v-for="opc in values.options">
                    <label>
                      <input type="checkbox" name=""  value="" >
                      {literal}{{opc.opcion == '' ? 'Opción' : opc.opcion}}{/literal}
                    </label>
                  </div>
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="Pregunta" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <ol class="container_select">
                <li v-for="(opc, index) in values.options">
                  <div class="input-group">
                    <input type="text"  class="form-control" v-model="values.options[index].opcion" placeholder="Opción">
                    <div class="input-group-addon">
                      <button type="button" @click="onClick_removeOption(index, opc.id)">X</button>
                    </div>
                  </div>
                </li>
                <li>
                  <div class="input-group" style="padding: 10px 5px">
                    {* <input type="text"  class="form-control" placeholder="Añadir opción" @click="onClick_agregarOptionSelect"> *}
                    <span style="" @click="onClick_agregarOptionSelect">Añadir opción</span>
                  </div>
                </li>
              </ol>
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          <button type="button" @click.prevent="onClick_delete">D</button>
          <button type="button" @click.prevent="onClick_delete">O</button>
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'upload'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? 'Pregunta' : values.pregunta}}{/literal}</label>
              <input type="file" name=""  class="form-control"   placeholder="Texto de respuesta corta">
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="Pregunta" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="text" name=""  class="form-control"   placeholder="Texto de respuesta corta">
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          <button type="button" @click.prevent="onClick_delete">D</button>
          <button type="button" @click.prevent="onClick_delete">O</button>
        </div>
      </div>

      <div class="col-sm-12 uu" v-if="tipo == 'fecha'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? 'Pregunta' : values.pregunta}}{/literal}</label>
              <input type="date" name=""  class="form-control"   placeholder="Texto de respuesta corta">
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="Pregunta" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="date" name=""  class="form-control"   placeholder="Texto de respuesta corta">
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          <button type="button" @click.prevent="onClick_delete">D</button>
          <button type="button" @click.prevent="onClick_delete">O</button>
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'hora'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? 'Pregunta' : values.pregunta}}{/literal}</label>
              <input type="time" name=""  class="form-control"   placeholder="Texto de respuesta corta">
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="Pregunta" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="time" name=""  class="form-control"   placeholder="Texto de respuesta corta">
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          <button type="button" @click.prevent="onClick_delete">D</button>
          <button type="button" @click.prevent="onClick_delete">O</button>
        </div>
      </div>

  </div>
</template>
{/block}
{block 'js' append}
<!-- <script >
$("#hidden_curso").val("{Session::get('learn_param_curso')}");
</script> -->
{if ($formulario != null)}
<script type="text/javascript">
  var data_frm = {json_encode($formulario->formatToArray())};
</script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript" src="{$_layoutParams.rutas.js}formulario.js"></script>

{/if}
{/block}