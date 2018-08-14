<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-9 col-xs-12 col-sm-8 col-lg-9">
        <div class="row ficha_foro">
            
            <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
                <div class="col-lg-12 p-rt-lt-0">
                    <h3 class="titulo-ficha">{$foro.For_Titulo}</h3>
                </div>
                <div class="col-lg-12 p-rt-lt-0">
                    <hr class="cursos-hr">
                </div>
                <input type="hidden" id="comentario_completo" name="comentario_completo" value="comentario_completo">
               <div id="lista_comentarios" class="row">               
                    {foreach from=$foro.For_Comentarios item=comentarios} 
                    {if $comentarios.Com_IdComentario == $iCom_IdComentario}
                        <div class="comment-box">
                            <div class="col-md-1 media-left">
                                <a href="#">
                                    <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
                                </a>
                            </div>
                            <div class="col-md-11 media-body ">
                                <h4 class="col-xs-12 media-heading">{$comentarios.Usu_Nombre|upper}
                                    <span> | {$comentarios.Com_Fecha|date_format:"%d-%m-%Y"}</span>    
                                    <div class="btn-group col-xs-1 pull-right">                                        
                                        {if Session::get('autenticado')}   
                                            <!-- para el usuario -->
                                            {if $Rol_Ckey=="participante_foro" && $_acl->Usu_IdUsuario() == $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%;">
                                            </button >
                                             <ul class="dropdown-menu" style="left: -490%; z-index: 100 !important; top: 100%;">
                                                <li><a comentario_="{$comentarios.Com_Descripcion}" id_comentario_editar="{$comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro files_coment_editar" style="cursor: pointer;">Editar</a></li>
                                                <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>                                                    
                                            {/if} 

                                            {if $Rol_Ckey=="participante_foro" && $_acl->Usu_IdUsuario() != $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%;">
                                            </button >
                                            <ul class="dropdown-menu" style="left: -490%; z-index: 100 !important; top: 100%;">
                                               <li><a id_comentario_reportar="{$comentarios.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                            </ul>   
                                            {/if}

                                            {if $_acl->Usu_IdUsuario() != $comentarios.Usu_IdUsuario && $Rol_Ckey=="sin_rol"}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%;">
                                            </button >
                                            <ul class="dropdown-menu" style="left: -490%; z-index: 100 !important; top: 100%;">
                                               <li><a id_comentario_reportar="{$comentarios.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                               <li><a href="{$_layoutParams.root}foro/index/ficha_comentario_completo/{$foro.For_IdForo}/{$comentarios.Com_IdComentario}" target="_blank" comentario_="{$comentarios.Com_Descripcion}" id_comentario_editar="{$comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="" style="cursor: pointer;">Ver comentario en otra página</a></li>
                                            </ul>   
                                            {/if}
                                            <!-- hasta aca --> 
                                            
                                            <!-- para el Facilitador -->
                                            {if $Rol_Ckey=="facilitador_foro" && $_acl->Usu_IdUsuario() == $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%;">
                                            </button >
                                             <ul class="dropdown-menu" style="left: -490%; z-index: 100 !important; top: 100%;">
                                                <li><a comentario_="{$comentarios.Com_Descripcion}" id_comentario_editar="{$comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro files_coment_editar" style="cursor: pointer;">Editar</a></li>
                                                <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>                                                    
                                            {/if} 

                                            {if $Rol_Ckey=="facilitador_foro" && $_acl->Usu_IdUsuario() != $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%;">
                                            </button >
                                            <ul class="dropdown-menu" style="left: -490%; z-index: 100 !important; top: 100%;">
                                               <li><a id_comentario_reportar="{$comentarios.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                               <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>   
                                            {/if}                                                                          
                                            <!-- hasta aca --> 

                                            <!-- para el Moderador -->
                                            {if $Rol_Ckey=="moderador_foro" && $_acl->Usu_IdUsuario() == $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%;">
                                            </button >
                                             <ul class="dropdown-menu" style="left: -490%; z-index: 100 !important; top: 100%;">
                                                <li><a comentario_="{$comentarios.Com_Descripcion}" id_comentario_editar="{$comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro files_coment_editar" style="cursor: pointer;">Editar</a></li>
                                                <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>                                                    
                                            {/if} 

                                            {if $Rol_Ckey=="moderador_foro" && $_acl->Usu_IdUsuario() != $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%;">
                                            </button >
                                            <ul class="dropdown-menu" style="left: -490%; z-index: 100 !important; top: 100%;">
                                               <li><a id_comentario_reportar="{$comentarios.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                               <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>   
                                            {/if}                                            
                                            <!-- hasta aca --> 

                                            <!-- para el Lider -->
                                            {if $Rol_Ckey=="lider_foro" && $_acl->Usu_IdUsuario() == $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%;">
                                            </button >
                                             <ul class="dropdown-menu" style="left: -490%; z-index: 100 !important; top: 100%;">
                                                <li><a comentario_="{$comentarios.Com_Descripcion}" id_comentario_editar="{$comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro files_coment_editar" style="cursor: pointer;">Editar</a></li>
                                                <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>                                                    
                                            {/if} 

                                            {if $Rol_Ckey=="lider_foro" && $_acl->Usu_IdUsuario() != $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%;">
                                            </button >
                                            <ul class="dropdown-menu" style="left: -490%; z-index: 100 !important; top: 100%;">
                                               <li><a id_comentario_reportar="{$comentarios.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                               <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>   
                                            {/if}  
                                            <!-- hasta aca -->

                                            <!-- para el administrador de foros -->
                                            {if $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador" && $_acl->Usu_IdUsuario() == $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%;">
                                            </button >
                                             <ul class="dropdown-menu" style="left: -490%; z-index: 100 !important; top: 100%;">
                                                <li><a comentario_="{$comentarios.Com_Descripcion}" id_comentario_editar="{$comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro files_coment_editar" style="cursor: pointer;">Editar</a></li>
                                                <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>                                                    
                                            {/if} 

                                            {if $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador" && $_acl->Usu_IdUsuario() != $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%;">
                                            </button >
                                            <ul class="dropdown-menu" style="left: -490%; z-index: 100 !important; top: 100%;">
                                               <li><a id_comentario_reportar="{$comentarios.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                               <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>   
                                            {/if} 
                                            <!-- hasta aca --> 
                                        {/if}                             
                                    </div>
                                </h4>
                                <div class="col-xs-12 capa capa_{$comentarios.Com_IdComentario}" Rol_Ckey="{$Rol_Ckey}" id_comentario_capa="{$comentarios.Com_IdComentario}">
                                    <span class="col-xs-11 capaVer1_{$comentarios.Com_IdComentario}">
                                        {$comentarios.Com_Descripcion}
                                    </span>                                  
                                </div>
                                    <!-- Para el editar en comentario principal -->
                                <div class="status-upload capaEditar_{$comentarios.Com_IdComentario}" idCapaEditar="{$comentarios.Com_IdComentario}" style="display:none;">                                    
                                    <textarea class="estilo-textarea" id="edit_comentario_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" placeholder="Ingrese su comentario"></textarea>                                    
                                    <div id="div_loading_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" id_padre="{$comentarios.Com_IdComentario}" class="load_files d-none">
                                    </div>
                                    <!-- para editar archivos -->
                                    <input type="hidden" id="Fim_IdForo_{$comentarios.Com_IdComentario}" name="Fim_IdForo_{$comentarios.Com_IdComentario}">                                    
                                    {foreach from=$comentarios.Archivos  item=file}
                                    <div id="div_show_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" id_padre="{$comentarios.Com_IdComentario}" class="show_files restaurar_mostrar_{$comentarios.Com_IdComentario}">
                                        <div class="files" tabindex="-1">
                                            <div class="file_titulo">{$file.Fim_NombreFile}</div>
                                            {$file.Fim_SizeFile=$file.Fim_SizeFile/1024}
                                            <div class="file_size">
                                                ({if $file.Fim_SizeFile<'1024'}
                                                {$file.Fim_SizeFile|string_format:"%.1f"} KB 
                                                {else} 
                                                    {$file.Fim_SizeFile=$file.Fim_SizeFile/1024} {$file.Fim_SizeFile|string_format:"%.1f"} MB
                                                {/if})
                                            </div>
                                            <div class="file_loading off"></div>
                                            <div role="button" class="file_close2" tabindex="-1" idcomentario="{$comentarios.Com_IdComentario}" Fim_IdForo="{$file.Fim_IdForo}"></div>
                                        </div>
                                    </div>
                                    {/foreach}
                                    <!-- hasta aca -->
                                    <ul>                                        
                                        <li><span title="PDF|DOC|PPT|Files" data-toggle="tooltip" data-placement="bottom" data-original-title="PDF|DOC|PPT|Files" class="foro_fileinput" for="files_doc" ><i class="fa fa-file-o"></i> <input name="files_doc" type="file" multiple="" class="files_coment"                                                                                                                                                            accept=".pptx, .pptm, .ppt, .pdf, .xps, .potx, .potm, .pot,.thmx, .ppsx, .ppsm, .pps, .ppam, .ppam, .ppa, .xml, .pptx,.pptx,.rar, .zip"></span></li>
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"  class="foro_fileinput" for="file_img"><i class="fa fa-picture-o"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="image/*"></span></li>
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"  class="foro_fileinput" for="files_video"><i class="fa fa-video-camera"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="video/*"></span></li>                                                
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"  class="foro_fileinput" for="files_son"><i class="fa fa-music"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="audio/*"></span></li>                                                

                                    </ul>
                                    <button type="button" id_foro="{$foro.For_IdForo}" id_usuario="{Session::get('id_usuario')}" id_padre="{$comentarios.Com_IdComentario}" class="btn btn-success green foro_coment_editado"><i class="fa fa-share"></i>Editar</button>
                                    <button id_foro="{$foro.For_IdForo}"="" id_comentario_editar="{$comentarios.Com_IdComentario}" type="button" class="btn btn-success green cancelar_comentario_foro"><i class="fa fa-share"></i>Cancelar</button>

                                </div><!-- Status Upload  -->
                                
                                <div id="div_show_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" id_padre="{$comentarios.Com_IdComentario}" class="show_files">
                                    {foreach from=$comentarios.Archivos  item=file}
                                        <div class="col-xs-12 files d-block ocultar_archivos_list_{$comentarios.Com_IdComentario}" tabindex="-1">
                                            {if $file.Fim_TipoFile|strstr:"video"}
                                                <i class="fa fa-video-camera"></i>
                                            {/if}
                                            {if $file.Fim_TipoFile|strstr:"image"}
                                                <i class="fa fa-picture-o"></i>
                                            {/if}
                                            {if $file.Fim_TipoFile|strstr:"application"}
                                                <i class="fa fa-file-o"></i>
                                            {/if}
                                            <div class="file_titulo">
                                                <a href="{$_layoutParams.root_archivo_fisico}{$file.Fim_NombreFile}"  title="Descargar" target="_blank">{$file.Fim_NombreFile}</a>
                                            </div>
                                            {$file.Fim_SizeFile=$file.Fim_SizeFile/1024}
                                            <div class="file_size">({if $file.Fim_SizeFile<1024}{$file.Fim_SizeFile|string_format:"%.1f"} KB {else} {$file.Fim_SizeFile=$file.Fim_SizeFile/1024} {$file.Fim_SizeFile|string_format:"%.1f"} MB{/if})</div>

                                            </div>
                                    {/foreach}
                                        </div>
                                {if $comentar_foro || $Rol_Ckey == "administrador_foro"}
                                <!-- para el responder -->
                                    <div id="comen_comen_{$comentarios.Com_IdComentario}" class="col-xs-12 media" style="display: none">
                                        <div class="widget-area no-padding blank">
                                            <div class="status-upload" id="ocultar_responder{$comentarios.Com_IdComentario}">
                                                <textarea class="estilo-textarea" id="text_comentario_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" placeholder="Ingrese su comentario"></textarea>
                                                <div id="div_loading_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" id_padre="{$comentarios.Com_IdComentario}" class="load_files d-none">

                                                </div>
                                                <ul>                                        
                                                    <li><span title="PDF|DOC|PPT|Files" data-toggle="tooltip" data-placement="bottom" data-original-title="PDF|DOC|PPT|Files" class="foro_fileinput" for="files_doc" ><i class="fa fa-file-o"></i> <input name="files_doc" type="file" multiple="" class="files_coment"                                                                                                                                                            accept=".pptx, .pptm, .ppt, .pdf, .xps, .potx, .potm, .pot,.thmx, .ppsx, .ppsm, .pps, .ppam, .ppam, .ppa, .xml, .pptx,.pptx,.rar, .zip"></span></li>
                                                    <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"  class="foro_fileinput" for="file_img"><i class="fa fa-picture-o"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="image/*"></span></li>
                                                    <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"  class="foro_fileinput" for="files_video"><i class="fa fa-video-camera"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="video/*"></span></li>                                                
                                                    <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"  class="foro_fileinput" for="files_son"><i class="fa fa-music"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="audio/*"></span></li>
                                                </ul>
                                                <button  type="button" id_foro="{$foro.For_IdForo}" id_usuario="{Session::get('id_usuario')}" id_padre="{$comentarios.Com_IdComentario}" class="btn btn-success green foro_coment"><i class="fa fa-share"></i>Comentar</button>
                                                <button id_comentario_cancelar_responder="{$comentarios.Com_IdComentario}" type="button" class="btn btn-success green cancelar_responder_comentario_foro"><i class="fa fa-share"></i>Cancelar</button>
                                            </div><!-- Status Upload  -->
                                        </div><!-- Widget Area -->
                                    </div>
                                {/if}
                            </div>
                        </div>   
                    {/if}            
                    {/foreach}
                    <!-- para listar solo hijo -->
                    {foreach from=$foro.For_Comentarios item=comentarios} 
                    {foreach from=$comentarios.Hijo_Comentarios item=hijo_comentarios}
                        {if $hijo_comentarios.Com_IdComentario == $iCom_IdComentario}
                        <div class="comment-box">
                            <div class="col-xs-12 media">
                                        <div class="col-md-1 media-left">
                                            <a href="#">
                                                <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
                                            </a>
                                        </div>
                                        <div class="col-md-12 media-body">
                                            <h4 class="col-xs-12 media-heading">{$hijo_comentarios.Usu_Nombre|upper}
                                                <span> | {$hijo_comentarios.Com_Fecha|date_format:"%d-%m-%Y"}</span>
                                                <div class="btn-group col-xs-1 pull-right">   
                                                {if Session::get('autenticado')}   
                                                <!-- para el usuario -->
                                                    {if $Rol_Ckey=="participante_foro" && $_acl->Usu_IdUsuario() == $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 18px;">
                                                    </button >
                                                     <ul class="dropdown-menu" style="left: -650%; z-index: 100 !important; top: 100%;">
                                                        <li><a comentario_="{$hijo_comentarios.Com_Descripcion}" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro files_coment_editar" style="cursor: pointer;">Editar</a></li>
                                                        <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>                                                    
                                                    {/if} 

                                                    {if $Rol_Ckey=="participante_foro" && $_acl->Usu_IdUsuario() != $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 18px;">
                                                    </button >
                                                    <ul class="dropdown-menu" style="left: -650%; z-index: 100 !important; top: 100%;">
                                                       <li><a id_comentario_reportar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                                    </ul>   
                                                    {/if}

                                                    {if $Rol_Ckey=="sin_rol" && $_acl->Usu_IdUsuario() != $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 18px;">
                                                    </button >
                                                    <ul class="dropdown-menu" style="left: -650%; z-index: 100 !important; top: 100%;">
                                                       <li><a id_comentario_reportar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                                    </ul>   
                                                    {/if}
                                                    <!-- hasta aca --> 
                                                    
                                                    <!-- para el Facilitador -->
                                                    {if $Rol_Ckey=="facilitador_foro" && $_acl->Usu_IdUsuario() == $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 18px;">
                                                    </button >
                                                     <ul class="dropdown-menu" style="left: -650%; z-index: 100 !important; top: 100%;">
                                                        <li><a comentario_="{$hijo_comentarios.Com_Descripcion}" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro files_coment_editar" style="cursor: pointer;">Editar</a></li>
                                                        <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>                                                    
                                                    {/if} 

                                                    {if $Rol_Ckey=="facilitador_foro" && $_acl->Usu_IdUsuario() != $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 18px;">
                                                    </button >
                                                    <ul class="dropdown-menu" style="left: -650%; z-index: 100 !important; top: 100%;">
                                                       <li><a id_comentario_reportar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>  
                                                       <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>   
                                                    {/if}                                                                          
                                                    <!-- hasta aca --> 

                                                    <!-- para el Moderador -->
                                                    {if $Rol_Ckey=="moderador_foro" && $_acl->Usu_IdUsuario() == $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 18px;">
                                                    </button >
                                                     <ul class="dropdown-menu" style="left: -650%; z-index: 100 !important; top: 100%;">
                                                        <li><a comentario_="{$hijo_comentarios.Com_Descripcion}" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro files_coment_editar" style="cursor: pointer;">Editar</a></li>
                                                        <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>                                                    
                                                    {/if} 

                                                    {if $Rol_Ckey=="moderador_foro" && $_acl->Usu_IdUsuario() != $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 18px;">
                                                    </button >
                                                    <ul class="dropdown-menu" style="left: -650%; z-index: 100 !important; top: 100%;">
                                                       <li><a id_comentario_reportar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>  
                                                       <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>   
                                                    {/if}                                            
                                                    <!-- hasta aca --> 

                                                    <!-- para el Lider -->
                                                    {if $Rol_Ckey=="lider_foro" && $_acl->Usu_IdUsuario() == $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 18px;">
                                                    </button >
                                                     <ul class="dropdown-menu" style="left: -650%; z-index: 100 !important; top: 100%;">
                                                        <li><a comentario_="{$hijo_comentarios.Com_Descripcion}" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro files_coment_editar" style="cursor: pointer;">Editar</a></li>
                                                        <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>                                                    
                                                    {/if} 

                                                    {if $Rol_Ckey=="lider_foro" && $_acl->Usu_IdUsuario() != $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 18px;">
                                                    </button >
                                                    <ul class="dropdown-menu" style="left: -650%; z-index: 100 !important; top: 100%;">
                                                       <li><a id_comentario_reportar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>  
                                                       <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>   
                                                    {/if}  
                                                    <!-- hasta aca -->

                                                    <!-- para el administrador de foros -->
                                                    {if $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador" && $_acl->Usu_IdUsuario() == $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 18px;">
                                                    </button >
                                                     <ul class="dropdown-menu" style="left: -650%; z-index: 100 !important; top: 100%;">
                                                        <li><a comentario_="{$hijo_comentarios.Com_Descripcion}" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro files_coment_editar" style="cursor: pointer;">Editar</a></li>
                                                        <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>                                                    
                                                    {/if} 

                                                    {if $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador" && $_acl->Usu_IdUsuario() != $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 18px;">
                                                    </button >
                                                    <ul class="dropdown-menu" style="left: -650%; z-index: 100 !important; top: 100%;">
                                                       <li><a id_comentario_reportar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>  
                                                       <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>   
                                                    {/if} 
                                                <!-- hasta aca --> 
                                                {/if}
                                                </div>
                                            </h4>
                                            <div class="col-xs-12 capa capa_{$hijo_comentarios.Com_IdComentario}" id_comentario_capa="{$hijo_comentarios.Com_IdComentario}">
                                                <span class="col-xs-11 capaVer1_{$hijo_comentarios.Com_IdComentario}">
                                                    {$hijo_comentarios.Com_Descripcion}
                                                </span>                                               
                                            </div>
                                                <!-- Para el editar en el hijo -->
                                                <div class="status-upload capaEditar_{$hijo_comentarios.Com_IdComentario}" idCapaEditar="{$hijo_comentarios.Com_IdComentario}" style="display:none;">
                                                    <textarea class="estilo-textarea" id="edit_comentario_{$foro.For_IdForo}_{$hijo_comentarios.Com_IdComentario}" placeholder="Ingrese su comentario"></textarea>
                                                    <div id="div_loading_{$foro.For_IdForo}_{$hijo_comentarios.Com_IdComentario}" id_padre="{$hijo_comentarios.Com_IdComentario}" class="load_files d-none"></div>
                                                     <input type="hidden" id="Fim_IdForo_{$hijo_comentarios.Com_IdComentario}" name="Fim_IdForo_{$hijo_comentarios.Com_IdComentario}">
                                                    <!-- para editar archivos -->
                                                    {foreach from=$hijo_comentarios.Archivos  item=file}
                                                    <div id="div_show_{$foro.For_IdForo}_{$hijo_comentarios.Com_IdComentario}" id_padre="{$hijo_comentarios.Com_IdComentario}" class="show_files restaurar_mostrar_{$hijo_comentarios.Com_IdComentario}">
                                                        <div class="files" tabindex="-1">
                                                            <div class="file_titulo">{$file.Fim_NombreFile}</div>
                                                            {$file.Fim_SizeFile=$file.Fim_SizeFile/1024}
                                                            <div class="file_size">
                                                                ({if $file.Fim_SizeFile<'1024'}
                                                                {$file.Fim_SizeFile|string_format:"%.1f"} KB 
                                                                {else} 
                                                                    {$file.Fim_SizeFile=$file.Fim_SizeFile/1024} {$file.Fim_SizeFile|string_format:"%.1f"} MB
                                                                {/if})
                                                            </div>
                                                            <div class="file_loading off"></div>
                                                            <div role="button" class="file_close2" tabindex="-1" idcomentario="{$hijo_comentarios.Com_IdComentario}" Fim_IdForo="{$file.Fim_IdForo}"></div>
                                                        </div>
                                                    </div>
                                                    {/foreach}
                                                    <!-- hasta aca -->
                                                    <ul>                                        
                                                        <li><span title="PDF|DOC|PPT|Files" data-toggle="tooltip" data-placement="bottom" data-original-title="PDF|DOC|PPT|Files" class="foro_fileinput" for="files_doc" ><i class="fa fa-file-o"></i> <input name="files_doc" type="file" multiple="" class="files_coment"                                                                                                                                                            accept=".pptx, .pptm, .ppt, .pdf, .xps, .potx, .potm, .pot,.thmx, .ppsx, .ppsm, .pps, .ppam, .ppam, .ppa, .xml, .pptx,.pptx,.rar, .zip"></span></li>
                                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"  class="foro_fileinput" for="file_img"><i class="fa fa-picture-o"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="image/*"></span></li>
                                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"  class="foro_fileinput" for="files_video"><i class="fa fa-video-camera"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="video/*"></span></li>                                                
                                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"  class="foro_fileinput" for="files_son"><i class="fa fa-music"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="audio/*"></span></li>                                                

                                                    </ul>
                                                    <button  type="button" id_foro="{$foro.For_IdForo}" id_usuario="{Session::get('id_usuario')}" id_padre="{$hijo_comentarios.Com_IdComentario}" class="btn btn-success green foro_coment_editado"><i class="fa fa-share"></i>Editar</button>
                                                    <button id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" type="button" class="btn btn-success green cancelar_comentario_foro"><i class="fa fa-share"></i>Cancelar</button>
                                                </div><!-- Status Upload hasta aqui. -->
                                            <div id="div_show_{$foro.For_IdForo}_{$hijo_comentarios.Com_IdComentario}" id_padre="{$comentarios.Com_IdComentario}" class="show_files">
                                                {foreach from=$hijo_comentarios.Archivos  item=file}
                                                    <div class="files d-block ocultar_archivos_list_{$hijo_comentarios.Com_IdComentario}" tabindex="-1" id="">
                                                        {if $file.Fim_TipoFile|strstr:"video"}
                                                            <i class="fa fa-video-camera"></i>
                                                        {/if}
                                                        {if $file.Fim_TipoFile|strstr:"image"}
                                                            <i class="fa fa-picture-o"></i>
                                                        {/if}
                                                        {if $file.Fim_TipoFile|strstr:"application"}
                                                            <i class="fa fa-file-o"></i>
                                                        {/if}
                                                        {if $file.Fim_TipoFile|strstr:"audio"}
                                                            <i class="fa fa-music"></i>
                                                        {/if}
                                                        <div class="file_titulo">
                                                            <a href="{$_layoutParams.root_archivo_fisico}{$file.Fim_NombreFile}" title="Descargar" target="_blank">{$file.Fim_NombreFile}</a>                                                    
                                                        </div>
                                                        {$file.Fim_SizeFile=$file.Fim_SizeFile/1024}
                                                        <div class="file_size">({if $file.Fim_SizeFile<1024}{$file.Fim_SizeFile|string_format:"%.1f"} KB {else} {$file.Fim_SizeFile=$file.Fim_SizeFile/1024} {$file.Fim_SizeFile|string_format:"%.1f"} MB{/if})</div>

                                                        </div>
                                                {/foreach} 
                                            </div>
                                        </div>
                                    </div>     
                        </div>
                        {/if}                          
                    {/foreach}          
                    {/foreach}
                </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                <div class="addon">
                    <label class="tit-integrante">Facilitado Por</label>
                    <ul>
                        {foreach from=$facilitadores item=facilitador} 
                            <li class="clearfix">
                                <a href="#" target="_blank">
                                    <div class="col-lg-4">
                                        <img class="round" src="https://8share-production-my.s3.amazonaws.com/campaigns/4898/photos/profile/thumb_copy.png?1397732185" alt="Perfil">
                                    </div>
                                </a>
                                <div class="col-lg-8 legend-info p-rt-lt-0">
                                    <a href="#" target="_blank">
                                        <strong class="underline">{$facilitador.Usu_Nombre} {$facilitador.Usu_Apellidos}</strong>
                                    </a>
                                        <hr class="cursos-hr2">                                
                                        {$facilitador.Rol_Nombre} <br>
                                        {$facilitador.Usu_InstitucionLaboral}
                                </div>
                                
                            </li> 
                        {/foreach}
                    </ul>
                </div>
                {if count($foro.Archivos)>0}
                    <div class="addon">
                        <label class="tit-integrante">Recursos</label>
                        <ul id="div_show_{$foro.For_IdForo}">
                            {foreach from=$foro.Archivos  item=file}
                                <li tabindex="-1" id="">
                                    {if $file.Fif_TipoFile|strstr:"video"}
                                        <i class="fa fa-video-camera"></i>
                                    {/if}
                                    {if $file.Fif_TipoFile|strstr:"image"}
                                        <i class="fa fa-picture-o"></i>
                                    {/if}
                                    {if $file.Fif_TipoFile|strstr:"application"}
                                        <i class="fa fa-file-o"></i>
                                    {/if}
                                    <div class="">
                                        <a class="file_titulo2 underline" href="{$_layoutParams.root_archivo_fisico}{$file.Fif_NombreFile}"  title="Descargar" target="_blank">{substr($file.Fif_NombreFile, 0, 33)}...</a>                                              
                                    </div>
                                    {$file.Fif_SizeFile=$file.Fif_SizeFile/1024}
                                    <div class="file_size">({if $file.Fif_SizeFile<1}{$file.Fif_SizeFile|string_format:"%.3f"} K {else} {$file.Fif_SizeFile=$file.Fif_SizeFile/1024} {$file.Fif_SizeFile|string_format:"%.3f"} M{/if})</div>
                                </li>
                            {/foreach}
                        </ul>
                    </div>
                {/if}
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
                        <h2 class="col-xs-8">Reporta un Comentario</h2>
                        <input type="hidden" id="idcomentario" name="idcomentario">
                        <button title="cerrar" type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="col-xs-12 panel-heading" style="color: #333; background-color: #F5F5AE; border-color: #ddd;">
                                <div class="col col-xs-1"><img src="{$_layoutParams.root_clear}public/img/advertencia.png">
                                </div>
                                <div class="col-xs-11">
                                    Tus comentarios nos ayudan a determinar cuándo algo no es apropiado. A continuación indicanos cúal es tu motivo para reportar este comentario.</div>
                                </div>                                   
                                <div class="panel-body"> 
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>Mensaje</label>
                                                <textarea class="form-control" id="ta_mensaje_reportar" name="ta_mensaje_reportar"></textarea>  
                                            </div>
                                        </div>
                                    </div>
                                <button type="button" id_foro="52" class="btn btn-primary btn-md enviar_reporte" data-dismiss="modal" style="margin-left: 88%;">Enviar</button>
                                </div>                               
                            </div>
                        </div>
    
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>