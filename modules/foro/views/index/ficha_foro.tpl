<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10">
        <div class="row ficha_foro">
            <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
                <!-- ficha-foro-josepacaya -->
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 p-rt-lt-0">
                    <div class="etiqueta">
                        {if $foro.For_Funcion == 'forum'}
                        Discusiones
                        {/if}
                        {if $foro.For_Funcion == 'webinar'}
                        Webinars
                        {/if}
                        {if $foro.For_Funcion == 'query'}
                        Consultas
                        {/if}
                        {if $foro.For_Funcion == 'workshop'}
                        Workshop
                        {/if}
                    </div>
                </div>
                
                <!--¨Para subir reporte de Discusion-->
                {if Session::get('autenticado') && ( $Rol_Ckey == "administrador" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey == "lider_foro" || $Rol_Ckey == "moderador_foro" || $id_usuario == $foro.Usu_IdUsuario)}

                    {$Fif_EsOutForo=0}
                    {foreach from=$foro.Archivos item=file}
                        {if $file.Fif_EsOutForo ==1}
                            {$Fif_EsOutForo=1}
                            {$Dub_IdDublinCore=$file.Dub_IdDublinCore}
                            {break}
                        {/if}
                    {/foreach}
                    {if  $foro.For_Funcion == 'forum' && $foro.For_Estado == 2}
                        {if $Fif_EsOutForo==0}
                            <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 text-center btn_opciones_foro pull-right">
                                <a href="{$_layoutParams.root_clear}dublincore/registrar/index/{$foro.Rec_IdRecurso}/{$foro.For_IdForo}" title="Subir reporte de la Discusión" id="btn-configuracion" class="btn btn-primary btn-circle dropdown-toggle"><i class="glyphicon glyphicon-cloud-upload"></i>
                                </a>
                            </div>
                        {else}
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 text-center btn_opciones_foro pull-right">
                            <a href="{$_layoutParams.root_clear}dublincore/editar/index/{$Dub_IdDublinCore}/{$foro.For_IdForo}" title="Editar reporte de foro" id="btn-configuracion" class="btn btn-primary btn-circle dropdown-toggle"><i class="glyphicon glyphicon-pencil"></i>
                            </a>
                        </div>
                        <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 text-center btn_opciones_foro pull-right">
                            <a target="_blank" href="{$_layoutParams.root_archivo_fisico}{$file.Fif_NombreFile}" title="Descargar reporte de discusión" id="btn-configuracion" class="btn btn-primary btn-circle dropdown-toggle"><i class="glyphicon glyphicon-cloud-download"></i>
                            </a>
                        </div>
                        {/if}
                    {/if}
                <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 text-center btn_opciones_foro pull-right">
                    <button  title="Administrar" id="btn-configuracion" class="btn btn-primary btn-circle dropdown-toggle" data-toggle="dropdown" type="button"><i class="glyphicon glyphicon-cog"></i>
                    </button>
                    <ul class="dropdown-menu" style="min-width: 200px;">
                        {if $_acl->permiso("editar_foro") || $id_usuario == $foro.Usu_IdUsuario}
                        <li><a href="{$_layoutParams.root}foro/admin/form/edit/{$foro.For_Funcion}/{$foro.For_IdForo}" id_foro="{$foro.For_IdForo}" class="opciones_foro" style="cursor: pointer;">{$lenguaje.foro_str_editar}<i class="i_opciones_foro glyphicon glyphicon-pencil pull-right"></i></a></li>
                        {/if}
                        {if $_acl->permiso("agregar_sub_discusion") && !isset($foro.For_IdPadre) && $foro.For_Funcion == 'forum' && $foro.Row_Estado == 1 && $foro.For_Estado == 1}
                        <li><a  href="{$_layoutParams.root}foro/admin/form/new/forum/{$foro.For_IdForo}" class="opciones_foro" style="cursor: pointer;">{$lenguaje.foro_str_crearsubdiscu}<i class="i_opciones_foro glyphicon glyphicon-plus pull-right"></i></a></li>
                        {/if}
                        {if $foro.For_Funcion != 'query'}
                        {if $_acl->permiso("listar_miembros")}
                        <li><a href="{$_layoutParams.root}foro/admin/members/{$foro.For_IdForo}" id_foro="{$foro.For_IdForo}" class="opciones_foro" style="cursor: pointer;">{$lenguaje.foro_str_vermiembros}<i class="i_opciones_foro glyphicon glyphicon-user pull-right"></i></a></li>
                        {/if}
                        {if $_acl->permiso("listar_actividades")}
                        <li><a href="{$_layoutParams.root}foro/admin/actividad/{$foro.For_IdForo}" id_foro="{$foro.For_IdForo}" class="opciones_foro" style="cursor: pointer;">{$<lenguaje class="foro_str_actividades"></lenguaje>}<i class="i_opciones_foro glyphicon glyphicon-calendar pull-right"></i></a></li>
                        {/if}
                        {/if}
                        {if ($_acl->permiso("habilitar_foro") || $id_usuario == $foro.Usu_IdUsuario) &&  $foro.For_Estado== 0}
                        <li><a id_foro="{$foro.For_IdForo}" class="opciones_foro hablitarForo" style="cursor: pointer;">{$lenguaje.foro_str_habilitar}<i class="i_opciones_foro glyphicon glyphicon-ok pull-right"></i></a></li>
                        {else}
                        {if ($_acl->permiso("cerrar_foro") || $id_usuario == $foro.Usu_IdUsuario) && $foro.For_Estado== 0}
                        <li><a id_foro="{$foro.For_IdForo}" class="opciones_foro cerrar_foro" estado="{$foro.For_Estado}" style="cursor: pointer;">{$lenguaje.foro_str_cerrarforo}<i class="i_opciones_foro glyphicon glyphicon-off pull-right"></i></a></li>
                        {/if}
                        {if ($_acl->permiso("deshabilitar_foro") || $id_usuario == $foro.Usu_IdUsuario) && ($foro.For_Estado== 1 || $foro.For_Estado == 2)}
                        <li><a id_foro="{$foro.For_IdForo}" for_estado="{$foro.For_Estado}" class="opciones_foro deshablitarForo" style="cursor: pointer;">{$lenguaje.foro_str_desabilitar}<i class="i_opciones_foro glyphicon glyphicon-eye-close pull-right"></i></a></li>
                        {/if}
                        {/if}
                        {if (($_acl->permiso("eliminar_foro") || $id_usuario == $foro.Usu_IdUsuario)) && $foro.Row_Estado==1}
                        <li><a id_foro="{$foro.For_IdForo}" class="opciones_foro eliminar_foro" Row_Estado="{$foro.Row_Estado}" style="cursor: pointer;">{$lenguaje.foro_str_eliminar}<i class="i_opciones_foro glyphicon glyphicon-trash pull-right"></i></a></li>
                        {/if}
                        {if (($_acl->permiso("restaurar_foro") || $id_usuario == $foro.Usu_IdUsuario)) && $foro.Row_Estado==0}
                        <li><a id_foro="{$foro.For_IdForo}" class="opciones_foro eliminar_foro" Row_Estado="{$foro.Row_Estado}" style="cursor: pointer;">{$lenguaje.foro_str_restaurar}<i class="i_opciones_foro glyphicon glyphicon-refresh pull-right"></i></a></li>
                        {/if}
                        {if $Rol_Ckey == "administrador" || $Rol_Ckey == "administrador_foro"}
                        <li><a href="{$_layoutParams.root}foro/admin/" id_foro="{$foro.For_IdForo}" class="opciones_foro" style="cursor: pointer;">{$lenguaje.foro_str_vertodoslosforos}<i class="i_opciones_foro glyphicon glyphicon-list pull-right"></i></a></li>
                        {/if}
                    </ul>
                </div>
                {/if}                
                <!--¨Fin Para subir reporte de Discusion-->
                
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12  p-rt-lt-0">
                    <hr class="cursos-hr">
                </div>
                <div class="col col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                    <h3 class="margin-t-10">{$foro.For_Titulo}</h3>
                </div>
                
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0" style="font-size: 12px;">
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 p-rt-lt-0">
                        <i class="glyphicon glyphicon-user" style="color: #777; text-align: center; vertical-align: middle; margin-bottom: 5px;"></i>
                        {$lenguaje.foro_str_creado} {timediff date={$tiempo} lang=Cookie::lenguaje()}  {$lenguaje.foro_str_por} <strong>{$nombre_usuario}</strong>
                    </div>
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 p-rt-lt-0">
                        <div class="pull-right">
                            <i class="fa fa-users" style="color: #777; text-align: center; vertical-align: middle;"></i>
                            {$lenguaje.foro_str_participantes}: <strong>{$Numero_participantes_x_idForo}</strong>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0">
                    <hr class="cursos-hr">
                </div>
                <div class="col col-xs-12 col-sm-12 col-md-12 col-lg-12 contenido">
                    <p>{$foro.For_Descripcion|html_entity_decode}</p>
                </div>
                <!--Sub Duscusiones-->
                {if $foro.For_Funcion=="forum"}
                    {if count($foro.Sub_Foros)>0}
                    <div class="col col-xs-12 col-sm-12 col-md-12 col-lg-12 pull-left">
                        <label class="">{$lenguaje.foro_str_subdiscusiones}:</label>
                        {if !isset($foro.For_IdPadre)}
                        {if $foro.Row_Estado == 1 && $foro.For_Estado == 1}
                        <a type="button"  href="{$_layoutParams.root}foro/admin/form/new/forum/{$foro.For_IdForo}" class="btn btn-primary btn-sm pull-right" title="Nueva Sub Discusión" style="padding: 2px 10px;"> Crear &nbsp;<i class=" glyphicon glyphicon-plus pull-right"> </i></a>
                        {/if}
                        {/if}
                        <hr class="cursos-hr">
                        <ul class="col">
                            {foreach from=$foro.Sub_Foros  item=sub_foro}
                            <li class="clearfix">
                                <div>
                                    <a class="link-foro" href="{$_layoutParams.root}foro/index/ficha/{$sub_foro.For_IdForo}" target="_blank">
                                        <strong>{$sub_foro.For_Titulo}</strong>
                                    </a>
                                    <br>
                                    <a class="simulalink" style="color: black;" href="{$_layoutParams.root}foro/index/ficha/{$sub_foro.For_IdForo}" target="_blank">
                                        {if strlen($sub_foro.For_Resumen)>150}
                                        {substr($sub_foro.For_Resumen, 0, 150)}...
                                        {else}
                                        {$sub_foro.For_Resumen}
                                        {/if}
                                    </a>
                                </div>
                            </li>
                            <div class="detalles-act-reciente">{$sub_foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; {timediff date=$sub_foro.tiempo lang=Cookie::lenguaje()}  &nbsp;&nbsp;-&nbsp;&nbsp; {$sub_foro.votos} voto(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$sub_foro.For_TParticipantes|default:0} miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp;{$sub_foro.For_TComentarios|default:0} comentario(s)</div>
                            <br>
                            <!-- <hr class="cursos-hr"> -->
                            {/foreach}
                        </ul>
                    </div>
                    {/if}
                {/if}
                 <!--Fin Sub Duscusiones-->
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0" style="font-size: 12px;">
                    <div class="col-xs-7 col-sm-7 col-md-7 col-lg-7 p-rt-lt-0">
                        {if $foro.For_PalabrasClaves != ""}
                        <div class="" style="width: fit-content;line-height: 250%;">
                            <i class="glyphicon glyphicon-tags" style="font-size: 20px; color: #777; text-align: center; vertical-align: middle;"></i>&nbsp;&nbsp;
                            {$tags = explode(",", $foro.For_PalabrasClaves)}
                            {for $i=0; $i<count($tags); $i++}
                            <a class="regresar-tematica" href="{$_layoutParams.root}foro/index/searchForo/{trim($tags[$i])}">{trim($tags[$i])}</a>
                            {/for}
                        </div>
                        {/if}
                        
                    </div>
                    <div class="col-xs-5 col-sm-5 col-md-5 col-lg-5 p-rt-lt-0">
                        <a class="pull-right regresar-tematica2" href="{$linea_tematica_url}">
                            <i class="glyphicon glyphicon-star" style="text-align: center; vertical-align: middle; margin-bottom: 3px;"></i>
                            {$lenguaje.foro_str_tematica}: {$linea_tematica}
                        </a>
                    </div>
                    <div class="col col-xs-12 col-sm-12 col-md-12 col-lg-12 padding-t-20">
                        
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0">
                    <hr class="cursos-hr">
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0">
                    {if Session::get('autenticado')}
                        {if $comentar_foro || $_acl->rolckey("administrador") || $_acl->rolckey("administrador_foro") || $_acl->rolckey("lider_foro") || $_acl->rolckey("moderador_foro")}
                            {if $foro.For_Estado == 0 || $foro.For_Estado == 2 || $foro.Row_Estado == 0}
                                {if $_acl->rolckey("administrador")  || $_acl->rolckey("administrador_foro") || $_acl->rolckey("lider_foro") || $_acl->rolckey("moderador_foro") }
                                    {if $foro.Row_Estado== 1}
                                        {if $foro.For_Estado == 0}
                                            <div class="col-lg-12 p-rt-lt-0 alert alert-danger text-center">
                                                <strong class="texto-alert-danger">!Este foro se encuentra DESHABILITADO!. Si desea habilitarlo, ir al boton de configuración <i class="glyphicon glyphicon-cog"></i> y de click en Habilitar.</strong>
                                            </div>
                                        {else}
                                            <div class="col-lg-12 p-rt-lt-0 alert alert-danger text-center">
                                                <strong class="texto-alert-danger">!Este foro se encuentra CERRADO!. Si desea habilitarlo, ir al boton de configuración <i class="glyphicon glyphicon-cog"></i> y de click en Habilitar.</strong>
                                            </div>
                                        {/if}
                                    {elseif $_acl->rolckey("administrador") || $_acl->rolckey("administrador_foro")}
                                        <div class="col-lg-12 p-rt-lt-0 alert alert-danger text-center">
                                            <strong class="texto-alert-danger">!Este foro se encuentra ELIMINADO!. Si desea habilitarlo, ir al boton de configuración <i class="glyphicon glyphicon-cog"></i> y de click en Restaurar.</strong>
                                        </div> 
                                    {/if}
                                {else}
                                    {if $foro.For_Estado== 2}
                                        <div class="col-lg-12 p-rt-lt-0 alert alert-danger text-center">
                                            <strong class="texto-alert-danger">!Este foro se encuentra cerrado!</strong>
                                        </div>
                                    {/if}
                                {/if}
                            {else}
                                <div class="widget-area no-padding blank">
                                    <div class="status-upload">
                                        <textarea class="estilo-textarea" id="text_comentario_{$foro.For_IdForo}_0" placeholder="Ingrese su comentario" ></textarea>
                                        <div id="div_loading_{$foro.For_IdForo}_0" id_padre="0" class="load_files d-none">
                                        </div>
                                        <ul>
                                            <li><span title="PDF|DOC|PPT|Files" data-toggle="tooltip" data-placement="bottom" data-original-title="PDF|DOC|PPT|Files" class="foro_fileinput" for="files_doc" ><i class="fa fa-file-o"></i> <input name="files_doc" type="file" multiple="" class="files_coment"                                                                                                                                                            accept=".pptx, .pptm, .ppt, .pdf, .xps, .potx, .potm, .pot,.thmx, .ppsx, .ppsm, .pps, .ppam, .ppam, .ppa, .xml, .pptx,.pptx,.rar, .zip"></span></li>
                                            <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"  class="foro_fileinput" for="file_img"><i class="fa fa-picture-o"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="image/*"></span></li>
                                            <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"  class="foro_fileinput" for="files_video"><i class="fa fa-video-camera"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="video/*"></span></li>
                                            <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"  class="foro_fileinput" for="files_son"><i class="fa fa-music"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="audio/*"></span></li>
                                        </ul>
                                        <button  type="button" id_foro="{$foro.For_IdForo}" id_usuario="{Session::get('id_usuario')}" id_padre="0" class="btn btn-success green foro_coment"><i class="fa fa-share"></i>Comentar</button>
                                    </div>                        
                                </div><!-- Widget Area -->
                            {/if}
                        {else}
                            {if $foro.For_Funcion=="forum"}
                                {if $foro.For_Estado== 2}
                                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0 alert alert-danger text-center">
                                    <strong class="texto-alert-danger">!Esta discusión se encuentra cerrada!</strong>
                                    </div>
                                {else}
                                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0">
                                        <button class="btn btn-primary btn-md inscribir_foro" id_foro="{$foro.For_IdForo}">{$lenguaje.foro_str_inscribeteparaparticipar}
                                        <i class="glyphicon glyphicon-log-in"></i></button>
                                    </div>
                                {/if}
                            {else}
                                <div>
                                    <button class="btn btn-primary btn-md inscribir_foro" id_foro="{$foro.For_IdForo}">{$lenguaje.foro_str_inscribeteparaparticipar}
                                    <i class="glyphicon glyphicon-log-in"></i></button>
                                </div>
                            {/if}
                        {/if}
                    {else}
                        {if $foro.For_Estado== 2}
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0 alert alert-danger text-center">
                                    <strong class="texto-alert-danger">!Este foro se encuentra cerrado!</strong>
                                 </div>
                        {else}
                            <div class="">
                                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 anuncio">
                                        <p>{$lenguaje.foro_str_mensajeparainicarsesesion}</p>
                                    </div>
                                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0">
                                        <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-group btn-success ini-sesion">{$lenguaje.foro_str_iniciesesion} <i class="glyphicon glyphicon-log-in"></i></button>
                                        </div>
                            </div>
                        {/if}
                    {/if}
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0">
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 p-rt-lt-0">
                            <h4>
                            <i class="glyphicon glyphicon-comment" style="color: #777; text-align: center; vertical-align: middle; margin-bottom: 3px;"></i>
                            {$lenguaje.str_comentarios}: <strong>{$Numero_comentarios_x_idForo}</strong>
                            </h4>
                    </div>
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 p-rt-lt-0" id="valoraciones_foro">
                        {include file='modules/foro/views/index/ajax/valoraciones_foro.tpl'}
                    </div>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0">
                    <hr class="cursos-hr">
                </div>
                <input type="hidden" id="ficha_foro" name="ficha_foro" value="ficha_foro">
                <div class="clearfix">                        
                </div>
                <div id="lista_comentarios" class="row">
                     {include file='modules/foro/views/index/ajax/lista_comentarios.tpl'}
                </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                {include file='modules/foro/views/index/ajax/include_foro_detalle.tpl'}
            </div>
        </div>
    </div>
</div>
                    <!-- para el reportar comentario -->
<div class="modal fade top-space-0" id="modal-reportar-comentario" tabindex="-1" role="dialog">
    <div class="modal-dialog login-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12 col-xs-12 col-lg-12 col-sm-12">
                        <h2 class="col-md-8 col-xs-8 col-lg-8 col-sm-8">{$lenguaje.foro_str_reportarcomentario}</h2>
                        <input type="hidden" id="idcomentario" name="idcomentario">
                        <button title="cerrar" type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                        </button>
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="col-md-12 col-xs-12 col-lg-12 col-sm-12 panel-heading" style="color: #333; background-color: #F5F5AE; border-color: #ddd;">
                                    <div class="col col-col-md-1 col-xs-1 col-lg-1 col-sm-1 "><img class="img-responsive" src="{$_layoutParams.root_clear}public/img/advertencia.png">
                                    </div>
                                    <div class="col-md-11 col-xs-11 col-lg-11 col-sm-11">
                                    {$lenguaje.foro_str_inforeportarcomentario}
                                    </div>
                                </div>
                                <div class="panel-body">
                                    <div class="row">
                                        <div class="col-md-12 col-xs-12 col-lg-12 col-sm-12">
                                            <div class="form-group">
                                                <label>{$lenguaje.foro_str_mensaje}</label>
                                                <textarea class="form-control" id="ta_mensaje_reportar" name="ta_mensaje_reportar"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                    <button type="button" id_foro="{$foro.For_IdForo}" class="btn btn-primary btn-md enviar_reporte" data-dismiss="modal" style="margin-left: 88%;">{$lenguaje.foro_str_enviar}</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>