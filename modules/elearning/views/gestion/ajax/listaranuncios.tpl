{if isset($anuncios) && count($anuncios)}
                <div class="table-responsive">
                    <table class="table" style="  margin: 20px auto">
                        <tr>
                            <th style=" text-align: center">Nº</th>
                            <th style=" text-align: center">Titulo</th>
                            <th style=" text-align: center">Descripción</th>
                            <th style=" text-align: center">Fecha</th>
                            {if $tipo==0}
                             <th style=" text-align: center">Estado</th>
                            {if $_acl->permiso("editar_rol")}
                            <th style=" text-align: center">Opciones</th>
                            {/if}
                            {/if}
                        </tr>
                        {foreach item=rl from=$anuncios}
                        {if $tipo==0}
                            <tr {if $rl.Row_Estado==0}
                                        {if $_acl->permiso("ver_eliminados")}
                                            class="btn-danger"
                                        {else}
                                            hidden {$numeropagina = $numeropagina-1}
                                        {/if}
                                    {/if} >
                                <td style=" text-align: center">{$numeropagina++}</td>
                                <td style=" text-align: center">{$rl.Anc_Titulo}</td>
                                <td style=" text-align: center">{$rl.Anc_DescripcionRec}...</td>
                                <td style=" text-align: center">{$rl.Anc_FechaReg}</td>
                                 <td style=" text-align: center">
                                        {if $rl.Anc_Estado==0}
                                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="{$lenguaje.label_denegado}" style="color: #DD4B39;"></p>
                                        {/if}                            
                                        {if $rl.Anc_Estado==1}
                                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="{$lenguaje.label_habilitado}" style="color: #088A08;"></p>
                                        {/if}
                                    </td>

                               {if $_acl->permiso("editar_rol")}
                                    <td style=" text-align: center">
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-anuncio" title="{$lenguaje.tabla_opcion_cambiar_est}" id_anuncio="{$rl.Anc_IdAnuncioCurso}" estado="{$rl.Anc_Estado}"> </a>
                                        
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="Editar" href="{$_layoutParams.root}elearning/gestion/editarAnuncios/{$rl.Anc_IdAnuncioCurso}"></a>

                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-envelope" title="Enviar email" href="{$_layoutParams.root}elearning/gestion/enviarEmailAnuncios/{$rl.Anc_IdAnuncioCurso}"></a>

                                         



                                        <a   
                                        {if $rl.Row_Estado==0}
                                            data-toggle="tooltip" 
                                            class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-anuncio" title="{$lenguaje.label_habilitar}" 
                                        {else}
                                            data-book-id="{$rl.Anc_Titulo}"
                                            data-toggle="modal"  data-target="#confirm-delete"
                                            class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-anuncio" title="{$lenguaje.label_eliminar}"
                                        {/if} 
                                        id_anuncio="{$rl.Anc_IdAnuncioCurso}" data-placement="bottom" > </a>

                                    </td>
                                    {/if}
                            </tr>
                            {else}

                               
                                <tr >

                                <td style=" text-align: center"> <a data-book-id="{$rl.Anc_Titulo}" data-book-texto="{$rl.Anc_Descripcion}"
                                            data-toggle="modal"  data-target="#confirm-leer"
                                            title="{$lenguaje.label_eliminar}"
                                        id_anuncio="{$rl.Anc_IdAnuncioCurso}" data-placement="bottom" > {if $rl.Anu_Leido==0}<b>{/if}{$numeropagina++}{if $rl.Anu_Leido==0}</b>{/if}</a></td>
                                <td style=" text-align: center"> <a data-book-id="{$rl.Anc_Titulo}" data-book-texto="{$rl.Anc_Descripcion}"
                                            data-toggle="modal"  data-target="#confirm-leer"
                                            title="{$lenguaje.label_eliminar}"
                                        id_anuncio="{$rl.Anc_IdAnuncioCurso}" data-placement="bottom" > {if $rl.Anu_Leido==0}<b>{/if}{$rl.Anc_Titulo}{if $rl.Anu_Leido==0}</b>{/if}</a></td>
                                <td style=" text-align: center"> <a data-book-id="{$rl.Anc_Titulo}" data-book-texto="{$rl.Anc_Descripcion}"
                                            data-toggle="modal"  data-target="#confirm-leer"
                                            title="{$lenguaje.label_eliminar}"
                                        id_anuncio="{$rl.Anc_IdAnuncioCurso}" data-placement="bottom" > {if $rl.Anu_Leido==0}<b>{/if}{$rl.Anc_DescripcionRec}...{if $rl.Anu_Leido==0}</b>{/if}</a></td>
                                <td style=" text-align: center"> <a data-book-id="{$rl.Anc_Titulo}" data-book-texto="{$rl.Anc_Descripcion}"
                                            data-toggle="modal"  data-target="#confirm-leer"
                                            title="{$lenguaje.label_eliminar}"
                                        id_anuncio="{$rl.Anc_IdAnuncioCurso}" data-placement="bottom" > {if $rl.Anu_Leido==0}<b>{/if}{$rl.Anc_FechaReg}{if $rl.Anu_Leido==0}</b>{/if}</a></td>
                                </tr>
                                
                            {/if}
                        {/foreach}
                    </table>
                </div>
                    {$paginacionanuncios|default:""}
                {else}
                    No hay registros
                {/if}                