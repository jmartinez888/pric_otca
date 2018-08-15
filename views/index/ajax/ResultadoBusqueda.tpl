{foreach from=$resultadoBusqueda item=rb}
    <div style="margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid #ddd;" >
        <a class="busqueda-link" style="font-size: 18px; margin: 30px auto" data-toggle="tooltip" data-placement="top" target="_blank" title="{$_layoutParams.root_clear}{$rb[3]}{$rb[0]}" href="{$_layoutParams.root}{$rb[3]}{$rb[0]}"> 
            {$rb[1]}
        </a>  
        {if $rb[4] == 1}<span style="background-color:#00a65a;color: white;font-weight:  bold;font-size: 11px;" class="badge">{$lenguaje.buscador_tipo_registro1}</span>{/if}
        {if $rb[4] == 2}<span style="color: white;font-weight:  bold;font-size: 11px;" class="badge">{$lenguaje.buscador_tipo_registro2}</span>{/if}
        {if $rb[4] == 3}<span style="background-color:#00c0ef;color: white;font-weight:  bold;font-size: 11px;" class="badge">{$lenguaje.buscador_tipo_registro3}</span>{/if}
        {if $rb[4] == 4}<span style="background-color:#f39c12;color: white;font-weight:  bold;font-size: 11px;" class="badge">{$lenguaje.buscador_tipo_registro4}</span>{/if}                                   
            {if $rb[4] == 2} 
            <a style="color: #03A51E; line-height: 1.2;" data-toggle="tooltip" data-placement="top" href="{$_layoutParams.root}dublincore/documentos/descargar/{$rb[5]}/{$rb[6]}" target="_blank" title="{$lenguaje["icono_descargar_documentos"]} {$rb[7]}">
                <br>
                <img style="width: 20px" src="{$_layoutParams.root_clear}public/img/documentos/{$rb[7]}.png"/><b>&nbsp;{$lenguaje["icono_descargar_documentos"]} {$rb[7]}</a></b>
            {/if}
        <div>
            <spam>{$rb[2]}  ...</spam>
            
        </div>                                       
    </div>
{/foreach}                              
<div class="panel-footer" style="margin-bottom: 15px;">
    {$paginacion|default:""}
</div> 