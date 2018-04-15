<div class="container">
	<center><h2>{$lenguaje["registro_ins"]}</h2></center><br>
	<ul class="nav nav-tabs">
		<li><a>1. {$lenguaje["registro_datos_generales"]}</a></li>
		<li><a>2. {$lenguaje["registro_datos_complementarios"]}</a></li>
		<li><a>3. {$lenguaje["busqueda_avanzada_label_ofertasR"]}</a></li>
		<li class="active"><a>4. {$lenguaje["registro_inv_dif"]}</a></li>
		<li><a>5. {$lenguaje["registro_li_idiomas"]}</a></li>
	</ul><br>
	<div class="row">
		<div class="col-md-5">
			<form method="post" class="form-horizontal" role="form">
				<fieldset>
					<legend>{$lenguaje["busqueda_avanzada_label_proyectosR"]}</legend>
					<div class="row">
					<div class="col-md-10">
						<label for="tipooferta">{$lenguaje["registro_inv_tipo_inv"]}</label>
						<input type="text" name="tipooferta" id="tipooferta" class="form-control" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-10">
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
					<div class="col-md-10">
						<label for="nombre">{$lenguaje["registro_inv_nombre"]}</label>
						<input type="text" name="nombre" id="nombre" class="form-control" required>
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
						<label for="contacto">{$lenguaje["Contacto"]}</label>
						<input type="text" name="contacto" id="contacto" class="form-control" required>
					</div>
				</div>
				<input type="hidden" name="guardar_inv" value="1"><br>
				<div class="row">
					<div class="col-md-6">
						<center><input type="submit" class="btn btn-success" value="{$lenguaje['registro_inv_registrar']}"></center>
						
					</div>
				</div>
				</fieldset>
			</form>
		</div>
		<div class="col-md-4 col-md-offset-2">
			<form method="post" class="form-horizontal" role="form">
				<fieldset>
					<legend>{$lenguaje["ficha_dif"]}</legend>
					<div class="row">
						<div class="col-md-10">
							<label for="difusion">{$lenguaje["registro_otros_datos_nombre"]}</label>
							<input type="text" name="difusion" id="difusion" class="form-control" required>
						</div>
					</div>
					<div class="row">
						<div class="col-md-10">
							<label for="dif_descripcion">{$lenguaje["ficha_descripcion"]}</label>
							<textarea name="dif_descripcion" id="dif_descripcion" class="form-control" required></textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-md-10">
							<label for="dif_enlace">Link:</label>
							<input type="text" name="dif_enlace" id="dif_enlace" class="form-control" required>
						</div>
					</div>
					<input type="hidden" name="guardar_dif" value="1"><br>
					<div class="row">
						<div class="col-md-6">
							<center><input type="submit" class="btn btn-success" value="{$lenguaje['registro_dif_registrar']}"></center>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	<h3>{$lenguaje["lista_inv_title"]}{$listaIns.Ins_Nombre}</h3>
	{if isset($listaofertas) && count($listaofertas)}
		<table class="table table-bordered">
			<thead>
				<th>{$lenguaje["ficha_tipo"]}</th>
				<th>{$lenguaje["registro_otros_datos_nombre"]}</th>
				<th>{$lenguaje["ficha_descripcion"]}</th>
				<th>{$lenguaje["ficha_tematica"]}</th>
				<th>{$lenguaje["Contacto"]}</th>
			</thead>
			<tbody>
				{foreach from=$listaofertas item=b}
					<tr>
						<td>{$b.Tipo}</td>
						<td>{$b.Nombre}</td>
						<td>{$b.Descripcion}</td>
						<td>{$b.Tematica}</td>
						<td>{$b.Contacto}</td>
					</tr>
				{/foreach}
			</tbody>
		</table>
	{else}
	<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
	{/if}<br>
	<h3>{$lenguaje["lista_dif_title"]} {$listaIns.Ins_Nombre}</h3>
	{if isset($listaDif) && count($listaDif)}
		<table class="table table-bordered">
			<thead>
				<th>{$lenguaje["registro_otros_datos_nombre"]}</th>
				<th>Link</th>
				<th>{$lenguaje["ficha_descripcion"]}</th>
			</thead>
			<tbody>
				{foreach from=$listaDif item=b}
					<tr>
						<td>{$b.Nombre}</td>
						<td>{$b.Enlace}</td>
						<td>{$b.Descripcion}</td>
					</tr>
				{/foreach}
			</tbody>
		</table>
	{else}
	<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
	{/if}
	<br>
<a href="{$_layoutParams.root_clear}es/oferta/registro/idiomas/{$id}" class="btn btn-danger">{$lenguaje["registro_otros_datos_omitir"]}</a>
<a href="{$_layoutParams.root_clear}es/oferta/registro/idiomas/{$id}" class="btn btn-primary">{$lenguaje["registro_otros_datos_guardar"]}</a>

</div>