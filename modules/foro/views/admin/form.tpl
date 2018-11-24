<div  class="margin-t-10" >
    {if $tipo == "new"}
    <div class="row">
        {if $Form_Funcion=="forum"}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">Nueva Discusión</h3>
        </div>
        
        {elseif $Form_Funcion=="webinar"}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">Nuevo Webinar</h3>
        </div>
        {elseif $Form_Funcion=="workshop"}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">Nuevo Workshop</h3>
        </div>
        {elseif $Form_Funcion=="query"}
        <h3 class="titulo">Nueva Consulta</h3>
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
                                <input type="radio"  name="idiomaRadio" id="idiomaRadio" value="{$idi.Idi_IdIdioma}"
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
                    <label for="text_titulo">Título</label>
                    <input type="text" placeholder="Ingrese Título del Foro" class="form-control" id="text_titulo" name="text_titulo" value="{$foro.For_Titulo|default:""}">
                </div>
                {if $Form_Funcion!="query"}
                <div class="form-group">
                    <label for="text_resumen">Resumen:</label>
                    <textarea type="text" placeholder="Ingrese Resumen del Foro" class="form-control" id="text_resumen" name="text_resumen">{$foro.For_Resumen|default:""}</textarea>
                </div>
                <div class="form-group">
                    <label for="text_palabras_claves">Etiquetas:</label>
                    <input type="text" placeholder="Ingrese etiquetas del Foro separadas por ," class="form-control" id="text_palabras_claves" name="text_palabras_claves" value="{$foro.For_PalabrasClaves|default:""}">
                </div>
                {/if}
                <div class="form-group">
                    <label for="text_descripcion">Descripción</label>
                    <textarea type="text" class="form-control" id="text_descripcion" name="text_descripcion">
                    {$foro.For_Descripcion|default:""}
                    </textarea>
                </div>
            </div>
            <div class="col-md-4 col-xs-12 col-sm-4 col-lg-4">
                {if !empty($foro_padre)}
                <div class="panel panel-default">
                    <div class="panel-heading"><label>Discusión Principal</label> </div>
                    <div class="panel-body">
                        
                        <a class="link-foro" href="http://pric.github:82/es/foro/index/ficha/52" target="_blank">
                            <strong>{$foro_padre.For_Titulo}</strong>
                        </a>                       
                        <p>
                           {if strlen($foro_padre.For_Resumen)>150}
                               {substr($foro_padre.For_Resumen, 0, 60)}...
                            {else}
                                {$foro_padre.For_Resumen}
                            {/if}
                        </p>
                        <div class="detalles-act-reciente f-z-14">{$foro_padre.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace {$foro_padre.tiempo} &nbsp;&nbsp;-&nbsp;&nbsp; {$foro_padre.votos} voto(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$foro_padre.For_TParticipantes|default:0} miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp;{$foro_padre.For_TComentarios|default:0} comentario(s)</div>
                        
                        
                    </div>
                </div>
                {/if}
                
                <div class="panel panel-default">
                    <div class="panel-heading panel_collapse" data-toggle="collapse" data-target="#panel_propiedades"><label>Propiedades de la Publicación</label> </div>
                    <div id="panel_propiedades" class="panel-body collapse in" >
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label for="s_lista_tematica" class="col-lg-3 control-label">Temática</label>
                                <div class="col-lg-8 col-md-6">
                                    <select style="cursor: pointer;" class="form-control" id="s_lista_tematica" name="s_lista_tematica">
                                        {foreach from=$linea_tematica item=item}
                                        <option style="cursor: pointer;" value="{$item.Lit_IdLineaTematica}" {if !empty($foro)&&$foro.Lit_IdLineaTematica==$item.Lit_IdLineaTematica}selected{/if}>{$item.Lit_Nombre}</option>
                                        {/foreach}
                                    </select>
                                </div>
                            </div>
                            {if $Form_Funcion!="query"}
                            <div class="form-group">
                                <label for="s_lista_entidad" class="col-lg-3 control-label">Entidad</label>
                                <div class="col-lg-8 col-md-6">
                                    <select class="form-control" id="s_lista_entidad" name="s_lista_entidad">
                                        {foreach from=$list_entidad item=item}
                                        <option value="{$item.Ent_IdEntidad}" 
                                        {if !empty($foro)&&$foro.Ent_Id_Entidad==1}selected{/if}>{$item.Ent_Siglas} - {$item.Ent_Nombre}</option>
                                        {/foreach}
                                        
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="text_date" class="col-lg-3 control-label">Fecha</label>
                                <div class="col-lg-8">
                                    <div class="checkbox">
                                        <label>
                                            <input id="cb_start_date" name="cb_start_date"  type="checkbox" value="" class="cb_select_fecha" div_time="start_date_div">
                                            Usar tiempo de publicación
                                        </label>
                                        <div id="start_date_div" class="input-group" style="display: none">
                                            <span class="input-group-btn">
                                                <button class="bt_start_time btn btn-default" type="button" title="Reiniciar ">
                                                <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                                <span class="sr-only">Calendario</span>
                                                </button>
                                            </span>
                                            <input id="start_time" class="form-control" name="start_time" type="text" value="" readonly>
                                            <span class="input-group-btn">
                                                <button class="bt_clear_start_time btn btn-default" type="button" title="Reiniciar ">
                                                <span class="glyphicon glyphicon-trash text-danger" aria-hidden="true"></span>
                                                <span class="sr-only">Reiniciar </span>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" id="cb_end_date" name="cb_end_date"  value="" class="cb_select_fecha" div_time="end_date_div">
                                            Usar tiempo de fin de publicación
                                        </label>
                                        <div id="end_date_div"  class="input-group" style="display: none">
                                            <span class="input-group-btn">
                                                <button class="bt_end_time btn btn-default" type="button" title="Reiniciar ">
                                                <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                                <span class="sr-only">Calendario</span>
                                                </button>
                                            </span>
                                            <input id="end_time" class="form-control" name="end_time" type="text" value="" readonly>
                                            <span class="input-group-btn">
                                                <button class="bt_clear_end_time btn btn-default" type="button" title="Reiniciar ">
                                                <span class="glyphicon glyphicon-trash text-danger" aria-hidden="true"></span>
                                                <span class="sr-only">Reiniciar </span>
                                                </button>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="s_lista_tipo" class="col-lg-3 control-label">Tipo</label>
                                <div class="col-lg-6 col-md-6">
                                    <select class="form-control" id="s_lista_tipo" name="s_lista_tipo">
                                        <option value="1"{if !empty($foro)&&$foro.For_Tipo==1}selected{/if}>Abierto</option>
                                        <option value="0"{if !empty($foro)&&$foro.For_Tipo==0}selected{/if}>Cerrado</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="s_lista_estado" class="col-lg-3 control-label">Visible</label>
                                <div class="col-lg-6 col-md-6">
                                    <select class="form-control" id="s_lista_estado" name="s_lista_estado">
                                        <option value="1"{if !empty($foro)&&$foro.For_Estado==1}selected{/if}>Público</option>
                                        <option value="0"{if !empty($foro)&&$foro.For_Estado==0}selected{/if}>Oculto</option>
                                    </select>
                                </div>
                            </div>
                            {/if}
                        </div>
                    </div>
                </div>
                <div class="panel panel-default status-upload">
                    <div class="panel-heading">
                        <div class="col col-xs-12 col-sm-12 col-md-4 col-lg-4">
                            <label>Materiales de Apoyo</label>
                        </div>
                        
                        <div class="col col-xs-12 col-sm-12 col-md-8 col-lg-8">
                          <ul class="pull-right">
                            <li><span title="PDF|DOC|PPT|Files" data-toggle="tooltip" data-placement="bottom" data-original-title="PDF|DOC|PPT|Files" class="form_fileinput" for="files_doc" ><i class="glyphicon glyphicon-file"></i> <input name="files_doc" type="file" multiple="" class="files_form"                                                                                                                                                            accept=".pptx, .pptm, .ppt, .pdf, .xps, .potx, .potm, .pot,.thmx, .ppsx, .ppsm, .pps, .ppam, .ppam, .ppa, .xml, .pptx,.pptx,.rar, .zip"></span></li>
                            <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"  class="form_fileinput" for="file_img"><i class="glyphicon glyphicon-picture"></i><input name="files_doc" type="file" multiple="" class="files_form" accept="image/*"></span></li>
                            <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"  class="form_fileinput" for="files_video"><i class="glyphicon glyphicon-facetime-video"></i><input name="files_doc" type="file" multiple="" class="files_form" accept="video/*"></span></li>
                            <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"  class="form_fileinput" for="files_son"><i class="glyphicon glyphicon-music"></i><input name="files_doc" type="file" multiple="" class="files_form" accept="audio/*"></span></li>
                        </ul>  
                        </div>
                        <div class="clearfix"></div>

                        <input id="hd_file_form" name="hd_file_form" type="hidden" value="">
                    </div>
                    {if !empty($foro)&&count($foro.Archivos)>0}
                    <div id="div_loading_file" class="panel-body load_files d-block">
                        {foreach from=$foro.Archivos key=key item=file}
                        <div class="files" tabindex="-1" id="">
                            <input id="file-e{$key}" name="attach_form" type="hidden" value="{$file.Fif_NombreFile}" checked="" f-size="{$file.Fif_SizeFile}" f-type="{$file.Fif_TipoFile}">
                            <div class="file_titulo">{$file.Fif_NombreFile}</div>
                            {$Fif_SizeFile=$file.Fif_SizeFile/1024}
                            <div class="file_size">({if $Fif_SizeFile<1}{$Fif_SizeFile|string_format:"%.3f"} K {else} {$Fif_SizeFile=$Fif_SizeFile/1024} {$Fif_SizeFile|string_format:"%.3f"} M{/if})</div>
                            <div class="file_loading off"></div>
                            <div role="button" class="file_close" tabindex="-1"></div>
                        </div>
                        {/foreach}
                    </div>
                    {else}
                    <div id="div_loading_file" class="panel-body load_files d-none">
                    </div>
                    {/if}
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading"><label>Publicar</label> </div>
                    <div class="panel-body">
                        {if !empty($foro_padre)}
                        <a id="bt_regresar" name="bt_regresar" class="btn btn-link"
                            href="{$_layoutParams.root}foro/index/ficha/{$iFor_IdPadre}"
                        >Regresar</a>
                        {else}
                        <a id="bt_regresar" name="bt_regresar" class="btn btn-link"
                            href="{$_layoutParams.root}foro/index/{$Form_Funcion}"
                        >Regresar</a>
                        {/if}
                        <button id="bt_guardar" name="bt_guardar" type="submit" class="btn btn-primary  pull-right">Guardar</button>
                    </div>
                    <div class="panel-heading">
                    </div>
                </div>
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
            <h3 class="titulo">Editar Discusión</h3>
        </div>
        
        {elseif $Form_Funcion=="webinar"}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">Editar Webinar</h3>
        </div>
        {elseif $Form_Funcion=="workshop"}
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">Editar Workshop</h3>
        </div>
        {elseif $Form_Funcion=="query"}
        <h3 class="titulo">Editar Consulta</h3>
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
    <div id='gestion_idiomas'>
        <div class="row">
            <form method="post" >
                <input type="hidden" id="IdiomaOriginal" name="IdiomaOriginal" value="{$IdiomaOriginal}" />
                <input type="hidden" id="idForo" name="idForo" value="{$idForo}" />
                <input type="hidden" id="Form_Funcion" name="Form_Funcion" value="{$Form_Funcion}" />
                <input type="hidden" id="Idiomaseleccionado" name="Idiomaseleccionado" value="{$Idiomaseleccionado}" />
                <div class="col-md-8">
                    <div style="margin-bottom: 25px;" class="form-group" >
                        {if isset($foro) && count($foro)}
                        {if  isset($idiomas) && count($idiomas)}
                        <ul class="nav nav-tabs ">
                            {foreach from=$idiomas item=idi}
                            <li role="presentation" class="{if $foro.Idi_IdIdioma==$idi.Idi_IdIdioma} active {/if}">
                                <a class="idioma_s" id="idioma_{$idi.Idi_IdIdioma}" href="#">{$idi.Idi_Idioma}</a>
                                <input type="hidden" id="hd_idioma_{$idi.Idi_IdIdioma}" value="{$idi.Idi_IdIdioma}" />
                                <input type="hidden" id="idiomaTradu" value="{$foro.Idi_IdIdioma}"/>
                            </li>
                            {/foreach}
                        </ul>
                        {/if}
                        {/if}
                    </div>
                    <div class="form-group">
                        <label for="text_titulo">Título</label>
                        <input type="text" placeholder="Ingrese Título del Foro" class="form-control" id="text_titulo" name="text_titulo" value="{$foro.For_Titulo|default:""}">
                    </div>
                    {if $Form_Funcion!="query"}
                    <div class="form-group">
                        <label for="text_resumen">Resumen:</label>
                        <textarea type="text" placeholder="Ingrese Resumen del Foro" class="form-control" id="text_resumen" name="text_resumen">{$foro.For_Resumen|default:""}</textarea>
                    </div>
                    <div class="form-group">
                        <label for="text_palabras_claves">Etiquetas:</label>
                        <input type="text" placeholder="Ingrese etiquetas del Foro separadas por ," class="form-control" id="text_palabras_claves" name="text_palabras_claves" value="{$foro.For_PalabrasClaves|default:""}">
                    </div>
                    {/if}
                    <div class="form-group">
                        <label for="text_descripcion">Descripción</label>
                        <textarea type="text" class="form-control" id="text_descripcion" name="text_descripcion">
                        {$foro.For_Descripcion|default:""}
                        </textarea>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="panel panel-default">
                        <div class="panel-heading panel_collapse" data-toggle="collapse" data-target="#panel_propiedades"><label>Propiedades de la Publicación</label> </div>
                        <div id="panel_propiedades" class="panel-body collapse in" >
                            <div class="form-horizontal">
                                <div class="form-group">
                                    <label for="s_lista_tematica" class="col-lg-3 control-label">Temática</label>
                                    <div class="col-lg-8 col-md-6">
                                        <select style="cursor: pointer;" class="form-control" id="s_lista_tematica" name="s_lista_tematica">
                                            {foreach from=$linea_tematica item=item}
                                            <option style="cursor: pointer;" value="{$item.Lit_IdLineaTematica}" {if !empty($foro)&&$foro.Lit_IdLineaTematica==$item.Lit_IdLineaTematica}selected{/if}>{$item.Lit_Nombre}</option>
                                            {/foreach}
                                        </select>
                                    </div>
                                </div>
                                {if $Form_Funcion!="query"}
                                <div class="form-group">
                                    <label for="s_lista_entidad" class="col-lg-3 control-label">Entidad</label>
                                    <div class="col-lg-8 col-md-6">
                                         <select class="form-control" id="s_lista_entidad" name="s_lista_entidad">
                                        {foreach from=$list_entidad item=item}
                                        <option value="{$item.Ent_IdEntidad}" 
                                        {if !empty($foro)&&$foro.Ent_Id_Entidad==$item.Ent_IdEntidad}selected{/if}>{$item.Ent_Siglas} - {$item.Ent_Nombre}</option>
                                        {/foreach}
                                        
                                    </select>                                        
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="text_date" class="col-lg-3 control-label">Fecha</label>
                                    <div class="col-lg-8">
                                        <div class="checkbox">
                                            <label>
                                                <input id="cb_start_date" name="cb_start_date"  type="checkbox" value="" class="cb_select_fecha" div_time="start_date_div">
                                                Usar tiempo de publicación
                                            </label>
                                            <div id="start_date_div" class="input-group" style="display: none">
                                                <span class="input-group-btn">
                                                    <button class="bt_start_time btn btn-default" type="button" title="Reiniciar ">
                                                    <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                                    <span class="sr-only">Calendario</span>
                                                    </button>
                                                </span>
                                                <input id="start_time" class="form-control" name="start_time" type="text" value="" readonly>
                                                <span class="input-group-btn">
                                                    <button class="bt_clear_start_time btn btn-default" type="button" title="Reiniciar ">
                                                    <span class="glyphicon glyphicon-trash text-danger" aria-hidden="true"></span>
                                                    <span class="sr-only">Reiniciar </span>
                                                    </button>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="checkbox">
                                            <label>
                                                <input type="checkbox" id="cb_end_date" name="cb_end_date"  value="" class="cb_select_fecha" div_time="end_date_div">
                                                Usar tiempo de fin de publicación
                                            </label>
                                            <div id="end_date_div"  class="input-group" style="display: none">
                                                <span class="input-group-btn">
                                                    <button class="bt_end_time btn btn-default" type="button" title="Reiniciar ">
                                                    <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                                    <span class="sr-only">Calendario</span>
                                                    </button>
                                                </span>
                                                <input id="end_time" class="form-control" name="end_time" type="text" value="" readonly>
                                                <span class="input-group-btn">
                                                    <button class="bt_clear_end_time btn btn-default" type="button" title="Reiniciar ">
                                                    <span class="glyphicon glyphicon-trash text-danger" aria-hidden="true"></span>
                                                    <span class="sr-only">Reiniciar </span>
                                                    </button>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="form-group">
                                    <label for="s_lista_tipo" class="col-lg-3 control-label">Tipo</label>
                                    <div class="col-lg-6 col-md-6">
                                        <select class="form-control" id="s_lista_tipo" name="s_lista_tipo">
                                            <option value="1"{if !empty($foro)&&$foro.For_Tipo==1}selected{/if}>Abierto</option>
                                            <option value="0"{if !empty($foro)&&$foro.For_Tipo==0}selected{/if}>Cerrado</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label for="s_lista_estado" class="col-lg-3 control-label">Visible</label>
                                    <div class="col-lg-6 col-md-6">
                                        <select class="form-control" id="s_lista_estado" name="s_lista_estado">
                                            <option value="1"{if !empty($foro)&&$foro.For_Estado==1}selected{/if}>Público</option>
                                            <option value="0"{if !empty($foro)&&$foro.For_Estado==0}selected{/if}>Oculto</option>
                                        </select>
                                    </div>
                                </div>
                                {/if}
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default status-upload">
                        <div class="panel-heading">
                            <label>Materiales de Apoyo</label>
                            <ul class="pull-right">
                                <li><span title="PDF|DOC|PPT|Files" data-toggle="tooltip" data-placement="bottom" data-original-title="PDF|DOC|PPT|Files" class="form_fileinput" for="files_doc" ><i class="glyphicon glyphicon-file"></i> <input name="files_doc" type="file" multiple="" class="files_form"                                                                                                                                                            accept=".pptx, .pptm, .ppt, .pdf, .xps, .potx, .potm, .pot,.thmx, .ppsx, .ppsm, .pps, .ppam, .ppam, .ppa, .xml, .pptx,.pptx,.rar, .zip"></span></li>
                                <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"  class="form_fileinput" for="file_img"><i class="glyphicon glyphicon-picture"></i><input name="files_doc" type="file" multiple="" class="files_form" accept="image/*"></span></li>
                                <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"  class="form_fileinput" for="files_video"><i class="glyphicon glyphicon-facetime-video"></i><input name="files_doc" type="file" multiple="" class="files_form" accept="video/*"></span></li>
                                <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"  class="form_fileinput" for="files_son"><i class="glyphicon glyphicon-music"></i><input name="files_doc" type="file" multiple="" class="files_form" accept="audio/*"></span></li>
                            </ul>
                            <input id="hd_file_form" name="hd_file_form" type="hidden" value="">
                        </div>
                        {if !empty($foro)&&count($foro.Archivos)>0}
                        <div id="div_loading_file" class="panel-body load_files d-block">
                            {foreach from=$foro.Archivos key=key item=file}
                            <div class="files" tabindex="-1" id="">
                                <input id="file-e{$key}" name="attach_form" type="hidden" value="{$file.Fif_NombreFile}" checked="" f-size="{$file.Fif_SizeFile}" f-type="{$file.Fif_TipoFile}">
                                <div class="file_titulo">{$file.Fif_NombreFile}</div>
                                {$Fif_SizeFile=$file.Fif_SizeFile/1024}
                                <div class="file_size">({if $Fif_SizeFile<1}{$Fif_SizeFile|string_format:"%.3f"} K {else} {$Fif_SizeFile=$Fif_SizeFile/1024} {$Fif_SizeFile|string_format:"%.3f"} M{/if})</div>
                                <div class="file_loading off"></div>
                                <div role="button" class="file_close" tabindex="-1"></div>
                            </div>
                            {/foreach}
                        </div>
                        {else}
                        <div id="div_loading_file" class="panel-body load_files d-none">
                        </div>
                        {/if}
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading"><label>Publicar</label> </div>
                        <div class="panel-body">
                            {if !empty($foro)}
                            <a id="bt_regresar" name="bt_regresar" class="btn btn-link"
                                href="{$_layoutParams.root}foro/index/ficha/{$idForo}"
                            >Regresar</a>
                            {else}
                            <a id="bt_regresar" name="bt_regresar" class="btn btn-link"
                                href="{$_layoutParams.root}foro/index/{$Form_Funcion}"
                            >Regresar</a>
                            {/if}
                            {if !empty($foro)}
                            <a target="_blank" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}" class="btn btn-default pull-right" style="    margin-left: 10px;">Vista Previa</a>
                            {/if}
                            <button id="bt_guardar" name="bt_guardar" type="submit" class="btn btn-primary pull-right">Guardar</button>
                        </div>
                        <div class="panel-heading">
                        </div>
                    </div>
                </div>
                <input type="hidden" id="hd_id_padre" name="hd_id_padre" value="{$iFor_IdPadre|default:0}">
                <input type="hidden" id="hd_id_recurso" name="hd_id_recurso" value="{$foro.Rec_IdRecurso|default:0}">
            </form>
        </div>
    </div>
    {/if}
</div>
<script>
startDate='{$start_date}';
endDate='{$end_date}';
</script>