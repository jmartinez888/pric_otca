<div  class="container-fluid" >   
    <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
        <h3 class="titulo-view">{$lenguaje.foro_admin_label_titulo}</h3>
    </div>
    <div class="panel panel-default">
        <p>{$lenguaje.foro_admin_label_descripcion}</p>   
        <div class="row">  
        <form method="POST">
            <div class="col-md-12">
                <div class="col-md-6 pull-left">
                    <a type="button" class="btn btn-primary btn-sm" href="{$_layoutParams.root}foro/admin/form/new" title="Crear nuevo Foro">Nuevo Foro</a>
                </div>
                    <div class="well-sm col-sm-12">
                        <div id="botones" class="btn-group pull-right">
                                <button type="submit" id="export_data_excel" name="export_data_excel" class="btn btn-info">EXCEL</button>
                                <button type="submit" id="export_data_csv" name="export_data_csv" class="btn btn-info">CSV</button>
                                <button type="submit" id="export_data_pdf" name="export_data_pdf" class="btn btn-info">PDF</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-offset-5 col-xs-3" > 
                            <select class="form-control" id="select_busqueda" name="select_busqueda">
                            <option value="">Todos</option>
                            {foreach item=itipo_foros from=$tipo_foros}
                                <option value='{$itipo_foros.For_Funcion}'>{$itipo_foros.For_Funcion}</option>
                            {/foreach}
                            </select>
                        </div>
                        <div class="col-xs-3">                            
                            <input id="text_busqueda" name="text_busqueda" type="text" class="form-control">
                        </div>
                        <div class="col-xs-2">
                            <button id="buscar_foro" class=" btn btn-primary" type="button"><i class="glyphicon glyphicon-search"></i></button>
                        </div>
                    </div>
            </div>
        </form>            
        <div id="listarForo" class="col-md-12" >
            {include file='modules/foro/views/admin/ajax/listarForo.tpl'}
        </div>
    </div>
</div>
