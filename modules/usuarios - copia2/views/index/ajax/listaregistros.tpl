{if isset($usuarios) && count($usuarios)}
    <div class="table-responsive" >
        <table class="table" style=" text-align: center">
            <tr >
                <th style=" text-align: center">{$lenguaje.label_n}</th>
                <th style=" text-align: center">{$lenguaje.label_usuario}</th>
                <th style=" text-align: center">{$lenguaje.label_rol}</th>
                <th style=" text-align: center">{$lenguaje.label_estado}</th>
                {if $_acl->permiso("editar_usuario")}
                <th style=" text-align: center">{$lenguaje.label_opciones}</th>
                {/if}
            </tr>
            {foreach from=$usuarios item=us}
                <tr {if $us.Row_Estado==0}
                                        {if $_acl->permiso("ver_eliminados")}
                                            class="btn-danger"
                                        {else}
                                            hidden {$numeropagina = $numeropagina-1}
                                        {/if}
                                    {/if}>
                    <td>{$numeropagina++}</td>
                    <td>{$us.Usu_Usuario}</td>

                    <td>
                        {if isset($us.Roles)}
                            <ul>
                                {foreach item=r from=$us.Roles}
                                    <li>{$r.Rol_Nombre}</li>
                                {/foreach}
                            </ul>
                        {else}
                        {$us.Rol_Nombre}
                        {/if}
                    </td>

                    <td style=" text-align: center">
                        {if $us.Usu_Estado==0}
                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="{$lenguaje.label_deshabilitado}" style="color: #DD4B39;"></p>
                        {/if}                            
                        {if $us.Usu_Estado==1}
                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="{$lenguaje.label_habilitado}" style="color: #088A08;"></p>
                        {/if}
                    </td>                                            
                    <td >
                        {if $_acl->permiso("editar_usuario")}
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default  btn-sm glyphicon glyphicon-pencil" title="{$lenguaje.label_editar_usuario}" href="{$_layoutParams.root}usuarios/index/rol/{$us.Usu_IdUsuario}"></a>
                        {/if}{if $_acl->permiso("agregar_rol")}
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-tasks" title="{$lenguaje.tabla_opcion_editar_permisos}"  href="{$_layoutParams.root}usuarios/index/permisos/{$us.Usu_IdUsuario}"></a>
                        {/if}{if $_acl->permiso("habilitar_deshabilitar_usuario")}
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh" title="{$lenguaje.tabla_opcion_cambiar_est}" href="{$_layoutParams.root}usuarios/index/_cambiarEstado/{$us.Usu_IdUsuario}/{$us.Usu_Estado}"> </a>      
                        {/if}{if $_acl->permiso("eliminar_usuario")}
                        <a data-toggle="tooltip" data-placement="bottom" {if $us.Row_Estado==1} class="btn btn-default btn-sm glyphicon glyphicon-trash" title="{$lenguaje.label_eliminar}" {else} class="btn btn-default btn-sm glyphicon glyphicon-ok" title="{$lenguaje.label_habilitar}" {/if} href="{$_layoutParams.root}usuarios/index/_eliminarUsuario/{$us.Usu_IdUsuario}/{$us.Row_Estado}"> </a>
                        {/if}
                    </td>                                            
                </tr>
            {/foreach}
        </table>
    </div>
    {$paginacion|default:""}
{else}
    {$lenguaje.no_registros}
{/if}