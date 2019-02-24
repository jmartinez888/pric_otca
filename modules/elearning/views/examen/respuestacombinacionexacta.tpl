{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-sm-9 col-md-10">
    <div class="col-xs-12">
      <div class="col-xs-12">
        <div class=" " style="margin-bottom: 0px !important">
          <div class="text-center text-bold" style="margin-top: 20px; margin-bottom: 20px; color: #267161;">
            <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
              {$titulo}
            </h3>
          </div>
        </div>
      </div>
      <h3>{$lenguaje["elearning_ respuestacombinacionexacta_titulo"]}</h3>
      <hr class="cursos-hr">
    </div>
    <div class="col col-xs-12">
      <div class="panel-body">
        <form method="POST">
          <label class="col-xs-10">{$lenguaje["elearning_ respuestacombinacionexacta_pregunta"]}</label>
          <label class="col-xs-2">{$lenguaje["elearning_ respuestacombinacionexacta_puntos"]}</label>
          <div class="col-xs-10">
            <input placeholder="{$lenguaje["elearning_ respuestacombinacionexacta_placeholder1"]}" class="form-control" name="in_pregunta" id="in_pregunta"/>
          </div>
          <div class="col-xs-2">
            <input data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_ respuestacombinacionexacta_text1"]} {$puntos_maximo}" placeholder="{$lenguaje["elearning_respuestacombinacionexacta_placeholder2"]}" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{$puntos_maximo}"/>
          </div>
          <input type="hidden" class="form-control" name="contador" id="contador" value="2"/>
          <div class="col-xs-10" style="margin-top:10px;">
            <label class="">{$lenguaje["elearning_ respuestacombinacionexacta_alternativas"]}</label>
          </div>
          <div class="col-xs-2" style="margin-top:10px;">
            <label class="">{$lenguaje["elearning_ respuestacombinacionexacta_correcto"]}</label>
          </div>
          <div id="alt" style="margin-top:10px;">
            <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="3"/>
            <div class="col-xs-10">
              <input placeholder="{$lenguaje["elearning_ respuestacombinacionexacta_placeholder3"]}" class="form-control " name="alt1" id="inPreg1" style="margin-top:10px;"/>
            </div>
            <div class="col-xs-1">
              <input type="checkbox" value="1" class="radioalt " name="ckb1" id='ckb1' checked="checked" style="margin-top:10px;"/>
            </div>
            <div class="col-xs-10">
              <input placeholder="{$lenguaje["elearning_ respuestacombinacionexacta_placeholder4"]}" class="form-control " name="alt2" id="inPreg2" style="margin-top:10px;"/>
            </div>
            <div class="col-xs-1">
              <input type="checkbox" value="2" class="radioalt " name="ckb2" id='ckb2' style="margin-top:10px;"/>
            </div>
          </div>
          <div class="col-xs-12" style="margin-top: 15px">
             <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_ respuestacombinacionexacta_cancelarregistro"]}" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">{$lenguaje["elearning_ respuestacombinacionexacta_btncancelar"]}</a>
             <button data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_ respuestacombinacionexacta_regpreg"]}" class="btn btn-success " name="btn_registrar_pregunta" id="btn_registrar_pregunta">{$lenguaje["elearning_ respuestacombinacionexacta_btnregistrar"]}</button>
             <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_ respuestacombinacionexacta_agregalter"]}" class="btn btn-primary pull-right glyphicon glyphicon-plus" id="btn_añadir2"></a>
          </div>
        </form>
        </div>
    </div>
</div>
