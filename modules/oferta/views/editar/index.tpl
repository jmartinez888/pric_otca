<div class="container">
	<center><h2>{$lenguaje["edicion_ins_title"]}</h2></center>
	<ul class="nav nav-tabs">
		<li class="active"><a>1. {$lenguaje["registro_datos_generales"]}</a></li>
		<li><a>2. {$lenguaje["registro_datos_complementarios"]}</a></li>
	</ul><br>
		<form method="post" enctype="multipart/form-data" class="form-horizontal" role="form">
			<div class="col-md-7">
			<div class="row">
			<div class="col-md-7">
				<label for="nombre">{$lenguaje["registro_label_nombre"]}</label>
				<input type="text" name="nombre" id="nombre" class="form-control" value="{$datos_ins.Ins_Nombre}" required>
			</div>
		</div>
		<div class="row">
			<div class="col-md-7">
				<label for="pais">{$lenguaje["resultados_busqueda_avanzada_label_filtros_pais"]}</label>
				<select name="pais" id="pais" class="form-control" required>
					<option>{$lenguaje["busqueda_avanzada_select_pais"]}</option>
					{if isset($paises) && count($paises)}
						{foreach from=$paises item=b}
							{if $datos_ins.Pai_IdPais == $b.Pai_IdPais}
							<option selected="true" value="{$b.Pai_IdPais}">{$b.Nombre}</option>
							{else}
							<option value="{$b.Pai_IdPais}">{$b.Nombre}</option>
							{/if}
						{/foreach}
					{/if}
				</select>
			</div>
		</div>
		<div id="mostrarciudades">
			<div class="row">
				<div class="col-md-7">
				<label for="ciudad">{$lenguaje["registro_label_ciudad"]}</label>
					<div class="ciudad">
						<select name='ciudad' id='ciudad' class='form-control'>
							{foreach from=$Ciudades item=c}
							{if $datos_ins.Ubi_IdUbigeo == $c.Ter_IdTerritorio}
								<option selected="true" value="{$c.Ter_IdTerritorio}">{$c.Ter_Nombre}</option>
							{else}
							<option value="{$c.Ter_IdTerritorio}">{$c.Ter_Nombre}</option>
							{/if}
							{/foreach}
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-7">
				<label for="tipo">{$lenguaje["busqueda_avanzada_label_tipo_ins"]}</label>
				<select name="tipo" id="tipo" class="form-control" required>
					<option>{$lenguaje["busqueda_avanzada_select_pais"]}</option>
					{if isset($tipos) && count($tipos)}
						{foreach from=$tipos item=b}
							{if $datos_ins.Ins_Tipo == $b.Tipo}
								<option selected="true" value="{$b.Tipo}">{$b.Tipo}</option>
							{else}
							<option value="{$b.Tipo}">{$b.Tipo}</option>
							{/if}
						{/foreach}
					{/if}
				</select>
			</div>
		</div>
		<div class="row">
			<div class="col-md-7">
				<label for="email">{$lenguaje["registro_label_email"]}</label>
				<input type="email" name="email" id="email" class="form-control" required value="{$datos_ins.Ins_CorreoPagina}">
			</div>
		</div>
		<div class="row">
			<div class="col-md-7">
				<label for="website">{$lenguaje["ficha_pagweb"]}</label>
				<input type="text" name="website" id="website" class="form-control" required value="{$datos_ins.Ins_WebSite}">
			</div>
		</div>
		<div class="row">
			<div class="col-md-7">
				<label for="direccion">{$lenguaje["ficha_dir"]}</label>
				<input type="text" name="direccion" id="direccion" class="form-control" required value="{$datos_ins.Ins_Direccion}">
			</div>
		</div>
		<div class="row">
			<div class="col-md-7">
				<label for="tel">{$lenguaje["ficha_tel"]}</label>
				<input type="text" name="tel" id="tel" class="form-control" required value="{$datos_ins.Ins_Telefono}">
			</div>
		</div>
		<div class="row">
			<div class="col-md-7">
				<label for="representante">{$lenguaje["ficha_representante"]}</label>
				<input type="text" name="representante" id="representante" class="form-control" required value="{$datos_ins.Ins_Representante}">
			</div>
		</div>
		<div class="row">
			<div class="col-md-5">
				<label for="idpadre">{$lenguaje["registro_label_ins_padre"]}</label>
				<select name="idpadre" id="idpadre" class="select2">
					{if $datos_ins.Ins_IdPadre == 0}
					<option selected="true" value="0">{{$lenguaje["registro_label_ins_padre_no"]}}</option>
					{/if}
					{foreach from=$ins item=b}
						{if $datos_ins.Ins_IdPadre == $b.Id}
						<option selected="true" value="{$b.Id}">{$b.Nombre}</option>
						{else}
							<option value="{$b.Id}">{$b.Nombre}</option>
						{/if}
					{/foreach}					
				</select>
			</div>
		</div>
		<div class="row">
			<div class="col-md-10">
				<br><label>{$lenguaje["registro_label_img_repre"]}</label><br>
				<div class="col-md-3">
					<label>{$lenguaje["edicion_img_Actual"]}</label>
					{if $datos_ins.Ins_img==""}
					{$datos_ins.Ins_img="logos/default.png"}
					{/if}
					<img src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$datos_ins.Ins_img}" width="120">
					<input type="hidden" name="img_actual" value="{$datos_ins.Ins_img}">
				</div>
				<div class="col-md-9">
					<label for="img">{$lenguaje["edicion_cambiar_img"]}</label>
					<input type="file" name="img" id="img" class="form-control" accept="image/*">
				</div>
			</div>
		</div><br>
		<input type="hidden" name="guardar" value="1">
		<div class="row">
			<div class="col-md-4">
				<center><input type="submit" class="btn btn-success" value="{$lenguaje['registro_otros_datos_guardar']}"></center>
			</div>
		</div>
		</div>

	<div class="col-md-5">
		<h3>{$lenguaje["registro_mapa"]}</h3>
			<div style="width: 320px; height: 240px; border: 1px solid black;" data-lat="{$datos_ins.Ins_latX}" data-lng="{$datos_ins.Ins_lngY}" id="map"></div>
			<input type="text" name="latX" id="latX" readonly required value="{$datos_ins.Ins_latX}">
			<input type="text" name="latY" id="latY" readonly required value="{$datos_ins.Ins_lngY}">
	</div>
	</form>
</div>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDSWBpyCFFqj_eluCnI0HbKeMb4k10vXnY&callback=initMap">
    </script>