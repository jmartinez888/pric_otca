<div  class="container" >   
    <h3 class="titulo-view">{$lenguaje.foro_admin_label_titulo}</h3>
    <p>{$lenguaje.foro_admin_label_descripcion}</p>   
    <div class="row">  
        <div class="col-md-12">
            <div class="col-md-6 pull-left">
                <a type="button" class="btn btn-primary btn-sm" href="{$_layoutParams.root}foro/admin/form/new" title="Crear nuevo Foro">Nuevo Foro</a>
            </div>
            <div class="col-md-4 pull-right">
                <div class="input-group">
                    <input id="text_busqueda" type="text" class="form-control">
                    <span class="input-group-btn">
                        <button id="buscar_foro" class="btn btn-default" type="button">Buscar</button>
                    </span>
                </div>
            </div>

        </div>
        <div id="listarForo" class="col-md-12" >
            {include file='modules/foro/views/admin/ajax/listarForo.tpl'}
        </div>
    </div>
</div>