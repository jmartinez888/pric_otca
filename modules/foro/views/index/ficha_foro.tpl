<div  class="container" >
    <div class="row ficha_foro">
        <div class="col-xs-12 col-sm-8 col-md-9 col-lg-9">
            <div class="row">
                <div class="col-md-6">
                    <span>{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"} {if ($foro.For_FechaCierre|date_format:"%d-%m-%Y")!=""} / {($foro.For_FechaCierre|date_format:"%d-%m-%Y")}{/if}</span>
                </div>
                <div class="col-md-6 text-right">
                    Colaboraciones <span class="badge">{$foro.For_TComentarios}</span> 
                </div>
                <div class="page-header">
                    <h3 class="titulo-view">{$foro.For_Titulo}</h3>
                </div>
                <div class="contenido">
                    {$foro.For_ResultadosEsperados|html_entity_decode}</p>
                </div>

                <div class="row col-md-12">
                    {if Session::get('autenticado')}               
                        {if $comentar_foro}
                            <div class="widget-area no-padding blank">
                                <div class="status-upload">
                                    <textarea id="text_comentario_{$foro.For_IdForo}_0" placeholder="Ingrese su comentario" ></textarea>
                                    <div id="div_loading_{$foro.For_IdForo}_0" id_padre="0" class="load_files d-none">

                                    </div>
                                    <ul>
                                        <li><span title="PDF|DOC|PPT|Files" data-toggle="tooltip" data-placement="bottom" data-original-title="PDF|DOC|PPT|Files" class="foro_fileinput" for="files_doc" ><i class="fa fa-file-o"></i> <input name="files_doc" type="file" multiple="" class="files_coment"                                                                                                                                                            accept=".pptx, .pptm, .ppt, .pdf, .xps, .potx, .potm, .pot,.thmx, .ppsx, .ppsm, .pps, .ppam, .ppam, .ppa, .xml, .pptx,.pptx,.rar, .zip"></span></li>
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"  class="foro_fileinput" for="file_img"><i class="fa fa-picture-o"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="image/*"></span></li>
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"  class="foro_fileinput" for="files_video"><i class="fa fa-video-camera"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="video/*"></span></li>                                                
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"  class="foro_fileinput" for="files_son"><i class="fa fa-music"></i><input name="files_doc" type="file" multiple="" class="files_coment" accept="audio/*"></span></li>                                                
                                    </ul>
                                    <button  type="button" id_foro="{$foro.For_IdForo}" id_usuario="{Session::get('id_usuario')}" id_padre="0" class="btn btn-success green foro_coment"><i class="fa fa-share"></i>Comentar</button>

                                </div><!-- Status Upload  -->
                            </div><!-- Widget Area -->
                        {else}
                            <button class="btn btn-primary btn-md inscribir_foro" id_foro="{$foro.For_IdForo}">Inscribite para comentar<i class="fa fa-sign-in"></i></button>
                            {/if}
                        {else}
                        <div class="form-login">                            
                            <h5>Cuelgue su contribución</h5>
                            <div class="row">                                
                                <div class="col-md-4 wrapper">
                                    <span class="group-btn">     
                                        <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-primary btn-md btn_login_user">Inicie Sesion <i class="fa fa-sign-in"></i></button>
                                    </span>
                                </div>
                            </div>

                        </div>


                    {/if}                    
                </div>
            </div>
            <div class="row">
                <hr>
                <h4>Comentarios:</h4>
            </div>
            <div id="lista_comentarios" class="row">               
                {foreach from=$foro.For_Comentarios item=comentarios} 
                    <div class="media comment-box">
                        <div class="col-md-1 media-left">
                            <a href="#">
                                <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
                            </a>
                        </div>
                        <div class="col-md-11 media-body">
                            <h4 class="media-heading">{$comentarios.Usu_Nombre|upper}
                                <span> | {$comentarios.Com_Fecha|date_format:"%d-%m-%Y"}</span>
                                {if $comentar_foro}                                   
                                    <span class="pull-right"> <button id_comentario="{$comentarios.Com_IdComentario}" class="btn btn-default btn-sm coment_coment">Comentar</button></span>
                                {/if}                                
                            </h4>
                            <p>{$comentarios.Com_Descripcion}</p>
                            <div id="div_show_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" id_padre="{$comentarios.Com_IdComentario}" class="show_files">
                                {foreach from=$comentarios.Archivos  item=file}
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
                                        <div class="file_titulo">
                                            <a href="{$_layoutParams.root_archivo_fisico}{$file.Fim_NombreFile}"  title="Descargar" target="_blank">{$file.Fim_NombreFile}</a>                                                    
                                        </div>
                                        <div class="file_size">({$file.Fim_SizeFile})</div>
                                    </div>
                                {/foreach}
                            </div>
                            {if $comentar_foro}
                                <div id="comen_comen_{$comentarios.Com_IdComentario}" class="media" style="display: none">
                                    <div class="widget-area no-padding blank">
                                        <div class="status-upload">

                                            <textarea id="text_comentario_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" placeholder="Ingrese su comentario" ></textarea>
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
                                <div class="media">
                                    <div class="col-md-1 media-left">
                                        <a href="#">
                                            <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
                                        </a>
                                    </div>
                                    <div class="col-md-11 media-body">
                                        <h4 class="media-heading">{$hijo_comentarios.Usu_Nombre|upper}
                                            <span> | {$hijo_comentarios.Com_Fecha|date_format:"%d-%m-%Y"}</span>
                                        </h4>
                                        <p>{$hijo_comentarios.Com_Descripcion}</p>
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
                                                    <div class="file_size">({$file.Fim_SizeFile})</div>
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>


                                </div>                          
                            {/foreach}
                        </div>
                    </div>                
                {/foreach}
            </div>
        </div>
        <div class="col-xs-12 col-sm-4 col-md-3 col-lg-3">
            <div class="addon">
                <label>FACILITADO POR</label>
                <ul>
                    {foreach from=$facilitadores item=facilitador} 
                        <li class="clearfix">
                            <a href="#" target="_blank">
                                <img class="round" src="https://8share-production-my.s3.amazonaws.com/campaigns/4898/photos/profile/thumb_copy.png?1397732185">
                                <div class="legend-info">
                                    <strong>{$facilitador.Usu_Nombre} {$facilitador.Usu_Apellidos}</strong>                                
                                    {$facilitador.Rol_Nombre} <br>
                                    {$facilitador.Usu_InstitucionLaboral}
                                </div>
                            </a>
                        </li> 
                    {/foreach}
                </ul>
            </div>
            {if count($foro.Archivos)>0}
            <div class="addon">
                <label>RECURSOS</label>
                <ul id="div_show_{$foro.For_IdForo}" class="show_files">
                    {foreach from=$foro.Archivos  item=file}
                        <li class="files" tabindex="-1" id="">
                            {if $file.Fif_TipoFile|strstr:"video"}
                                <i class="fa fa-video-camera"></i>
                            {/if}
                            {if $file.Fif_TipoFile|strstr:"image"}
                                <i class="fa fa-picture-o"></i>
                            {/if}
                            {if $file.Fif_TipoFile|strstr:"application"}
                                <i class="fa fa-file-o"></i>
                            {/if}
                            <div class="file_titulo">
                                <a href="{$_layoutParams.root_archivo_fisico}{$file.Fif_NombreFile}"  title="Descargar" target="_blank">{$file.Fif_NombreFile}</a>                                                    
                            </div>
                            <div class="file_size">({$file.Fif_SizeFile})</div>
                        </li>
                    {/foreach}
                </ul>
            </div>
            {/if}


            {if Session::get('autenticado')}
                {if !$comentar_foro}
                    <hr>
                    <div class="card">
                        <span class="group-btn">                             
                            <button class="btn btn-primary btn-md inscribir_foro" id_foro="{$foro.For_IdForo}">Inscribite <i class="fa fa-sign-in"></i></button>
                        </span>
                    </div>
                {/if}
            {else}
                <hr>
                <div class="card">
                    <div class="form-login">
                        <h5>Iniciar sesión para contribuir</h5>                      
                        <div class="wrapper">
                            <span class="group-btn">     
                                <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-primary btn-md btn_login_user">login<i class="fa fa-sign-in"></i></button>
                            </span>
                        </div>
                    </div>
                </div>
                <hr>
                <div class="card">
                    <h5>Nuevo Usuario?</h5>
                    <span class="group-btn">     
                        <a href="#" class="btn btn-primary btn-md btn_registro_user" data-toggle="modal" data-target="#modal-login"  id="register-form-link" >Registrate <i class="fa fa-sign-in"></i></a>
                    </span>
                </div>
            {/if}

        </div>
    </div>

</div>
