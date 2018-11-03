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
        <h3>Añadir pregunta: Respuesta Múltiple</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form method="POST">
            <label class="col-sm-10">Pregunta</label>
            <label class="col-sm-2">Puntos</label>
            <div class="col-sm-10">
            <input placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta"/>
             </div>
             <div class="col-sm-2">
            <input data-toggle="tooltip" data-placement="bottom" title="El valor debe ser inferior o igual a {$puntos_maximo}" placeholder="Puntos" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{$puntos_maximo}"/>
             </div>
                          <br>
            <input type="hidden" class="form-control" name="contador" id="contador" value="2"/>
            <div class="col-sm-10" style="margin-top:10px;">
              <label class="margin-top-10">Alternativas</label>
            </div>
            <div class="col-sm-2" style="margin-top:10px;">
              <label class="margin-top-10">Correcto</label>
            </div>

            <div id="alt">
              <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="3"/>
                <div class="col-sm-10"><input placeholder="Alternativa" class="form-control margin-top-10" name="alt1" id="inPreg1" style="margin-top:10px;"/></div>
                <div class="col-sm-1"><input type="checkbox" value="1" class="radioalt margin-top-10" name="ckb1" id='ckb1' checked="checked" style="margin-top:10px;"/></div>
                 <div class="col-sm-10"><input placeholder="Alternativa" class="form-control margin-top-10" name="alt2" id="inPreg2" style="margin-top:10px;"/></div>
                <div class="col-sm-1"><input type="checkbox" value="2" class="radioalt margin-top-10" name="ckb2" id='ckb2' style="margin-top:10px;"/></div>
            </div>
                <div class="col col-sm-12" style="margin-top: 15px">
                  <div class="col-sm-10">
                    <a data-toggle="tooltip" data-placement="bottom" title="Cancelar registro" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">Cancelar</a>
                     <button data-toggle="tooltip" data-placement="bottom" title="Registrar pregunta" class="btn btn-success margin-top-10" name="btn_registrar_pregunta" id="btn_registrar_pregunta">Registrar</button>
                   </div>
                   <div class="col-sm-2">
                     <a data-toggle="tooltip" data-placement="bottom" title="Agregar alternativa" class="btn btn-primary pull-right margin-top-10 glyphicon glyphicon-plus" id="btn_añadir2"></a>
                   </div>
                </div>
        </form>
        </div>
    </div>
</div>
