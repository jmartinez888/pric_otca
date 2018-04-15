<div class="container">
	{if isset($mensaje_guardado)}
<h2>{$mensaje_guardado}</h2>
{/if}
	<center><h2>Registro de Instituciones</h2></center><br>
	<ul class="nav nav-tabs">
		<li class="active"><a>1. Datos Generales</a></li>
		<li><a>2. Datos Complementarios</a></li>
		<li><a>3. Ofertas Académicas</a></li>
		<li><a>4. Investigación y Difusión</a></li>
	</ul><br>
	<form method="post" enctype="multipart/form-data" class="form-horizontal" role="form">
		<div class="col-md-7">
			<div class="row">
				<div class="col-md-7">
					<label for="nombre">Nombre de la Institución</label>
					<input type="text" name="nombre" pattern="[^0-9]" title="Prohibido el ingreso de números" id="nombre" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="descripcion">Breve Descripción</label>
					<textarea name="descripcion" class="form-control" id="descripcion"></textarea>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="pais">País</label>
					<select name="pais" id="pais" class="form-control" required>
						<option>--Seleccione--</option>
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
					<label for="tipo">Tipo de Institución</label>
					<select name="tipo" id="tipo" class="form-control" required>
						<option>--Seleccione--</option>
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
					<label for="email">Email de Contacto</label>
					<input type="email" name="email" id="email" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="website">Página web</label>
					<input type="text" name="website" id="website" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="direccion">Dirección</label>
					<input type="text" name="direccion" id="direccion" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="tel">Número Telefónico</label>
					<input type="text" name="tel" minlength="8" pattern="[0-9]+" maxlength="15" id="tel" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="representante">Nombre del Representante</label>
					<input type="text" name="representante" id="representante" class="form-control" required>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="idpadre">¿Esta Institución es parte de otra Institución más grande?</label>
					<select name="idpadre" id="idpadre" class="select2">
						<option value="0">No pertenence a ninguna otra</option>
						{foreach from=$ins item=b}
							<option value="{$b.Id}">{$b.Nombre}</option>
						{/foreach}					
					</select>
				</div>
			</div>
			<div class="row">
				<div class="col-md-7">
					<label for="img">Imagen Representativa</label>
					<input type="file" name="img" id="img" class="form-control" accept="image/*" required>
				</div>
			</div><br>
			<input type="hidden" name="guardar" value="1">
			<div class="row">
				<div class="col-md-7">
					<center><input type="submit" class="btn btn-success btn-lg" value="Continuar"></center>	
				</div>
			</div>
		</div>
		<div class="col-md-5">
			<h3>Arrastre el marcador para definir la ubicación de la Institución</h3>
			<div style="width: 320px; height: 240px; border: 1px solid black;"  id="map"></div>
			<input type="text" name="latX" id="latX" readonly required>
			<input type="text" name="latY" id="latY" readonly required>
		</div>
	</form>
</div>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDSWBpyCFFqj_eluCnI0HbKeMb4k10vXnY&callback=initMap">
    </script>