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
        <h3>Editar pregunta: Rellenar blancos</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col col-xs-12">
        <div class="panel-body">
        <form method="POST">
         <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
            <input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">
            <input type="hidden" name="idexamen" id="idexamen" value="{$examen}">
          <input type="hidden" value="{$puntos_maximo}" id="maximo"/>
            <div class="col-xs-12">
              <label class="col col-xs-9 ">Pregunta:</label>
              <label class="col col-xs-3 text-right" id="puntoslabel">Total de Puntos: {$preguntaedit.Pre_Puntos}</label>
              <textarea rows="5" placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta">{$preguntaedit.Pre_Descripcion}</textarea>
            </div>
           <!--  <div class="col-lg-12" style="margin-top: 15px;">
              <label class="col-lg-1">Puntos:</label>
              <div class="col-lg-3"> -->
              <input class="form-control" name="puntos" id="puntos" type="hidden" value="{$preguntaedit.Pre_Puntos}"/>
<!--               </div>
            </div> -->
            <div class="col-xs-12" style="margin-top: 15px;">
              <label class="">(Escriba el texto debajo, y use estos separadores |...| para definir uno o más espacios en blanco): </label>
              <textarea rows="5" placeholder="Conservemos el |medio ambiente| para que el |mundo| este sano." class="form-control" name="in_pregunta4" id="in_pregunta4">{$preguntaedit.Pre_Descripcion2}</textarea>
            </div>

            <div class="col-xs-12" style="margin-top: 15px">
            <b>Respuestas en blanco: </b> ¡El puntaje máximo disponible es {$puntos_maximo}!.

              <div class="col col-xs-12" style="margin-top: 15px" id="alt">
                <div class='table-responsive'>
                  <table id='tabla' class='table' style='margin: 20px auto'>
                    <tr>
                      <th class="col-xs-1" style='text-align: center'>Nº</th>
                      <th class="col-xs-9" style='text-align: center'>Respuesta</th>
                      <th class="col-xs-2" style='text-align: center'>Puntos <button type="button" data-toggle="tooltip" data-placement="bottom" title="Asignar puntos automaticamente" class="btn btn-xs btn-warning margin-top-10" name="btn_asignar_puntos" id="btn_asignar_puntos">Asignar</button></th>
                    </tr>
                    {$i=1}
                    {foreach item=ra from=$alternativas}
                    <tr style='text-align: center'>
                      <td >{$i}</td>
                      <td>{$ra.Alt_Etiqueta}</td>
                      <td><input data-toggle="tooltip" data-placement="bottom" title="El valor debe ser inferior o igual a {if $preguntaedit.Pre_Estado == 0}{$puntos_maximo-$preguntaedit.Pre_Puntos+$ra.Alt_Puntos}{else}{$puntos_maximo+$ra.Alt_Puntos}{/if}" placeholder="Puntos" class="form-control puntos_blanco" name="puntos{$i}" id="puntos{$i}" type='number' min='0' max="{if $preguntaedit.Pre_Estado == 0}{$puntos_maximo}{else}{$puntos_maximo+$ra.Alt_Puntos}{/if}" value="{$ra.Alt_Puntos}"/></td>
                    </tr>
                    {$i=$i+1}
                    {/foreach}
                    <input class="form-control" name="contblanco" id="contblanco" type="hidden" value="{$i}"/>
                  </table>
                </div>
              </div>
            </div>            
            <div class="col-sm-10">
              <a data-toggle="tooltip" data-placement="bottom" title="Cancelar registro" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">Cancelar</a>
               <button data-toggle="tooltip" data-placement="bottom" title="Guardar cambios" class="btn btn-success " disabled="true" name="btn_registrar_pregunta" id="btn_registrar_pregunta">Guardar</button>
            </div>
        </form>
        </div>
    </div>
</div>

<!-- <script type="text/javascript">
  $(document).on('ready', function () { 
    var maximo = $("#maximo").val();
    // if (maximo < $("#puntos").val()) {}
    // $("#puntos").val();
    var numAlternativas = (contblanco-1);
    var puntosRestantes = maximo%numAlternativas; //Lo que sobra(residuo)
    var puntosEnteros = Math.floor(maximo/numAlternativas);
    // alert(puntosRestantes);    
    for (var i = 1; i < contblanco; i++){
        // if("puntos"+i!=this.id)            
        // $("#puntos"+i).val(puntosEnteros);
        $("#puntos"+i).attr('max', puntosEnteros);
        $("#puntos"+i).attr('data-original-title', "El valor debe ser inferior o igual a " + puntosEnteros);
    } 
    for (var j = 1; j < contblanco; j++) {
        if (puntosRestantes > 0) {
            var _max = parseInt($("#puntos"+j).attr('max')) + 1;
            // $("#puntos"+j).val(_max);
            $("#puntos"+j).attr('max', _max);
            $("#puntos"+j).attr('data-original-title', "El valor debe ser inferior o igual a " + _max);
        } 
        puntosRestantes--;            
    }
    // $("#puntos").val(maximo);
    // $("#puntoslabel").text("Puntos: "+ maximo);

  });
</script> -->
