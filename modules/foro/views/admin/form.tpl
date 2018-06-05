<div  class="container" >   
    {if $Form_Funcion=="forum"}
    <h3 class="titulo-view">{$lenguaje.foro_admin_form_label_titulo}</h3>
    {elseif $Form_Funcion=="webinar"}
       <h3 class="titulo-view">Nuevo Webinar</h3> 
    {elseif $Form_Funcion=="workshop"}
        <h3 class="titulo-view">Nuevo WorkShop</h3> 
    {elseif $Form_Funcion=="query"}       
        <h3 class="titulo-view">Nueva Consulta!.. </h3> 
    {/if}
    <div class="row">
        <form method="post" >
            <div class="col-md-8">
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
                    <div class="panel-heading"><label>Publicar</label> </div>
                    <div class="panel-body">
                        <button class="btn btn-default pull-left">Vista Previa</button>
                        <button id="bt_guardar" name="bt_guardar" type="submit" class="btn btn-primary pull-right">Guardar</button>
                    </div>
                    <div class="panel-heading">
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading panel_collapse" data-toggle="collapse" data-target="#panel_propiedades"><label>Propiedades de la Publicación</label> </div>
                    <div id="panel_propiedades" class="panel-body collapse in" >
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label for="s_lista_tematica" class="col-lg-3 control-label">Temática</label>
                                <div class="col-lg-8 col-md-6">
                                    <select class="form-control" id="s_lista_tematica" name="s_lista_tematica">
                                        <option value="1" {if !empty($foro)&&$foro.Lit_IdLineaTematica==1}selected{/if}>Bosques</option>
                                        <option value="2" {if !empty($foro)&&$foro.Lit_IdLineaTematica==2}selected{/if}>Recursos Hidricos</option>
                                        <option value="3" {if !empty($foro)&&$foro.Lit_IdLineaTematica==3}selected{/if}>Cites</option>                                       
                                    </select>
                                </div>
                            </div>
                            {if $Form_Funcion!="query"} 
                            <div class="form-group">
                                <label for="s_lista_entidad" class="col-lg-3 control-label">Entidad responsable</label>
                                <div class="col-lg-8 col-md-6">
                                    <select class="form-control" id="s_lista_entidad" name="s_lista_entidad">
                                        <option value="1" {if !empty($foro)&&$foro.Ent_Id_Entidad==1}selected{/if}>OTCA</option>
                                        <option value="2" {if !empty($foro)&&$foro.Ent_Id_Entidad==2}selected{/if}>IIAP</option>
                                        <option value="3" {if !empty($foro)&&$foro.Ent_Id_Entidad==3}selected{/if}>ANA-BRASIL</option>                                       
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
            </div>
            <input type="hidden" id="hd_id_padre" name="hd_id_padre" value="{$iFor_IdPadre|default:0}">
            <input type="hidden" id="hd_id_recurso" name="hd_id_recurso" value="{$foro.Rec_IdRecurso|default:0}">
        </form>
    </div>
</div>
<script>
 startDate='{$start_date}';
 endDate='{$end_date}';

</script>