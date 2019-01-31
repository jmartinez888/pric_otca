<div  class="margin-t-10" >
    {if $tipo == "new"}
    <div class="row">
        {if $Form_Funcion=="forum"}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">{$lenguaje.foro_discusion_nueva_discusion}</h3>
        </div>
        
        {elseif $Form_Funcion=="webinar"}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">{$lenguaje.foro_discusion_nuevo_webinar}</h3>
        </div>
        {elseif $Form_Funcion=="workshop"}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">{$lenguaje.foro_discusion_nuevo_workshop}</h3>
        </div>
        {elseif $Form_Funcion=="query"}
        <h3 class="titulo">{$lenguaje.foro_discusion_nueva_consulta}</h3>
        {/if}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12 p-rt-lt-0">
            <hr class="foro-hr-title-form">
        </div>
    </div>
    <div class="row">
        <form method="post" >
            <div class="col-md-8 col-xs-12 col-sm-8 col-lg-8">
                <div class="form-group" >
                    <label class="col col-md-2 col-xs-2 col-sm-2 col-lg-2 control-label">{$lenguaje.foro_admin_label_idioma}: </label>
                    {if  isset($idiomas) && count($idiomas)}
                    <div class="col form-inline col-md-10 col-xs-10 col-sm-10 col-lg-10">
                        {foreach from=$idiomas item=idi}
                        {if  isset($datos) && count($datos)}
                        {if $datos.Idi_IdIdioma==$idi.Idi_IdIdioma}
                        <input type="hidden" value="{$idi.Idi_IdIdioma}" name="idiomaRadio">
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
                                <input type="radio"  name="idiomaRadio"  value="{$idi.Idi_IdIdioma}"
                                {if isset($idiomaUrl) && $idiomaUrl == $idi.Idi_IdIdioma } checked="checked" {/if} required>
                                {$idi.Idi_Idioma}
                            </label>
                        </div>
                        {/if}
                        {/foreach}
                    </div>
                    {/if}
                    <div class="clearfix"></div>
                </div>
                <div class="form-group">
                    <label for="text_titulo">{$lenguaje.foro_form_titulo}:</label>
                    <input type="text" placeholder="Ingrese Título del Foro" class="form-control" id="text_titulo" name="text_titulo" value="{$foro.For_Titulo|default:""}">
                </div>
                {if $Form_Funcion!="query"}
                <div class="form-group">
                    <label for="text_resumen">{$lenguaje.foro_form_resumen}:</label>
                    <textarea type="text" placeholder="Ingrese Resumen del Foro" class="form-control" id="text_resumen" name="text_resumen">{$foro.For_Resumen|default:""}</textarea>
                </div>
                <div class="form-group">
                    <label for="text_palabras_claves">{$lenguaje.foro_form_etiquetas}:</label>
                    <input type="text" placeholder="Ingrese etiquetas del Foro separadas por ," class="form-control" id="text_palabras_claves" name="text_palabras_claves" value="{$foro.For_PalabrasClaves|default:""}">
                </div>
                {/if}
                <div class="form-group">
                    <label for="text_descripcion">{$lenguaje.foro_form_descripcion}</label>
                    <textarea type="text" class="form-control" id="text_descripcion" name="text_descripcion">
                    {$foro.For_Descripcion|default:""}
                    </textarea>
                </div>
            </div>
            <div id="div_foro_propiedades"  class="col-md-4 col-xs-12 col-sm-4 col-lg-4">
                {include file='modules/foro/views/admin/ajax/include_foro_propiedades.tpl'}
            </div>
            <input type="hidden" id="hd_id_padre" name="hd_id_padre" value="{$iFor_IdPadre|default:0}">
            <input type="hidden" id="hd_id_recurso" name="hd_id_recurso" value="{$foro.Rec_IdRecurso|default:0}">
        </form>
    </div>
    {/if}
    {if $tipo == "edit"}
    <div class="row">
        {if $Form_Funcion=="forum"}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">{$lenguaje.foro_form_editardiscusion}</h3>
        </div>
        
        {elseif $Form_Funcion=="webinar"}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">{$lenguaje.foro_form_editarwebinar}</h3>
        </div>
        {elseif $Form_Funcion=="workshop"}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">{$lenguaje.foro_form_editarworkshop}</h3>
        </div>
        {elseif $Form_Funcion=="query"}
        <h3 class="titulo">{$lenguaje.foro_form_editarconsulta}</h3>
        {/if}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12 p-rt-lt-0">
            <hr class="foro-hr-title-form">
        </div>
    </div>
    <!--    <form method="post" >
        <input type="text" id="idIdiomaOriginal" name="idIdiomaOriginal" value="{$idIdiomaOriginal}" />
        <input type="text" id="idForo" name="idForo" value="{$idForo}" />
        <input type="text" id="$Form_Funcion" name="$Form_Funcion" value="{$Form_Funcion}" />
    </form> -->
        <div class="row">
            <form method="post" >
                <input type="hidden" id="IdiomaOriginal" name="IdiomaOriginal" value="{$IdiomaOriginal}" />
                <input type="hidden" id="idForo" name="idForo" value="{$idForo}" />
                <input type="hidden" id="Form_Funcion" name="Form_Funcion" value="{$Form_Funcion}" />
                <div id="gestion_idiomas" class="col-md-8 col-xs-12 col-sm-8 col-lg-8">
                {include file='modules/foro/views/admin/ajax/gestion_idiomas.tpl'}
                </div>
                <div id="div_foro_propiedades" class="col-md-4 col-xs-12 col-sm-4 col-lg-4">
                   {include file='modules/foro/views/admin/ajax/include_foro_propiedades.tpl'}
                </div>
                <input type="hidden" id="hd_id_padre" name="hd_id_padre" value="{$iFor_IdPadre|default:0}">
                <input type="hidden" id="hd_id_recurso" name="hd_id_recurso" value="{$foro.Rec_IdRecurso|default:0}">
            </form>
        </div>
    {/if}
</div>
<!--  Modal nueva entidad-->
<div class="modal fade top-space-0" id="modal-nueva-entidad" tabindex="-1" role="dialog">
    <div class="modal-dialog login-dialog">
        <div class="modal-content">
            <div class="modal-body" >
                <div class="row">
                    <div class="col-md-12 col-xs-12 col-lg-12 col-sm-12">
                        <h2>{$lenguaje.foro_form_nuevaentidad}</h2>
                        <hr>
                        <div class="form-group" >
                            <div class="form-group">
                                <label for="text_resumen">{$lenguaje.foro_form_nombre}:</label>
                                <input type="text" placeholder="Ingrese nombre de la entidad" class="form-control" id="text_nombre_entidad" name="text_nombre_entidad">
                            </div>
                            <div class="form-group">
                                <label for="text_palabras_claves">{$lenguaje.foro_form_siglas}:</label>
                                <input type="text" placeholder="Ingrese siglas  de la entidad" class="form-control" id="text_siglas_entidad" name="text_siglas_entidad" >
                            </div>
                            <button id="bt_guardar_entidad" name="bt_guardar_entidad" type="button" class="btn btn-primary  pull-right">{$lenguaje.foro_form_guardar}</button>
                            
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
startDate='{$start_date}';
endDate='{$end_date}';
</script>