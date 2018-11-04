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
        <h3>Añadir pregunta: Rellenar blancos</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col col-lg-12">
        <div class="panel-body">
        <form method="POST">
          <input type="hidden" value="{$puntos_maximo}" id="maximo"/>
            <div class="col-lg-12">
              <label class="col col-sm-10">Pregunta:</label>
              <label class="col col-sm-2 text-right" id="puntoslabel">Total de Puntos: 0</label>
              <textarea rows="5" placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta"></textarea>
            </div>
<!--             <div class="col-lg-12" style="margin-top: 15px;">
              <label class="col-lg-1">Puntos:</label>
              <div class="col-lg-3"> -->
              <input data-toggle="tooltip" data-placement="bottom" title="El valor debe ser inferior o igual a {$puntos_maximo}" placeholder="Puntos" class="form-control" name="puntos" id="puntos" type="hidden" min="0" max="{$puntos_maximo}"/>
<!--                </div>
            </div> -->
            <div class="col-sm-12" style="margin-top: 15px;">
              <label class="">(Escriba el texto debajo, y use estos separadores |...| para definir uno o más espacios en blanco):</label>
              <textarea rows="5" placeholder="Conservemos el |medio ambiente| para que el |mundo| este sano." class="form-control" name="in_pregunta4" id="in_pregunta4"></textarea>
            </div>

            <div class="col-lg-12" style="margin-top: 15px">
              <b>Respuestas en blanco:</b>
              <div class="col-lg-12" style="margin-top: 15px" id="alt">
                Por favor defina un espacio en blanco con estos separadores <b>|...|</b>
              </div>
            </div>
                <div class="col-sm-12" style="margin-top: 15px">
                   <a data-toggle="tooltip" data-placement="bottom" title="Cancelar registro"  href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">Cancelar</a>
                   <button data-toggle="tooltip" data-placement="bottom" title="Registrar pregunta" class="btn btn-success " name="btn_registrar_pregunta" id="btn_registrar_pregunta">Registrar</button>
                </div>
        </form>
        </div>
    </div>
</div>
