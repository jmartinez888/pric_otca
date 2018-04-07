{if !empty($lista_member_select) && isset($lista_member_select)}
    {foreach from=$lista_member_select item=member} 
        <div class="row">
            <div class="col-md-2 text-center">
                <input type="radio" name="rd_member_select" id="rd_member_select_{$member.Usu_IdUsuario}" value="{$member.Usu_IdUsuario}">
            </div>
            <div class="col-md-10">
                {$member.Usu_Nombre} {$member.Usu_Apellidos} 
            </div>
        </div>
        <hr>
    {/foreach}
{else}
    <span>No se encontraron resultados</span>
{/if}