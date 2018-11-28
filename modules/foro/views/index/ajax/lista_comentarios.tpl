{foreach from=$foro.For_Comentarios item=comentarios}
<div class="comment-box col col-xs-12 col-sm-12 col-md-12 col-lg-12">
    <div class=" col-xs-1 col-sm-1 col-md-1 col-lg-1 media-left">
        <a href="#">
            <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png" alt="Perfil" style="border-radius: 50%;">
        </a>
    </div>
    <div class="col-xs-11 col-sm-11 col-md-11 col-lg-11 media-body ">
       {include file='modules/foro/views/index/ajax/include_cuerpo_comment.tpl' commen_body=$comentarios reply=true}
        <!-- Jhon Martinez -->
        <div class="col col-xs-12 col-sm-12 col-md-12 col-lg-12" id="comentarioshijos_{$comentarios.Com_IdComentario}">
            {foreach from=$comentarios.Hijo_Comentarios item=hijo_comentarios}
            <div class="col col-xs-12 col-sm-12 col-md-12 col-lg-12 media">
                <div class="row">
                    <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 media-left">
                        <a href="#">
                            <img class="img-responsive user-photo" src="https://ssl.gstatic.com/accounts/ui/avatar_2x.png" alt="Perfil" style="border-radius: 50%;">
                        </a>
                    </div>
                    <div class="col-xs-11 col-sm-11 col-md-11 col-lg-11 media-body">
                         {include file='modules/foro/views/index/ajax/include_cuerpo_comment.tpl' commen_body=$hijo_comentarios is_hijo=true}                        
                    </div>
                </div>
            </div>
            {/foreach}
            <div class="clearfix">
            </div>
        </div>
    </div>
</div>
{/foreach}