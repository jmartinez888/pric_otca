<div class="table-responsive">
    <table class="table">
        <thead>
            <tr>
                <th>#</th>
                <th>Foro</th>
                <th>Participantes</th>
                <th>Comentarios</th>
                <th>Creador</th>
                <th>Fecha Creacion</th>
                <th>Fecha Cierre</th>
                <th style=" text-align: center">Estado</th>
                <th>Opciones</th>
            </tr>
        </thead>
        <tbody> 
            {foreach from=$lista_foros item=foro}            
                <tr>
                    <th scope="row">{$numeropagina++}</th>
                    <td>{$foro.For_Titulo}</td>
                    <td>{$foro.For_NParticipantes}</td>
                    <td>{$foro.For_NComentarios}</td>
                    <td>{$foro.Usu_Usuario}</td>
                    <td>{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"}</td>
                    <td>{$foro.For_FechaCierre|date_format:"%d-%m-%Y"}</td>
                    <th style=" text-align: center">{$foro.For_Estado}</th>
                    <td>
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default  btn-sm glyphicon glyphicon-pencil " title="Editar Foro" href="{$_layoutParams.root}foro/admin/form/edit/{$foro.For_Funcion}/{$foro.For_IdForo}"></a>
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default  btn-sm glyphicon glyphicon-user" title="Ver Miembrios" href="{$_layoutParams.root}foro/admin/members/{$foro.For_IdForo}"></a>
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default  btn-sm glyphicon glyphicon-calendar" title="Ver Actividades" href="{$_layoutParams.root}foro/admin/actividad/{$foro.For_IdForo}"></a>
                        <a target="_blank" data-toggle="tooltip" data-placement="bottom" class="btn btn-default  btn-sm glyphicon glyphicon-eye-open" title="Ver Ficha " href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}"></a>
                        <button data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-off cerrar_foro" title="Cerrar Foro" id_foro="{$foro.For_IdForo}" estado="{$foro.For_Estado}" > </button>                      
                        <button data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh cambiar_estado" title="Cambiar Estado" id_foro="{$foro.For_IdForo}" estado="{$foro.For_Estado}" > </button>  
                        {if $foro.Row_Estado == 0} 
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-ok eliminar_foro" title="Habilitar" id_foro="{$foro.For_IdForo}" estado="{$foro.Row_Estado}"></a>
                        {else}
                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-trash eliminar_foro" title="Eliminar" id_foro="{$foro.For_IdForo}" estado="{$foro.Row_Estado}"></a> 
                        {/if} 
                    </td>
                </tr>  
            {/foreach}
        </tbody>
    </table>
</div>
{$paginacion|default:""}