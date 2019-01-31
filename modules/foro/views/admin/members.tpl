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
                        <strong>{$lenguaje.foro_members_actividad}</strong>
                        </h4>
                    </div>
                    <div class="panel-body">
                        <table class="table table-user-information">
                            <tbody>
                                <tr>
                                    <td colspan ="2"><a href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}"> {$foro.For_Titulo}</a></td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje.foro_members_autor}</td>
                                    <td>{$foro.Usu_Usuario}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje.foro_members_nmiembros}</td>
                                    <td>{$foro.For_NParticipantes}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje.foro_members_comentarios}</td>
                                    <td>{$foro.For_NComentarios}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje.foro_members_fechacreacion}</td>
                                    <td>{$foro.For_FechaCreacion}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje.foro_members_fechacierre}</td>
                                    <td>{$foro.For_FechaCierre}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje.foro_members_fechaactualizacion}</td>
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
                <li role="presentation" {if $Rol_Ckey=='lider_foro'} class="active" {/if}><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="lider_foro" id_foro="{$foro.For_IdForo|Default:0}">{$lenguaje.foro_members_lider}</a></li>
                {/if}
                {if $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                <li role="presentation" ><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="moderador_foro" id_foro="{$foro.For_IdForo|Default:0}">{$lenguaje.foro_members_moderador}</a></li>
                {/if}
                {if $Rol_Ckey=="moderador_foro" || $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                <li role="presentation" {if $Rol_Ckey=='moderador_foro'} class="active" {/if}><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="facilitador_foro" id_foro="{$foro.For_IdForo|Default:0}">{$lenguaje.foro_members_facilitador}</a></li>
                {/if}
                {if $Rol_Ckey=="facilitador_foro" || $Rol_Ckey=="moderador_foro" || $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                <li role="presentation" {if $Rol_Ckey=='facilitador_foro'} class="active" {/if}><a href="#tab_members" aria-controls="tab_members" role="tab" data-toggle="tab" class="tab_member" rol_member="participante_foro" id_foro="{$foro.For_IdForo|Default:0}">{$lenguaje.foro_members_participante}</a></li>
                {/if}
                {if $Rol_Ckey=="facilitador_foro" || $Rol_Ckey=="moderador_foro" || $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                <li class="pull-right"><a type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#modal-asignar-member" title="Asignar nuevo miembro al foro">{$lenguaje.foro_members_asignar}</a></li>
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
    <div class="modal-dialog login-dialo modal-lg">
        <div class="modal-content">
            <div class="modal-body" >
                <div class="row">
                    <div class="col-md-12 col-xs-12 col-lg-12 col-sm-12">
                        <h2>{$lenguaje.foro_members_aniadirmiembro}</h2>
                        <hr>
                        <div class="panel-group" >
                            <div class="panel panel-default">
                                <div class="panel-heading">
                                    <h4 class="panel-title">
                                    {$lenguaje.foro_members_localizarusuario}
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
                                            <button type="button" id="bt_buscar_user_foro" class="btn btn-default" id_foro="{$foro.For_IdForo}" >{$lenguaje.foro_members_buscar}</button>
                                        </div>
                                    </div>
                                </div>
                                <div class="panel-heading">
                                    <div class="col-md-2 col-xs-4 col-lg-2 col-sm-2">
                                        {$lenguaje.foro_members_seleccione}
                                    </div>
                                    <div class="col-md-10 col-xs-8 col-lg-10 col-sm-10">
                                        {$lenguaje.foro_members_nombre}
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                                <div class="panel-body">
                                    <div id="lista_member_select">
                                        {if isset($lista_meber_select)}
                                        {else}
                                        <span>{$lenguaje.foro_members_realicebusqueda}</span>
                                        {/if}
                                    </div>
                                    <div class="row">
                                        <hr>
                                        <div class="col-md-12 col-xs-12 col-lg-12 col-sm-12">
                                            <div class="form-group">
                                                <label for="ta_mensaje_usuario"></label>
                                                <textarea  class="form-control"  id="ta_mensaje_usuario" name="ta_mensaje_usuario">
                                                   
                                                    <h2 style="display: block;margin: 0;padding: 0;color: #202020;font-family: Helvetica;font-size: 18px;font-style: normal;font-weight: bold;line-height: 125%;letter-spacing: normal;text-align: left;">INVITACION.</h2>
                                                    <p>Hola |nombre| |apellidos|, usted a sido invitado a participar en la discusión sobre |titulo_foro|. </p>
                                                    <p>Ingrese al siguiente link para participar.</p>
                                                     <a href= "{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
                                                     {$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}</a>
                                                   
                                                </textarea>
                                            </div>
                                        </div>
                                        <div class="col-md-12 col-xs-12 col-lg-12 col-sm-12 margin-t-10 "> 
                                            <blockquote style="margin: 0;">
                                                <b style="font-size: 14px">{$lenguaje.foro_members_notavariables}</b>
                                                <em> 
                                                    <h5><strong>|nombre|</strong> = {$lenguaje.foro_members_nombreparticipante}</h5>
                                                    <h5><strong>|apellidos|</strong> =  {$lenguaje.foro_members_apellidoparticipante}</h5>
                                                    <h5><strong>|usuario|</strong> = {$lenguaje.foro_members_usuarioparticipante}</h5>
                                                    <h5><strong>|titulo_foro|</strong> = {$lenguaje.foro_members_tituloforo}</h5>
                                                </em>
                                            </blockquote> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
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
                        <h2>{$lenguaje.foro_members_permisosparticipante}</h2>
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