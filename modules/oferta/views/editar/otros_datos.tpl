<div class="container">
	<center><h2>Edición de Instituciones</h2></center>
	<ul class="nav nav-tabs">
		<li><a>1. Datos Generales</a></li>
		<li class="active"><a>2. Datos Complementarios</a></li>
	</ul><br>
	{if isset($mensaje_guardado)}
		<h3>La Institución <b>{$ins}</b> fue {$mensaje_guardado}</h3>
	{/if}
	<h3>Ingrese otros datos complementarios de la Institución que considere relevantes. </h3><br>
	<div class="row">
		<div class="col-md-6">
			<form method="post" class="form-horizontal" role="form">
				<div class="row">
					<div class="col-md-6">
						<label for="atributo">Ítem</label>
						<input type="text" name="atributo" id="atributo" class="form-control" required>
						<p style="color: red;">(Ejemplo: Año de Fundación, emails alternativos, capacidad de su auditorio, etc.)</p>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<label for="valor">Valor del Ítem</label>
						<input type="text" name="valor" id="valor" class="form-control" required>
					</div>
				</div>
				<input type="hidden" name="guardar_otros_datos" value="1">
				<input type="hidden" name="ultimo_id" value="{$ultimo_id}">
				<br>
				<div class="row">
					<div class="col-md-4">
						<center><input type="submit" class="btn btn-success" value="Registrar Datos"></center>
					</div>
				</div>
			</form>
		</div>
		<div class="col-md-6">
			{if isset($editar_od) && count($editar_od)}
				<form method="post" class="form-horizontal" role="form">
					<div class="row">
						<div class="col-md-6">
							<label for="atributo">Ítem</label>
							<input type="text" name="atributoE" id="atributo" class="form-control" value="{$editar_od.Atributo}" required>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<label for="valor">Valor del ítem</label>
							<input type="text" name="valorE" id="valor" class="form-control" required value="{$editar_od.Valor}">
						</div>
						<input type="hidden" name="editar_otros_datos" value="1">
						<input type="hidden" name="id_editar_otros_datos" value="{$editar_od.Ins_IdInstitucion_otros_datos}">
						<input type="hidden" name="ultimo_idE" value="{$ultimo_id}">
					</div><br>
					<div class="row">
						<div class="col-md-4">
							<center><input type="submit" class="btn btn-success" value="Editar Datos"></center>
						</div>
					</div>
				</form>	
			{/if}
		</div>
	</div>
	<br>
	<div class="row">
		<h3>Datos Guardados</h3>
		{if isset($otros_datos_ins) && count($otros_datos_ins)}
		<table class="table table-bordered">

			<thead>
				<th>Ítem</th>
				<th>Valor del ítem</th>
				<th>Editar</th>
				<th>Eliminar</th>
			</thead>
			<tbody>
				
					{foreach from=$otros_datos_ins item=b}
						<tr>
							<td>{$b.Atributo}</td>
							<td>{$b.Valor}</td>
							<td><a class="btn btn-success" href="{$_layoutParams.root_clear}es/oferta/editar/index/{$b.Ins_IdInstitucion}/{$b.Ins_IdInstitucion_otros_datos}">[Editar]</a></td>
							<td>
								<form method="post" class="form-horizontal" role="form">
									<input type="hidden" name="id_ins_o_d" value="{$b.Ins_IdInstitucion_otros_datos}">
									<input type="hidden" name="eliminar" value="1">
									<input type="submit" name="btn_eliminar" class="btn btn-danger" value="[Eliminar]">
								</form>
							</td>
						</tr>
					{/foreach}
			</tbody>
		</table>
		{else}
		<p>No se encontraron registros.</p>
		{/if}
	</div>
	<div class="row">
		<a href="{$_layoutParams.root_clear}es/oferta/instituciones/ficha/{$ultimo_id}" class="btn btn-primary">Finalizar edición</a>
	</div><br>
</div>