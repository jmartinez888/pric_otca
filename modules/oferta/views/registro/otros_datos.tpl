<div class="container">
	<center><h2>{$lenguaje["registro_ins"]}</h2></center><br>
	<ul class="nav nav-tabs">
		<li><a>1. {$lenguaje["registro_datos_generales"]}</a></li>
		<li class="active"><a>2. {$lenguaje["registro_datos_complementarios"]}</a></li>
		<li><a>3. {$lenguaje["busqueda_avanzada_label_ofertasR"]}</a></li>
		<li><a>4. {$lenguaje["registro_inv_dif"]}</a></li>
		<li><a>5. {$lenguaje["registro_li_idiomas"]}</a></li>
	</ul><br>
	{if isset($mensaje_guardado)}
		<h3>{$lenguaje["registro_la_ins"]} <b>{$ins}</b> {$lenguaje["registro_guardado"]}</h3>
	{/if}
	<h3>{$lenguaje["registro_otros_datos"]}</h3><br>
	<form method="post" class="form-horizontal" role="form">
		<div class="row">
			<div class="col-md-4">
				<label for="atributo">{$lenguaje["registro_otros_datos_nombre"]}</label>
				<input type="text" name="atributo" id="atributo" class="form-control" required>
				<p style="color: red;">{$lenguaje["registro_otros_datos_nombre_ejemplo"]}</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<label for="valor">{$lenguaje["registro_otros_datos_contenido"]}</label>
				<input type="text" name="valor" id="valor" class="form-control" required>
			</div>
		</div>
		<input type="hidden" name="guardar_otros_datos" value="1">
		<input type="hidden" name="ultimo_id" value="{$ultimo_id}"><br>
		<div class="row">
			<div class="col-md-4">
				<center><input type="submit" class="btn btn-success" value="{$lenguaje['registro_otros_datos_registrar']}"></center>
			</div>
		</div>
	</form>
	<br>
	<h3>{$lenguaje["registro_otros_datos_lista"]}</h3>
	{if isset($otros_datos_ins) && count($otros_datos_ins)}
	<table class="table table-bordered">
		<thead>
			<th>{$lenguaje["registro_otros_datos_nombre"]}</th>
			<th>{$lenguaje["registro_otros_datos_contenido"]}</th>
		</thead>
		<tbody>
				{foreach from=$otros_datos_ins item=b}
					<tr>
						<td>{$b.Atributo}</td>
						<td>{$b.Valor}</td>
					</tr>
				{/foreach}
		</tbody>
	</table>
	{else}
		<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
		{/if}
		<a href="registro/ofertas_academicas/{$ultimo_id}" class="btn btn-danger">{$lenguaje["registro_otros_datos_omitir"]}</a>
		<a href="registro/ofertas_academicas/{$ultimo_id}" class="btn btn-primary">{$lenguaje["registro_otros_datos_guardar"]}</a>
</div>