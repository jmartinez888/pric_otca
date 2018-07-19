{if isset($modulos) && count($modulos)}
                <div class="table-responsive">
                    <table class="table" style="  margin: 20px auto">
                        <tr>
                            <th style=" text-align: center">{$lenguaje.label_n}</th>
                            <th >Módulo</th>
                            <th style=" text-align: center">Código</th>
                            <th style=" text-align: center">Descripción</th>
                            <th style=" text-align: center">Estado</th>
                            {if $_acl->permiso("editar_rol")}
                            <th style=" text-align: center">Opciones</th>
                            {/if}
                        </tr>
                        {foreach item=rl from=$modulos}
                            <tr {if $rl.Row_Estado==0}
                                    {if $_acl->permiso("ver_eliminados")}
                                        class="btn-danger"
                                    {else}
                                        hidden {$numeropagina=$numeropagina-1}
                                    {/if}
                                {/if} >
                                <td style=" text-align: center">{$numeropagina++}</td>
                                <td>{$rl.Mod_Nombre}</td>
                                <td style=" text-align: center">{$rl.Mod_Codigo}</td>
                                <td style=" text-align: center">{$rl.Mod_Descripcion}</td>
                                
                                {if $_acl->permiso("editar_rol")}
                                <td style=" text-align: center">             
                                    {if $rl.Mod_Estado==0}
                                        <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="{$lenguaje.label_deshabilitado}" style="color: #DD4B39;"/>
                                    {else}
                                        <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="{$lenguaje.label_habilitado}" style="color: #088A08;"/>
                                    {/if}
                                </td>
                                <td style=" text-align: center">
                                    <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-modulo" title="{$lenguaje.tabla_opcion_cambiar_est}"
                                    id_modulo="{$rl.Mod_IdModulo}" estado="{$rl.Mod_Estado}"> </a>
                                    <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="{$lenguaje.tabla_opcion_editar}" href="{$_layoutParams.root}acl/index/editarModulo/{$rl.Mod_IdModulo}"> </a>
                                    <a   
                                    {if $rl.Row_Estado==0}
                                        data-toggle="tooltip" 
                                        class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-modulo" title="{$lenguaje.label_habilitar}" 
                                    {else}
                                        data-book-id="{$rl.Mod_Nombre}"
                                        data-toggle="modal"  data-target="#confirm-delete"
                                        class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-modulo" title="{$lenguaje.label_eliminar}"
                                    {/if} 
                                    id_modulo="{$rl.Mod_IdModulo}" data-placement="bottom" > </a>
                                </td>
                                {/if}
                            </tr>
                        {/foreach}
                    </table>
                </div>
                    {$paginacionmodulos|default:""}
                {else}
                    {$lenguaje.no_registros}
                {/if}              

                <script type="text/javascript">
    mensaje({$_mensaje_json});
</script>  