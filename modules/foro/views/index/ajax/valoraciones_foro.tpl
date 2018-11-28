{if Session::get('autenticado')}
{if $valoracion_foro == 0}
<span class="likes pull-right">
    <i class="fa btn-like fa-heart-o" id="ValorarForo" name="ValorarForo"
    title="Me gusta" id_foro="{$foro.For_IdForo}" id_usuario="{$id_usuario}" valor="{$valoracion_foro}" ajaxtpl="valoraciones_foro"  objeto="forum"></i>
    <span>
        <strong>{shortnumber number=$Nvaloraciones_foro}</strong>
    </span>
</span>
{else}
<span class="likes pull-right">
    <i class="fa btn-like fa-heart"
    title="Ya no me gusta" id="ValorarForo" name="ValorarForo" id_foro="{$foro.For_IdForo}" id_usuario="{$id_usuario}" valor="{$valoracion_foro}" ajaxtpl="valoraciones_foro" objeto="forum"></i>
    <span>
        <strong>{shortnumber number=$Nvaloraciones_foro}</strong>
    </span>
</span>
{/if}
{else}
<div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 p-rt-lt-0 text-right">
    <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-comentar" style="">
    <i class="glyphicon glyphicon-comment"></i>
    &nbsp;Comentar</button>
</div>
<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 p-rt-lt-0 text-right">
    <span class="likes pull-right">
        <i class="fa btn-like fa-heart-o" data-toggle="modal" data-target="#modal-login" id="login-form-link"
        title="Me gusta" ></i>
        <span>
            <strong>{shortnumber number=$Nvaloraciones_foro}</strong>
        </span>
    </span>
</div>
{/if}