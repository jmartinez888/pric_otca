           
                    {foreach from=$foro.For_Comentarios item=comentarios} 
                        <div class="comment-box">
                            <div class="col-md-1 media-left">
                                <a href="#">
                                    <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
                                </a>
                            </div>
                            <div class="col-md-11 media-body ">
                               <!--  <input type="hidden" name="id_comentario_capa" id="id_comentario_capa" value="{$comentarios.Com_IdComentario}"> -->
                                <h4 class="col-xs-12 media-heading">{$comentarios.Usu_Nombre|upper}
                                    <span> | {$comentarios.Com_Fecha|date_format:"%d-%m-%Y"}</span>
                                    {if $comentar_foro}                                   
                                        <span class="pull-right" style="font-size: 15px"> <button id_comentario="{$comentarios.Com_IdComentario}" class="btn btn-success btn-sm fa fa-comment-o coment_coment"> Responder</button></span>
                                    {/if}                                
                                </h4>
                                <div class="col-xs-12 capa" id_comentario_capa="{$comentarios.Com_IdComentario}">
                                    <span class="col-xs-11">
                                        {$comentarios.Com_Descripcion}
                                    </span>
                                    {if $Rol_Ckey=="administrador_foro" || $_acl->Usu_IdUsuario() == $comentarios.Usu_IdUsuario}
                                    <div class="btn-group col-xs-1">
                                        <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 70%; display: none;">
                                        </button >
                                        {if $Rol_Ckey=="administrador_foro"}
                                        <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                            <li><a href="#">Editar</a></li>
                                            <li><a href="#">Eliminar</a></li>
                                            <li><a href="#">Reportar</a></li>
                                            <li><a href="#">Bloquear</a></li>
                                        </ul>
                                        {/if}
                                        {if $Rol_Ckey=="participante_foro"}
                                        <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                            <li><a href="#">Editar</a></li>
                                            <li><a href="#">Eliminar</a></li>
                                        </ul>
                                        {/if}
                                    </div>
                                    {/if}
                                </div>
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
                                {if $comentar_foro}
                                    <div id="comen_comen_{$comentarios.Com_IdComentario}" class="col-xs-12 media" style="display: none">
                                        <div class="widget-area no-padding blank">
                                            <div class="status-upload">

                                                <textarea class="estilo-textarea" id="text_comentario_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" placeholder="Ingrese su comentario" ></textarea>
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
                                            <!-- <p class="col-xs-12">{$hijo_comentarios.Com_Descripcion}
                                                <span title="Editar o Eliminar" style="top: 0; cursor: pointer; display: none;" class="glyphicon glyphicon-option-horizontal pull-right col-xs-1 opciones_comentario" aria-hidden="true">
                                                </span>
                                            </p> -->
                                            <div class="col-xs-12 capa" id_comentario_capa="{$hijo_comentarios.Com_IdComentario}">
                                                <span class="col-xs-11">
                                                    {$hijo_comentarios.Com_Descripcion}
                                                </span>
                                                {if $Rol_Ckey=="administrador_foro" || $_acl->Usu_IdUsuario() == $hijo_comentarios.Usu_IdUsuario}
                                                <div class="btn-group col-xs-1">
                                                    <button title="Editar o Eliminar" class=" btn btn-default glyphicon glyphicon-option-horizontal dropdown-toggle opciones_comentario_{$hijo_comentarios.Com_IdComentario}" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="right: 25px; display: none;">
                                                    </button >
                                                    {if $Rol_Ckey=="administrador_foro"}
                                                    <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                        <li><a href="#">Editar</a></li>
                                                        <li><a href="#">Eliminar</a></li>
                                                        <li><a href="#">Reportar</a></li>
                                                        <li><a href="#">Bloquear</a></li>
                                                    </ul>
                                                    {/if}
                                                    {if $Rol_Ckey=="participante_foro"}
                                                    <ul class="dropdown-menu" style="left: -400%; z-index: 100 !important; top: -10%;">
                                                        <li><a href="#">Editar</a></li>
                                                        <li><a href="#">Eliminar</a></li>
                                                    </ul>
                                                    {/if}
                                                </div>
                                                {/if}
                                            </div>
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
                
<script type="text/javascript">
    js_option();
</script>