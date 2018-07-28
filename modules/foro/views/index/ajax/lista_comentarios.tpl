<!-- <div id="lista_comentarios" class="row">   -->             
                    {foreach from=$foro.For_Comentarios item=comentarios} 
                        <div class="comment-box">
                            <div class="col-md-1 media-left">
                                <a href="#">
                                    <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
                                </a>
                            </div>
                            <div class="col-md-11 media-body ">
                                <h4 class="col-xs-12 media-heading">{$comentarios.Usu_Nombre|upper}
                                    <span> | {$comentarios.Com_Fecha|date_format:"%d-%m-%Y"}</span>
                                    {if $comentar_foro || $Rol_Ckey == "administrador_foro"}                                   
                                        <span class="pull-right" style="font-size: 15px"> <button id_comentario="{$comentarios.Com_IdComentario}" class="btn btn-success btn-sm fa fa-comment-o coment_coment"> Responder</button></span>
                                    {/if}                                
                                </h4>
                                <div class="col-xs-12 capa capa_{$comentarios.Com_IdComentario}" Rol_Ckey="{$Rol_Ckey}" id_comentario_capa="{$comentarios.Com_IdComentario}">
                                    <span class="col-xs-11 capaVer1_{$comentarios.Com_IdComentario}">
                                        {if strlen($comentarios.Com_Descripcion)<=250}
                                            {$comentarios.Com_Descripcion}
                                        {else}
                                            {substr($comentarios.Com_Descripcion, 0, 250)}
                                        <a class="ver_mas" id_comentario_editar="{$comentarios.Com_IdComentario}" style="cursor: pointer;">...ver todo</a>
                                        {/if}
                                    </span>
                                    <span class="col-xs-11 capaVer2_{$comentarios.Com_IdComentario}" style="display:none;" id_comentario_editar="{$comentarios.Com_IdComentario}">
                                        {$comentarios.Com_Descripcion}
                                        <a class="ver_menos" id_comentario_editar="{$comentarios.Com_IdComentario}" style="cursor: pointer;">...ver menos</a>
                                    </span>
                                    <!-- <span class="col-xs-11">
                                        {if strlen($comentarios.Com_Descripcion)<=250}
                                            {$comentarios.Com_Descripcion}
                                        {else}
                                            {substr($comentarios.Com_Descripcion, 0, 250)}
                                        <a href="{$_layoutParams.root}foro/index/ficha_comentario_completo/{$foro.For_IdForo}/{$comentarios.Com_IdComentario}" title="ver comentario completo">...ver mas</a>
                                        {/if}
                                    </span> -->
                                    <div class="btn-group col-xs-1">                                        
                                        {if Session::get('autenticado')}   
                                            <!-- para el usuario -->
                                            {if $Rol_Ckey=="participante_foro" && $_acl->Usu_IdUsuario() == $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%; display: none;">
                                            </button >
                                             <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                <li><a comentario_="{$comentarios.Com_Descripcion}" id_comentario_editar="{$comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro" style="cursor: pointer;">Editar</a></li>
                                                <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>                                                    
                                            {/if} 

                                            {if $Rol_Ckey=="participante_foro" && $_acl->Usu_IdUsuario() != $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%; display: none;">
                                            </button >
                                            <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                               <li><a id_comentario_reportar="{$comentarios.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                            </ul>   
                                            {/if}
                                            <!-- hasta aca --> 
                                            
                                            <!-- para el Facilitador -->
                                            {if $Rol_Ckey=="facilitador_foro" && $_acl->Usu_IdUsuario() == $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%; display: none;">
                                            </button >
                                             <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                <li><a comentario_="{$comentarios.Com_Descripcion}" id_comentario_editar="{$comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro" style="cursor: pointer;">Editar</a></li>
                                                <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>                                                    
                                            {/if} 

                                            {if $Rol_Ckey=="facilitador_foro" && $_acl->Usu_IdUsuario() != $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%; display: none;">
                                            </button >
                                            <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                               <li><a id_comentario_reportar="{$comentarios.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                               <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>   
                                            {/if}                                                                          
                                            <!-- hasta aca --> 

                                            <!-- para el Moderador -->
                                            {if $Rol_Ckey=="moderador_foro" && $_acl->Usu_IdUsuario() == $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%; display: none;">
                                            </button >
                                             <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                <li><a comentario_="{$comentarios.Com_Descripcion}" id_comentario_editar="{$comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro" style="cursor: pointer;">Editar</a></li>
                                                <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>                                                    
                                            {/if} 

                                            {if $Rol_Ckey=="moderador_foro" && $_acl->Usu_IdUsuario() != $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%; display: none;">
                                            </button >
                                            <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                               <li><a id_comentario_reportar="{$comentarios.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                               <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>   
                                            {/if}                                            
                                            <!-- hasta aca --> 

                                            <!-- para el Lider -->
                                            {if $Rol_Ckey=="lider_foro" && $_acl->Usu_IdUsuario() == $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%; display: none;">
                                            </button >
                                             <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                <li><a comentario_="{$comentarios.Com_Descripcion}" id_comentario_editar="{$comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro" style="cursor: pointer;">Editar</a></li>
                                                <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>                                                    
                                            {/if} 

                                            {if $Rol_Ckey=="lider_foro" && $_acl->Usu_IdUsuario() != $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%; display: none;">
                                            </button >
                                            <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                               <li><a id_comentario_reportar="{$comentarios.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                               <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>   
                                            {/if}  
                                            <!-- hasta aca -->

                                            <!-- para el administrador de foros -->
                                            {if $Rol_Ckey=="administrador_foro" && $_acl->Usu_IdUsuario() == $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%; display: none;">
                                            </button >
                                             <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                <li><a comentario_="{$comentarios.Com_Descripcion}" id_comentario_editar="{$comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro" style="cursor: pointer;">Editar</a></li>
                                                <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>                                                    
                                            {/if} 

                                            {if $Rol_Ckey=="administrador_foro" && $_acl->Usu_IdUsuario() != $comentarios.Usu_IdUsuario}
                                            <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%; display: none;">
                                            </button >
                                            <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                               <li><a id_comentario_reportar="{$comentarios.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                                               <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                            </ul>   
                                            {/if} 
                                            <!-- hasta aca --> 
                                        {/if}                             
                                    </div>
                                </div>
                                    <!-- Para el editar en comentario principal -->
                                <div class="status-upload capaEditar_{$comentarios.Com_IdComentario}" idCapaEditar="{$comentarios.Com_IdComentario}" style="display:none;">
                                    <textarea class="estilo-textarea" id="edit_comentario_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" placeholder="Ingrese su comentario"></textarea>
                                    <div id="div_loading_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" id_padre="{$comentarios.Com_IdComentario}" class="load_files d-none">

                                    </div>
                                    <ul>                                        
                                        <li><span title="PDF|DOC|PPT|Files" data-toggle="tooltip" data-placement="bottom" data-original-title="PDF|DOC|PPT|Files" class="foro_fileinput" for="files_doc" ><i class="fa fa-file-o"></i> <input name="files_doc" type="file" multiple="" class="files_coment"                                                                                                                                                            accept=".pptx, .pptm, .ppt, .pdf, .xps, .potx, .potm, .pot,.thmx, .ppsx, .ppsm, .pps, .ppam, .ppam, .ppa, .xml, .pptx,.pptx,.rar, .zip"></span></li>
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"  class="foro_fileinput" for="file_img"><i class="fa fa-picture-o"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="image/*"></span></li>
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"  class="foro_fileinput" for="files_video"><i class="fa fa-video-camera"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="video/*"></span></li>                                                
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"  class="foro_fileinput" for="files_son"><i class="fa fa-music"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="audio/*"></span></li>                                                

                                    </ul>
                                    <button type="button" id_foro="{$foro.For_IdForo}" id_usuario="{Session::get('id_usuario')}" id_padre="{$comentarios.Com_IdComentario}" class="btn btn-success green foro_coment_editado"><i class="fa fa-share"></i>Editar</button>
                                    <button id_comentario_editar="{$comentarios.Com_IdComentario}" type="button" class="btn btn-success green cancelar_comentario_foro"><i class="fa fa-share"></i>Cancelar</button>

                                </div><!-- Status Upload  -->
                                
                                <div id="div_show_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" id_padre="{$comentarios.Com_IdComentario}" class="show_files">
                                    {foreach from=$comentarios.Archivos  item=file}
                                        <div class="col-xs-12 files" tabindex="-1" id="">
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
                                            <div class="file_size">({if $file.Fim_SizeFile<1}{$file.Fim_SizeFile|string_format:"%.3f"} K {else} {$file.Fim_SizeFile=$file.Fim_SizeFile/1024} {$file.Fim_SizeFile|string_format:"%.3f"} M{/if})</div>

                                            </div>
                                        {/foreach}
                                        </div>
                                {if $comentar_foro || $Rol_Ckey == "administrador_foro"}
                                    <div id="comen_comen_{$comentarios.Com_IdComentario}" class="col-xs-12 media" style="display: none">
                                        <div class="widget-area no-padding blank">
                                            <div class="status-upload">
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
                                            </div><!-- Status Upload  -->
                                        </div><!-- Widget Area -->
                                    </div>
                                {/if}
                                {foreach from=$comentarios.Hijo_Comentarios item=hijo_comentarios}
                                    <div class="col-xs-12 media">
                                        <div class="col-md-1 media-left">
                                            <a href="#">
                                                <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
                                            </a>
                                        </div>
                                        <div class="col-md-12 media-body">
                                            <h4 class="col-xs-12 media-heading">{$hijo_comentarios.Usu_Nombre|upper}
                                                <span> | {$hijo_comentarios.Com_Fecha|date_format:"%d-%m-%Y"}</span>
                                            </h4>
                                            <div class="col-xs-12 capa capa_{$hijo_comentarios.Com_IdComentario}" id_comentario_capa="{$hijo_comentarios.Com_IdComentario}">
                                                <span class="col-xs-11 capaVer1_{$hijo_comentarios.Com_IdComentario}">
                                                    {if strlen($hijo_comentarios.Com_Descripcion)<=250}
                                                        {$hijo_comentarios.Com_Descripcion}
                                                    {else}
                                                        {substr($hijo_comentarios.Com_Descripcion, 0, 250)}
                                                    <a class="ver_mas" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;">...ver todo</a>
                                                    {/if}
                                                </span>
                                                <span class="col-xs-11 capaVer2_{$hijo_comentarios.Com_IdComentario}" style="display:none;" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}">
                                                    {$hijo_comentarios.Com_Descripcion}
                                                    <a class="ver_menos" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;">...ver menos</a>
                                                </span>
                                                <!-- <span class="col-xs-11">
                                                    {if strlen($hijo_comentarios.Com_Descripcion)<=250}
                                                        {$hijo_comentarios.Com_Descripcion}
                                                    {else}
                                                        {substr($hijo_comentarios.Com_Descripcion, 0, 250)}
                                                    <a href="{$_layoutParams.root}foro/index/ficha_comentario_completo/{$foro.For_IdForo}/{$hijo_comentarios.Com_IdComentario}" title="ver comentario completo">...ver mas</a>
                                                    {/if}
                                                </span> -->
                                                <div class="btn-group col-xs-1">   
                                                {if Session::get('autenticado')}   
                                                <!-- para el usuario -->
                                                    {if $Rol_Ckey=="participante_foro" && $_acl->Usu_IdUsuario() == $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 25px; display: none;">
                                                    </button >
                                                     <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                        <li><a comentario_="{$hijo_comentarios.Com_Descripcion}" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro" style="cursor: pointer;">Editar</a></li>
                                                        <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>                                                    
                                                    {/if} 

                                                    {if $Rol_Ckey=="participante_foro" && $_acl->Usu_IdUsuario() != $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 25px; display: none;">
                                                    </button >
                                                    <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                       <li><a id_comentario_reportar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;">Reportar</a></li>
                                                    </ul>   
                                                    {/if}
                                                    <!-- hasta aca --> 
                                                    
                                                    <!-- para el Facilitador -->
                                                    {if $Rol_Ckey=="facilitador_foro" && $_acl->Usu_IdUsuario() == $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 25px; display: none;">
                                                    </button >
                                                     <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                        <li><a comentario_="{$hijo_comentarios.Com_Descripcion}" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro" style="cursor: pointer;">Editar</a></li>
                                                        <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>                                                    
                                                    {/if} 

                                                    {if $Rol_Ckey=="facilitador_foro" && $_acl->Usu_IdUsuario() != $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 25px; display: none;">
                                                    </button >
                                                    <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                       <li><a id_comentario_reportar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;">Reportar</a></li>
                                                       <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>   
                                                    {/if}                                                                          
                                                    <!-- hasta aca --> 

                                                    <!-- para el Moderador -->
                                                    {if $Rol_Ckey=="moderador_foro" && $_acl->Usu_IdUsuario() == $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 25px; display: none;">
                                                    </button >
                                                     <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                        <li><a comentario_="{$hijo_comentarios.Com_Descripcion}" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro" style="cursor: pointer;">Editar</a></li>
                                                        <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>                                                    
                                                    {/if} 

                                                    {if $Rol_Ckey=="moderador_foro" && $_acl->Usu_IdUsuario() != $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 25px; display: none;">
                                                    </button >
                                                    <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                       <li><a id_comentario_reportar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;">Reportar</a></li>
                                                       <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>   
                                                    {/if}                                            
                                                    <!-- hasta aca --> 

                                                    <!-- para el Lider -->
                                                    {if $Rol_Ckey=="lider_foro" && $_acl->Usu_IdUsuario() == $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 25px; display: none;">
                                                    </button >
                                                     <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                        <li><a comentario_="{$hijo_comentarios.Com_Descripcion}" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro" style="cursor: pointer;">Editar</a></li>
                                                        <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>                                                    
                                                    {/if} 

                                                    {if $Rol_Ckey=="lider_foro" && $_acl->Usu_IdUsuario() != $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 25px; display: none;">
                                                    </button >
                                                    <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                       <li><a id_comentario_reportar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;">Reportar</a></li>
                                                       <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>   
                                                    {/if}  
                                                    <!-- hasta aca -->

                                                    <!-- para el administrador de foros -->
                                                    {if $Rol_Ckey=="administrador_foro" && $_acl->Usu_IdUsuario() == $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 25px; display: none;">
                                                    </button >
                                                     <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                        <li><a comentario_="{$hijo_comentarios.Com_Descripcion}" id_comentario_editar="{$hijo_comentarios.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro" style="cursor: pointer;">Editar</a></li>
                                                        <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>                                                    
                                                    {/if} 

                                                    {if $Rol_Ckey=="administrador_foro" && $_acl->Usu_IdUsuario() != $hijo_comentarios.Usu_IdUsuario}
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 25px; display: none;">
                                                    </button >
                                                    <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                       <li><a id_comentario_reportar="{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;">Reportar</a></li>
                                                       <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$hijo_comentarios.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                                                    </ul>   
                                                    {/if} 
                                                <!-- hasta aca --> 
                                                {/if} 
                                                </div>
                                            </div>
                                                <!-- Para el editar en el hijo -->
                                                <div class="status-upload capaEditar_{$hijo_comentarios.Com_IdComentario}" idCapaEditar="{$hijo_comentarios.Com_IdComentario}" style="display:none;">
                                                    <textarea class="estilo-textarea" id="edit_comentario_{$foro.For_IdForo}_{$hijo_comentarios.Com_IdComentario}" placeholder="Ingrese su comentario"></textarea>
                                                    <div id="div_loading_{$foro.For_IdForo}_{$hijo_comentarios.Com_IdComentario}" id_padre="{$comentarios.Com_IdComentario}" class="load_files d-none">

                                                    </div>
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
                                                    <div class="files" tabindex="-1" id="">
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
                                                        <div class="file_size">({if $file.Fim_SizeFile<1}{$file.Fim_SizeFile|string_format:"%.3f"} K {else} {$file.Fim_SizeFile=$file.Fim_SizeFile/1024} {$file.Fim_SizeFile|string_format:"%.3f"} M{/if})</div>

                                                    </div>
                                                {/foreach}
                                            </div>
                                        </div>
                                    </div>                          
                                {/foreach}
                            </div>
                        </div>                
                    {/foreach}
               <!--  </div> -->
<script type="text/javascript">
    js_option();
</script>