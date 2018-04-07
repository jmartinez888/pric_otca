<div  class="container" >
    <div class="row">
        <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
            <div class="row">
                <div class="col-md-6">
                    <span>{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"} - {$foro.For_FechaCierre|date_format:"%d-%m-%Y"}</span>
                </div>
                <div class="col-md-6 text-right">
                    Colaboraciones <span class="badge">{$foro.For_TComentarios}</span> 
                </div>
                <div class="page-header">
                    <h3 class="titulo-view">{$foro.For_Titulo}</h3>
                </div>
                <p class="text-justify">{$foro.For_ResultadosEsperados}</p>
                <div class="row col-md-12">
                    {if Session::get('autenticado')}               
                        {if $comentar_foro}
                            <div class="widget-area no-padding blank">
                                <div class="status-upload">
                                    <textarea id="text_comentario_{$foro.For_IdForo}_0" placeholder="Ingrese su comentario" ></textarea>
                                     <div id="div_loading_{$foro.For_IdForo}_0" id_padre="0" class="load_files d-none">
                                        
                                    </div>
                                    <ul>
                                        <li><span title="PDF|DOC|PPT|Files" data-toggle="tooltip" data-placement="bottom" data-original-title="PDF|DOC|PPT|Files" class="foro_fileinput" for="files_doc" ><i class="fa fa-file-o"></i> <input id="files_doc" type="file" name="files[]" multiple="" class="files_coment"></span></li>
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"  class="foro_fileinput" for="file_img"><i class="fa fa-picture-o"></i><input id="files_doc" type="file" name="files[]" multiple=""></span></li>
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"  class="foro_fileinput" for="files_video"><i class="fa fa-video-camera"></i><input id="files_doc" type="file" name="files[]" multiple=""></span></li>                                                
                                        <li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"  class="foro_fileinput" for="files_son"><i class="fa fa-music"></i><input id="files_doc" type="file" name="files[]" multiple=""></span></li>                                                
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
                            {if $comentar_foro}
                                <div id="comen_comen_{$comentarios.Com_IdComentario}" class="media" style="display: none">
                                    <div class="widget-area no-padding blank">
                                        <div class="status-upload">

                                            <textarea id="text_comentario_{$foro.For_IdForo}_{$comentarios.Com_IdComentario}" placeholder="Ingrese su comentario" ></textarea>
                                            <ul>                                        
                                                <li><a title="" data-toggle="modal" data-target="#modal-add-files"  data-placement="bottom" data-original-title="PDF|DOC|PPT|Files"><i class="fa fa-file-o"></i></a></li>
                                                <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="File"><i class="fa fa-file-o"></i></a></li>
                                                <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"><i class="fa fa-picture-o"></i></a></li>
                                                <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"><i class="fa fa-video-camera"></i></a></li>                                                
                                                <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"><i class="fa fa-music"></i></a></li>                                                

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
                                    </div>
                                </div>                          
                            {/foreach}
                        </div>
                    </div>                
                {/foreach}
            </div>
        </div>
        <div class="col-xs-12 col-sm-4 col-md-3 col-lg-2">
            <div class="card">
                <div class="card-body">
                    <h6 class="card-subtitle mb-2 text-muted">Facilitado por:</h6>
                    <h5 class="card-title"><a>Andrea Cattaneo</a> <br>Italia <br> FAO ESA</h5>
                    <p class="card-text">Para mayor información sobre el (los) facilitador (es) haga clic en el nombre</p>
                </div>
            </div>

            {if Session::get('autenticado')}
                {if !$comentar_foro}
                    <hr>
                    <div class="card">
                        <span class="group-btn">                             
                            <button class="btn btn-primary btn-md inscribir_foro" id_foro="{$foro.For_IdForo}">Inscríbite <i class="fa fa-sign-in"></i></button>
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
