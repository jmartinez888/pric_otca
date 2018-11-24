<div class="margin-t-10 col-md-offset-6  col-lg-offset-6  col-md-6 col-xs-12 col-sm-12 col-lg-6">
    <div class="input-group">
        <input id="text_busqueda_miembro" name="text_busqueda_miembro" type="text" class="form-control" value="{$text_busqueda_miembro}">
        <span class="input-group-btn">
            <button id="buscar_miembro_foro" name="buscar_miembro_foro" class=" btn btn-primary" type="button"><i class="glyphicon glyphicon-search"></i></button>
        </span>
    </div>
    
</div>
<div class="margin-t-10 col-md-12 col-xs-12 col-sm-12 col-lg-12">
    <!-- </div> -->
    <table class="table">
        <thead>
            <tr>
                <th>#</th>
                <th>Usuario</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Registrado</th>
                <th>Estado</th>
                <th>Opciones</th>
            </tr>
        </thead>
        <tbody>
            {foreach from=$lista_members item=member}
            <tr>
                <th scope="row">{$numeropagina++}</th>
                <td>{$member.Usu_Usuario}</td>
                <td>{$member.Usu_Nombre}</td>
                <td>{$member.Usu_Apellidos}</td>
                <td>{$member.Usf_FechaRegistro|date_format:"%d-%m-%Y"}</td>
                <td>{$member.Usf_Estado}</td>
                <td>
                    <a type="button" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-list permisos_member" data-toggle="modal" data-target="#modal-permisos-member" data-original-title="Editar Permisos" id_usuario="{$member.Usu_IdUsuario}" id_foro="{$member.For_IdForo}" id_rol="{$member.Rol_IdRol}"></a>
                    <button data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh cambiar_estado" title="Cambiar Estado" id_usuario="{$member.Usu_IdUsuario}" id_foro="{$member.For_IdForo}" estado="{$member.Usf_Estado}" > </button>
                    <button data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-trash eliminar_miembro" title="Eliminar" id_usuario="{$member.Usu_IdUsuario}" id_foro="{$member.For_IdForo}" > </button>
                </td>
            </tr>
            {/foreach}
        </tbody>
    </table>
</div>
{$paginacion|default:""}
