<div class="container">
	<center><h2>Registro de Instituciones</h2><br></center>
	<ul class="nav nav-tabs">
		<li><a>1. Datos Generales</a></li>
		<li class="active"><a>2. Datos Complementarios</a></li>
		<li><a>3. Ofertas Académicas</a></li>
		<li><a>4. Investigación y Difusión</a></li>
	</ul><br>
	{if isset($mensaje_guardado)}
		<h3>La Institución <b>{$ins}</b> fue {$mensaje_guardado}.</h3>
	{/if}
	<h3>Ingrese otros datos complementarios de la Institución que considere relevantes. </h3><br>
	<form method="post" class="form-horizontal" role="form">
		<div class="row">
			<div class="col-md-4">
				<label for="atributo">Nombre</label>
				<input type="text" name="atributo" id="atributo" class="form-control" required>
				<p style="color: red;">(Ejemplo: Año de Fundación, emails alternativos, capacidad de su auditorio, etc.)</p>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<label for="valor">Contenido</label>
				<input type="text" name="valor" id="valor" class="form-control" required>
			</div>
		</div>
		<input type="hidden" name="guardar_otros_datos" value="1">
		<input type="hidden" name="ultimo_id" value="{$ultimo_id}"><br>
		<div class="row">
			<div class="col-md-4">
				<center><input type="submit" class="btn btn-success" value="Registrar datos"></center>
			</div>
		</div>
	</form>
	<br>
	<h3>Datos complementarios guardados</h3>
	{if isset($otros_datos_ins) && count($otros_datos_ins)}
	<table class="table table-bordered">
		<thead>
			<th>Atributo</th>
			<th>Valor</th>
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
		<p>No se encontraron registros.</p>
		{/if}
		<a href="registro/ofertas_academicas/{$ultimo_id}" class="btn btn-danger">Omitir esta sección</a>
		<a href="registro/ofertas_academicas/{$ultimo_id}" class="btn btn-primary">Guardar y Continuar</a>
</div>