<div class="container">
<center><h2>{$lenguaje["registro_ins"]}</h2></center><br>
	<ul class="nav nav-tabs">
		<li><a>1. {$lenguaje["registro_datos_generales"]}</a></li>
		<li><a>2. {$lenguaje["registro_datos_complementarios"]}</a></li>
		<li><a>3. {$lenguaje["busqueda_avanzada_label_ofertasR"]}</a></li>
		<li><a>4. {$lenguaje["registro_inv_dif"]}</a></li>
		<li class="active"><a>5. {$lenguaje["registro_li_idiomas"]}</a></li>
	</ul><br>
	{if isset($guardado_correctamente)}
	<h3>{$lenguaje["registro_msj_final"]}</h3>
	<center><a href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$id}" class="btn btn-primary">{$lenguaje["registro_ver_ficha"]}</a></center>
	{else}
	
	<form method="post" enctype="multipart/form-data" class="form-horizontal" role="form">
		<div class="row">
			<div class="col-md-6">
				{if isset($idioma_1)}
					<div class="row">
						<div class="col-md-11">
							<h2>{$lenguaje["idioma_label"]}: <b>{$idioma_1.Idi_Idioma}</b></h2>
							<input type="hidden" name="idi1_ididioma" value="{$idioma_1.Idi_IdIdioma}">
							<br>
							<h3>1. {$lenguaje["registro_datos_generales"]}</h3>
							<div class="row">
								<div class="col-md-7">
									<label for="idi1_nombre">{$lenguaje["registro_label_nombre"]}</label>
									<input type="text" name="idi1_nombre"  title="{$lenguaje['registro_label_nombre_title']}" id="idi1_nombre" class="form-control" required>
								</div>
							</div>
							<div class="row">
								<div class="col-md-7">
									<label for="idi1_descripcion">{$lenguaje["ficha_descripcion"]}</label>
									<textarea name="idi1_descripcion" class="form-control" id="idi1_descripcion"></textarea>
								</div>
							</div>
							<hr>
							<h3>2. {$lenguaje["registro_datos_complementarios"]}</h3><br>
							{if isset($otros_datos_ins) && count($otros_datos_ins)}
								{$contador_iod = 0}
								{foreach from=$otros_datos_ins item=b}
									<table class="table table-bordered">
										<thead>
											<th>{$lenguaje["idioma_label_original"]}: </th>
											<th>{$b.Atributo}</th>
											<th>{$b.Valor}</th>
										</thead>
										<tbody>
											<tr>
												<td>{$lenguaje["idioma_label_traduccion"]}: </td>
												<td><input type="text" name="idi1_atributo_{$contador_iod}" id="idi1_atributo_{$contador_iod}" class="form-control" required></td>
												<td><input type="text" name="idi1_valor_{$contador_iod}" id="idi1_valor_{$contador_iod}" class="form-control" required></td>
												<input type="hidden" name="idi1_idiod_{$contador_iod}" value="{$b.Ins_IdInstitucion_otros_datos}">
											</tr>				
										</tbody>
									</table>
									{$contador_iod = $contador_iod + 1}
								{/foreach}
							{else}
								<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
							{/if}
							<hr>
							<h3>3. {$lenguaje["busqueda_avanzada_label_ofertasR"]}</h3><br>
							{if isset($listaofertas) && count($listaofertas)}
								{$contador_ofertas=0}
								{foreach from=$listaofertas item=b}
									<table class="table table-bordered">
										<thead>
											<th>{$lenguaje["idioma_label_original"]}: </th>
											<th>{$b.Nombre}</th>
											<th>{$b.Descripcion}</th>
										</thead>
										<tbody>
												<tr>
													<td>{$lenguaje["idioma_label_traduccion"]}: </td>
													<td><input type="text" name="idi1_nombre_{$contador_ofertas}" id="idi1_nombre_{$contador_ofertas}" class="form-control" required></td>
													<td><textarea name="idi1_descripcion_{$contador_ofertas}" id="idi1_descripcion_{$contador_ofertas}" class="form-control" required></textarea></td>
													<input type="hidden" name="idi1_idoferta_{$contador_ofertas}" value="{$b.Ofe_IdOferta}">
												</tr>
										</tbody>
									</table>
									{$contador_ofertas=$contador_ofertas + 1}
								{/foreach}
							{else}
							<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
							{/if}
							<hr>
							<h3>4. {$lenguaje["registro_inv_dif"]}</h3><br>
							{if isset($listaOfertasInv) && count($listaOfertasInv)}
								{$contador_inv=0}
								{foreach from=$listaOfertasInv item=b}
									<table class="table table-bordered">
										<thead>
											<th>{$lenguaje["idioma_label_original"]}: </th>
											<th>{$b.Nombre}</th>
											<th>{$b.Descripcion}</th>
										</thead>
										<tbody>
											<tr>
												<td>{$lenguaje["idioma_label_traduccion"]}: </td>
												<td><input type="text" name="idi1_nombre_inv_{$contador_inv}" id="idi1_nombre_inv_{$contador_inv}" class="form-control" required></td>
												<td><textarea name="idi1_descripcion_inv_{$contador_inv}" id="idi1_descripcion_inv_{$contador_inv}" class="form-control" required></textarea></td>
												<input type="hidden" name="idi1_idinv_{$contador_inv}" value="{$b.Ofe_IdOferta}">
											</tr>									
										</tbody>
									</table>
									{$contador_inv=$contador_inv + 1}
								{/foreach}
							{else}
							<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
							{/if}<br>
							{if isset($listaOfertasDifusion) && count($listaOfertasDifusion)}
								{$contador_dif=0}
								{foreach from=$listaOfertasDifusion item=b}
									<table class="table table-bordered">
										<thead>
											<th>{$lenguaje["idioma_label_original"]}: </th>
											<th>{$b.Nombre}</th>
											<th>{$b.Descripcion}</th>
										</thead>
										<tbody>
											<tr>
												<td>{$lenguaje["idioma_label_traduccion"]}: </td>
												<td><input type="text" name="idi1_difusion_{$contador_dif}" id="idi1_difusion_{$contador_dif}" class="form-control" required></td>
												<td><textarea name="idi1_dif_descripcion_{$contador_dif}" id="idi1_dif_descripcion{$contador_dif}" class="form-control" required></textarea></td>
												<input type="hidden" name="idi1_iddif_{$contador_dif}" value="{$b.Dif_IdDifusion}">
											</tr>
										</tbody>
									</table>
									{$contador_dif=$contador_dif + 1}
								{/foreach}
							{else}
							<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
							{/if}
						</div>
					</div>
				{/if}
			</div>
			<div class="col-md-6">
				{if isset($idioma_2)}
					<div class="row">
						<div class="col-md-11">
							<h2>{$lenguaje["idioma_label"]}: <b>{$idioma_2.Idi_Idioma}</b></h2>
							<br>
							<input type="hidden" name="idi2_ididioma" value="{$idioma_2.Idi_IdIdioma}">
							<h3>1. {$lenguaje["registro_datos_generales"]}</h3>
							<div class="row">
								<div class="col-md-7">
									<label for="idi2_nombre">{$lenguaje["registro_label_nombre"]}</label>
									<input type="text" name="idi2_nombre"  title="{$lenguaje['registro_label_nombre_title']}" id="idi2_nombre" class="form-control" required>
								</div>
							</div>
							<div class="row">
								<div class="col-md-7">
									<label for="idi2_descripcion">{$lenguaje["ficha_descripcion"]}</label>
									<textarea name="idi2_descripcion" class="form-control" id="idi2_descripcion"></textarea>
								</div>
							</div>
							<hr>
							<h3>2. {$lenguaje["registro_datos_complementarios"]}</h3><br>
							{if isset($otros_datos_ins) && count($otros_datos_ins)}
								{$contador2_iod = 0}
								{foreach from=$otros_datos_ins item=b}
									<table class="table table-bordered">
										<thead>
											<th>{$lenguaje["idioma_label_original"]}: </th>
											<th>{$b.Atributo}</th>
											<th>{$b.Valor}</th>
										</thead>
										<tbody>
											<tr>
												<td>{$lenguaje["idioma_label_traduccion"]}: </td>
												<td><input type="text" name="idi2_atributo_{$contador2_iod}" id="idi2_atributo_{$contador2_iod}" class="form-control" required></td>
												<td><input type="text" name="idi2_valor_{$contador2_iod}" id="idi2_valor_{$contador2_iod}" class="form-control" required></td>
											</tr>				
										</tbody>
									</table>
									{$contador2_iod=$contador2_iod+1}
								{/foreach}
							{else}
								<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
							{/if}
							<hr>
							<h3>3. {$lenguaje["busqueda_avanzada_label_ofertasR"]}</h3><br>
							{if isset($listaofertas) && count($listaofertas)}
								{$contador2_ofertas=0}
								{foreach from=$listaofertas item=b}
									<table class="table table-bordered">
										<thead>
											<th>{$lenguaje["idioma_label_original"]}: </th>
											<th>{$b.Nombre}</th>
											<th>{$b.Descripcion}</th>
										</thead>
										<tbody>
												<tr>
													<td>{$lenguaje["idioma_label_traduccion"]}: </td>
													<td><input type="text" name="idi2_nombre_{$contador2_ofertas}" id="idi2_nombre_{$contador2_ofertas}" class="form-control" required></td>
													<td><textarea name="idi2_descripcion_{$contador2_ofertas}" id="idi2_descripcion_{$contador2_ofertas}" class="form-control" required></textarea></td>
												</tr>
										</tbody>
									</table>
									{$contador2_ofertas=$contador2_ofertas + 1}
								{/foreach}
							{else}
							<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
							{/if}
							<hr>
							<h3>4. {$lenguaje["registro_inv_dif"]}</h3><br>
							{if isset($listaOfertasInv) && count($listaOfertasInv)}
								{$contador2_inv=0}
								{foreach from=$listaOfertasInv item=b}
									<table class="table table-bordered">
										<thead>
											<th>{$lenguaje["idioma_label_original"]}: </th>
											<th>{$b.Nombre}</th>
											<th>{$b.Descripcion}</th>
										</thead>
										<tbody>
											<tr>
												<td>{$lenguaje["idioma_label_traduccion"]}: </td>
												<td><input type="text" name="idi2_nombre_inv_{$contador2_inv}" id="idi2_nombre_inv_{$contador2_inv}" class="form-control" required></td>
												<td><textarea name="idi2_descripcion_inv_{$contador2_inv}" id="idi2_descripcion_inv{$contador2_inv}" class="form-control" required></textarea></td>
											</tr>									
										</tbody>
									</table>
									{$contador2_inv = $contador2_inv + 1}
								{/foreach}
							{else}
							<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
							{/if}<br>
							{if isset($listaOfertasDifusion) && count($listaOfertasDifusion)}
								{$contador2_dif=0}
								{foreach from=$listaOfertasDifusion item=b}
									<table class="table table-bordered">
										<thead>
											<th>{$lenguaje["idioma_label_original"]}: </th>
											<th>{$b.Nombre}</th>
											<th>{$b.Descripcion}</th>
										</thead>
										<tbody>
											<tr>
												<td>{$lenguaje["idioma_label_traduccion"]}: </td>
												<td><input type="text" name="idi2_difusion_{$contador2_dif}" id="idi2_difusion_{$contador2_dif}" class="form-control" required></td>
												<td><textarea name="idi2_dif_descripcion_{$contador2_dif}" id="idi2_dif_descripcion_{$contador2_dif}" class="form-control" required></textarea></td>
											</tr>
										</tbody>
									</table>
									{$contador2_dif = $contador2_dif + 1}
								{/foreach}
							{else}
							<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
							{/if}
						</div>
					</div>
				{/if}
			</div>
		</div>
		<input type="hidden" name="guardando" value="1">
		<center><input type="submit" class="btn btn-primary" value="{$lenguaje['registrar_fin']}"></center>	
	</form>
	<br>
	{/if}
</div>
</div>