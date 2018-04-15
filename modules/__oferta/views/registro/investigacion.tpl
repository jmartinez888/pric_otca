<div class="container">
	<center><h2>Registro de Instituciones</h2><br></center>
	<ul class="nav nav-tabs">
		<li><a>1. Datos Generales</a></li>
		<li><a>2. Datos Complementarios</a></li>
		<li><a>3. Ofertas Académicas</a></li>
		<li class="active"><a>4. Investigación y Difusión</a></li>
	</ul><br>
	<div class="row">
		<div class="col-md-5">
			<form method="post" class="form-horizontal" role="form">
				<fieldset>
					<legend>Proyectos de Investigación</legend>
					<div class="row">
					<div class="col-md-10">
						<label for="tipooferta">Tipo de Investigación Realizada</label>
						<input type="text" name="tipooferta" id="tipooferta" class="form-control" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-10">
						<label for="tematica">Temática Relacionada</label>
						<select name="tematica" id="tematica" class="form-control" required>
							<option>--Seleccione--</option>
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
						<label for="nombre">Nombre de la Investigación Realizada</label>
						<input type="text" name="nombre" id="nombre" class="form-control" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-10">
						<label for="descripcion">Breve Descripción</label>
						<textarea name="descripcion" id="descripcion" class="form-control" required></textarea>
					</div>
				</div>
				<div class="row">
					<div class="col-md-10">
						<label for="contacto">Contacto</label>
						<input type="text" name="contacto" id="contacto" class="form-control" required>
					</div>
				</div>
				<input type="hidden" name="guardar_inv" value="1"><br>
				<div class="row">
					<div class="col-md-6">
						<center><input type="submit" class="btn btn-success" value="Guardar Proyecto de Investigación"></center>
						
					</div>
				</div>
				</fieldset>
			</form>
		</div>
		<div class="col-md-4 col-md-offset-2">
			<form method="post" class="form-horizontal" role="form">
				<fieldset>
					<legend>Medios de Difusión</legend>
					<div class="row">
						<div class="col-md-10">
							<label for="difusion">Nombre:</label>
							<input type="text" name="difusion" id="difusion" class="form-control" required>
						</div>
					</div>
					<div class="row">
						<div class="col-md-10">
							<label for="dif_descripcion">Descripcion:</label>
							<textarea name="dif_descripcion" id="dif_descripcion" class="form-control" required></textarea>
						</div>
					</div>
					<div class="row">
						<div class="col-md-10">
							<label for="dif_enlace">Enlace:</label>
							<input type="text" name="dif_enlace" id="dif_enlace" class="form-control" required>
						</div>
					</div>
					<input type="hidden" name="guardar_dif" value="1"><br>
					<div class="row">
						<div class="col-md-6">
							<center><input type="submit" class="btn btn-success" value="Guardar Medio de Difusión"></center>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	<h3>Lista de Proyectos de Investigación de {$listaIns.Ins_Nombre}</h3>
	{if isset($listaofertas) && count($listaofertas)}
		<table class="table table-bordered">
			<thead>
				<th>Tipo</th>
				<th>Nombre</th>
				<th>Descripción</th>
				<th>Temática</th>
				<th>Contacto</th>
				<!--<th>Editar</th>
				<th>Eliminar</th>-->
			</thead>
			<tbody>
				{foreach from=$listaofertas item=b}
					<tr>
						<td>{$b.Tipo}</td>
						<td>{$b.Nombre}</td>
						<td>{$b.Descripcion}</td>
						<td>{$b.Tematica}</td>
						<td>{$b.Contacto}</td>
						<!--<td><a href="">[Editar]</a></td>
						<td><a href="">[Eliminar]</a></td>-->
					</tr>
				{/foreach}
			</tbody>
		</table>
	{else}
	<p>No se encontraron registros.</p>
	{/if}<br>
	<h3>Lista de Medios de Difusión de {$listaIns.Ins_Nombre}</h3>
	{if isset($listaDif) && count($listaDif)}
		<table class="table table-bordered">
			<thead>
				<th>Nombre</th>
				<!--<th>Editar</th>
				<th>Eliminar</th>-->
			</thead>
			<tbody>
				{foreach from=$listaDif item=b}
					<tr>
						<td>{$b.Nombre}</td>
						<!--<td><a href="">[Editar]</a></td>
						<td><a href="">[Eliminar]</a></td>-->
					</tr>
				{/foreach}
			</tbody>
		</table>
	{else}
	<p>No se encontraron registros.</p>
	{/if}
	<br><a href="{$_layoutParams.root_clear}es/oferta/instituciones/ficha/{$id}" class="btn btn-danger">Omitir esta sección y Finalizar</a>
	<a href="{$_layoutParams.root_clear}es/oferta/instituciones/ficha/{$id}" class="btn btn-primary">Guardar y Finalizar</a>
</div>