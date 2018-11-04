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
      <h3>Añadir pregunta: Combinación Exacta</h3>
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
          <input type="hidden" class="form-control" name="contador" id="contador" value="2"/>
          <div class="col-xs-10" style="margin-top:10px;">
            <label class="">Alternativas</label>
          </div>
          <div class="col-xs-2" style="margin-top:10px;">
            <label class="">Correcto</label>
          </div>
          <div id="alt" style="margin-top:10px;">
            <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="3"/>
            <div class="col-xs-10">
              <input placeholder="Alternativa" class="form-control " name="alt1" id="inPreg1" style="margin-top:10px;"/>
            </div>
            <div class="col-xs-1">
              <input type="checkbox" value="1" class="radioalt " name="ckb1" id='ckb1' checked="checked" style="margin-top:10px;"/>
            </div>
            <div class="col-xs-10">
              <input placeholder="Alternativa" class="form-control " name="alt2" id="inPreg2" style="margin-top:10px;"/>
            </div>
            <div class="col-xs-1">
              <input type="checkbox" value="2" class="radioalt " name="ckb2" id='ckb2' style="margin-top:10px;"/>
            </div>
          </div>
          <div class="col-xs-12" style="margin-top: 15px">
             <a data-toggle="tooltip" data-placement="bottom" title="Cancelar registro" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">Cancelar</a>
             <button data-toggle="tooltip" data-placement="bottom" title="Registrar pregunta" class="btn btn-success " name="btn_registrar_pregunta" id="btn_registrar_pregunta">Registrar</button>
             <a data-toggle="tooltip" data-placement="bottom" title="Agregar alternativa" class="btn btn-primary pull-right glyphicon glyphicon-plus" id="btn_añadir2"></a>
          </div>
        </form>
        </div>
    </div>
</div>
