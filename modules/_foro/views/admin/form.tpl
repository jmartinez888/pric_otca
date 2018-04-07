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
                                <label for="text_date" class="col-lg-3 control-label">Fecha Cierre</label>
                                <div class="col-lg-8">
                                    <input type="daytime" class="form-control" id="text_date" name="text_date"
                                           placeholder="dd/mm/yyyy hh:mm">
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