{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10">
<div class="col-lg-12">
        <h3>Añadir pregunta: Rellenar blancos</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form method="POST">
          <input type="hidden" value="{$puntos_maximo}" id="maximo"/>
            <div class="col-lg-12">
              <label class="col-lg-10">Pregunta:</label>
              <!-- <label class="col-lg-2">Puntos: 0</label> -->
              <textarea rows="5" placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta"></textarea>
            </div>
            <div class="col-lg-12" style="margin-top: 15px;">
              <label class="col-lg-1">Puntos:</label>
              <div class="col-lg-3">
              <input placeholder="Puntos" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{$puntos_maximo}"/>
               </div>
            </div>
            <div class="col-lg-12" style="margin-top: 15px;">
              <label class="">(Escriba el texto debajo, y use estos separadores |...| para definir uno o más espacios en blanco):</label>
              <textarea rows="5" placeholder="Pregunta" class="form-control" name="in_pregunta4" id="in_pregunta4"></textarea>
            </div>

            <div class="col-lg-12" style="margin-top: 15px">
            <b>Respuestas en blanco:</b>

            <div class="col-lg-12" style="margin-top: 15px" id="alt">
              Por favor defina un espacio en blanco con estos separadores <b>|...|</b>
            </div>
            </div>
            
                <div class="col-lg-12" style="margin-top: 15px">
                   <a href="{$_layoutParams.root}elearning/examen/preguntas/{$examen}" class="btn btn-danger">Cancelar</a>
                   <button class="btn btn-success pull-right margin-top-10" name="btn_registrar_pregunta" id="btn_registrar_pregunta">Registrar</button>
                </div>
        </form>
        </div>
    </div>
</div>
