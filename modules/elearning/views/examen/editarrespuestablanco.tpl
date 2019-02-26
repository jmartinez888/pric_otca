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
        <h3>{$lenguaje["elearning_editarrespuestarellenarblanco_titulo"]}</h3>
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
              <label class="col col-xs-9 ">{$lenguaje["elearning_editarrespuestarellenarblanco_pregunta"]}:</label>
              <label class="col col-xs-3 text-right" id="puntoslabel">{$lenguaje["elearning_editarrespuestarellenarblanco_totalpuntos"]} {$preguntaedit.Pre_Puntos}</label>
              <textarea rows="5" placeholder="{$lenguaje["elearning_editarrespuestarellenarblanco_placeholder1"]}" class="form-control" name="in_pregunta" id="in_pregunta">{$preguntaedit.Pre_Descripcion}</textarea>
            </div>
           <!--  <div class="col-lg-12" style="margin-top: 15px;">
              <label class="col-lg-1">{$lenguaje["elearning_editarrespuestarellenarblanco_puntos"]}</label>
              <div class="col-lg-3"> -->
              <input class="form-control" name="puntos" id="puntos" type="hidden" value="{$preguntaedit.Pre_Puntos}"/>
<!--               </div>
            </div> -->
            <div class="col-xs-12" style="margin-top: 15px;">
              <label class="">{$lenguaje["elearning_editarrespuestarellenarblanco_texto1"]}</label>
              <textarea rows="5" placeholder="{$lenguaje["elearning_editarrespuestarellenarblanco_texto2"]}" class="form-control" name="in_pregunta4" id="in_pregunta4">{$preguntaedit.Pre_Descripcion2}</textarea>
            </div>

            <div class="col-xs-12" style="margin-top: 15px">
            <b>{$lenguaje["elearning_editarrespuestarellenarblanco_respuestablanco"]} </b> {$lenguaje["elearning_editarrespuestarellenarblanco_respuestapuntmax"]} {$puntos_maximo}!.

              <div class="col col-xs-12" style="margin-top: 15px" id="alt">
                <div class='table-responsive'>
                  <table id='tabla' class='table' style='margin: 20px auto'>
                    <tr>
                      <th class="col-xs-1" style='text-align: center'>Nº</th>
                      <th class="col-xs-9" style='text-align: center'>{$lenguaje["elearning_editarrespuestarellenarblanco_respuestatitulo"]}</th>
                      <th class="col-xs-2" style='text-align: center'>{$lenguaje["elearning_editarrespuestarellenarblanco_respuestapuntos"]} <button type="button" data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_editarrespuestarellenarblanco_asignarpuntos"]}" class="btn btn-xs btn-warning margin-top-10" name="btn_asignar_puntos" id="btn_asignar_puntos">{$lenguaje["elearning_editarrespuestarellenarblanco_btnasignar"]}</button></th>
                    </tr>
                    {$i=1}
                    {foreach item=ra from=$alternativas}
                    <tr style='text-align: center'>
                      <td >{$i}</td>
                      <td>{$ra.Alt_Etiqueta}</td>
                      <td><input data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_editarrespuestarellenarblanco_valor"]} {if $preguntaedit.Pre_Estado == 0}{$puntos_maximo-$preguntaedit.Pre_Puntos+$ra.Alt_Puntos}{else}{$puntos_maximo+$ra.Alt_Puntos}{/if}" placeholder="{$lenguaje["elearning_editarrespuestarellenarblanco_placeholder0"]}" class="form-control puntos_blanco" name="puntos{$i}" id="puntos{$i}" type='number' min='0' max="{if $preguntaedit.Pre_Estado == 0}{$puntos_maximo}{else}{$puntos_maximo+$ra.Alt_Puntos}{/if}" value="{$ra.Alt_Puntos}"/></td>
                    </tr>
                    {$i=$i+1}
                    {/foreach}
                    <input class="form-control" name="contblanco" id="contblanco" type="hidden" value="{$i}"/>
                  </table>
                </div>
              </div>
            </div>            
            <div class="col-sm-10">
              <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_editarrespuestarellenarblanco_cancelarR"]}" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">{$lenguaje["elearning_editarrespuestarellenarblanco_btncancelar"]}</a>
               <button data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_editarrespuestarellenarblanco_textguardar"]}" class="btn btn-success " disabled="true" name="btn_registrar_pregunta" id="btn_registrar_pregunta">{$lenguaje["elearning_editarrespuestarellenarblanco_btnguardar"]}</button>
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
        $("#puntos"+i).attr('data-original-title', "{$lenguaje["elearning_editarrespuestarellenarblanco_valor1"]}" + puntosEnteros);
    } 
    for (var j = 1; j < contblanco; j++) {
        if (puntosRestantes > 0) {
            var _max = parseInt($("#puntos"+j).attr('max')) + 1;
            // $("#puntos"+j).val(_max);
            $("#puntos"+j).attr('max', _max);
            $("#puntos"+j).attr('data-original-title', "{$lenguaje["elearning_editarrespuestarellenarblanco_valor2"]} " + _max);
        } 
        puntosRestantes--;            
    }
    // $("#puntos").val(maximo);
    // $("#puntoslabel").text("Puntos: "+ maximo);

  });
</script> -->
