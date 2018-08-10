{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10">
<div class="col-lg-12">
        <h3>Añadir pregunta: Respuesta Relacionada</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form method="POST">
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
            

            <div id="alt" class="col-lg-12" style="margin-top:10px;">
            <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="3"/>
                <label class="">Respuestas</label>
                <br>
                <label class="" style="margin-top:10px;">Enunciado:</label>
                <input placeholder="Enunciado" class="form-control" name="enu1" id="enu1"/>
                <label class="">Corresponde a:</label>
                <input placeholder="Respuesta relacionada" class="form-control" name="rpta1" id="rpta1"/>
                <label class="" style="margin-top:20px;">Enunciado:</label>
                <input placeholder="Enunciado" class="form-control" name="enu2" id="enu2"/>
                <label class="">Corresponde a:</label>
                <input placeholder="Respuesta relacionada" class="form-control" name="rpta2" id="rpta2"/>
            </div>
                <div class="col-lg-12" style="margin-top: 15px">
                   <a href="{$_layoutParams.root}elearning/examen/preguntas/{$examen}" class="btn btn-danger pull-right">Cancelar</a>
                   <button class="btn btn-success margin-top-10" name="btn_registrar_pregunta" id="btn_registrar_pregunta">Registrar</button>
                   <a class="btn btn-primary pull-right margin-top-10 glyphicon glyphicon-plus" id="btn_añadir4"></a>
                </div>
        </form>
        </div>
    </div>
</div>