<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10">
        <div class="row ficha_foro">
            
            <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
            <!-- ficha-foro-josepacaya -->
                <div class="col-lg-12 p-rt-lt-0">
                    <a class="regresar-tematica" href="#"> < NombreDeLaTemática</a>
                    <div class="pull-right etiqueta">Discusión</div>
                </div>
                <div class="col-lg-12 p-rt-lt-0">
                    <h3 class="titulo-ficha">{$foro.For_Titulo}</h3>
                </div>
                <div class="col-lg-12 p-rt-lt-0" style="font-size: 12px;">
                    <div class="col-lg-6 p-rt-lt-0">
                    hace 1 mes por <strong>NombreDelUsuario</strong>
                    </div>
                    <div class="col-lg-6 p-rt-lt-0">
                        <div class="pull-right">Comentarios: <strong>0</strong></div>
                    </div>
                </div>
                <div class="col-lg-12 p-rt-lt-0">
                    <hr class="cursos-hr">
                </div>
                <div class="col-lg-12 contenido">
                    <p>{$foro.For_Descripcion|html_entity_decode}</p>
                </div>
                <div class="col-lg-12 p-rt-lt-0" style="font-size: 12px;">
                    <div class="col-lg-8 p-rt-lt-0">
                        <div class="participantes">Participantes: <strong>2</strong></div>
                    </div>
                    <div class="col-lg-4 p-rt-lt-0">
                        <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-default btn-comentar">
                            <i class="glyphicon glyphicon-comment"></i>
                        &nbsp;Comentar</button>
                        <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-default btn-like pull-right" id="btnCalificar">
                            <i class="glyphicon glyphicon-thumbs-up"></i>
                        </button>
                    </div> 
                </div>
                <div class="col-lg-12 p-rt-lt-0">
                    <hr class="cursos-hr">
                </div>




            <!-- fin ficha-foro-josepacaya-->

                 <!--    <div class="col-md-6">
                        <span>{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"} {if ($foro.For_FechaCierre|date_format:"%d-%m-%Y")!=""} / {($foro.For_FechaCierre|date_format:"%d-%m-%Y")}{/if}</span>
                    </div>
                    <div class="col-md-6 text-right">
                        {if {$foro.For_Funcion}=="forum" }
                             Colaboraciones <span class="badge">{$foro.For_TComentarios}</span> 
                        {else}
                         Participantes <span class="badge">{$foro.For_TParticipantes}</span> 
                        {/if}
                    </div>
                    <div class="col-lg-12"><hr class="cursos-hr"></div>
                    <div class="page-header">
                        <h3 class="titulo-view">{$foro.For_Titulo}</h3>
                    </div>
                    <div class="contenido">
                        {$foro.For_Descripcion|html_entity_decode}</p>
                    </div>    -->

                    <div class="col-md-12 p-rt-lt-0">
                        {if Session::get('autenticado')}               
                            {if $comentar_foro}
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

                                    </div><!-- Status Upload  -->
                                </div><!-- Widget Area -->
                            {else}
                                 {if $foro.For_Funcion=="forum"}
                                 <div class="col-md-12 p-rt-lt-0">
                                     <button class="btn btn-primary btn-md inscribir_foro" id_foro="{$foro.For_IdForo}">Inscríbete para comentar
                                     <i class="glyphicon glyphicon-log-in"></i></button>
                                 </div>
                                {else}
                                <div>
                                     <button class="btn btn-primary btn-md inscribir_foro" id_foro="{$foro.For_IdForo}">Inscríbete para participar en el Webinar
                                     <i class="glyphicon glyphicon-log-in"></i></button>
                                </div>
                                {/if}
                                {/if}
                            {else}
                            <div class="">
                                <div class="col-lg-12 anuncio"> 
                                  <p>Para colgar su contribución inicie sesión.</p>
                                </div>                              
                                <div class="col-md-12 p-rt-lt-0">    
                                    <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-group btn-success ini-sesion">Inicie Sesion <i class="glyphicon glyphicon-log-in"></i></button>
                                </div>
                            </div>
                        {/if}                    
                    </div>
                 
                <div class="col-lg-12 p-rt-lt-0">
                    <h4>Comentarios:</h4>
                </div>
                <div class="col-lg-12 p-rt-lt-0">
                    <hr class="cursos-hr">
                </div>
                <div id="lista_comentarios" class="row">               
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
                {if $foro.For_Funcion=="forum"}
                <div class="addon">
                    <label class="tit-integrante">Sub Foros</label>
                    <div style="padding: 10px">
                        <a type="button"  href="{$_layoutParams.root}foro/admin/form/new/forum/{$foro.For_IdForo}" class="btn btn-primary btn-sm" title="Nuevo Sub FOro">Nuevo</a>
                    </div>
                    {if count($foro.Sub_Foros)>0}
                        <ul>
                            {foreach from=$foro.Sub_Foros  item=sub_foro}
                                <li class="clearfix">
                                    <div >
                                        <a href="{$_layoutParams.root}foro/index/ficha/{$sub_foro.For_IdForo}" target="_blank">
                                            <strong>{$sub_foro.For_Titulo}</strong>
                                        </a>
                                        <div>
                                            <i>Por: </i> 
                                        </div>
                                        <div class="pull-left">
                                            {$sub_foro.For_FechaCreacion|date_format:"%d-%m-%Y"}
                                        </div>
                                        <div class="pull-right">
                                            Colaboraciones <span class="badge">{$sub_foro.For_TComentarios}</span>
                                        </div>
                                    </div>
                                </li>
                            {/foreach}
                        </ul>
                    {/if}
                </div>
                {/if}

                {if Session::get('autenticado')}
                    {if !$comentar_foro}
                        <hr>
                        <div class="card">
                            <span class="group-btn">                             
                                <button class="btn btn-primary btn-md inscribir_foro" id_foro="{$foro.For_IdForo}">Inscríbete <i class="fa fa-sign-in"></i></button>
                            </span>
                        </div>
                    {/if}
                {else}
                    <hr>
                    <div class="card">
                        <div class="form-login">
                             {if $foro.For_Funcion=="forum"}
                            <h5>Iniciar sesión para contribuir</h5>  
                            {else}
                            <h5>Iniciar sesión para participar</h5>  
                            {/if}
                            <div>
                                <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-group btn-success">Inicie Sesion <i class="glyphicon glyphicon-log-in"></i></button>
                            </div>
                        </div>
                    </div>
                    <hr>
                    <!-- <div class="card">
                        <h5>Nuevo Usuario?</h5>
                        <span class="group-btn">     
                            <a href="#" class="btn btn-primary btn-md btn_registro_user" data-toggle="modal" data-target="#modal-login"  id="register-form-link" >Registrate <i class="fa fa-sign-in"></i></a>
                        </span>
                    </div> -->
                {/if}

            </div>
        </div>

    </div>
</div>
