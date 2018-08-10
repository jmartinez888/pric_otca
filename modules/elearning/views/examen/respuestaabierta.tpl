{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10">
<div class="col-lg-12">
        <h3>Añadir pregunta: Respuesta Abierta</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form method="POST">
            <div class="col-lg-12">
              <label class="">Pregunta</label>
              <textarea rows="5" placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta"></textarea>
            </div>
            <div class="col-lg-12" style="margin-top: 15px;">
              <label class="col-lg-1">Puntos:</label>
              <div class="col-lg-3">
              <input placeholder="Puntos" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{$puntos_maximo}"/>
               </div>
            </div>
            
                <div class="col-lg-12" style="margin-top: 15px">
                  <a href="{$_layoutParams.root}elearning/examen/preguntas/{$examen}" class="btn btn-danger pull-right">Cancelar</a>
                   <button class="btn btn-success margin-top-10" name="btn_registrar_pregunta" id="btn_registrar_pregunta">Registrar</button>
                </div>
        </form>
        </div>
    </div>
</div>
