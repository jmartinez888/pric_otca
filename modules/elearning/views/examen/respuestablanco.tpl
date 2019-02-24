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
        <h3>{$lenguaje["elearning_respuestablanco_titulo"]}</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col col-lg-12">
        <div class="panel-body">
        <form method="POST">
          <input type="hidden" value="{$puntos_maximo}" id="maximo"/>
            <div class="col-lg-12">
              <label class="col col-sm-10">{$lenguaje["elearning_respuestablanco_pregunta"]}</label>
              <label class="col col-sm-2 text-right" id="puntoslabel">{$lenguaje["elearning_respuestablanco_totalpnts"]}</label>
              <textarea rows="5" placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta"></textarea>
            </div>
<!--             <div class="col-lg-12" style="margin-top: 15px;">
              <label class="col-lg-1">{$lenguaje["elearning_respuestablanco_puntos"]}</label>
              <div class="col-lg-3"> -->
              <input data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestablanco_palceholder1"]} {$puntos_maximo}" placeholder="{$lenguaje["elearning_respuestablanco_palceholder2"]}" class="form-control" name="puntos" id="puntos" type="hidden" min="0" max="{$puntos_maximo}"/>
<!--                </div>
            </div> -->
            <div class="col-sm-12" style="margin-top: 15px;">
              <label class="">{$lenguaje["elearning_respuestablanco_text2"]}</label>
              <textarea rows="5" placeholder="{$lenguaje["elearning_respuestablanco_palceholder3"]}" class="form-control" name="in_pregunta4" id="in_pregunta4"></textarea>
            </div>

            <div class="col-lg-12" style="margin-top: 15px">
              <b>{$lenguaje["elearning_respuestablanco_text3"]}</b>
              <div class="col-lg-12" style="margin-top: 15px" id="alt">
                {$lenguaje["elearning_respuestablanco_text4"]} <b>|...|</b>
              </div>
            </div>
                <div class="col-sm-12" style="margin-top: 15px">
                   <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestablanco_titulo2"]}"  href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">{$lenguaje["elearning_respuestablanco_btncancelar"]}</a>
                   <button data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestablanco_titulo3"]}" class="btn btn-success " name="btn_registrar_pregunta" id="btn_registrar_pregunta">{$lenguaje["elearning_respuestablanco_btnregtro"]}</button>
                </div>
        </form>
        </div>
    </div>
</div>
