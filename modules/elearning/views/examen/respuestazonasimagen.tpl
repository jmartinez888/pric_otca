{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-9">
<div class="col-lg-12">
    <div class="col-lg-12">
  <div class=" " style="margin-bottom: 0px !important">
    <div class="text-center text-bold" style="margin-top: 20px; margin-bottom: 20px; color: #267161;">
      <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
        Titulo de Nuevo curso mooc
                </h3>
    </div>
  </div>
</div>
        <h3>Añadir pregunta: Respuesta con Zonas de Imagen </h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form method="POST" enctype="multipart/form-data">
            <div class="col-lg-12">
              <label class="">Pregunta</label>
              <textarea rows="5" placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta">
              </textarea>
            
                <div class="form-group">
                              <label for="img">Seleccione Background:</label>
                              <input type="file" class="form-control" name="img" id="img" accept="image/*" required>
                              <br>
                </div>
                 <div  class="col-lg-12 col-xs-12 file-preview-zone" style="background: url({if isset($plantilla) && count($plantilla)}{$_layoutParams.root_clear}{$plantilla.Plc_UrlImg}{else}{$_layoutParams.ruta_img}frontend/pric.png){/if}; background-size: 100%; -moz-background-size: 100%; -o-background-size: 100%; -webkit-background-size: 100%;  -khtml-background-size: 100%; max-width: 100%; height:21cm; position: relative;" id="cuadro1" ondragenter="return enter_as(event)" ondragover="return over_as(event)" ondragleave="return leave_as(event)" ondrop="return drop_as(event)">
                </div>

                <div class="col-lg-12" style="margin-top: 15px">
                   <button class="btn btn-success pull-right margin-top-10" name="btn_registrar_pregunta" id="btn_registrar_pregunta">Registrar</button>
                </div>
              </div>
        </form>
        </div>
    </div>
</div>
