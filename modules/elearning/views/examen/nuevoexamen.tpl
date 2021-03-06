{extends 'template.tpl'}
{block 'contenido'}
{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-xs-12 col-sm-12 col-md-9 col-lg-10">
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
        <h3>{$lang->get("elearning_nuevo_examenT")}</h3> 
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <form class="form-horizontal" autocomplete="on" method="POST">
            <input type="hidden" value="1" name="enviar" />
            <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">

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
           
            <div class="form-group">
                <label class="col-lg-3 control-label">{$lang->get("elearning_examen_titulo")} :</label>
                <div class="col-lg-9">
                    <p><input class="form-control" id ="titulo" type="text" name="titulo" value="{$datos.nombre|default:""}" placeholder={$lang->get("elearning_examen_titulo")}></p>
                </div>
            </div>
            
            {if isset($idLeccion) && $idLeccion > 0}
                <div class="form-group">
                    <label class="col-lg-3 control-label">{$lang->get("elearning_examen_modulo")}</label>
                    <div class="col-lg-9">
                        <p>
                          <select class="form-control" id="selectmodulo" name="selectmodulo" >
                            {if isset($modulos) && count($modulos)}
                            <option value="0">{$lang->get("elearning_seleccione_modulo")}</option>
                            {foreach item=ll from=$modulos}
                                <option {if $leccion.Moc_IdModuloCurso == $ll.Moc_IdModuloCurso} selected="selected" {/if} value="{$ll.Moc_IdModuloCurso}">{$ll.Moc_Titulo}</option>
                            {/foreach}
                            {/if}
                          </select>
                        </p>
                    </div>
                </div>
                <div id="completar">
                {if isset($lecciones) && count($lecciones)}
                    <div class="form-group">
                        <label class="col-xs-3 control-label">{$lang->get("elearning_nuevo_examen_leccion")}</label>
                        <div class="col-xs-9">
                            <select class="form-control" id="selectleccion" name="selectleccion" >
                                {foreach item=ll from=$lecciones}
                                    <option value="{$ll.Lec_IdLeccion}" {if $leccion.Lec_IdLeccion == $ll.Lec_IdLeccion} selected="selected" {/if}>{$ll.Lec_Titulo}</option>
                                {/foreach}
                            </select>
                        </div>
                    </div>  
                    <div class="form-group">
                        <label class="col-xs-3 control-label">{$lang->get("elearning_nuevo_porcentaje")}</label>
                        <div class="col-xs-9">
                            <input data-toggle="tooltip" data-placement="bottom" title="{$lang->get("elearning_nuevo_examen_porcentaje2")}{$porcentaje}" class="form-control" id ="porcentaje" type="number" name="porcentaje" value="{$examen.Exa_Porcentaje|default:'0'}" placeholder="{$lang->get('str_porcentaje')}" max="{$porcentaje}" min="0" value="0"/>
                        </div>
                    </div>   
                    <div class="form-group">
                        <label class="col-xs-3 control-label">{$lang->get("elearning_nuevo_examen_puntajeMax")}</label>
                        <div class="col-xs-9">
                            <p class="  margin-t-10"> <input type="radio" value="20" class="radioalt " name="puntaje" checked="checked" />  20</p>
                            <p class=" margin-t-10"> <input type="radio" value="100" class="radioalt " name="puntaje"/>
                             100</p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-3 control-label">{$lang->get("elearning_nuevo_examen_NumeroI")}</label>
                        <div class="col-xs-9">
                            <select class="form-control" id="intentos" name="intentos">          
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="5">5</option>
                                <option value="10">10</option>
                                <option value="0">{$lang->get("elearning_nuevo_examen_ilimitado")}</option>
                            </select>
                        </div>
                    </div>
                {else}
                    <center>{$lang->get("elearning_nuevo_examen_LeccionesNo")}<center>
                {/if}
                </div>
            {else}
                <div class="form-group">
                    <label class="col-lg-3 control-label">{$lang->get("elearning_nuevo_examen_modulo")}</label>
                    <div class="col-lg-9">
                        <p>
                          <select class="form-control" id="selectmodulo" name="selectmodulo">
                            {if isset($modulos) && count($modulos)}
                            <option value="0">{$lang->get("elearning_nuevo_examen_seleccionM")}</option>
                            {foreach item=ll from=$modulos}
                                <option value="{$ll.Moc_IdModuloCurso}">{$ll.Moc_Titulo}</option>
                            {/foreach}
                            {/if}
                          </select>
                        </p>
                    </div>
                </div>
                <div id="completar">

                </div>
            {/if}

            <div class="form-group">
                <div class="col-lg-offset-2 col-lg-10">
                 <button class="btn btn-success pull-right margin-top-10" id="guardar" name="guardar">{$lang->get("elearning_nuevo_examen_Bguardar")}</button>
                </div>
            </div>
        </form>
    </div>
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

