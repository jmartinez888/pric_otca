
	<div class="row">
		<div class="col-md-4">
			<label for="ciudad">{$lenguaje["registro_label_ciudad"]}</label>
			<div class="ciudad">
				<select name='ciudad' id='ciudad' class='form-control'>
					{foreach from=$Ciudades item=c}
						<option value="{$c.Ter_IdTerritorio}">{$c.Ter_Nombre}</option>
					{/foreach}
				</select>
			</div>
		</div>
	</div>
