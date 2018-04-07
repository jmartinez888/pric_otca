<div  class="container" >   
    <h3 class="titulo-view">{$lenguaje.foro_admin_form_label_titulo}</h3>
    <div class="row">
        <form method="post" >
            <div class="col-md-8">

                <div class="form-group">
                    <label for="text_titulo">Título</label>
                    <input type="text" placeholder="Ingrese Título del Foro" class="form-control" id="text_titulo" name="text_titulo">
                </div>
                <div class="form-group">
                    <label for="text_objetivo">Objetivo:</label>
                    <textarea type="text" placeholder="Ingrese Objetivo del Foro" class="form-control" id="text_objetivo" name="text_objetivo"></textarea>
                </div>
                <div class="form-group">
                    <label for="text_palabras_claves">Etiquetas:</label>
                    <input type="text" placeholder="Ingrese etiquetas del Foro separadas por ," class="form-control" id="text_palabras_claves" name="text_palabras_claves">
                </div>
                <div class="form-group">
                    <label for="text_resultados_e">Resultados Esperados:</label>
                    <textarea type="text" class="form-control" id="text_resultados_e" name="text_resultados_e"></textarea>
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
                    <div class="panel-heading panel_collapse" data-toggle="collapse" data-target="#panel_propiedades"><label>Propiedades del Foro</label> </div>
                    <div id="panel_propiedades" class="panel-body collapse in" >
                        <div class="form-horizontal">
                            <div class="form-group">
                                <label for="s_lista_tematica" class="col-lg-3 control-label">Temática</label>
                                <div class="col-lg-8 col-md-6">
                                    <select class="form-control" id="s_lista_tematica" name="s_lista_tematica">
                                        <option value="1">Bosques</option>
                                        <option value="2">Recursos Hidricos</option>
                                        <option value="3">Cites</option>                                       
                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="s_lista_entidad" class="col-lg-3 control-label">Entidad responsable</label>
                                <div class="col-lg-8 col-md-6">
                                    <select class="form-control" id="s_lista_tematica" name="s_lista_tematica">
                                        <option value="1">OTCA</option>
                                        <option value="2">IIAP</option>
                                        <option value="3">ANA-BRASIL</option>                                       
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
                                    <select class="form-control" id="s_lista_tipo">
                                        <option value="1">Abierto</option>
                                        <option value="0">Cerrado</option>

                                    </select>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="s_lista_estado" class="col-lg-3 control-label">Visible</label>
                                <div class="col-lg-6 col-md-6">
                                    <select class="form-control" id="s_lista_estado" name="s_lista_estado">
                                        <option value="1">Público</option>
                                        <option value="0">Oculto</option>

                                    </select>
                                </div>
                            </div>

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
                    <div id="div_loading_file" class="panel-body load_files d-none">

                    </div>
                </div>  
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div>
                            <label>Miembros</label>
                            <a class="pull-right">Asignar</a>
                        </div>  
                    </div>   
                </div>  
            </div>
        </form>
    </div>
</div>
<script>
 startDate='{$start_date}';
 endDate='{$end_date}';
</script>