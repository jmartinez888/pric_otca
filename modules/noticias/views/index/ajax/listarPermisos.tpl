
<!-- <div style="position:fixed; width:75%; margin: 0px auto; z-index:150 ">
    {if isset($_error)}
        <div id="_errl" class="alert alert-error " >
            <a class="close " data-dismiss="alert">X</a>
            {$_error}
        </div>
    {/if}
    {if isset($_mensaje)}
        <div id="_msgl" class="alert alert-success" >
            <a class="close" data-dismiss="alert">X</a>
            {$_mensaje}
        </div>
    {/if}             
</div>   -->

{if isset($permisos) && count($permisos)}
<div class="table-responsive">
    <table class="table" style="  margin: 20px auto">
        <tr>
            <th style=" text-align: center">{$lenguaje.label_n}</th>
            <th >{$lenguaje.label_permiso} </th>
            <th >Módulo</th>
            <th style=" text-align: center">{$lenguaje.label_clave}</th>
            <th style=" text-align: center">{$lenguaje.label_estado}</th>                          
            {if $_acl->permiso("editar_rol")}
            <th style=" text-align: center">{$lenguaje.label_opciones}</th>
            {/if}
        </tr>
        {foreach item=rl from=$permisos}
            <tr {if $rl.Row_Estado==0}
                    {if $_acl->permiso("ver_eliminados")}
                        class="btn-danger"
                    {else}
                        hidden {$numeropagina=$numeropagina-1}
                    {/if}
                {/if} >
                <td style=" text-align: center">{$numeropagina++}</td>
                <td>{$rl.Per_Nombre}</td>
                <td>{$rl.Mod_Nombre|default:" - "}</td>
                <td style=" text-align: center">{$rl.Per_Ckey}</td>
                
                {if $_acl->permiso("editar_rol")}
                <td style=" text-align: center">             
                    {if $rl.Per_Estado==0}
                        <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="{$lenguaje.label_deshabilitado}" style="color: #DD4B39;"/>
                    {else}
                        <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="{$lenguaje.label_habilitado}" style="color: #088A08;"/>
                    {/if}
                </td>
                <td style=" text-align: center">
                    <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-permiso" title="{$lenguaje.tabla_opcion_cambiar_est}"
                    id_permiso="{$rl.Per_IdPermiso}" estado="{$rl.Per_Estado}"> </a>
                    <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="{$lenguaje.tabla_opcion_editar}" href="{$_layoutParams.root}acl/index/editarPermiso/{$rl.Per_IdPermiso}"> </a>
                    <a   
                    {if $rl.Row_Estado==0}
                        data-toggle="tooltip" 
                        class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-permiso" title="{$lenguaje.label_habilitar}" 
                    {else}
                        data-book-id="{$rl.Per_Nombre}"
                        data-toggle="modal"  data-target="#confirm-delete"
                        class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-permiso" title="{$lenguaje.label_eliminar}"
                    {/if} 
                    id_permiso="{$rl.Per_IdPermiso}" data-placement="bottom" > </a>
                </td>
                {/if}
            </tr>
        {/foreach}
    </table>
</div>
    {$paginacionPermisos|default:""}
{else}
    {$lenguaje.no_registros}
{/if} 

<script type="text/javascript">
    mensaje({$_mensaje_json});
</script>
