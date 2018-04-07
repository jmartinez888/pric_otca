{if isset($roles) && count($roles)}
    <div class="table-responsive">
        <table class="table" style="  margin: 20px auto">
            <tr>
                <th style=" text-align: center">{$lenguaje.label_n}</th>
                <th >{$lenguaje.label_rol}</th>
                <th >{$lenguaje.label_modulo} </th>
                <th style=" text-align: center">{$lenguaje.label_estado}</th>
                {if $_acl->permiso("editar_rol")}
                <th style=" text-align: center">{$lenguaje.label_opciones}</th>
                {/if}
            </tr>
            {foreach item=rl from=$roles}
                <tr {if $rl.Row_Estado==0}
                        {if $_acl->permiso("ver_eliminados")}
                            class="btn-danger"
                        {else}
                            hidden {$numeropagina = $numeropagina-1}
                        {/if}
                    {/if} >
                    <td style=" text-align: center">{$numeropagina++}</td>
                    <td>{$rl.Rol_Nombre}</td>
                    <td>{$rl.Mod_Nombre|default:" - "}</td>
                    <td style=" text-align: center">
                        {if $rl.Rol_Estado==0}
                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="{$lenguaje.label_denegado}" style="color: #DD4B39;"></p>
                        {/if}                            
                        {if $rl.Rol_Estado==1}
                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="{$lenguaje.label_habilitado}" style="color: #088A08;"></p>
                        {/if}
                    </td>
                    {if $_acl->permiso("editar_rol")}
                    <td style=" text-align: center">
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-rol" title="{$lenguaje.tabla_opcion_cambiar_est}" id_rol="{$rl.Rol_IdRol}" estado="{$rl.Rol_Estado}"> </a>
                        
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="{$lenguaje.tabla_opcion_editar_rol}" href="{$_layoutParams.root}acl/index/editarRol/{$rl.Rol_IdRol}"></a>

                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-list" title="{$lenguaje.tabla_opcion_editar_permisos}" href="{$_layoutParams.root}acl/index/permisos_role/{$rl.Rol_IdRol}"></a>

                        <a   
                        {if $rl.Row_Estado==0}
                            data-toggle="tooltip" 
                            class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-rol" title="{$lenguaje.label_habilitar}" 
                        {else}
                            data-book-id="{$rl.Rol_Nombre}"
                            data-toggle="modal"  data-target="#confirm-delete"
                            class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-rol" title="{$lenguaje.label_eliminar}"
                        {/if} 
                        id_rol="{$rl.Rol_IdRol}" data-placement="bottom" > </a>

                    </td>
                    {/if}
                </tr>
            {/foreach}
        </table>
    </div>
    {$paginacion|default:""}
{else}
    {$lenguaje.no_registros}
{/if}

<script type="text/javascript">
    mensaje({$_mensaje_json});
</script>