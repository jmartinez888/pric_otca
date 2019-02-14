<template id="inputs">
  <div>
    <div class="col-sm-12 xx" v-if="element.tag_name != 'titulo' && element.edit">
      {* <h2>{literal}{{element.id}}{/literal}</h2> *}
      <div class="col-sm-6">

        <div class="form-group">

          <select v-if="element.tipo == 'titulo_a' || element.tipo == 'titulo_b'" name="" id="tipo" class="form-control" required="required" v-model="tipo">
            {* <option value="titulo">TITU</option> *}
            <option value="titulo_a">TITULO</option>
            <option value="titulo_b">SUB-TITULO</option>
          </select>
          <select v-else name="" id="tipo" class="form-control" required="required" v-model="tipo">
            <option value="texto">TEXTO</option>
            <option value="parrafo">PARRAFO</option>
            <option value="select">SELECT</option>
            <option value="radio">RADIO</option>
            <option value="box">BOX</option>
            <option value="upload">UPLOAD</option>
            <option value="fecha">FECHA</option>
            <option value="hora">HORA</option>
            <option value="cuadricula">CUADRICULA</option>
            <option value="casilla">CASILLAS</option>
          </select>
        </div>
      </div>
    </div>
    {* <button type="button" @click.prevent="show_me">show me</button> *}

      <div class="col-sm-12 uu" v-if="tipo == 'titulo_a'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <h2>{literal}{{values.pregunta == '' ? 'Título' : values.pregunta}}{/literal}</h2>
              <p>{literal}{{ values.descripcion }}{/literal}</p>
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="Título" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="text" name=""  class="form-control"   placeholder="{$lang->get('str_descripcion')}" v-model="values.descripcion">
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'titulo_b'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <h3>{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('str_sub_titulo')}{literal}' : values.pregunta}}{/literal}</h3>
              <p>{literal}{{ values.descripcion }}{/literal}</p>
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('str_sub_titulo')}" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="text" name=""  class="form-control"   placeholder="{$lang->get('str_descripcion')}" v-model="values.descripcion">
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'titulo'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <h1>{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('elearning_formulario_responder_formulario_sin_titulo')}{literal}' : values.pregunta}}{/literal}</h1>
              <p>{literal}{{ values.descripcion }}{/literal}</p>
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('elearning_formulario_responder_formulario_sin_titulo')}" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="text" name=""  class="form-control"   placeholder="{$lang->get('str_descripcion')}" v-model="values.descripcion">
            </div>
          </form>
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'texto'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('str_pregunta')}{literal}' : values.pregunta}}{/literal}</label>
              <input type="text" name=""  class="form-control"   placeholder="{$lang->get('elearning_formulario_responder_texto_res_corta')}">
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('str_pregunta')}" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="text" name=""  class="form-control"   placeholder="{$lang->get('elearning_formulario_responder_texto_res_corta')}">
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'parrafo'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('str_pregunta')}{literal}' : values.pregunta}}{/literal}</label>
              <textarea class="form-control" rows="3" required="required" placeholder="">{$lang->get('elearning_formulario_responder_texto_res_larga')}</textarea>
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('str_pregunta')}" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <textarea class="form-control" rows="3" required="required" placeholder="">{$lang->get('elearning_formulario_responder_texto_res_larga')}</textarea>
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'cuadricula'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('str_pregunta')}{literal}' : values.pregunta}}{/literal}</label>
              <table class="table table-sm table-bordered table-hover">
                <thead>
                  <tr>
                    <th>&nbsp;</th>
                    <th v-for="columnas in values.options">{literal}{{ columnas.opcion }}{/literal}</th>
                  </tr>
                </thead>
                <tbody>
                  {* <tr v-for="filas in values.preguntas" v-if="filas.tipo == 'fil'"> *}
                  <tr v-for="filas in values.preguntas">
                    <td><span>{literal}{{ filas.pregunta }}{/literal}</span></td>
                    <td v-for="columnas in values.options"><div class="radio">
                      <label>
                        <input type="radio" value="">
                      </label>
                    </div></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('str_pregunta')}" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <div class="col-sm-6">
                <ol class="container_select">
                  {* <li v-for="(opc, index) in values.preguntas" v-if="opc.tipo == 'fil'"> *}
                  <li v-for="(opc, index) in values.preguntas">
                    <div class="input-group">
                      <input type="text"  class="form-control"  v-model="values.preguntas[index].pregunta" placeholder="Opción">
                      <div class="input-group-addon">
                        <button type="button" @click="onClick_removeOption(index, opc.id, 'fil')">X</button>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="input-group" style="padding: 10px 5px">
                      <span  @click="onClick_agregarOptionColFil('fil')">{$lang->get('elearning_formulario_responder_add_fil')}</span>
                    </div>
                  </li>
                </ol>
              </div>
              <div class="col-sm-6">
                <ol class="container_select">
                  <li v-for="(opc, index) in values.options">
                    <div class="input-group">
                      <input type="text"  class="form-control"  v-model="values.options[index].opcion" placeholder="Opción">
                      <div class="input-group-addon">
                        <button type="button" @click="onClick_removeOption(index, opc.id, 'col')">X</button>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="input-group" style="padding: 10px 5px">
                      {* <input type="text"  class="form-control" placeholder="{$lang->get('elearning_formulario_responder_add_opc')}" @click="onClick_agregarOptionSelect"> *}
                      <span style="" @click="onClick_agregarOptionColFil('col')">{$lang->get('elearning_formulario_responder_add_col')}</span>
                    </div>
                  </li>
                </ol>
              </div>
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'casilla'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('str_pregunta')}{literal}' : values.pregunta}}{/literal}</label>
              <table class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <th>&nbsp;</th>
                    <th v-for="columnas in values.options">{literal}{{ columnas.opcion }}{/literal}</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="filas in values.preguntas">
                    <td>{literal}{{ filas.opcion }}{/literal}</td>
                    <td v-for="columnas in values.options"><div class="checkbox">
                      <label>
                        <input type="checkbox" value="">
                      </label>
                    </div></td>
                  </tr>
                </tbody>
              </table>
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('str_pregunta')}" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <div class="col-sm-6">
                <ol class="container_select">
                  <li v-for="(opc, index) in values.preguntas">
                    <div class="input-group">
                      <input type="text"  class="form-control"  v-model="values.preguntas[index].pregunta" placeholder="Opción">
                      <div class="input-group-addon">
                        <button type="button" @click="onClick_removeOption(index, opc.id, 'fil')">X</button>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="input-group" style="padding: 10px 5px">
                      <span style="" @click="onClick_agregarOptionColFil('fil')">{$lang->get('elearning_formulario_responder_add_fil')}</span>
                    </div>
                  </li>
                </ol>
              </div>
              <div class="col-sm-6">
                <ol class="container_select">
                  <li v-for="(opc, index) in values.options">
                    <div class="input-group">
                      <input type="text"  class="form-control"  v-model="values.options[index].opcion" placeholder="Opción">
                      <div class="input-group-addon">
                        <button type="button" @click="onClick_removeOption(index, opc.id, 'col')">X</button>
                      </div>
                    </div>
                  </li>
                  <li>
                    <div class="input-group" style="padding: 10px 5px">
                      {* <input type="text"  class="form-control" placeholder="{$lang->get('elearning_formulario_responder_add_opc')}" @click="onClick_agregarOptionSelect"> *}
                      <span style="" @click="onClick_agregarOptionColFil('col')">{$lang->get('elearning_formulario_responder_add_col')}</span>
                    </div>
                  </li>
                </ol>
              </div>
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'select'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('str_pregunta')}{literal}' : values.pregunta}}{/literal}</label>
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
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('str_pregunta')}" v-model="values.pregunta">
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
                    {* <input type="text"  class="form-control" placeholder="{$lang->get('elearning_formulario_responder_add_opc')}" @click="onClick_agregarOptionSelect"> *}
                    <span style="" @click="onClick_agregarOptionSelect">{$lang->get('elearning_formulario_responder_add_opc')}</span>
                  </div>
                </li>
              </ol>
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'radio'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('str_pregunta')}{literal}' : values.pregunta}}{/literal}</label>
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
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('str_pregunta')}" v-model="values.pregunta">
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
                    {* <input type="text"  class="form-control" placeholder="{$lang->get('elearning_formulario_responder_add_opc')}" @click="onClick_agregarOptionSelect"> *}
                    <span style="" @click="onClick_agregarOptionSelect">{$lang->get('elearning_formulario_responder_add_opc')}</span>
                  </div>
                </li>
              </ol>
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'box'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('str_pregunta')}{literal}' : values.pregunta}}{/literal}</label>
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
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('str_pregunta')}" v-model="values.pregunta">
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
                    {* <input type="text"  class="form-control" placeholder="{$lang->get('elearning_formulario_responder_add_opc')}" @click="onClick_agregarOptionSelect"> *}
                    <span style="" @click="onClick_agregarOptionSelect">{$lang->get('elearning_formulario_responder_add_opc')}</span>
                  </div>
                </li>
              </ol>
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'upload'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('str_pregunta')}{literal}' : values.pregunta}}{/literal}</label>
              <input type="file" name=""  class="form-control"   placeholder="{$lang->get('elearning_formulario_responder_texto_res_corta')}">
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('str_pregunta')}" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="text" name=""  class="form-control"   placeholder="{$lang->get('elearning_formulario_responder_texto_res_corta')}">
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'fecha'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('str_pregunta')}{literal}' : values.pregunta}}{/literal}</label>
              <input type="date" name=""  class="form-control"   placeholder="{$lang->get('elearning_formulario_responder_texto_res_corta')}">
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('str_pregunta')}" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="date" name=""  class="form-control"   placeholder="{$lang->get('elearning_formulario_responder_texto_res_corta')}">
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>
      <div class="col-sm-12 uu" v-if="tipo == 'hora'">
        <div class="col-sm-12" v-if="!element.edit">
          <form role="form">
            <div class="form-group">
              <label class="control-label">{literal}{{values.pregunta == '' ? '{/literal}{$lang->get('str_pregunta')}{literal}' : values.pregunta}}{/literal}</label>
              <input type="time" name=""  class="form-control"   placeholder="{$lang->get('elearning_formulario_responder_texto_res_corta')}">
            </div>
          </form>
        </div>
        <div class="col-sm-12" v-else>
          <form role="form">
            <div class="form-group">
              <input type="text" name=""  class="form-control" value="" required="required" pattern="" title="" placeholder="{$lang->get('str_pregunta')}" v-model="values.pregunta">
            </div>
            <div class="form-group">
              <input type="time" name=""  class="form-control"   placeholder="{$lang->get('elearning_formulario_responder_texto_res_corta')}">
            </div>
          </form>
        </div>
        <hr>
        <div v-if="element.edit" class="pull-right">
          {include 'botones_acciones_tags.tpl'}
        </div>
      </div>

  </div>
</template>