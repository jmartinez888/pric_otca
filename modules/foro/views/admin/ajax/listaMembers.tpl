                         
                            <div class="table-responsive">
                                <div class="col-xs-3">     
                                    <input id="text_busqueda_miembro" name="text_busqueda_miembro" type="text" class="form-control" value="{$text_busqueda_miembro}">
                                </div>
                                <!-- <div class="col-xs-1"> -->
                                    <button id="buscar_miembro_foro" name="buscar_miembro_foro" class=" btn btn-primary" type="button"><i class="glyphicon glyphicon-search"></i></button>
                                <!-- </div> -->
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>#</th>
                                            <th>Usuario</th>
                                            <th>Nombre</th>
                                            <th>Apellido</th> 
                                            <th>Registrado</th>     
                                            <th>Estado</th> 
                                            <th>Opciones</th>
                                        </tr>
                                    </thead>
                                    <tbody> 
                                        {foreach from=$lista_members item=member}            
                                            <tr>
                                                <th scope="row">{$numeropagina++}</th>
                                                <td>{$member.Usu_Usuario}</td>
                                                <td>{$member.Usu_Nombre}</td>
                                                <td>{$member.Usu_Apellidos}</td>
                                                <td>{$member.Usf_FechaRegistro|date_format:"%d-%m-%Y"}</td>                               
                                                <td>{$member.Usf_Estado}</td>
                                                <td>
                                                    <a type="button" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-list permisos_member" data-toggle="modal" data-target="#modal-permisos-member" data-original-title="Editar Permisos" id_usuario="{$member.Usu_IdUsuario}" id_foro="{$member.For_IdForo}" id_rol="{$member.Rol_IdRol}"></a>
                                                    <button data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh cambiar_estado" title="Cambiar Estado" id_usuario="{$member.Usu_IdUsuario}" id_foro="{$member.For_IdForo}" estado="{$member.Usf_Estado}" > </button>      
                                                    <button data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-trash eliminar_miembro" title="Eliminar" id_usuario="{$member.Usu_IdUsuario}" id_foro="{$member.For_IdForo}" > </button>
                                                </td>
                                            </tr>  
                                        {/foreach}
                                    </tbody>
                                </table>
                            </div>
                            {$paginacion|default:""}
                        </div>
