
<form class="form-horizontal" style="margin-top: 15px" autocomplete="on" method="POST">
    <input type="hidden" value="1" name="enviar" />
    <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
    <input type="hidden" name="curso_id" id="curso_id" value="{$idcurso}">
    <input type="hidden" name="examen_id" id="examen_id" value="{$examen.Exa_IdExamen}">
    <input type="hidden" name="idIdiomaOriginal" id="idIdiomaOriginal" value="{$examen.Idi_IdIdioma}">
    <input type="hidden" name="idioma_original_id" id="idioma_original_id" value="{$examen.Idi_IdIdioma}">
    <input type="hidden" name="idioma_id" id="idioma_id" value="{$examen.Idi_IdIdioma_Peticion}">
    {*<input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">*}

    <div class="form-group">
        <label class="col-xs-3 control-label">{$lenguaje["elearning_editexam_titulo"]}</label>
        <div class="col-xs-9 ">
            <input class="form-control" id ="titulo" type="text" name="titulo" value="{$examen.Exa_Titulo|default:""}" placeholder="{$lang->get('str_titulo')}"/>
        </div>
    </div>
    <div class="form-group">
        <label class="col-xs-3 control-label" >{$lenguaje["elearning_editexam_modulo"]}</label>
        <div class="col-xs-9">
            <select class="form-control" id="selectmodulo" name="selectmodulo">
                {if isset($modulos) && count($modulos)}
                <option value="0">{$lenguaje["elearning_editexam_selmodulo"]}</option>
                {foreach item=ll from=$modulos}
                    <option value="{$ll.Moc_IdModuloCurso}" {if $ll.Moc_IdModuloCurso == $examen.Moc_IdModulo} selected="selected" {/if}>{$ll.Moc_Titulo}</option>
                {/foreach}
                {/if}
            </select>
        </div>
    </div>

    <div id="completar">
        {if isset($lecciones) && count($lecciones)}
        <div class="form-group">
            <label class="col-xs-3 control-label" >{$lenguaje["elearning_editexam_lecc"]}</label>
            <div class="col-xs-9">
                <select class="form-control" id="selectleccion" name="selectleccion">
                    {foreach item=ll from=$lecciones}
                        <option value="{$ll.Lec_IdLeccion}" {if $examen.Lec_IdLeccion == $ll.Lec_IdLeccion} selected="selected" {/if}>{$ll.Lec_Titulo}</option>
                    {/foreach}
                </select>
            </div>
        </div>  
        <div class="form-group">
            <label class="col-xs-3 control-label" >{$lenguaje["elearning_editexam_PorcG"]}</label>
            <div class="col-xs-9">
                <input data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_editexam_label"]} {$porcentaje}" class="form-control" id ="porcentaje" type="number" name="porcentaje" value="{$examen.Exa_Porcentaje|default:'0'}" placeholder="Porcentaje" max="{$porcentaje}" min="0" value="0"/>
            </div>
        </div>   
        <div class="form-group">
            <label class="col-xs-3 control-label" >{$lenguaje["elearning_editexam_puntaje"]} </label>
            <div class="col-xs-2 col-lg-1 ">
                <p class="  margin-t-10" > 
                    <input type="radio" value="20" class="radioalt " name="puntaje" {if $examen.Exa_Peso == 20 } checked="checked" {/if} {if isset($examenAlumno) && $examenAlumno.Exa_IdExamen > 0 } disabled="" {/if}  /> 20</p>
                <p class=" margin-t-10"> 
                    <input type="radio" value="100" class="radioalt " name="puntaje" {if $examen.Exa_Peso == 100 } checked="checked" {/if} {if isset($examenAlumno) && $examenAlumno.Exa_IdExamen > 0 } disabled="" {/if} /> 100</p>
            </div>
            <div class=" col-xs-7 margin-t-10 " > 
                <blockquote style="margin: 0;">
                    <b style="font-size: 14px">NOTA: </b>
                    <em> 
                        {if isset($examenAlumno) && $examenAlumno.Exa_IdExamen > 0 } 
                            <h5>
                                {$lenguaje["elearning_editexam_label2"]} 
                            </h5> 
                        {else}
                            <h5>
                                {$lenguaje["elearning_editexam_label3"]}  
                            </h5>
                        {/if}  
                    </em>
                </blockquote> 
            </div>
        </div>
        <div class="form-group">
            <label class="col-xs-3 control-label" >{$lenguaje["elearning_editexam_intentos"]} </label>
            <div class="col-xs-9">
                <select class="form-control" id="intentos" name="intentos">                            
                    <option {if $examen.Exa_Intentos == 1} selected="selected" {/if} value="1">1</option>
                    <option {if $examen.Exa_Intentos == 2} selected="selected" {/if} value="2">2</option>
                    <option {if $examen.Exa_Intentos == 3} selected="selected" {/if} value="3">3</option>
                    <option {if $examen.Exa_Intentos == 5} selected="selected" {/if} value="5">5</option>
                    <option {if $examen.Exa_Intentos == 10} selected="selected" {/if} value="10">10</option>
                    <option {if $examen.Exa_Intentos == 0} selected="selected" {/if} value="0">Ilimitado</option>
                </select>
            </div>
        </div>
        {else}
        <center>{$lenguaje["elearning_editexam_lecc1"]} <center>
        {/if}
    </div>
    <div class="form-group">
        <div class="col-sm-12">
            <button class="btn btn-info  pull-right ml-4" id="prepararPregunta" name="prepararPregunta"> {$lenguaje["elearning_editexam_B2"]} </button>
            <button class="btn btn-success  pull-right" id="guardarEditar" name="guardarEditar"> {$lenguaje["elearning_editexam_BG"]} </button>
        </div>
        
    </div>
</form>
