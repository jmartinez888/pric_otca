{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-sm-10" style="padding-bottom: 40px;">
    <div class="col-lg-12">
        <div class="col-lg-12">
      <div class=" " style="margin-bottom: 0px !important">
        <div class="text-center text-bold" style="margin-top: 20px; margin-bottom: 20px; color: #267161;">
          <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
            {$titulo}
          </h3>
        </div>
      </div>
    </div>
        <h3>{$lenguaje["elearning_respuestaunica_titulo"]}</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form class="form-horizontal" autocomplete="on" method="POST">
            <label class="col-sm-10">{$lenguaje["elearning_respuestaunica_pregunta"]}</label>
            <label class="col-sm-2">{$lenguaje["elearning_respuestaunica_puntos"]}</label>
            <div class="col-sm-10">
            <input placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta"/>
             </div>
             <div class="col-sm-2">
            <input data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestaunica_valor"]} {$puntos_maximo}" placeholder="{$lenguaje["elearning_respuestaunica_palholderpuntos"]}" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{$puntos_maximo}"/>
             </div>
             <br>
            <input type="hidden" class="form-control" name="contador" id="contador" value="2"/>
            <div class="col-sm-10" style="margin-top:10px;">
              <label class="margin-top-10">{$lenguaje["elearning_respuestaunica_alternativas"]}</label>
            </div>
            <div class="col-sm-2" style="margin-top:10px;">
              <label class=" margin-top-10">{$lenguaje["elearning_respuestaunica_correcto"]}</label>
            </div>

            <div id="alt" style="margin-top:10px;">
              <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="3"/>
                <div class="col-sm-10"><input placeholder="{$lenguaje["elearning_respuestaunica_placeholder1"]}" class="form-control margin-top-10" name="alt1" id="inPreg1" style="margin-top:10px;"/></div>
                <div class="col-sm-2"><input type="radio" value="1" class="radioalt margin-top-10" name="valor_preg" checked="checked" style="margin-top:10px;"/></div>
                 <div class="col-sm-10"><input placeholder="{$lenguaje["elearning_respuestaunica_placeholder2"]}" class="form-control margin-top-10" name="alt2" id="inPreg2" style="margin-top:10px;"/></div>
                <div class="col-sm-2"><input type="radio" value="2" class="radioalt margin-top-10" name="valor_preg" style="margin-top:10px;"/></div>
            </div>
              <div class="col col-sm-12" style="margin-top: 15px">
                <div class="col-sm-10">
                  <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestaunica_btncancelar"]}"  href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">{$lenguaje["{$lenguaje["elearning_respuestaunica_btncancelar2"]}"]}</a>
                 <button data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestaunica_tituloregpre"]}" class="btn btn-success  margin-top-10" name="btn_registrar_pregunta" id="btn_registrar_pregunta">{$lenguaje["elearning_respuestaunica_btnregistrar1"]}</button>
                </div>
                <div class="col-sm-2">
                 <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestaunica_btnagregar"]}"  class="btn btn-primary pull-right margin-top-10 glyphicon glyphicon-plus" id="btn_añadir1"></a>
               </div>
            </div>
        </form>
        </div>
    </div>
  </div>
