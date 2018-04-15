<div class="container">
	<div class="row">
		<div class="col-md-9">
			<center><h3>{$lenguaje["edicion_editar_ofertas_title"]} <b>{$listaIns.Ins_Nombre}</b></h3></center>
		</div>
		<div class="col-md-3">
			<br><a href="{$_layoutParams.root_clear}es/oferta/instituciones/ficha/{$id}" class="btn btn-primary">{$lenguaje["edicion_editar_fin"]}</a>
		</div>
	</div>
	<ul class="nav nav-tabs">
		<li class="active"><a>{$lenguaje["busqueda_avanzada_label_ofertasR"]}</a></li>
	</ul><br>
	<div class="row">
		<div class="col-md-6">
			<form method="post" class="form-horizontal" role="form">
				<fieldset>
					<legend>{$lenguaje["registro_otros_datos_registrar"]}</legend>
					<div class="row">
					<div class="col-md-8">
						<label for="tipooferta">{{$lenguaje["busqueda_avanzada_label_tipo_ofertas"]}}</label>
						<select name="tipooferta" id="tipooferta" class="form-control" required>
							<option>{$lenguaje["busqueda_avanzada_select_pais"]}</option>
							{if isset($tipooferta) && count($tipooferta)}
								{foreach from=$tipooferta item=b}
									<option value="{$b.Nombre}">{$b.Nombre}</option>
								{/foreach}
							{/if}
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
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
					<div class="col-md-8">
						<label for="nombre">{$lenguaje["registro_oferta_nombre"]}</label>
						<input type="text" name="nombre" id="nombre" class="form-control" required>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<label for="descripcion">{$lenguaje["ficha_descripcion"]}</label>
						<textarea name="descripcion" id="descripcion" class="form-control" required></textarea>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<label for="contacto">{$lenguaje["Contacto"]}</label>
						<input type="text" name="contacto" id="contacto" class="form-control" required>
					</div>
				</div>
				<input type="hidden" name="guardar" value="1"><br>
				<div class="row">
					<div class="col-md-8">
						<center><input type="submit" class="btn btn-success" value="{$lenguaje['registro_oferta_registrar']}"></center>
					</div>
				</div>
				</fieldset>
			</form>		
		</div>
		<div class="col-md-6">
			{if isset($editar_oferta) && count($editar_oferta)}
				<form method="post" class="form-horizontal" role="form">
				<fieldset>
					<legend>{$lenguaje["edicion_label_editar"]}</legend>
					<div class="row">
					<div class="col-md-8">
						<label for="tipooferta">{$lenguaje["busqueda_avanzada_label_tipo_ofertas"]}</label>
						<select name="tipooferta" id="tipooferta" class="form-control" required>
							{if isset($tipooferta) && count($tipooferta)}
								{foreach from=$tipooferta item=b}
									{if $editar_oferta.Ofe_Tipo == $b.Nombre}
									<option selected="true" value="{$b.Nombre}">{$b.Nombre}</option>
									{else}
									<option value="{$b.Nombre}">{$b.Nombre}</option>
									{/if}
								{/foreach}
							{/if}
						</select>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<label for="tematica">{$lenguaje["ficha_tematica"]}</label>
						<select name="tematica" id="tematica" class="form-control" required>
							{if isset($tematica) && count($tematica)}
								{foreach from=$tematica item=b}
								{if $editar_oferta.Tem_Nombre == $b.Nombre}
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
					<div class="col-md-8">
						<label for="nombre">{$lenguaje["registro_oferta_nombre"]}</label>
						<input type="text" name="nombre" id="nombre" class="form-control" required value="{$editar_oferta.Ofe_Nombre}">
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<label for="descripcion">{$lenguaje["ficha_descripcion"]}</label>
						<textarea name="descripcion" id="descripcion" class="form-control" required>{$editar_oferta.Ofe_Descripcion}</textarea>
					</div>
				</div>
				<div class="row">
					<div class="col-md-8">
						<label for="contacto">{$lenguaje["Contacto"]}</label>
						<input type="text" name="contacto" id="contacto" class="form-control" value="{$editar_oferta.Contacto}" required>
					</div>
				</div>
				<input type="hidden" name="editar" value="1"><br>
				<div class="row">
					<div class="col-md-8">
						<center><input type="submit" class="btn btn-success" value="{$lenguaje['edicion_label_editar']}"></center>
					</div>
				</div>
				</fieldset>
			</form>
			{/if}
		</div>
	</div>	
	<div class="row">
		<h3>{$lenguaje["lista_oferta_title"]}  {$listaIns.Ins_Nombre}</h3>
		{if isset($listaofertas) && count($listaofertas)}
			<table class="table table-bordered">
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
							<td><a class="btn btn-success" href="{$_layoutParams.root_clear}es/oferta/editar/ofertas_academicas/{$b.Ins_IdInstitucion}/{$b.Ofe_IdOferta}">[{$lenguaje["edicion_label_editar"]}]</a></td>
							<td>
								<form method="post" class="form-horizontal" role="form">
									<input type="hidden" name="id_oferta" value="{$b.Ofe_IdOferta}">
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
</div>