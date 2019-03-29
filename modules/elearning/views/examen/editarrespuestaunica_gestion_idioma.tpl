<form method="POST" class="mt-15">
    <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
    {*<input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">*}
    <input type="hidden" name="idexamen" id="idexamen" value="{$examen}">
    <input type="hidden" name="idIdiomaOriginal" id="idIdiomaOriginal" value="{$preguntaedit.Idi_IdIdioma}">
    <input type="hidden" name="pregunta_id" id="pregunta_id" value="{$preguntaedit.Pre_IdPregunta}">
    <input type="hidden" name="idioma_original_id" id="idioma_original_id" value="{$preguntaedit.Idi_IdIdioma}">
    <input type="hidden" name="idioma_id" id="idioma_id" value="{$idioma_id}">
    <label class="col-sm-10">{$lang->get("elearning_editarrespuestaunica_pregunta")}</label>
    <label class="col-sm-2">{$lang->get("elearning_editarrespuestaunica_puntos")}</label>
    
    <div class="col-sm-10">
      <input placeholder="{$lang->get("elearning_editarrespuestaunica_placeholder0")}" class="form-control" name="in_pregunta" id="in_pregunta" value="{$preguntaedit.Pre_Descripcion}"/>
      </div>
      <div class="col-sm-2">
      <input data-toggle="tooltip" data-placement="bottom" title="{$lang->get("elearning_editarrespuestaunica_text1")} {if $preguntaedit.Pre_Estado == 0}{$puntos_maximo}{else}{$preguntaedit.Pre_Puntos+$puntos_maximo}{/if}" placeholder="{$lang->get("elearning_editarrespuestaunica_placeholder1")}" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{if $preguntaedit.Pre_Estado == 0}{$puntos_maximo}{else}{$preguntaedit.Pre_Puntos+$puntos_maximo}{/if}" value="{$preguntaedit.Pre_Puntos}"/>
        </div>
        <br>
      <input type="hidden" class="form-control" name="contador" id="contador" value="{$nextinput-1}"/>
    <div class="col-sm-10">
      <label class="margin-top-10" style="margin-top:10px;">{$lang->get("elearning_editarrespuestaunica_alternativas")}</label>
    </div>
    <div class="col-sm-2">
      <label class="margin-top-10" style="margin-top:10px;">{$lang->get("elearning_editarrespuestaunica_correcto")}</label>
    </div>

    <div id="alt">
        <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="{$nextinput}"/>
        {$i=1}
        {foreach item=rl from=$alternativas}
        <div>
            <div class="col-sm-10">
              
              <input type="hidden" name="alt[{$i}][id]" id="" value="{$rl.Alt_IdAlternativa}">
              <input type="hidden" name="alt[{$i}][valor]" id="" value="{$rl.Alt_Valor}">
              
              <input placeholder="{$lang->get("elearning_editarrespuestaunica_placeholder2")}" class="form-control margin-top-10" name="alt[{$i}][value]" id="inPreg{$i}" style="margin-top:10px;" value="{$rl.Alt_Etiqueta}" type="text"/></div>
            <div class="col-sm-1"><input type="radio" value="{$i}" class="radioalt margin-top-10" name="valor_preg" style="margin-top:10px;" {if $preguntaedit.Pre_Valor==$i}checked{/if}/></div>
            {if $i>2}
            <div class='col-sm-1'>
              <a href='javascript:void(0);' data-toggle='tooltip' data-placement='right' title='{$lang->get("elearning_editarrespuestaunica_text2")}' class='remove_button btn btn-danger pull-right margin-top-10 '><i class='glyphicon glyphicon-minus'></i></a>
            </div>
            {/if}
        </div>
            {$i=$i+1}
        {/foreach}
    </div>
    <div class="col col-sm-12" style="margin-top: 15px">
        <div class="col-sm-10">
          <a data-toggle="tooltip" data-placement="bottom" title="{$lang->get("elearning_editarrespuestaunica_text3")}" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">{$lang->get("elearning_editarrespuestaunica_btncancelar")}</a>
        
          <button data-toggle="tooltip" data-placement="bottom" title="{$lang->get("elearning_editarrespuestaunica_text4")}" class="btn btn-success margin-top-10" name="btn_registrar_pregunta" id="btn_registrar_pregunta">{$lang->get("elearning_editarrespuestaunica_btnguardar")}</button>
        </div>
        <div class="col-sm-2">
            <a data-toggle="tooltip" data-placement="bottom" title="{$lang->get("elearning_editarrespuestaunica_text5")}" class="btn btn-primary margin-top-10 glyphicon glyphicon-plus" id="btn_añadir1"></a>
        </div>
    </div>
</form>
