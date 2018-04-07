<div class="container">
	<center><h2>Registro de Instituciones</h2><br></center>
	<ul class="nav nav-tabs">
		<li><a>1. Datos Generales</a></li>
		<li><a>2. Datos Complementarios</a></li>
		<li class="active"><a>3. Ofertas Académicas</a></li>
		<li><a>4. Investigación y Difusión</a></li>
	</ul><br>
	<h3>Registrar Ofertas Académicas de <b>{$listaIns.Ins_Nombre}</b></h3>
	<form method="post" class="form-horizontal" role="form">
		<div class="row">
			<div class="col-md-4">
				<label for="tipooferta">Tipo de Oferta Académica</label>
				<select name="tipooferta" id="tipooferta" class="form-control" required>
					<option>--Seleccione--</option>
					{if isset($tipooferta) && count($tipooferta)}
						{foreach from=$tipooferta item=b}
							<option value="{$b.Nombre}">{$b.Nombre}</option>
						{/foreach}
					{/if}
				</select>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
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
			<div class="col-md-4">
				<label for="nombre">Nombre de la Oferta Académica</label>
				<input type="text" name="nombre" id="nombre" class="form-control" required>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<label for="descripcion">Breve Descripción</label>
				<textarea name="descripcion" id="descripcion" class="form-control" required></textarea>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<label for="contacto">Contacto</label>
				<input type="text" name="contacto" id="contacto" class="form-control" required>
			</div>
		</div>
		<input type="hidden" name="guardar" value="1"><br>
		<div class="row">
			<div class="col-md-4">
				<center><input type="submit" class="btn btn-success" value="Registrar Oferta"></center>
				
			</div>
		</div>
	</form>
	<h3>Lista de Ofertas Académicas de <b>{$listaIns.Ins_Nombre}</b></h3>
	{if isset($listaofertas) && count($listaofertas)}
		<table class="table table-bordered">
			<thead>
				<th>Tipo</th>
				<th>Nombre</th>
				<th>Descripción</th>
				<th>Temática</th>
				<th>Contacto</th>
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
	<p>No se encontraron registros.</p>
	{/if}
<br><a href="{$_layoutParams.root_clear}es/oferta/registro/investigacion/{$id}" class="btn btn-danger">Omitir esta sección</a>
<a href="{$_layoutParams.root_clear}es/oferta/registro/investigacion/{$id}" class="btn btn-primary">Guardar y Continuar</a>
</div>