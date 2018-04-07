<div class="panel-heading">
    <h4 class="panel-title">
        {$user.Usu_Nombre} {$user.Usu_Apellidos} 
    </h4>
</div>               
<div class="panel-body">
    <div class="table-responsive">
        <table class="table" style="  margin: 20px auto">
            <tr>
                <th>Permiso</th>
                <th style="text-align:center">Habilitado</th>
                <th style="text-align:center">Denegado</th>
            </tr>
            {foreach item=pr from=$lista_permisos}
                <tr>
                    <td>{$pr.Per_Nombre}</td>
                    <td style="text-align:center">
                        <input type="radio" class="rcb_permisos" name="perm_{$pr.Per_IdPermiso}" value="1" id_foro="{$pr.For_IdForo}" id_usuario="{$pr.Usu_IdUsuario}" id_permiso="{$pr.Per_IdPermiso}" {if $pr.Ufp_Estado!=NULL}{if ($pr.Ufp_Estado == 1)}checked="checked"{/if}{else}{if ($pr.Per_Valor == 1)}checked="checked"{/if}{/if}/></td>
                    <td style="text-align:center">
                        <input type="radio" class="rcb_permisos" name="perm_{$pr.Per_IdPermiso}" value="0" id_foro="{$pr.For_IdForo}" id_usuario="{$pr.Usu_IdUsuario}" id_permiso="{$pr.Per_IdPermiso}" {if $pr.Ufp_Estado!=NULL}{if ($pr.Ufp_Estado == 0)}checked="checked"{/if} {else}{if ($pr.Per_Valor == "")}checked="checked"{/if}{/if}/></td>                   
                    </td>
                </tr>
            {/foreach}
        </table>
    </div>
</div>
<div class="modal-footer">  
    <button type="button" class="btn btn-primary btn-sm" data-dismiss="modal">Aceptar</button>
</div>