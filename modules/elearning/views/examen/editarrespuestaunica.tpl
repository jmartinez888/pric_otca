{extends 'template.tpl'}
{block 'contenido'}
{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-xs-12 col-sm-12 col-md-9 col-lg-10">
  <div class="col-sm-12 pt-20">
    <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
        {$titulo}
    </h3>
  </div>
    <div class="col-lg-12">
        <div class="col-lg-12">
      <div class=" " style="margin-bottom: 0px !important">
        <div class="text-center text-bold" style="margin-top: 20px; margin-bottom: 20px; color: #267161;">
          
        </div>
      </div>
    </div>
        <h3>{$lang->get("elearning_editarrespuestaunica_titulo")}</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div id="gestion_idiomas_pregunta">
            {if isset($preguntaedit)}
              {if  isset($idiomas) && count($idiomas)}
                  <ul class="nav nav-tabs " role="tablist">
                  {foreach from=$idiomas item=idi}
                      <li role="presentation" class="{if Cookie::lenguaje()==$idi.Idi_IdIdioma} active {/if}">
                          <a class="idioma_s" id="idioma_{$idi.Idi_IdIdioma}" href="#" role="tab" data-toggle="tab">{$idi.Idi_Idioma}</a>
                          <input type="hidden" id="hd_idioma_{$idi.Idi_IdIdioma}" value="{$idi.Idi_IdIdioma}" />
                          <input type="hidden" id="idiomaTradu" value="{$preguntaedit.Idi_IdIdioma}"/>
                      </li>    
                  {/foreach}
                  </ul>
              {/if}
              <div id="replace_contenido_pregunta">
                  {include 'editarrespuestaunica_gestion_idioma.tpl'}
                  {*
                  <form method="POST">
                      <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
                      <input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">
                      <input type="hidden" name="idexamen" id="idexamen" value="{$examen}">
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
                              <div class="col-sm-10"><input placeholder="{$lang->get("elearning_editarrespuestaunica_placeholder2")}" class="form-control margin-top-10" name="alt{$i}" id="inPreg{$i}" style="margin-top:10px;" value="{$rl.Alt_Etiqueta}" type="text"/></div>
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
                  *}
              </div>
          {/if}
        </div>
        
        
    </div>
</div>
{/block}                                                                                                                                                                                                                                    
