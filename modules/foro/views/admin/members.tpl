<div  class="margin-t-10" >
    <div class="row">
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
            <h3 class="titulo">{$lenguaje.foro_admin__members_label_titulo}</h3>
        </div>
        <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12 p-rt-lt-0">
            <hr class="foro-hr-title-form">
        </div>
        <div class="col-md-3 col-xs-12 col-sm-4 col-lg-3">
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
                                    <td colspan ="2"><a href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}"> {$foro.For_Titulo}</a></td>
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
        <div class="col-md-9 col-xs-12 col-sm-8 col-lg-9">            
            <input type="hidden" id="ckey" name="ckey" value="{$Rol_Ckey}">
            <ul class="nav nav-tabs" role="tablist">
                {if $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                <li role="presentation" {if $Rol_Ckey=='lider_foro'} class="active" {/if}><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="lider_foro" id_foro="{$foro.For_IdForo|Default:0}">Lider</a></li>
                {/if}
                {if $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                <li role="presentation" ><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="moderador_foro" id_foro="{$foro.For_IdForo|Default:0}">Moderador</a></li>
                {/if}
                {if $Rol_Ckey=="moderador_foro" || $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                <li role="presentation" {if $Rol_Ckey=='moderador_foro'} class="active" {/if}><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="facilitador_foro" id_foro="{$foro.For_IdForo|Default:0}">Facilitador</a></li>
                {/if}
                {if $Rol_Ckey=="facilitador_foro" || $Rol_Ckey=="moderador_foro" || $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                <li role="presentation" {if $Rol_Ckey=='facilitador_foro'} class="active" {/if}><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="participante_foro" id_foro="{$foro.For_IdForo|Default:0}">Participante</a></li>
                {/if}
                {if $Rol_Ckey=="facilitador_foro" || $Rol_Ckey=="moderador_foro" || $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                <li class="pull-right"><a type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modal-asignar-member" title="Asignar nuevo miembro al foro">Asignar</a></li>
                {/if}
                <!-- ver -->
            </ul>
            <!-- Tab panes -->
            
            <div class="row" id="listaMembers">
                {include file='modules/foro/views/admin/ajax/listaMembers.tpl'}
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
                                        <div class="form-group col-md-4 col-xs-4 col-lg-4 col-sm-4">
                                            <select class="form-control" id="s_lista_rol_foro" name="s_lista_rol_foro">
                                                {foreach from=$lista_rol_foro item=rol_foro}
                                                {if $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                                                <option value="{$rol_foro.Rol_IdRol}" ckey="{$rol_foro.Rol_Ckey}">{$rol_foro.Rol_Nombre}</option>
                                                {elseif $Rol_Ckey=="moderador_foro" && $rol_foro.Rol_Ckey!="lider_foro"  && $rol_foro.Rol_Ckey!="moderador_foro" }
                                                <option value="{$rol_foro.Rol_IdRol}" ckey="{$rol_foro.Rol_Ckey}">{$rol_foro.Rol_Nombre}</option>
                                                {elseif $Rol_Ckey=="facilitador_foro" && $rol_foro.Rol_Ckey=="facilitador_foro"}
                                                <option value="{$rol_foro.Rol_IdRol}" ckey="{$rol_foro.Rol_Ckey}">{$rol_foro.Rol_Nombre}</option>
                                                {/if}
                                                {/foreach}
                                            </select>
                                        </div>
                                        <div class="form-group  col-md-6 col-xs-6 col-lg-6 col-sm-6">
                                            <input type="text" class="form-control" style="width: 100%" id="tb_buscar_usuario" name="tb_buscar_usuario" placeholder="Buscar usuario por nombre">
                                        </div>
                                        <div class="col-md-2 col-xs-2 col-lg-2 col-sm-2 pull-right">
                                            <button type="button" id="bt_buscar_user_foro" class="btn btn-default" id_foro="{$foro.For_IdForo}" >Buscar</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-heading">
                                    <div class="col-md-2 col-xs-4 col-lg-2 col-sm-2">
                                        Seleccione
                                    </div>
                                    <div class="col-md-10 col-xs-8 col-lg-10 col-sm-10">
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
                                        <div class="col-md-12 col-xs-12 col-lg-12 col-sm-12">
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
                <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal" id="bt_asignar_usuario" id_foro="{$foro.For_IdForo}" >Añadir</button>
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
</div>