<div class="container">
	{if isset($mensaje_guardado)}
<h2>{$mensaje_guardado}</h2>
{/if}
	<center><h2>{$lenguaje["registro_ins"]}</h2></center><br>
	<ul class="nav nav-tabs">
		<li class="active"><a>1. {$lenguaje["registro_datos_generales"]}</a></li>
		<li><a>2. {$lenguaje["registro_datos_complementarios"]}</a></li>
		<li><a>3. {$lenguaje["busqueda_avanzada_label_ofertasR"]}</a></li>
		<li><a>4. {$lenguaje["registro_inv_dif"]}</a></li>
		<li><a>5. {$lenguaje["registro_li_idiomas"]}</a></li>
	</ul><br>
	<form method="post" enctype="multipart/form-data" class="form-horizontal" role="form">
		<div class="col-md-7">
			<div class="row">
				<div class="col-md-7">
					<label for="nombre">{$lenguaje["registro_label_nombre"]}</label>
					<input type="text" name="nombre" title="{$lenguaje['registro_label_nombre_title']}" id="nombre" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="descripcion">{$lenguaje["ficha_descripcion"]}</label>
					<textarea name="descripcion" class="form-control" id="descripcion"></textarea>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="pais">{$lenguaje["resultados_busqueda_avanzada_label_filtros_pais"]}</label>
					<select name="pais" id="pais" class="form-control" required>
						<option>{$lenguaje["busqueda_avanzada_select_pais"]}</option>
						{if isset($paises) && count($paises)}
							{foreach from=$paises item=b}
								<option value="{$b.Pai_IdPais}">{$b.Nombre}</option>
							{/foreach}
						{/if}
					</select>
				</div>
			</div>
			<div id="mostrarciudades">
				
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="tipo">{$lenguaje["busqueda_avanzada_label_tipo_ins"]}</label>
					<select name="tipo" id="tipo" class="form-control" required>
						<option>{$lenguaje["busqueda_avanzada_select_pais"]}</option>
						{if isset($tipos) && count($tipos)}
							{foreach from=$tipos item=b}
								<option value="{$b.Tipo}">{$b.Tipo}</option>
							{/foreach}
						{/if}
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="email">{$lenguaje["registro_label_email"]}</label>
					<input type="email" name="email" id="email" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="website">{$lenguaje["ficha_pagweb"]}</label>
					<input type="text" name="website" id="website" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="direccion">{$lenguaje["ficha_dir"]}</label>
					<input type="text" name="direccion" id="direccion" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="tel">{$lenguaje["ficha_tel"]}</label>
					<input type="text" name="tel" minlength="8" pattern="[0-9]+" maxlength="15" id="tel" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="representante">{$lenguaje["ficha_representante"]}</label>
					<input type="text" name="representante" id="representante" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="idpadre">{$lenguaje["registro_label_ins_padre"]}</label>
					<select name="idpadre" id="idpadre" class="select2">
						<option value="0">{$lenguaje["registro_label_ins_padre_no"]}</option>
						{foreach from=$ins item=b}
							<option value="{$b.Id}">{$b.Nombre}</option>
						{/foreach}					
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="img">{$lenguaje["registro_label_img_repre"]}</label>
					<input type="file" name="img"  id="img" class="form-control" accept="image/*" required>
				</div>
			</div><br>
			<input type="hidden" name="guardar" value="1">
			<div class="row">
				<div class="col-md-7">
					<center><input type="submit" class="btn btn-success btn-lg" value="{$lenguaje['continuar']}"></center>	
				</div>
			</div>
		</div>
		<div class="col-md-5">
			<h3>{$lenguaje["registro_mapa"]}</h3>
			<div style="width: 320px; height: 240px; border: 1px solid black;"  id="map"></div>
			<input type="text" name="latX" id="latX" readonly required>
			<input type="text" name="latY" id="latY" readonly required>
		</div>
	</form>
</div>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDSWBpyCFFqj_eluCnI0HbKeMb4k10vXnY&callback=initMap">
    </script>