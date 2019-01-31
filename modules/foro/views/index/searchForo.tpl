<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">
        <h2 class="titulo">{$lenguaje.foro_index_str_buscar_foro}</h2>
        <div class="col-md-12 col-xs-12 col-sm-8 col-lg-12 p-rt-lt-0">
            <hr class="cursos-hr-title-foro">
        </div>
        <div class="row">
            <div class="col-md-offset-6 col-lg-offset-6 col-md-6 col-xs-12 col-sm-12 col-lg-6">
                <div class="input-group">
                    <input type ="text" class="form-control"  data-toggle="tooltip" data-original-title="Buscar Foro" placeholder="Buscar en Foro" name="text_busqueda" id="text_busqueda" onkeypress="tecla_enter_foro(event)" value="{$search|default:''}">
                    <span class="input-group-btn">
                        <button class="btn  btn-success btn-buscador" type="button" id="buscar_foro"><i class="glyphicon glyphicon-search"></i></button>
                    </span>
                    </div><!-- /input-group -->
                </div>
                <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12" style="margin-top: 15px;">
                    <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
                         <input type="hidden" name="hdd_tipo" id="hdd_tipo" value="">
                         <div  id="lista_search" class="row">
                           {include file='modules/foro/views/index/ajax/lista_search.tpl'}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>