{extends 'template.tpl'}
{block 'contenido'}
{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<input type="hidden" id="IdiomaOriginal" value="{$IdiomaOriginal}"/>

        <div class="col-sm-9 col-md-9">
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
                <h3>{$lenguaje["elearning_label_editexam"]}</h3>
                <hr class="cursos-hr">
            </div>
            <div class=" col-xs-12">
                <div id="gestion_idiomas">
                {if isset($curso)}
                    {if  isset($idiomas) && count($idiomas)}
                        <ul class="nav nav-tabs " role="tablist">
                        {foreach from=$idiomas item=idi}
                            <li role="presentation" class="{if $examen.Idi_IdIdioma==$idi.Idi_IdIdioma} active {/if}">
                                <a class="idioma_s" id="idioma_{$idi.Idi_IdIdioma}" href="#" role="tab" data-toggle="tab">{$idi.Idi_Idioma}</a>
                                <input type="hidden" id="hd_idioma_{$idi.Idi_IdIdioma}" value="{$idi.Idi_IdIdioma}" />
                                <input type="hidden" id="idiomaTradu" value="{$curso.Idi_IdIdioma}"/>
                            </li>    
                        {/foreach}
                        </ul>
                               
                    {/if}
        <!-- <div style="width: 100%; margin: 0px auto"> -->
                <div id="replace_contenido">

                    {include 'editarexamen_gestion_idioma.tpl'}
                </div>
                {*
                    <form class="form-horizontal" style="margin-top: 15px" autocomplete="on" method="POST">
                        <input type="hidden" value="1" name="enviar" />
                        <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
                    
                        <div class="form-group">
                            <label class="col-xs-3 control-label">{$lenguaje["elearning_editexam_titulo"]}</label>
                            <div class="col-xs-9 ">
                                <input class="form-control" id ="titulo" type="text" name="titulo" value="{$examen.Exa_Titulo|default:""}" placeholder="Título"/>
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
                *}
                {/if}
            </div>
            </div>
        </div>
        
    

{/block}

<!-- <script type="text/javascript">
    Menu(1);
    RefreshTagUrl();
   $("#btn-guardar-examen").click(function(e){
  e.preventDefault();
  SubmitForm($("#frm_registro"), $(this), function(data, event){
    Mensaje("Exámen registrado con éxito", function(){
      CargarPagina("examen/preguntas", { id: $("#idcurso").val(), idleccion: $("#selectleccion").val()  }, false, false);
    })
  });
});

   $("body").on('change', "#selectmodulo", function () {      
        $("#cargando").show();
    $.post(_root_ + 'elearning/examen/actualizarlecciones',
    {
        id:$("#selectmodulo").val() 
        
    }, function (data) {
        $("#completar").html('');
        $("#cargando").hide();
        $("#completar").html(data);
    });
    });
</script> -->

