<div class="container">
	<center><h2>{$lenguaje["registro_ins"]}</h2></center><br>
	<ul class="nav nav-tabs">
		<li><a>1. {$lenguaje["registro_datos_generales"]}</a></li>
		<li><a>2. {$lenguaje["registro_datos_complementarios"]}</a></li>
		<li class="active"><a>3. {$lenguaje["busqueda_avanzada_label_ofertasR"]}</a></li>
		<li><a>4. {$lenguaje["registro_inv_dif"]}</a></li>
		<li><a>5. {$lenguaje["registro_li_idiomas"]}</a></li>
	</ul><br>
	<h3>{$lenguaje["registro_ofertas_academicas"]} <b>{$listaIns.Ins_Nombre}</b></h3>
	<form method="post" class="form-horizontal" role="form">
		<div class="row">
			<div class="col-md-4">
				<label for="tipooferta">{$lenguaje["busqueda_avanzada_label_tipo_ofertas"]}</label>
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
			<div class="col-md-4">
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
			<div class="col-md-4">
				<label for="nombre">{$lenguaje["registro_oferta_nombre"]}</label>
				<input type="text" name="nombre" id="nombre" class="form-control" required>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<label for="descripcion">{$lenguaje["ficha_descripcion"]}</label>
				<textarea name="descripcion" id="descripcion" class="form-control" required></textarea>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<label for="contacto">{$lenguaje["Contacto"]}</label>
				<input type="text" name="contacto" id="contacto" class="form-control" required>
			</div>
		</div>
		<input type="hidden" name="guardar" value="1"><br>
		<div class="row">
			<div class="col-md-4">
				<center><input type="submit" class="btn btn-success" value="{$lenguaje['registro_oferta_registrar']}"></center>
				
			</div>
		</div>
	</form>
	<h3>{$lenguaje["lista_oferta_title"]} <b>{$listaIns.Ins_Nombre}</b></h3>
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
	{/if}
<br><a href="{$_layoutParams.root_clear}es/oferta/registro/investigacion/{$id}" class="btn btn-danger">{$lenguaje["registro_otros_datos_omitir"]}</a>
<a href="{$_layoutParams.root_clear}es/oferta/registro/investigacion/{$id}" class="btn btn-primary">{$lenguaje["registro_otros_datos_guardar"]}</a>
</div>