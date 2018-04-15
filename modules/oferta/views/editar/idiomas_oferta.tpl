<div class="container">
	<div class="row">
		<div class="col-md-9">
			<center><h3>{$lenguaje["edicion_editar_ofertas_title"]} <b>{$listaIns.Ins_Nombre}</b></h3></center>
		</div>
		<div class="col-md-3">
			<br><a href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$id}" class="btn btn-primary">{$lenguaje["edicion_editar_fin"]}</a>
		</div>
	</div>
	<ul class="nav nav-tabs">
		<li class="active"><a>{$lenguaje["busqueda_avanzada_label_ofertasR"]}</a></li>
	</ul><br>
	{if isset($actualizado_correctamente)}
	<h3>{$lenguaje["registro_msj_final"]}</h3>
	<center><a href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$id}" class="btn btn-primary">{$lenguaje["registro_ver_ficha"]}</a></center>
	{else}
	{if isset($editar_idiomas_oferta) && count($editar_idiomas_oferta)}
	<div class="row">
		<div class="col-md-6">
			
				<form method="post" class="form-horizontal" role="form">
					<fieldset>
					<legend>{$lenguaje["edicion_label_editar"]}</legend>
					<div class="row">
						<div class="col-md-8">
							<label for="nombre">{$lenguaje["registro_oferta_nombre"]}</label>
							<input type="text" name="nombre" id="nombre" class="form-control" required value="{$editar_oferta_nombre}">
						</div>
					</div>
					<div class="row">
						<div class="col-md-8">
							<label for="descripcion">{$lenguaje["ficha_descripcion"]}</label>
							<textarea name="descripcion" id="descripcion" class="form-control" required>{$editar_oferta_descripcion}</textarea>
						</div>
					</div>
					<input type="hidden" name="idioma" value="{$editar_oferta_idioma}">
					<input type="hidden" name="editar_idoferta" value="{$editar_idoferta}">
					<input type="hidden" name="editar_idi_ofertas" value="1"><br>
					<div class="row">
						<div class="col-md-8">
							<center><input type="submit" class="btn btn-success" value="{$lenguaje['edicion_label_editar']}"></center>
						</div>
					</div>
					</fieldset>
				</form>
			
		</div>
	</div>	
	{else}
	<div class="row">

		<h3>{$lenguaje["lista_oferta_title"]}  {$listaIns.Ins_Nombre}</h3>
		{if isset($listaofertas) && count($listaofertas)}
			<table class="table table-bordered">
				<thead>
					<th>{$lenguaje["registro_otros_datos_nombre"]}</th>
					<th>{$lenguaje["ficha_descripcion"]}</th>					
					<th>{$lenguaje["edicion_label_editar"]}</th>
				</thead>
				<tbody>{$cont_=0}
					{foreach from=$listaofertas item=c}
						{foreach from=$c item=b}
						<tr>
							<td>{$b.Ofe_Nombre}</td>
							<td>{$b.Ofe_Descripcion}</td>
							<form method="post">
								<input type="hidden" name="nombre" value="{$b.Ofe_Nombre}">
								<input type="hidden" name="descripcion" value="{$b.Ofe_Descripcion}">
								<input type="hidden" name="idioma" value="{$cont_}">
								<input type="hidden" name="id_oferta" value="{$b.Ofe_IdOferta}">
								<input type="hidden" name="editar_traduccion_oferta" value="1">
								<td><input type="submit" class="btn btn-success" value="[{$lenguaje['edicion_label_editar']}]" ></td>
							</form>
						</tr>{$cont_=1}
						{/foreach}
					{/foreach}
				</tbody>
			</table>
		{else}
		<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
		{/if}
	</div>
	{/if}
	{/if}
</div>