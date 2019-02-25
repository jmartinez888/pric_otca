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
      <h3>{$lenguaje["elearning_ editarrespuestacombinacionexacta_titulo"]}</h3>
      <hr class="cursos-hr">
    </div>
    <div class="col col-xs-12">
      <div class="panel-body">
        <form method="POST">
         <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
            <input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">
            <input type="hidden" name="idexamen" id="idexamen" value="{$examen}">
            <label class="col-xs-10">{$lenguaje["elearning_ editarrespuestacombinacionexacta_pregunta"]}</label>
            <label class="col-xs-2">{$lenguaje["elearning_ editarrespuestacombinacionexacta_puntos"]}</label>
            <div class="col-xs-10">
              <input placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta" value="{$preguntaedit.Pre_Descripcion}"/>
            </div>
            <div class="col-xs-2">
              <input placeholder="{$lenguaje["elearning_ editarrespuestacombinacionexacta_placeholder1"]}" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{if $puntos_maximo>$preguntaedit.Pre_Puntos}{$puntos_maximo}{else}{$preguntaedit.Pre_Puntos+$puntos_maximo}{/if}" value="{$preguntaedit.Pre_Puntos}"/>
            </div>
            <br>
            <input type="hidden" class="form-control" name="contador" id="contador" value="{$nextinput-1}"/>
            <div class="col-xs-10" style="margin-top:10px;">
              <label >{$lenguaje["elearning_ editarrespuestacombinacionexacta_alternativas"]}</label>
            </div>
            <div class="col-xs-2" style="margin-top:10px;">
              <label >{$lenguaje["elearning_ editarrespuestacombinacionexacta_correcto"]}</label>
            </div>
            <div id="alt">
              <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="{$nextinput}"/>
              {$i=1}
              {foreach item=rl from=$alternativas}
              <div class="col col-xs-12">
                <div class="col-xs-10">
                  <input placeholder="{$lenguaje["elearning_ editarrespuestacombinacionexacta_placeholder2"]}" class="form-control " name="alt{$i}" id="inPreg{$i}" style="margin-top:10px;" value="{$rl.Alt_Etiqueta}" type="text"/>
                </div>
                <div class="col-xs-1">
                  <input type="checkbox" value="{$i}" class="radioalt " name="ckb{$i}" id='ckb{$i}' {if $rl.Alt_Check==1} checked {/if} style="margin-top:10px;"/>
                </div>
                {if $i>2}
                  <div class='col-xs-1'>
                    <a data-toggle='tooltip' data-placement='right' title='{$lenguaje["elearning_ editarrespuestacombinacionexacta_text1"]}' href='javascript:void(0);' class='remove_button btn btn-danger pull-right' ><i class='glyphicon glyphicon-minus'></i></a>  
                  </div>
                {/if}
                </div>
                  {$i=$i+1}
                {/foreach}
            </div>
            <div class="col-xs-12" style="margin-top: 15px">
               <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_ editarrespuestacombinacionexacta_text2"]}" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">{$lenguaje["elearning_ editarrespuestacombinacionexacta_btncancelar"]}</a>
               <button data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_ editarrespuestacombinacionexacta_text3"]}" class="btn btn-success " name="btn_registrar_pregunta" id="btn_registrar_pregunta">{$lenguaje["elearning_ editarrespuestacombinacionexacta_text3"]}</button>
               <a data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_ editarrespuestacombinacionexacta_text4"]}" class="btn btn-primary pull-right glyphicon glyphicon-plus" id="btn_añadir2"></a>
            </div>
        </form>
        </div>
    </div>
</div>
