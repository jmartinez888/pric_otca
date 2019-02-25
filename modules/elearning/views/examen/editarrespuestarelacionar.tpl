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
      <h3>{$lenguaje["elearning_ editarrespuestarelacionar_titulo"]}</h3>
      <hr class="cursos-hr">
    </div>
    <div class="col col-xs-12">
      <div class="panel-body">
        <form method="POST">
          <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
          <input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">
          <input type="hidden" name="idexamen" id="idexamen" value="{$examen}">
          <label class="col-xs-10">{$lenguaje["elearning_ editarrespuestarelacionar_pregunta"]}</label>
          <label class="col-xs-2">{$lenguaje["elearning_ editarrespuestarelacionar_puntos"]}</label>
          <div class="col-xs-10">
            <input placeholder="{$lenguaje["elearning_ editarrespuestarelacionar_placeholder1"]}" class="form-control" name="in_pregunta" id="in_pregunta" value="{$preguntaedit.Pre_Descripcion}"/>
          </div>
          <div class="col-xs-2">
            <input data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_ editarrespuestarelacionada_text1"]} {if $puntos_maximo>$preguntaedit.Pre_Puntos}{$puntos_maximo}{else}{$preguntaedit.Pre_Puntos+$puntos_maximo}{/if}" placeholder="{$lenguaje["elearning_ editarrespuestarelacionada_placeholder2"]}" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{if $puntos_maximo>$preguntaedit.Pre_Puntos}{$puntos_maximo}{else}{$preguntaedit.Pre_Puntos+$puntos_maximo}{/if}" value="{$preguntaedit.Pre_Puntos}"/>
          </div>
          <br>
          <input type="hidden" class="form-control" name="contador" id="contador" value="{$nextinput-1}"/>
          <div id="alt" class="col-xs-12 margin-t-10">
            <label class="">{$lenguaje["elearning_ editarrespuestarelacionada_respuestas"]}</label>
            <br>
            <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="{$nextinput}"/>
            {$i=1}
            {for $j=0; $j<count($alternativas); $j=$j+2}
              <div class="col col-xs-12"> 
                {if $j>2}
                 <div class="col col-xs-11">
                {/if}
                  <label class="" style="margin-top:10px;">Enunciado {$i}:</label>
                  <input placeholder="Enunciado {$i}" class="form-control" name="enu{$i}" id="enu{$i}" value="{$alternativas[$j]['Alt_Etiqueta']}"/>
                  <label class="">Corresponde a:</label>
                  <input placeholder="Respuesta relacionada" class="form-control" name="rpta{$i}" id="rpta{$i}" value="{$alternativas[$j+1]['Alt_Etiqueta']}"/>
                {if $j>2}
                </div>
                <div class="col col-xs-1" style="margin-top: 10%">
                  <a data-toggle='tooltip' data-placement='right'  title='{$lenguaje["elearning_ editarrespuestarelacionada_eliminaralternativa"]}' href='javascript:void(0);' class='remove_button btn btn-danger pull-right ' title='Remove field'><i class='glyphicon glyphicon-minus'></i></a>
                </div>
                {/if}
              </div>
              {$i=$i+1}
            {/for}
            </div>
            <div class="col-xs-12" style="margin-top: 15px">
               <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_ editarrespuestarelacionada_text2"]}" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">{$lenguaje["elearning_ editarrespuestarelacionada_btncancelar"]}</a>
               <button data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_ editarrespuestarelacionada_text3"]}" class="btn btn-success " name="btn_registrar_pregunta" id="btn_registrar_pregunta">{$lenguaje["elearning_ editarrespuestarelacionada_btnguardar"]}</button>
               <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_ editarrespuestarelacionada_text4"]}" class="btn btn-primary pull-right glyphicon glyphicon-plus" id="btn_añadir4"></a>
            </div>
        </form>
      </div>
    </div>
</div>
