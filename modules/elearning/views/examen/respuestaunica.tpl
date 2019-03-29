{extends 'template.tpl'}
{block 'contenido'}
{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-xs-12 col-sm-12 col-md-9 col-lg-10" style="padding-bottom: 40px;">
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
        <h3>{$lang->get("elearning_respuestaunica_titulo")}</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form class="form-horizontal" autocomplete="on" method="POST">
          
            <div class="form-group" >
                <label class="col-lg-3 control-label">{$lang->get('str_idioma')} : </label>
                
                {if  isset($idiomas) && count($idiomas)}              
                    <div class="form-inline col-lg-9">
                    {foreach from=$idiomas item=idi}
                        {if  isset($datos) && count($datos)}
                        {if $datos.Idi_IdIdioma==$idi.Idi_IdIdioma} 
                        <input type="hidden" value="{$idi.Idi_Idioma}" id="idiomaRadio" name="idiomaRadio"> 
                        {/if}
                        <div class="radio">
                            <label>
                                <input disabled="true" type="radio"  value="{$idi.Idi_IdIdioma}" 
                                    {if $datos.Idi_IdIdioma==$idi.Idi_IdIdioma} checked="checked" {/if} required>
                                {$idi.Idi_Idioma}
                            </label>   
                        </div>   
                        {else}
                        <div class="radio">
                            <label>
                                <input type="radio"  name="idiomaRadio" id="idiomaRadio_{$idi.Idi_IdIdioma}" value="{$idi.Idi_IdIdioma}"  
                                    {if isset($idiomaUrl) && $idiomaUrl == $idi.Idi_IdIdioma } checked="checked" {/if} required>
                                {$idi.Idi_Idioma} 
                            </label>  
                        </div>
                        {/if}
                    {/foreach}
                    </div>              
                {/if}
            </div>
            <label class="col-sm-10">{$lang->get("elearning_respuestaunica_pregunta")}</label>
            <label class="col-sm-2">{$lang->get("elearning_respuestaunica_puntos")}</label>
            <div class="col-sm-10">
            <input placeholder="{$lang->get('str_pregunta')}" class="form-control" name="in_pregunta" id="in_pregunta"/>
             </div>
             <div class="col-sm-2">
            <input data-toggle="tooltip" data-placement="bottom" title="{$lang->get("elearning_respuestaunica_valor")} {$puntos_maximo}" placeholder="{$lang->get("elearning_respuestaunica_palholderpuntos")}" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{$puntos_maximo}"/>
             </div>
             <br>
            <input type="hidden" class="form-control" name="contador" id="contador" value="2"/>
            <div class="col-sm-10" style="margin-top:10px;">
              <label class="margin-top-10">{$lang->get("elearning_respuestaunica_alternativas")}</label>
            </div>
            <div class="col-sm-2" style="margin-top:10px;">
              <label class=" margin-top-10">{$lang->get("elearning_respuestaunica_correcto")}</label>
            </div>

            <div id="alt" style="margin-top:10px;">
              <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="3"/>
                <div class="col-sm-10"><input placeholder="{$lang->get("elearning_respuestaunica_placeholder1")}" class="form-control margin-top-10" name="alt1" id="inPreg1" style="margin-top:10px;"/></div>
                <div class="col-sm-2"><input type="radio" value="1" class="radioalt margin-top-10" name="valor_preg" checked="checked" style="margin-top:10px;"/></div>
                 <div class="col-sm-10"><input placeholder="{$lang->get("elearning_respuestaunica_placeholder2")}" class="form-control margin-top-10" name="alt2" id="inPreg2" style="margin-top:10px;"/></div>
                <div class="col-sm-2"><input type="radio" value="2" class="radioalt margin-top-10" name="valor_preg" style="margin-top:10px;"/></div>
            </div>
              <div class="col col-sm-12" style="margin-top: 15px">
                <div class="col-sm-10">
                  <a data-toggle="tooltip" data-placement="bottom" title="{$lang->get("str_cancelar")}"  href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">{$lang->get("elearning_respuestaunica_btncancelar2")}</a>
                 <button data-toggle="tooltip" data-placement="bottom" title="{$lang->get("elearning_respuestaunica_tituloregpre")}" class="btn btn-success  margin-top-10" name="btn_registrar_pregunta" id="btn_registrar_pregunta">{$lang->get("elearning_respuestaunica_btnregistrar1")}</button>
                </div>
                <div class="col-sm-2">
                 <a data-toggle="tooltip" data-placement="bottom" title="{$lang->get("elearning_respuestaunica_btnagregar")}"  class="btn btn-primary pull-right margin-top-10 glyphicon glyphicon-plus" id="btn_añadir1"></a>
               </div>
            </div>
        </form>
        </div>
    </div>
    
  </div>
{/block}
{block 'template'}
<template id="tpl-cabezera">
  <div class='table-responsive'>
    <table id='tabla' class='table' style='margin: 20px auto'>
      <tr>
        <th style='text-align: center'>Nº</th>
        <th style='text-align: center'>{$lang->get('str_respuesta')}</th>
        <th class='col-lg-3' style='text-align: center'>{$lang->get('str_puntos')} <button type='button' data-toggle='tooltip' data-placement='bottom' title='{$lang->get('elearning_editarrespuestarellenarblanco_asignarpuntos')}' class='btn btn-xs btn-warning margin-top-10' name='btn_asignar_puntos' id='btn_asignar_puntos'>{$lang->get('str_asignar')}</button> 
        </th>
      </tr>
    </table>
  </div>
</template>
<template id="tpl-campo-pre-4">
  <tr style='text-align: center'>
    <td><b>{literal}{{varj}}{/literal}.</b></td>
    <td>{literal}{{textoseparado}}{/literal}</td>
    <td>
      <input placeholder="{$lang->get('str_puntos')}" class='form-control puntos_blanco' data-toggle='tooltip' data-placement='bottom' title='{$lang->get('elearning_nuevo_examen_porcentaje2')} {literal}{{maximo}}{/literal}' name='puntos{literal}{{varj}}{/literal}' id='puntos{literal}{{varj}}{/literal}' type='number' min='0' max='{literal}{{maximo}}{/literal}' value='0'/>
    </td>
  </tr>
</template>
<template id="tpl-campo-add1">
    <div class='col col-sm-12'>
      <div class='col-sm-10'><input style='margin-top:10px;' placeholder='{$lang->get('str_alternativa')}' class='form-control margin-t-10' name='alt{literal}{{nextinput}}{/literal}' id='alt{literal}{{nextinput}}{/literal}'/></div><div class='col-sm-1'><input style='margin-top:10px;' type='radio' value='{literal}{{nextinput}}{/literal}' class='radioalt margin-t-10' name='valor_preg'/></div><div class='col-sm-1'> <a style='margin-top:10px;' href='javascript:void(0);' class='remove_button btn btn-danger pull-right margin-t-10 ' data-toggle='tooltip' data-placement='right'  title='{$lang->get('elearning_ editarrespuestaunica_text2')}'><i class='glyphicon glyphicon-minus'></i></a></div>
    </div>
</template>
<template id="tpl-campo-add2">
    <div class='col col-sm-12'>
      <div class='col-sm-10'><input style='margin-top:10px;' placeholder='{$lang->get('str_alternativa')}' class='form-control margin-t-10' name='alt{literal}{{nextinput}}{/literal}' id='alt{literal}{{nextinput}}{/literal}'/></div><div class='col-sm-1'><input style='margin-top:10px;' type='checkbox' value='{literal}{{nextinput}}{/literal}' class='radioalt margin-t-10' name='ckb{literal}{{nextinput}}{/literal}' id='ckb{literal}{{nextinput}}{/literal}' /></div><div class='col-sm-1'><a style='margin-top:10px;' href='javascript:void(0);' class='remove_button btn btn-danger pull-right margin-t-10 ' data-toggle='tooltip' data-placement='right'  title='{$lang->get('elearning_ editarrespuestaunica_text2')}'><i class='glyphicon glyphicon-minus'></i></a></div> 
    </div>
</template>
<template id="tpl-campo-add4">
    <div class='col col-sm-12'>
      <div class='col col-sm-11 margin-t-10'><label class=''>{$lang->get('str_enunciado')} {literal}{{nextinput}}{/literal}:</label><input placeholder='{$lang->get('str_enunciado')} {literal}{{nextinput}}{/literal}' class='form-control' name='enu{literal}{{nextinput}}{/literal}' id='enu{literal}{{nextinput}}{/literal}'/><label class=''>{$lang->get('elearning_respuestarelacionar_corresponde1')}</label><input placeholder='{$lang->get('elearning_respuestarelacionar_placeholder4')}' class='form-control' name='rpta{literal}{{nextinput}}{/literal}' id='rpta{literal}{{nextinput}}{/literal}'/></div><div class='col col-sm-1' ><a href='javascript:void(0);' class='remove_button btn btn-danger pull-right' style='margin-top:100%;' data-toggle='tooltip' data-placement='right'  title='{$lang->get('elearning_ editarrespuestaunica_text2')}'><i class='glyphicon glyphicon-minus'></i></a></div>
    </div>
</template>

{/block}
{block 'js'}
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js" type="text/javascript"></script>
<script type="text/javascript">
  const LANG_UTILS_VIEW = {
    str_puntos: '{$lang->get('str_puntos')}',
    espacio_blanco_con_separadores: '{$lang->get('elearning_cursos_espacio_blanco_con_separadores')}',
    nuevo_examen_porcentaje2: '{$lang->get('elearning_nuevo_examen_porcentaje2')}',
    elearning_label_mensaje: '{$lang->get('elearning_label_mensaje')}',
    no_se_puede_habilitar_examen_supera_porcentaje: '{$lang->get('elearning_cursos_no_se_puede_habilitar_examen_supera_porcentaje')}',
    elearning_cursos_solo_puede_habilitar_examen_supera_puntaje: '{$lang->get('elearning_cursos_elearning_cursos_solo_puede_habilitar_examen_supera_puntaje')}',
    elearning_cursos_solo_puede_habilitar_examen_leccion: '{$lang->get('elearning_cursos_solo_puede_habilitar_examen_leccion')}',
    elearning_cursos_porcentaje_supero: '{$lang->get('elearning_cursos_porcentaje_supero')}',
    elearning_cursos_alcanzado_todos_puntos_peso_registrados: '{$lang->get('elearning_cursos_alcanzado_todos_puntos_peso_registrados')}',
    elearning_cursos_puntaje_pregunta_supera_habilitar: '{$lang->get('elearning_cursos_puntaje_pregunta_supera_habilitar')}',
  }
</script>
<script src="{$_layoutParams.rutas.js}index.js" type="text/javascript"></script>
{/block}
