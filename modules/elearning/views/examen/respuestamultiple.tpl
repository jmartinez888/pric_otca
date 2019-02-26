
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
        <h3>{$lenguaje["elearning_respuestamultiple_titulo"]}</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form method="POST">
            <label class="col-sm-10">{$lenguaje["elearning_respuestamultiple_pregunta"]}</label>
            <label class="col-sm-2">{$lenguaje["elearning_respuestamultiple_puntos"]}</label>
            <div class="col-sm-10">
            <input placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta"/>
             </div>
             <div class="col-sm-2">
            <input data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestamultiple_palceholder1"]} {$puntos_maximo}" placeholder="{$lenguaje["elearning_respuestamultiple_puntos"]}" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{$puntos_maximo}"/>
             </div>
                          <br>
            <input type="hidden" class="form-control" name="contador" id="contador" value="2"/>
            <div class="col-sm-10" style="margin-top:10px;">
              <label class="margin-top-10">{$lenguaje["elearning_respuestamultiple_alternativas"]}</label>
            </div>
            <div class="col-sm-2" style="margin-top:10px;">
              <label class="margin-top-10">{$lenguaje["elearning_respuestamultiple_correcto"]}</label>
            </div>

            <div id="alt">
              <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="3"/>
                <div class="col-sm-10"><input placeholder="{$lenguaje["elearning_respuestamultiple_alternativa1"]}" class="form-control margin-top-10" name="alt1" id="inPreg1" style="margin-top:10px;"/></div>
                <div class="col-sm-1"><input type="checkbox" value="1" class="radioalt margin-top-10" name="ckb1" id='ckb1' checked="checked" style="margin-top:10px;"/></div>
                 <div class="col-sm-10"><input placeholder="{$lenguaje["elearning_respuestamultiple_alternativa2"]}" class="form-control margin-top-10" name="alt2" id="inPreg2" style="margin-top:10px;"/></div>
                <div class="col-sm-1"><input type="checkbox" value="2" class="radioalt margin-top-10" name="ckb2" id='ckb2' style="margin-top:10px;"/></div>
            </div>
                <div class="col col-sm-12" style="margin-top: 15px">
                  <div class="col-sm-10">
                    <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestamultiple_cancelarprg"]}" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">{$lenguaje["elearning_respuestamultiple_btncancelar"]}</a>
                     <button data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestamultiple_registrarprg"]}" class="btn btn-success " name="btn_registrar_pregunta" id="btn_registrar_pregunta">{$lenguaje["elearning_respuestamultiple_btnregistrar"]}</button>
                   </div>
                   <div class="col-sm-2">
                     <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestamultiple_agregaralternativa"]}" class="btn btn-primary pull-right glyphicon glyphicon-plus" id="btn_añadir2"></a>
                   </div>
                </div>
        </form>
        </div>
    </div>
</div>
