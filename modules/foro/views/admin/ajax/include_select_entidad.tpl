<select class="form-control selectpicker" id="s_lista_entidad" name="s_lista_entidad" data-live-search="true" required>
	<option value="">Seleccione!...</option>
	{foreach from=$list_entidad item=item}
	<option value="{$item.Ent_IdEntidad}"
	{if !empty($foro)&&$foro.Ent_Id_Entidad==$item.Ent_IdEntidad}selected{/if}>{$item.Ent_Siglas} - {$item.Ent_Nombre}</option>
	{/foreach}
	<option data-icon="glyphicon glyphicon-plus" value="-1" >Registrar Entidad</option>
</select>