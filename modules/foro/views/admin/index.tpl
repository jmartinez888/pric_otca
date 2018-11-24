<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-top: 20px;">
        <h3 class="titulo">{$lenguaje.foro_admin_label_titulo}</h3>
    </div>
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <hr class="margin-t-10">
    </div>
</div>
<div class="panel panel-default">
    <div class="row">
        <form method="POST">
            <div class=" col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="well-sm col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <a type="button" class="btn btn-primary btn-sm" href="{$_layoutParams.root}foro/admin/form/new" title="Crear nuevo Foro">Nuevo Foro</a>
                </div>
                <div class="well-sm col-xs-6 col-sm-6 col-md-6 col-lg-6">
                    <div id="botones" class="btn-group pull-right">
                        <button type="submit" id="export_data_excel" name="export_data_excel" class="btn btn-info">EXCEL</button>
                        <button type="submit" id="export_data_csv" name="export_data_csv" class="btn btn-info">CSV</button>
                        <button type="submit" id="export_data_pdf" name="export_data_pdf" class="btn btn-info">PDF</button>
                    </div>
                </div>
                <div class="form-group row">
                    <div class="col-md-offset-6 col-lg-offset-6 col-xs-4 col-sm-4 col-md-2 col-lg-2" >
                        <select class="form-control" id="select_busqueda" name="select_busqueda">
                            <option value="">Todos</option>
                            {foreach item=itipo_foros from=$tipo_foros}
                            <option value='{$itipo_foros.For_Funcion}'>{$itipo_foros.For_Funcion}</option>
                            {/foreach}
                        </select>
                    </div>
                    <div class="col-xs-7 col-sm-7 col-md-3 col-lg-3">
                        <input id="text_busqueda" name="text_busqueda" type="text" class="form-control">
                    </div>
                    <div class="col col-xs-1 col-sm-1 col-md-1 col-lg-1">
                        <button id="buscar_foro" class=" btn btn-primary" type="button"><i class="glyphicon glyphicon-search"></i></button>
                    </div>
                </div>
            </div>
        </form>
        <div id="listarForo" class="col-xs-12 col-sm-12 col-md-12 col-lg-12" >
            {include file='modules/foro/views/admin/ajax/listarForo.tpl'}
        </div>
    </div>
</div>