{if Session::get('autenticado')}
{if $comment_like.valoracion_comentario == 1}
<span class="likes pull-right">
    <i class="fa btn-like fa-heart  valorar_comentario"
    id_comentario="{$comment_like.Com_IdComentario}"
    id_usuario="{Session::get('id_usuario')}"
    ajaxtpl="valoraciones_comentarios"
    valor="{$comment_like.valoracion_comentario}"
    objeto="comment"
     title="Me gusta"
    ></i>
    <span>
        <strong>{shortnumber number=$comment_like.Nvaloraciones_comentario}</strong>       
    </span>
</span>
{else}
<span class="likes pull-right">
    <i class="fa btn-like fa-heart-o valorar_comentario"
    id_comentario="{$comment_like.Com_IdComentario}"
    id_usuario="{Session::get('id_usuario')}"
    ajaxtpl="valoraciones_comentarios"
    valor="{$comment_like.valoracion_comentario}"
    objeto="comment"
    title="Ya no me gusta" 
    ></i>
    <span>
        <strong>{shortnumber number=$comment_like.Nvaloraciones_comentario}</strong>
    </span>
</span>
{/if}
{else}
<span class="likes pull-right">
    <i class="fa btn-like fa-heart-o" 
    data-toggle="modal" data-target="#modal-login" id="login-form-link"
        title="Me gusta"
    ></i>
    <span>
        <strong>{shortnumber number=$comment_like.Nvaloraciones_comentario}</strong>
    </span>
</span>
{/if}