<div class="container">
	<center><h2>{$lenguaje["edicion_ins_title"]}</h2></center>
	<ul class="nav nav-tabs">
		<li><a>1. {$lenguaje["registro_datos_generales"]}</a></li>
		<li class="active"><a>2. {$lenguaje["registro_datos_complementarios"]}</a></li>
	</ul><br>
	{if isset($mensaje_guardado)}
		<h3>{$lenguaje["registro_la_ins"]} <b>{$ins}</b> {$lenguaje["registro_actualizado"]}</h3>
	{/if}
	<h3>{$lenguaje["registro_otros_datos"]}</h3><br>
	<div class="row">
		<div class="col-md-6">
			<form method="post" class="form-horizontal" role="form">
				<div class="row">
					<div class="col-md-6">
						<label for="atributo">{$lenguaje["registro_otros_datos_nombre"]}</label>
						<input type="text" name="atributo" id="atributo" class="form-control" required>
						<p style="color: red;">{$lenguaje["registro_otros_datos_nombre_ejemplo"]}</p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="valor">{$lenguaje["registro_otros_datos_contenido"]}</label>
						<input type="text" name="valor" id="valor" class="form-control" required>
					</div>
				</div>
				<input type="hidden" name="guardar_otros_datos" value="1">
				<input type="hidden" name="ultimo_id" value="{$ultimo_id}">
				<br>
				<div class="row">
					<div class="col-md-4">
						<center><input type="submit" class="btn btn-success" value="{$lenguaje['registro_otros_datos_registrar']}"></center>
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-6">
			{if isset($editar_od) && count($editar_od)}
				<form method="post" class="form-horizontal" role="form">
					<div class="row">
						<div class="col-md-6">
							<label for="atributo">{$lenguaje["registro_otros_datos_nombre"]}</label>
							<input type="text" name="atributoE" id="atributo" class="form-control" value="{$editar_od.Atributo}" required>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<label for="valor">{$lenguaje["registro_otros_datos_contenido"]}</label>
							<input type="text" name="valorE" id="valor" class="form-control" required value="{$editar_od.Valor}">
						</div>
						<input type="hidden" name="editar_otros_datos" value="1">
						<input type="hidden" name="id_editar_otros_datos" value="{$editar_od.Ins_IdInstitucion_otros_datos}">
						<input type="hidden" name="ultimo_idE" value="{$ultimo_id}">
					</div><br>
					<div class="row">
						<div class="col-md-4">
							<center><input type="submit" class="btn btn-success" value="{$lenguaje['ficha_editar_guardar']}"></center>
						</div>
					</div>
				</form>	
			{/if}
		</div>
	</div>
	<br>
	<div class="row">
		<h3>{$lenguaje["registro_otros_datos_lista"]}</h3>
		{if isset($otros_datos_ins) && count($otros_datos_ins)}
		<table class="table table-bordered">

			<thead>
				<th>{$lenguaje["registro_otros_datos_nombre"]}</th>
				<th>{$lenguaje["registro_otros_datos_contenido"]}</th>
				<th>{$lenguaje["edicion_label_editar"]}</th>
				<th>{$lenguaje["edicion_label_eliminar"]}</th>
			</thead>
			<tbody>
				
					{foreach from=$otros_datos_ins item=b}
						<tr>
							<td>{$b.Atributo}</td>
							<td>{$b.Valor}</td>
							<td><a class="btn btn-success" href="{$_layoutParams.root_clear}es/oferta/editar/index/{$b.Ins_IdInstitucion}/{$b.Ins_IdInstitucion_otros_datos}">[{$lenguaje["edicion_label_editar"]}]</a></td>
							<td>
								<form method="post" class="form-horizontal" role="form">
									<input type="hidden" name="id_ins_o_d" value="{$b.Ins_IdInstitucion_otros_datos}">
									<input type="hidden" name="eliminar" value="1">
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
	<div class="row">
		<a href="{$_layoutParams.root_clear}es/oferta/instituciones/ficha/{$ultimo_id}" class="btn btn-primary">{$lenguaje["edicion_editar_fin"]}</a>
	</div><br>
</div>