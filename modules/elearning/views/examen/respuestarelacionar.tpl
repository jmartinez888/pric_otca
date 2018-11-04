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
      <h3>Añadir pregunta: Respuesta Relacionada</h3>
      <hr class="cursos-hr">
    </div>
    <div class="col col-xs-12">
      <div class="panel-body">
        <form method="POST">
            <label class="col-xs-10">Pregunta</label>
            <label class="col-xs-2">Puntos</label>
            <div class="col-xs-10">
            <input placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta"/>
            </div>
            <div class="col-xs-2">
              <input data-toggle="tooltip" data-placement="bottom" title="El valor debe ser inferior o igual a {$puntos_maximo}" placeholder="Puntos" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{$puntos_maximo}"/>
            </div>
            <br>
            <input type="hidden" class="form-control" name="contador" id="contador" value="2"/>
            <div id="alt" class="col-xs-12" style="margin-top:10px;">
              <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="3"/>
              <br>
              <label class="">Respuestas</label>
              <br>
              <div class='col col-xs-12 margin-t-10'> 
                <label class="" >Enunciado 1:</label>
                <input placeholder="Enunciado 1" class="form-control" name="enu1" id="enu1"/>
                <label class="">Corresponde a:</label>
                <input placeholder="Respuesta relacionada" class="form-control" name="rpta1" id="rpta1"/>
              </div>
              <div class='col col-xs-12 margin-t-10'> 
                <label class="" >Enunciado 2:</label>
                <input placeholder="Enunciado 2" class="form-control" name="enu2" id="enu2"/>
                <label class="">Corresponde a:</label>
                <input placeholder="Respuesta relacionada" class="form-control" name="rpta2" id="rpta2"/>
              </div>
            </div>
            <div class="col-xs-12" style="margin-top: 15px">
              <a data-toggle="tooltip" data-placement="bottom" title="Cancelar registro" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">Cancelar</a>
               <button data-toggle="tooltip" data-placement="bottom" title="Registrar pregunta" class="btn btn-success " name="btn_registrar_pregunta" id="btn_registrar_pregunta">Registrar</button>
               <a data-toggle="tooltip" data-placement="bottom" title="Agregar alternativa" class="btn btn-primary pull-right glyphicon glyphicon-plus" id="btn_añadir4"></a>
            </div>
        </form>
      </div>
    </div>
</div>