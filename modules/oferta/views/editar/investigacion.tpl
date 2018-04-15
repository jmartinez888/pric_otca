<div class="container">
	<div class="row">
		<div class="col-md-9">
			<center><h3>{$lenguaje["registro_inv_dif"]} <b>{$listaIns.Ins_Nombre}</b></h3></center>
		</div>
		<div class="col-md-3">
		<br><a href="{$_layoutParams.root_clear}es/oferta/instituciones/ficha/{$id}" class="btn btn-primary">{$lenguaje["edicion_editar_fin"]}</a>
		</div>
	</div><br>
	<ul class="nav nav-tabs">
		<li class="active"><a>{$lenguaje["registro_inv_dif"]}</a></li>
	</ul><br>
	<div class="row">
		<div class="col-md-8">
			{if isset($ident)}
				{if $ident=="proyecto"}
				<form method="post" class="form-horizontal" role="form">
					<fieldset>
						<legend>{$lenguaje["edicion_editar_inv_title"]}</legend>
						<div class="row">
						<div class="col-md-6">
							<label for="tipooferta">{$lenguaje["registro_inv_tipo_inv"]}</label>
							<input type="text" name="tipooferta" id="tipooferta" class="form-control" value="{$editar_inv.Tipo}" required>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<label for="tematica">{$lenguaje["ficha_tematica"]}</label>
							<select name="tematica" id="tematica" class="form-control" required>
								<option>{$lenguaje["busqueda_avanzada_select_pais"]}</option>
								{if isset($tematica) && count($tematica)}
									{foreach from=$tematica item=b}
										{if $b.Nombre == $editar_inv.Tematica}
										<option selected="true" value="{$b.Id}">{$b.Nombre}</option>
										{else}
										<option value="{$b.Id}">{$b.Nombre}</option>
										{/if}
									{/foreach}
								{/if}
							</select>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<label for="nombre">{$lenguaje["registro_inv_nombre"]}</label>
							<input type="text" name="nombre" id="nombre" class="form-control" required value="{$editar_inv.Nombre}">
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<label for="descripcion">{$lenguaje["ficha_descripcion"]}</label>
							<textarea name="descripcion" id="descripcion" class="form-control" required>{$editar_inv.Descripcion}</textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<label for="contacto">{$lenguaje["Contacto"]}</label>
							<input type="text" name="contacto" id="contacto" class="form-control" required value="{$editar_inv.Contacto}">
						</div>
					</div>
					<input type="hidden" name="editar_inv" value="1">
					<div class="row">
						<div class="col-md-6">
							<center><input type="submit" class="btn btn-success" value="$lenguaje['edicion_label_editar']"></center>
							
						</div>
					</div>
					</fieldset>
				</form>
				{else}
				<form method="post" class="form-horizontal" role="form">
				<fieldset>
					<legend>{$lenguaje["registrar_proyecto_inv_title"]}</legend>
				</fieldset>
				<div class="row">
					<div class="col-md-6">
						<label for="tipooferta">{$lenguaje["registro_inv_tipo_inv"]}</label>
						<input type="text" name="tipooferta" id="tipooferta" class="form-control" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="tematica">{$lenguaje["ficha_tematica"]}</label>
						<select name="tematica" id="tematica" class="form-control" required>
							<option>{$lenguaje["busqueda_avanzada_select_pais"]}</option>
							{if isset($tematica) && count($tematica)}
								{foreach from=$tematica item=b}
									<option value="{$b.Id}">{$b.Nombre}</option>
								{/foreach}
							{/if}
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="nombre">{$lenguaje["registro_inv_nombre"]}</label>
						<input type="text" name="nombre" id="nombre" class="form-control" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="descripcion">{$lenguaje["ficha_descripcion"]}</label>
						<textarea name="descripcion" id="descripcion" class="form-control" required></textarea>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="contacto">{$lenguaje["Contacto"]}</label>
						<input type="text" name="contacto" id="contacto" class="form-control" required>
					</div>
				</div>
				<input type="hidden" name="guardar_inv" value="1">
				<div class="row">
					<div class="col-md-6">
						<center><input type="submit" class="btn btn-success" value="{$lenguaje['registro_inv_registrar']}"></center>
					</div>
				</div>
			</form>
				{/if}
			{else}
			<form method="post" class="form-horizontal" role="form">
				<fieldset>
					<legend>{$lenguaje["registrar_proyecto_inv_title"]}</legend>
					<div class="row">
					<div class="col-md-6">
						<label for="tipooferta">{$lenguaje["registro_inv_tipo_inv"]}</label>
						<input type="text" name="tipooferta" id="tipooferta" class="form-control" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="tematica">{$lenguaje["ficha_tematica"]}</label>
						<select name="tematica" id="tematica" class="form-control" required>
							<option>{$lenguaje["busqueda_avanzada_select_pais"]}</option>
							{if isset($tematica) && count($tematica)}
								{foreach from=$tematica item=b}
									<option value="{$b.Id}">{$b.Nombre}</option>
								{/foreach}
							{/if}
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="nombre">{$lenguaje["registro_inv_nombre"]}</label>
						<input type="text" name="nombre" id="nombre" class="form-control" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="descripcion">{$lenguaje["ficha_descripcion"]}</label>
						<textarea name="descripcion" id="descripcion" class="form-control" required></textarea>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="contacto">{$lenguaje["Contacto"]}</label>
						<input type="text" name="contacto" id="contacto" class="form-control" required>
					</div>
				</div>
				<input type="hidden" name="guardar_inv" value="1">
				<div class="row">
					<div class="col-md-6">
						<center><input type="submit" class="btn btn-success" value="{$lenguaje['registro_inv_registrar']}"></center>
					</div>
				</div>
				</fieldset>
			</form>
			{/if}

		</div>
		{if isset($ident)}
			{if $ident=="difusion"}
			<div class="col-md-4">
				<form method="post" class="form-horizontal" role="form">
					<fieldset>
						<legend>{$lenguaje["edicion_label_editar"]} {$lenguaje["ficha_dif"]}</legend>
						<div class="row">
							<div class="col-md-10">
								<label for="difusion">{$lenguaje["registro_otros_datos_nombre"]}</label>
								<input type="text" name="difusion" id="difusion" class="form-control" required value="{$editar_dif.Nombre}">
							</div>
						</div>
						<div class="row">
							<div class="col-md-10">
								<label for="descripcion">{$lenguaje["ficha_descripcion"]}</label>
								<input type="text" name="descripcion" id="descripcion" class="form-control" required value="{$editar_dif.Descripcion}">
							</div>
						</div>
						<div class="row">
							<div class="col-md-10">
								<label for="enlace">Link:</label>
								<input type="text" name="enlace" id="enlace" class="form-control" required value="{$editar_dif.Enlace}">
							</div>
						</div>
						<input type="hidden" name="editar_dif" value="1">
						<div class="row">
							<div class="col-md-6"><br>
								<center><input type="submit" class="btn btn-success" value="{$lenguaje['edicion_label_editar']}"></center>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
			{/if}
		{else}
		<div class="col-md-4">
			<form method="post" class="form-horizontal" role="form">
				<fieldset>
					<legend>{$lenguaje["registro_dif_registrar"]}</legend>
					<div class="row">
						<div class="col-md-10">
							<label for="difusion">{$lenguaje["registro_otros_datos_nombre"]}</label>
							<input type="text" name="difusion" id="difusion" class="form-control" required>
						</div>
					</div>
					<div class="row">
						<div class="col-md-10">
							<label for="descripcion">{$lenguaje["ficha_descripcion"]}</label>
							<textarea name="descripcion" id="descripcion" class="form-control" required></textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-md-10">
							<label for="enlace">Link</label>
							<input type="text" name="enlace" id="enlace" class="form-control" required>
						</div>
					</div>
					<input type="hidden" name="guardar_dif" value="1">
					<div class="row">
						<div class="col-md-6"><br>
							<center><input type="submit" class="btn btn-success" value="{$lenguaje['registro_dif_registrar']}"></center>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
		{/if}
	</div>
	<h3>{$lenguaje["lista_inv_title"]} {$listaIns.Ins_Nombre}</h3>
	{if isset($listaofertas) && count($listaofertas)}
		<table class="table table-bordered table-striped">
			<thead>
				<th>{$lenguaje["ficha_tipo"]}</th>
				<th>{$lenguaje["registro_otros_datos_nombre"]}</th>
				<th>{$lenguaje["ficha_descripcion"]}</th>
				<th>{$lenguaje["ficha_tematica"]}</th>
				<th>{$lenguaje["Contacto"]}</th>
				<th>{$lenguaje["edicion_label_editar"]}</th>
				<th>{$lenguaje["edicion_label_eliminar"]}</th>
			</thead>
			<tbody>
				{foreach from=$listaofertas item=b}
					<tr>
						<td>{$b.Tipo}</td>
						<td>{$b.Nombre}</td>
						<td>{$b.Descripcion}</td>
						<td>{$b.Tematica}</td>
						<td>{$b.Contacto}</td>
						<td><a class="btn btn-success" href="{$_layoutParams.root_clear}es/oferta/editar/investigacion/{$listaIns.Ins_IdInstitucion}/proyecto/{$b.Ofe_IdOferta}">[{$lenguaje["edicion_label_editar"]}]</a></td>
						<td>
							<form method="post" class="form-horizontal" role="form">
								<input type="hidden" name="id_inv" value="{$b.Ofe_IdOferta}">
								<input type="hidden" name="eliminar_inv" value="1">
								<input type="submit" name="btn_eliminar" class="btn btn-danger" value="[{$lenguaje['edicion_label_eliminar']}]">
							</form>
						</td>
					</tr>
				{/foreach}
			</tbody>
		</table>
	{else}
	<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
	{/if}<br>
	<h3>{$lenguaje["lista_dif_title"]} {$listaIns.Ins_Nombre}</h3>
	{if isset($listaDif) && count($listaDif)}
		<table class="table table-bordered table-striped">
			<thead>
				<th>{{$lenguaje["registro_otros_datos_nombre"]}}</th>
				<th>Link</th>
				<th>{$lenguaje["ficha_descripcion"]}</th>
				<th>{$lenguaje["edicion_label_editar"]}</th>
				<th>{$lenguaje["edicion_label_eliminar"]}</th>
			</thead>
			<tbody>
				{foreach from=$listaDif item=b}
					<tr>
						<td>{$b.Nombre}</td>
						<td>{$b.Enlace}</td>
						<td>{$b.Descripcion}</td>
						<td><a class="btn btn-success" href="{$_layoutParams.root_clear}es/oferta/editar/investigacion/{$listaIns.Ins_IdInstitucion}/difusion/{$b.Dif_IdDifusion}">[{$lenguaje["edicion_label_editar"]}]</a></td>
						<td>
							<form method="post" class="form-horizontal" role="form">
								<input type="hidden" name="id_dif" value="{$b.Dif_IdDifusion}">
								<input type="hidden" name="eliminar_dif" value="1">
								<input type="submit" name="btn_eliminar" class="btn btn-danger" value="[{$lenguaje['edicion_label_eliminar']}]">
							</form>
						</td>
					</tr>
				{/foreach}
			</tbody>
		</table>
	{else}
	<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
	{/if}
</div>