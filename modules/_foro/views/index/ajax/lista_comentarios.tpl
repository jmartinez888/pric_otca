{foreach from=$For_Comentarios item=comentarios}                 
    <div class="media comment-box">
        <div class="col-md-1 media-left">
            <a href="#">
                <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png">
            </a>
        </div>
        <div class="col-md-11 media-body">
            <h4 class="media-heading">{$comentarios.Usu_Nombre|upper}
                <span> | {$comentarios.Com_Fecha|date_format:"%d-%m-%Y"}</span>
                <span class="pull-right"> <button id_comentario="{$comentarios.Com_IdComentario}" class="btn btn-default btn-sm coment_coment">Comentar</button></span>
            </h4>
            <p>{$comentarios.Com_Descripcion}</p>
            <div id="comen_comen_{$comentarios.Com_IdComentario}" class="media" style="display: none">
                <div class="widget-area no-padding blank">
                    <div class="status-upload">
                      
                            <textarea id="text_comentario_{$comentarios.For_IdForo}_{$comentarios.Com_IdComentario}" placeholder="Ingrese su comentario" ></textarea>
                            <ul>
                                <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"><i class="fa fa-music"></i></a></li>
                                <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"><i class="fa fa-video-camera"></i></a></li>
                                <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Sound Record"><i class="fa fa-microphone"></i></a></li>
                                <li><a title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"><i class="fa fa-picture-o"></i></a></li>
                            </ul>
                            <button  type="button" id_foro="{$comentarios.For_IdForo}" id_usuario="{Session::get('id_usuario')}" id_padre="{$comentarios.Com_IdComentario}" class="btn btn-success green foro_coment"><i class="fa fa-share"></i>Comentar</button>
                       
                    </div><!-- Status Upload  -->
                </div><!-- Widget Area -->
            </div>
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