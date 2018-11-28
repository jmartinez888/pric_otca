 		<!--Cabecera comentario-->
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 media-heading
        {if empty($is_hijo)} 
        media-heading-jp
        {else}
        media-heading-jp-hijo
        {/if}
        ">
            <div class="col col-xs-8 col-sm-8 col-md-8 col-lg-8">
                <h4 class="user">
                {$commen_body.Usu_Nombre} {$commen_body.Usu_Apellidos} <br>
                </h4>
                <span class="date">{timediff date=$commen_body.Com_Fecha lang=Cookie::lenguaje()} {$commen_body.Com_Fecha}</span>
            </div>
            <div class="col col-xs-4 col-sm-4 col-md-4 col-lg-4 text-right">
                <span title="Opciones"  class="dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" style="cursor: pointer;" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
                    <i class="glyphicon glyphicon-option-vertical"></i>
                </span>
                <ul class="dropdown-menu pull-right">
                    {if Session::get('autenticado')}
                    {if $_acl->Usu_IdUsuario() == $commen_body.Usu_IdUsuario || $Rol_Ckey=="facilitador_foro" || $Rol_Ckey=="moderador_foro" || $Rol_Ckey=="lider_foro" || $Rol_Ckey=="administrador_foro" || $Rol_Ckey=="administrador"}
                    {if $_acl->Usu_IdUsuario() == $commen_body.Usu_IdUsuario}
                    <li><a comentario_="{$commen_body.Com_Descripcion}" id_comentario_editar="{$commen_body.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="editar_comentario_foro files_coment_editar" style="cursor: pointer;">Editar</a></li>
                    {/if}
                    <li><a id_foro="{$foro.For_IdForo}" id_comentario_delete="{$commen_body.Com_IdComentario}" class="eliminar_comentario_foro" style="cursor: pointer;">Eliminar</a></li>
                    {/if}
                    {if $_acl->Usu_IdUsuario() != $commen_body.Usu_IdUsuario}
                    <li><a id_comentario_reportar="{$commen_body.Com_IdComentario}" class="reportar" style="cursor: pointer;" data-toggle="modal" data-target="#modal-reportar-comentario">Reportar</a></li>
                    {/if}
                    {/if}
                    <li><a href="{$_layoutParams.root}foro/index/ficha_comentario_completo/{$foro.For_IdForo}/{$commen_body.Com_IdComentario}" target="_blank" comentario_="{$commen_body.Com_Descripcion}" id_comentario_editar="{$commen_body.Com_IdComentario}" id_foro="{$foro.For_IdForo}" class="" style="cursor: pointer;">Ver comentario en otra página</a></li>
                </ul>
            </div>
        </div>
        <!--Fin Cabecera comentario-->
        <!--Cuerpo comentario-->
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 capa capa-jp capa_{$commen_body.Com_IdComentario}" Rol_Ckey="{$Rol_Ckey}" id_comentario_capa="{$commen_body.Com_IdComentario}">
            <span class="col col-xs-12 col-sm-12 col-md-12 col-lg-12 capaVer1_{$commen_body.Com_IdComentario}">
                {if strlen($commen_body.Com_Descripcion)<=250}
                {$commen_body.Com_Descripcion}
                {else}
                {substr($commen_body.Com_Descripcion, 0, 270)}
                <a class="ver_mas" id_comentario_editar="{$commen_body.Com_IdComentario}" style="cursor: pointer;">...ver más</a>
                {/if}
            </span>
            <span class="col col-xs-12 col-sm-12 col-md-12 col-lg-12 capaVer2_{$commen_body.Com_IdComentario}" style="display:none;" id_comentario_editar="{$commen_body.Com_IdComentario}">
                {substr($commen_body.Com_Descripcion, 0, 1500)}
                <a class="ver_menos" id_comentario_editar="{$commen_body.Com_IdComentario}" style="cursor: pointer;"> ver menos</a>
            </span>
            <!-- Lilstado de file adjunto -->
            {if count($commen_body.Archivos)}
            <div id="div_show_{$foro.For_IdForo}_{$commen_body.Com_IdComentario}" id_padre="{$commen_body.Com_IdComentario}" class="col col-xs-12 col-sm-12 col-md-12 col-lg-12 show_files">
                {foreach from=$commen_body.Archivos  item=file}
                <div class="col-xs-12 files d-block ocultar_archivos_list_{$commen_body.Com_IdComentario}" tabindex="-1">
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
                    <div class="file_size">
                        ({if $file.Fim_SizeFile<1024}
                        {$file.Fim_SizeFile|string_format:'%.1f'} KB
                        {else}
                        {$file.Fim_SizeFile=$file.Fim_SizeFile/1024}
                        {$file.Fim_SizeFile|string_format:'%.1f'} MB
                        {/if})
                    </div>
                </div>
                {/foreach}
            </div>
            {/if}
            <!--Fin Lilstado de file adjunto -->                   
            <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 p-rt-lt-0">
                {if !isset($is_hijo)}   
                    {if $comentar_foro || $Rol_Ckey == "administrador_foro" || $Rol_Ckey == "administrador"}
                    <span class="pull-left" style="font-size: 15px;margin-top: 10px; cursor: pointer;"> <a id_comentario="{$commen_body.Com_IdComentario}" class="coment_coment">Responder</a></span>
                    {/if}
                {/if}

            </div>
             <!-- valoraciones -->
            <div id="valoraciones_comentarios_{$commen_body.Com_IdComentario}" class="col-xs-6 col-sm-6 col-md-6 col-lg-6 p-rt-lt-0 ">
                {include file='modules/foro/views/index/ajax/valoraciones_comentarios.tpl' comment_like=$commen_body}
            </div>
            
        </div>
        <!--Fin Cuerpo comentario-->
        <!-- Para el editar en comentario principal -->
        <div class="status-upload capaEditar_{$commen_body.Com_IdComentario}" idCapaEditar="{$commen_body.Com_IdComentario}" style="display:none;">
            <textarea class="estilo-textarea" id="edit_comentario_{$foro.For_IdForo}_{$commen_body.Com_IdComentario}" placeholder="Ingrese su comentario"></textarea>
            <div id="div_loading_{$foro.For_IdForo}_{$commen_body.Com_IdComentario}" id_padre="{$commen_body.Com_IdComentario}" class="load_files d-none">
            </div>
            <!-- para editar archivos -->
            <input type="hidden" id="Fim_IdForo_{$commen_body.Com_IdComentario}" name="Fim_IdForo_{$commen_body.Com_IdComentario}">
            {foreach from=$commen_body.Archivos  item=file}
            <div id="div_show_{$foro.For_IdForo}_{$commen_body.Com_IdComentario}" id_padre="{$commen_body.Com_IdComentario}" class="show_files restaurar_mostrar_{$commen_body.Com_IdComentario}">
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
                    <div role="button" class="file_close2" tabindex="-1" idcomentario="{$commen_body.Com_IdComentario}" Fim_IdForo="{$file.Fim_IdForo}"></div>
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
            <button type="button" id_foro="{$foro.For_IdForo}" id_usuario="{Session::get('id_usuario')}" id_padre="{$commen_body.Com_IdComentario}" class="btn btn-success green foro_coment_editado"><i class="fa fa-share"></i>Editar</button>

            <button id_foro="{$foro.For_IdForo}"="" id_comentario_editar="{$commen_body.Com_IdComentario}" type="button" class="btn btn-warning green cancelar_comentario_foro"><i class="fa fa-times"></i>Cancelar
            </button>
        </div>
        <!--Fin Para el editar en comentario principal -->
        
        <!-- Formulario para el responder -->
        {if $comentar_foro || $Rol_Ckey == "administrador_foro" || $Rol_Ckey == "administrador"}
        <div id="comen_comen_{$commen_body.Com_IdComentario}" class="col col-xs-12 col-sm-12 col-md-12 col-lg-12 media margin-0 margin-b-10" style="display: none">
            <div class="widget-area no-padding blank">
                <div class="status-upload" id="ocultar_responder{$commen_body.Com_IdComentario}">
                    <textarea class="estilo-textarea" id="text_comentario_{$foro.For_IdForo}_{$commen_body.Com_IdComentario}" placeholder="Ingrese su comentario"></textarea>
                    <div id="div_loading_{$foro.For_IdForo}_{$commen_body.Com_IdComentario}" id_padre="{$commen_body.Com_IdComentario}" class="load_files d-none">
                    </div>
                    <ul>
                        <li><span title="PDF|DOC|PPT|Files" data-toggle="tooltip" data-placement="bottom" data-original-title="PDF|DOC|PPT|Files" class="foro_fileinput" for="files_doc" ><i class="fa fa-file-o"></i> <input name="files_doc" type="file" multiple="" class="files_coment"                                                                                                                                                            accept=".pptx, .pptm, .ppt, .pdf, .xps, .potx, .potm, .pot,.thmx, .ppsx, .ppsm, .pps, .ppam, .ppam, .ppa, .xml, .pptx,.pptx,.rar, .zip"></span></li>
                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"  class="foro_fileinput" for="file_img"><i class="fa fa-picture-o"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="image/*"></span></li>
                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"  class="foro_fileinput" for="files_video"><i class="fa fa-video-camera"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="video/*"></span></li>
                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"  class="foro_fileinput" for="files_son"><i class="fa fa-music"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="audio/*"></span></li>
                    </ul>
                    <button  type="button" id_foro="{$foro.For_IdForo}" id_usuario="{Session::get('id_usuario')}" id_padre="{$commen_body.Com_IdComentario}" class="btn btn-success green foro_coment"><i class="fa fa-share"></i>Comentar</button>
                    <button id_comentario_cancelar_responder="{$commen_body.Com_IdComentario}" type="button" class="btn btn-warning green cancelar_responder_comentario_foro"><i class="fa fa-times"></i>Cancelar</button>
                </div><!-- Status Upload  -->
            </div><!-- Widget Area -->
        </div>
        {/if}
        <!--Fin Formulario para el responder -->