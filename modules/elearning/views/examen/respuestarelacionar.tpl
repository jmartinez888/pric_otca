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
      <h3>{$lenguaje["elearning_respuestarelacionar_titulo"]}</h3>
      <hr class="cursos-hr">
    </div>
    <div class="col col-xs-12">
      <div class="panel-body">
        <form method="POST">
            <label class="col-xs-10">{$lenguaje["elearning_respuestarelacionar_pregunta"]}</label>
            <label class="col-xs-2">{$lenguaje["elearning_respuestarelacionar_puntos"]}</label>
            <div class="col-xs-10">
            <input placeholder="{$lenguaje["elearning_respuestarelacionar_placeholder1"]}" class="form-control" name="in_pregunta" id="in_pregunta"/>
            </div>
            <div class="col-xs-2">
              <input data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestarelacionar_titulo2"]} {$puntos_maximo}" placeholder="{$lenguaje["elearning_respuestarelacionar_placeholder2"]}" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{$puntos_maximo}"/>
            </div>
            <br>
            <input type="hidden" class="form-control" name="contador" id="contador" value="2"/>
            <div id="alt" class="col-xs-12" style="margin-top:10px;">
              <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="3"/>
              <br>
              <label class="">{$lenguaje["elearning_respuestarelacionar_respuestas"]}</label>
              <br>
              <div class='col col-xs-12 margin-t-10'> 
                <label class="" >{$lenguaje["elearning_respuestarelacionar_enunciado1"]}</label>
                <input placeholder="{$lenguaje["elearning_respuestarelacionar_placeholder3"]}" class="form-control" name="enu1" id="enu1"/>
                <label class="">{$lenguaje["elearning_respuestarelacionar_corresponde1"]}</label>
                <input placeholder="{$lenguaje["elearning_respuestarelacionar_placeholder4"]}" class="form-control" name="rpta1" id="rpta1"/>
              </div>
              <div class='col col-xs-12 margin-t-10'> 
                <label class="" >{$lenguaje["elearning_respuestarelacionar_enunciado2"]}</label>
                <input placeholder="{$lenguaje["elearning_respuestarelacionar_placeholder5"]}" class="form-control" name="enu2" id="enu2"/>
                <label class="">{$lenguaje["elearning_respuestarelacionar_corresponde2"]}</label>
                <input placeholder="{$lenguaje["elearning_respuestarelacionar_placeholder5"]}" class="form-control" name="rpta2" id="rpta2"/>
              </div>
            </div>
            <div class="col-xs-12" style="margin-top: 15px">
              <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestarelacionar_cancelarreg"]}" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">{$lenguaje["elearning_respuestarelacionar_btncancelar"]}</a>
               <button data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestarelacionar_regpreg"]}" class="btn btn-success " name="btn_registrar_pregunta" id="btn_registrar_pregunta">{$lenguaje["elearning_respuestarelacionar_btnreg"]}</button>
               <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_respuestarelacionar_agrealter"]}" class="btn btn-primary pull-right glyphicon glyphicon-plus" id="btn_añadir4"></a>
            </div>
        </form>
      </div>
    </div>
</div>
