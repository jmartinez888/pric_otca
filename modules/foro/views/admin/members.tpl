<a href = "" onclick = "window.open ('https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent ('{$_layoutParams.root}{$_layoutParams.modulo}'),' facebook-share-dialog ',' width = 626, height = 436, left = 300, top = 150 '); return false; ">
<img style="width: 4%;" src = "{$_layoutParams.root_clear}public/img/facebook.png" alt = " facebook" >
<a target="_blank" href ="https://twitter.com/share" class ="twitter-share-button" data-url="" data-text="Charolastra" data-lang="es" data-size="large">
<img style="width: 3%;" src = "{$_layoutParams.root_clear}public/img/twiter.png" alt = " facebook"></a>

    <h3 class="titulo-view">{$lenguaje.foro_admin__members_label_titulo}</h3>
    <div class="row">
        <div class="col-md-3">
            <div class="panel-group" id="accordion">
                <div class="panel panel-default">                    
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <strong>Foro</strong>
                        </h4>
                    </div>               
                    <div class="panel-body">
                        <table class="table table-user-information">
                            <tbody>                           
                                <tr>
                                    <td>Nombre:</td>
                                    <td>{$foro.For_Titulo}</td>     
                                </tr>                                
                                <tr>
                                    <td>Autor</td>
                                    <td>{$foro.Usu_Usuario}</td>
                                </tr>                                 
                                <tr>
                                    <td>Miembros</td>
                                    <td>{$foro.For_NParticipantes}</td>
                                </tr>                                
                                <tr>
                                    <td>Comentarios</td>
                                    <td>{$foro.For_NComentarios}</td>
                                </tr>
                                <tr>
                                    <td>Fecha Creacion</td>
                                    <td>{$foro.For_FechaCreacion}</td>
                                </tr>
                                <tr>
                                    <td>Fecha Cierre</td>
                                    <td>{$foro.For_FechaCierre}</td>
                                </tr>
                                <tr>
                                    <td>Fecha Actualizacion</td>
                                    <td>{$foro.For_Update}</td>
                                </tr>


                            </tbody>
                        </table>
                    </div>
                </div>
            </div>             
        </div>

        <div class="col-md-9">
            <div class="panel panel-default">
                <input type="hidden" id="ckey" name="ckey" value="{$Rol_Ckey}">
                <ul class="nav nav-tabs" role="tablist">
                    {if $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                        <li role="presentation" class="active"><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="lider_foro" id_foro="{$foro.For_IdForo|Default:0}">Lider</a></li>
                    {/if}
                    {if $Rol_Ckey=="moderador_foro" || $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                        <li role="presentation" ><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="moderador_foro" id_foro="{$foro.For_IdForo|Default:0}">Moderador</a></li>
                    {/if}
                    {if $Rol_Ckey=="moderador_foro" || $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}    
                        <li role="presentation"><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="facilitador_foro" id_foro="{$foro.For_IdForo|Default:0}">Facilitador</a></li>
                    {/if}
                    {if $Rol_Ckey=="facilitador_foro" || $Rol_Ckey=="moderador_foro" || $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                        <li role="presentation"><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="participante_foro" id_foro="{$foro.For_IdForo|Default:0}">Participante</a></li>
                    {/if}
                    {if $Rol_Ckey=="facilitador_foro" || $Rol_Ckey=="moderador_foro" || $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                        <li class="pull-right"><a type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modal-asignar-member" title="Asignar nuevo miembro al foro">Asignar</a></li>
                    {/if}
                    <!-- ver -->
                </ul>
                <!-- Tab panes -->
                <div class="tab-content">  
                    <div role="tabpanel" class="tab-pane active" id="tab_members">
                        <div id="listaMembers">                            
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

                    </div>                
                </div>
            </div>
        </div> 

    </div>
</div>
<!--  Modal Asignar Member -->
<div class="modal fade top-space-0" id="modal-asignar-member" tabindex="-1" role="dialog">
    <div class="modal-dialog login-dialog">
        <div class="modal-content">
            <div class="modal-body" >
                <div class="row">
                    <div class="col-md-12 col-xs-12 col-lg-12 col-sm-12">
                        <h2>Añadir miembro al Foro</h2>
                        <hr>
                        <div class="panel-group" >
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                        Localizar un usuario
                                    </h4>
                                </div>               
                                <div class="panel-body">
                                    <div class="form-inline row" >
                                        <div class="form-group col-md-4">                                          
                                            <select class="form-control" id="s_lista_rol_foro" name="s_lista_rol_foro">
                                                {foreach from=$lista_rol_foro item=rol_foro} 
                                                    <option value="{$rol_foro.Rol_IdRol}" ckey="{$rol_foro.Rol_Ckey}">{$rol_foro.Rol_Nombre}</option>
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="form-group  col-md-8">                                            
                                            <input type="text" class="form-control" style="width: 100%" id="tb_buscar_usuario" name="tb_buscar_usuario" placeholder="Buscar usuario por nombre">
                                        </div> 
                                        <div class="col-md-2 pull-right">
                                            <button type="button" id="bt_buscar_user_foro" class="btn btn-default" id_foro="{$foro.For_IdForo}" >Buscar</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-heading">
                                    <div class="col-md-2">
                                        Seleccione
                                    </div>
                                    <div class="col-md-10">
                                        Nombre
                                    </div>
                                    <div class="clearfix"></div>                                                                           
                                </div>  
                                <div class="panel-body">                                   
                                    <div id="lista_member_select">
                                        {if isset($lista_meber_select)}

                                        {else}
                                            <span>Realice una busqueda</span>
                                        {/if}
                                    </div>    
                                    <div class="row">
                                        <hr>
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label for="ta_mensaje_usuario">Mensaje</label>
                                                <textarea  class="form-control"  id="ta_mensaje_usuario" name="ta_mensaje_usuario" ></textarea>  
                                            </div>

                                        </div>
                                    </div>
                                </div>                               
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">  
                <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal" id="bt_asignar_usuario" id_foro="{$foro.For_IdForo}" >Guardar</button>
            </div>
        </div>
    </div>
</div>

<!--  Modal Permisos Member -->
<div class="modal fade top-space-0" id="modal-permisos-member" tabindex="-1" role="dialog">
    <div class="modal-dialog login-dialog">
        <div class="modal-content">
            <div class="modal-body" >
                <div class="row">
                    <div class="col-md-12 col-xs-12 col-lg-12 col-sm-12">
                        <h2>Permisos del Participante</h2>
                        <hr>
                        <div class="panel-group" >
                            <div class="panel panel-default" id="listaPermisosMember">
                                                                                   
                            </div>
                        </div>
                    </div>
                </div>
            </div>          
        </div>
    </div>
</div>

