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
  h2.tag-custom {
    margin-top: 8px;
    margin-bottom: 4px;

  }
  h3.tag-custom {
    margin-top: 4px;
    margin-bottom: 2px;

  }
</style>
<!-- <link href="{$_url}gcurso/css/_view_finalizar_registro.css" rel="stylesheet" type="text/css"/> -->
{/block}
{block 'subcontenido'}
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
{if $obj_curso == null}
  <div class="col-lg-12">
    <h3>No existe curso</h3>
    {* <form action="{$_layoutParams.root}elearning/formulario/store" method="post" accept-charset="utf-8">
      <input type="hidden" name="mode" value="unique">
      <input type="hidden" name="curso_id" value="{$curso['Cur_IdCurso']}">
      <button type="submit" class="btn btn-success">Crear formulario</button>
    </form> *}
  </div>
{else}
  {if ($formulario == null)}
    <div class="col-lg-12">
      <h3>No posee formulario</h3>
    </div>
  {else}
    {if (!isset($respuesta) || $respuesta->Fur_Completado == 0)}

      <div class="col-lg-12 ">
        <div class="panel panel-default tab-content" role="" style="">
          <div class="panel-body form-horizontal tab-pane active" role="tabpanel"  id="formulario_editar">

            <div id="formulario_editar_vue">
              <div class="col-sm-12">
                <form role="form" action="{$_layoutParams.root}elearning/formulario/store_respuesta/{$obj_curso['Cur_IdCurso']}" method="post" enctype="multipart/form-data">
                  <div class="form-group">
                    <h1>{$formulario->Frm_Titulo}</h1>
                    <p>{$formulario->Frm_Descripcion}</p>
                  </div>
                  <hr>
                  {foreach $formulario->preguntas as $pre}
                    <div class="form-group">
                      {if ($pre->Fpr_Tipo == 'titulo_a' || $pre->Fpr_Tipo == 'titulo_b')}
                        {if ($pre->Fpr_Tipo == 'titulo_a')}
                          <h2 class="tag-custom">{$pre->Fpr_Pregunta}</h2>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'titulo_b')}
                          <h3 class="tag-custom">{$pre->Fpr_Pregunta}</h3>
                        {/if}
                        {if (trim($pre->Fpr_Descripcion) != '')}
                          <p>{$pre->Fpr_Descripcion}</p>
                        {/if}
                      {else}

                        <label class="control-label">{$pre->Fpr_Pregunta}</label>
                        {if ($pre->Fpr_Tipo == 'texto')}
                          <input type="text" name="frm_pre_{$pre->Fpr_IdForPreguntas}"  class="form-control" {if ($pre->Fpr_Obligatorio == 1)}required="required"{/if}>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'parrafo')}
                          <textarea name="frm_pre_{$pre->Fpr_IdForPreguntas}" class="form-control" rows="3"></textarea>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'select')}
                          <select name="frm_pre_{$pre->Fpr_IdForPreguntas}"  class="form-control" >
                            {foreach $pre->opciones as $opc}
                              <option value="{$opc->Fpo_IdForPrOpc}">{$opc->Fpo_Opcion}</option>
                            {/foreach}
                          </select>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'radio')}
                          {foreach $pre->opciones as $opc}
                            <div class="radio">
                              <label>
                                <input type="radio" name="frm_pre_{$pre->Fpr_IdForPreguntas}"  value="{$opc->Fpo_IdForPrOpc}" >
                                {$opc->Fpo_Opcion}
                              </label>
                            </div>
                          {/foreach}
                        {/if}
                        {if ($pre->Fpr_Tipo == 'box')}
                          {foreach $pre->opciones as $opc}
                            <div class="checkbox">
                              <label>
                                <input type="checkbox" name="frm_pre_{$pre->Fpr_IdForPreguntas}[]" value="{$opc->Fpo_IdForPrOpc}">
                                {$opc->Fpo_Opcion}
                              </label>
                            </div>
                          {/foreach}
                        {/if}
                        {if ($pre->Fpr_Tipo == 'upload')}
                          <input type="file" name="file_pre_{$pre->Fpr_IdForPreguntas}"  class="form-control" >
                        {/if}
                        {if ($pre->Fpr_Tipo == 'fecha')}
                          <input type="date" name="frm_pre_{$pre->Fpr_IdForPreguntas}"  class="form-control"   >
                        {/if}
                        {if ($pre->Fpr_Tipo == 'hora')}
                          <input type="time" name="frm_pre_{$pre->Fpr_IdForPreguntas}"  class="form-control"   >
                        {/if}
                        {if ($pre->Fpr_Tipo == 'cuadricula')}
                          <table class="table table-bordered table-hover">
                            <thead>
                              <tr>
                                <th>&nbsp;</th>
                                {foreach $pre->hijos as $col}
                                  <th>{$col->Fpr_Pregunta}</th>
                                {/foreach}
                              </tr>
                            </thead>
                            <tbody>
                              {foreach $pre->opciones as $fil}
                                {if $fil->Fpo_Tipo == 'fil'}
                                  <tr>
                                    <td>{$fil->Fpo_Opcion}</td>
                                    {foreach $pre->hijos as $col}
                                      <td>
                                        <div class="radio">
                                          <label>
                                            <input type="radio" name="frm_pre_{$col->Fpr_IdForPreguntas}" id="input" value="{$fil->Fpo_IdForPrOpc}" required="">
                                            {$fil->Fpo_IdForPrOpc}_{$col->Fpr_IdForPreguntas}
                                          </label>
                                        </div>
                                      </td>

                                    {/foreach}
                                  </tr>
                                {/if}
                              {/foreach}
                            </tbody>
                          </table>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'casilla')}
                          <table class="table table-bordered table-hover">
                            <thead>
                              <tr>
                                <th>&nbsp;</th>
                                {foreach $pre->hijos as $col}
                                  <th>{$col->Fpr_Pregunta}</th>
                                {/foreach}
                              </tr>
                            </thead>
                            <tbody>
                              {foreach $pre->opciones as $fil}
                                {if $fil->Fpo_Tipo == 'fil'}
                                  <tr>
                                    <td>{$fil->Fpo_Opcion}</td>
                                    {foreach $pre->hijos as $col}
                                      <td>
                                        <div class="checkbox">
                                          <label>
                                            <input type="checkbox" name="frm_pre_{$col->Fpr_IdForPreguntas}[]" id="input" value="{$fil->Fpo_IdForPrOpc}" >
                                            {$fil->Fpo_IdForPrOpc}_{$col->Fpr_IdForPreguntas}
                                          </label>
                                        </div>
                                      </td>

                                    {/foreach}
                                  </tr>
                                {/if}
                              {/foreach}
                            </tbody>
                          </table>
                        {/if}
                      {/if}
                    </div>
                  {/foreach}
                  <button type="submit" class="btn btn-success">Enviar respuestas</button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    {else}
      <div class="col-lg-12">
        <h3>Formulario ya fue respondido</h3>
      </div>
    {/if}
  {/if}
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