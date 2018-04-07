<div  class="container" >   
    <h3 class="titulo-view">{$lenguaje.foro_index_label_titulo}</h3>
    <p>{$lenguaje.foro_index_label_descripcion}</p>   
    <div class="row">
        {foreach from=$lista_foros item=foro}
            <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4">
                <div class="page-header">
                    <a href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">               
                    <h4>{$foro.For_Titulo}</h4>                               
                    </a>
                </div>
                <div class="row">
                        <div class="col-md-12">
                            <p>{$foro.For_Objetivo}</p>
                        </div>

                         <div class="col-md-6">
                             <span>{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"} - {$foro.For_FechaCierre|date_format:"%d-%m-%Y"}</span>
                        </div>
                        <div class="col-md-6 text-right">
                            Colaboraciones <span class="badge">{$foro.For_TComentarios}</span> 
                        </div>
                </div>
            </div>
        {/foreach}
    </div>
  
</div>