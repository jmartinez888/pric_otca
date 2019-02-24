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
      <h3>{$lenguaje["elearning_respuestaabierta_titulo"]}</h3>
      <hr class="cursos-hr">
    </div>
    <div class="col col-xs-12">
      <div class="panel-body">
        <form method="POST">
            <div class="col-xs-12">
              <label class="">{$lenguaje["elearning_respuestaabierta_pregunta"]}</label>
              <textarea rows="5" placeholder="{$lenguaje["elearning_respuestaabierta_placeholder1"]}" class="form-control" name="in_pregunta" id="in_pregunta"></textarea>
            </div>
            <div class="col-xs-12" style="margin-top: 15px;">
              <label class="col col-xs-2 col-md-1">{$lenguaje["elearning_respuestaabierta_puntos"]}</label>
              <div class="col-xs-3 col-md-2">
                <input data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestaabierta_text1"]} {$puntos_maximo}" placeholder="{$lenguaje["elearning_respuestaabierta_placeholder2"]}" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{$puntos_maximo}"/>
              </div>
            </div>
            <div class="col-xs-12" style="margin-top: 15px">
              <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestaabierta_text2"]}" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">{$lenguaje["elearning_respuestaabierta_btncancelar"]}</a>
              <button data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestaabierta_text3"]}" class="btn btn-success" name="btn_registrar_pregunta" id="btn_registrar_pregunta">{$lenguaje["elearning_respuestaabierta_btnregistrar"]}</button>
            </div>
        </form>
        </div>
    </div>
</div>
