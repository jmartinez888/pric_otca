{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-9">
<div class="col-lg-12">
    <div class="col-lg-12">
  <div class=" " style="margin-bottom: 0px !important">
    <div class="text-center text-bold" style="margin-top: 20px; margin-bottom: 20px; color: #267161;">
      <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
        <!-- Titulo de Nuevo curso mooc -->
                </h3>
    </div>
  </div>
</div>
        <h3>Añadir pregunta: Respuesta Única</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form class="form-horizontal" autocomplete="on" method="POST">
              <label class="col-lg-9">Pregunta</label>
              <label class="col-lg-3">Puntos</label>
              <div class="col-lg-9">
              <input placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta"/>
               </div>
               <div class="col-lg-3">
              <input placeholder="Puntos" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{$puntos_maximo}"/>
               </div>
                            <br>
            <input type="hidden" class="form-control" name="contador" id="contador" value="2"/>
            <div class="col-lg-8" style="margin-top:10px;">
              <label class="margin-top-10">Alternativas</label>
            </div>
            <div class="col-lg-3" style="margin-top:10px;">
              <label class="margin-top-10 pull-right">Correcto</label>
            </div>

            <div id="alt" style="margin-top:10px;">
              <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="3"/>
                <div class="col-lg-10"><input placeholder="Alternativa" class="form-control margin-top-10" name="alt1" id="inPreg1" style="margin-top:10px;"/></div>
                <div class="col-lg-1"><input type="radio" value="1" class="radioalt margin-top-10" name="valor_preg" checked="checked" style="margin-top:10px;"/></div>
                 <div class="col-lg-10"><input placeholder="Alternativa" class="form-control margin-top-10" name="alt2" id="inPreg2" style="margin-top:10px;"/></div>
                <div class="col-lg-1"><input type="radio" value="2" class="radioalt margin-top-10" name="valor_preg" style="margin-top:10px;"/></div>
            </div>
                <div class="col-lg-12" style="margin-top: 15px">
                  <a href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">Cancelar</a>
                   <button class="btn btn-success pull-right margin-top-10" name="btn_registrar_pregunta" id="btn_registrar_pregunta">Registrar</button>
                   <a class="btn btn-primary pull-right margin-top-10 glyphicon glyphicon-plus" id="btn_añadir1"></a>
                </div>
        </form>
        </div>
    </div>
  </div>