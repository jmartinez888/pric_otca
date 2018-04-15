<div class="container">
<center><h2>{$lenguaje["edicion_ins_title"]}</h2></center><br>
	<ul class="nav nav-tabs">
		<li><a>1. {$lenguaje["registro_datos_generales"]}</a></li>
		<li><a>2. {$lenguaje["registro_datos_complementarios"]}</a></li>
		<li><a>3. {$lenguaje["busqueda_avanzada_label_ofertasR"]}</a></li>
		<li><a>4. {$lenguaje["registro_inv_dif"]}</a></li>
		<li class="active"><a>5. {$lenguaje["registro_li_idiomas"]}</a></li>
	</ul><br>
	{if isset($actualizado_correctamente)}
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
									<input type="text" name="idi1_nombre"  title="{$lenguaje['registro_label_nombre_title']}" id="idi1_nombre" class="form-control" value="{$traducido_lista1.Cot_Traduccion}" required>
								</div>
							</div>
							<div class="row">
								<div class="col-md-7">
									<label for="idi1_descripcion">{$lenguaje["ficha_descripcion"]}</label>
									<textarea name="idi1_descripcion" class="form-control" id="idi1_descripcion">{$traducido_lista1_Descripcion.Cot_Traduccion}</textarea>
								</div>
							</div>
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
									<input type="text" name="idi2_nombre"  title="{$lenguaje['registro_label_nombre_title']}" id="idi2_nombre" class="form-control" value="{$traducido_lista2.Cot_Traduccion}" required>
								</div>
							</div>
							<div class="row">
								<div class="col-md-7">
									<label for="idi2_descripcion">{$lenguaje["ficha_descripcion"]}</label>
									<textarea name="idi2_descripcion" class="form-control" id="idi2_descripcion">{$traducido_lista2_Descripcion.Cot_Traduccion}</textarea>
								</div>
							</div>
							<hr>
							
						</div>
					</div>
				{/if}
			</div>
		</div>
		<input type="hidden" name="actualizando" value="1">
		<center><input type="submit" class="btn btn-primary" value="{$lenguaje['ficha_editar']}"></center>	
	</form>
	<br>
	{/if}
</div>
</div>