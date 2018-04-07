
<div class="container">
	<h2>Ficha de la Institución</h2>
	{if isset($listaIns) && count($listaIns)}
	<div class="row">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-10 col-md-offset-1" style="border: 3px solid grey; ">
					<div class="row">
						<center>
							{if $listaIns.Ins_img == ''}
							{$listaIns.Ins_img = 'logos/default.png'}			
							{/if}
							<div class="col-md-12 titulo" style="background-color: green;">
								<div class="col-md-6 col-md-offset-2">
									<h2 class="nombre_uni" style="color: white;">{$listaIns.Ins_Nombre}</h2>
								</div>
								<div class="col-md-2">
									<img width="80" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$listaIns.Ins_img}" alt="{$listaIns.Ins_img}" class="pais " style="padding-top: 5px; padding-bottom: 5px;" data-toggle="tooltip" data-original-title="{$listaIns.Ins_Nombre}">
								</div>
							</div>
						</center>
					</div>
					<div class="row" style="background-color: #E9F8CA;">
						<div class="col-md-10">
							<h3>Datos Generales</h3>
						</div>
						<div class="col-md-2"><br>
							{if Session::get('autenticado')}
								{if $_acl->permiso("editar_institucion") && isset($inst_usuario)}
								<a href="../../editar/index/{$listaIns.Ins_IdInstitucion}">[Editar esta sección]</a>
								{/if}
							{/if}
						</div>
					</div><br>
					<div class="row">
						<div class="col-md-7">
							<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">Sede: {$listaIns.Ubi_Sede}, {$listaIns.Pai_Nombre}<img width="40" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$listaIns.Pai_Nombre}.png" alt="{$listaIns.Pai_Nombre}" class="pais " data-toggle="tooltip" data-original-title="{$listaIns.Pai_Nombre}"></li>
						</div>
					</div>
					{if $listaIns.Ins_CorreoPagina !=='' && $listaIns.Ins_CorreoPagina !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">Contacto: {$listaIns.Ins_CorreoPagina}</li>	
						</div>
					</div>
					{/if}
					{if $listaIns.Ins_Tipo !=='' && $listaIns.Ins_Tipo !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">Tipo: {$listaIns.Ins_Tipo}</li>
						</div>
					</div>
		-			{/if}
					{if $listaIns.Ins_Representante !=='' && $listaIns.Ins_Representante !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">Representante: {$listaIns.Ins_Representante}</li>
						</div>
					</div>
					{/if}
					{if $listaIns.Ins_Telefono !=='' && $listaIns.Ins_Telefono !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">Número Telefónico Principal: {$listaIns.Ins_Telefono}</li>
						</div>
					</div>
					{/if}
					{if $listaIns.Ins_Direccion !=='' && $listaIns.Ins_Direccion !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">Dirección: {$listaIns.Ins_Direccion}</li>
						</div>
					</div>
					{/if}
					{if $listaIns.Ins_WebSite !=='' && $listaIns.Ins_WebSite !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">Página Web: {$listaIns.Ins_WebSite}</li>	
						</div>
					</div>
					{/if}
					{if isset($listaIns.Otros_Datos) && count($listaIns.Otros_Datos)}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<h4>Otros Datos:</h4>
							<ul>
								{foreach item=OD from=$listaIns.Otros_Datos}
								<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$OD.Atributo}: {$OD.Valor}</li>
								{/foreach}
							</ul>
						</div>
					</div><br>
					{/if}
					{if isset($listaIns.Difusion) && count($listaIns.Difusion)}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<h4>Medios de Difusión:</h4>
							<ul>
								{foreach item=OD from=$listaIns.Difusion}
								<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$OD.Dif_Nombre}</li>
								{/foreach}
							</ul>
						</div>
					</div><br>
					{/if}
					{if isset($listaIns.Padre) && count($listaIns.Padre) || isset($listaIns.Hijos) && count($listaIns.Hijos)}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<h4>Instituciones Complementarias:</h4>
							{if isset($listaIns.Padre) && count($listaIns.Padre)}
							<ul>
								{foreach item=Pa from=$listaIns.Padre}
								<a href="{$_layoutParams.root_clear}es/oferta/instituciones/ficha/{$Pa.Ins_IdInstitucion}"><li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$Pa.Ins_Nombre}</li></a>
								{/foreach}
							</ul>
							{/if}
							{if isset($listaIns.Hijos) && count($listaIns.Hijos)}
							<ul>
								{foreach item=Hi from=$listaIns.Hijos}
								<a href="{$_layoutParams.root_clear}es/oferta/instituciones/ficha/{$Hi.Ins_IdInstitucion}"><li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$Hi.Ins_Nombre}</li></a>
								{/foreach}
							</ul>
							{/if}
						</div>
					</div><br>
					{/if}
						</div>
						<div class="col-md-5">
							<div style="width: 320px; height: 240px;" data-lat="{$listaIns.Ins_latX}" data-lng="{$listaIns.Ins_lngY}" id="map"></div>
						</div>
					</div>
					<div class="row" style="background-color: #E9F8CA;">
						<div class="col-md-10">
							<h3>Ofertas Académicas que ofrece:</h3>
						</div>
						<div class="col-md-2"><br>
							{if Session::get('autenticado')}
								{if $_acl->permiso("editar_institucion") && isset($inst_usuario)}
								<a href="../../editar/ofertas_academicas/{$listaIns.Ins_IdInstitucion}">[Editar esta sección]</a>
								{/if}
							{/if}
						</div>
					</div>
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<h3><li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">Especializaciones: </li></h3>
							{if isset($listaIns.Especializaciones) && count($listaIns.Especializaciones)}
							
								{foreach item=ES from=$listaIns.Especializaciones}
								<div style="background-color: #E9F8CA; padding: 10px 10px 10px 10px;">
								<h4 style="color: blue;">{$ES.Ofe_Nombre}</h4>
								<p>{$ES.Ofe_Descripcion}</p>
								<p>Temática: {$ES.Tem_Nombre}</p>
							</div><br>
								{/foreach}
							
							{else}
							<p>No ofrece especializaciones</p>
							{/if}
							<h3><li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">Maestrías: </li></h3>
							{if isset($listaIns.Maestrias) && count($listaIns.Maestrias)}
							<ul>
								{foreach item=ES from=$listaIns.Maestrias}
								<div style="background-color: #E9F8CA; padding: 10px 10px 10px 10px;">
								<h4 style="color: blue;">{$ES.Ofe_Nombre}</h4>
								<p>{$ES.Ofe_Descripcion}</p>
								<p>Temática: {$ES.Tem_Nombre}</p>
							</div><br>
								{/foreach}
							</ul>
							{else}
							<p>No ofrece Maestrias</p>
							{/if}
							<h3><li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">Doctorados: </li></h3>
							{if isset($listaIns.Doctorados) && count($listaIns.Doctorados)}
							<ul>
								{foreach item=ES from=$listaIns.Doctorados}
								<div style="background-color: #E9F8CA; padding: 10px 10px 10px 10px;">
								<h4 style="color: blue;">{$ES.Ofe_Nombre}</h4>
								<p>{$ES.Ofe_Descripcion}</p>
								<p>Temática: {$ES.Tem_Nombre}</p>
							</div><br>
								{/foreach}
							</ul>
							{else}
							<p>No ofrece Doctorados</p>
							{/if}
						</div>
					</div>
					<div class="row" style="background-color: #E9F8CA;">
						<div class="col-md-10">
							<h3>Proyectos de Investigacion Realizados:</h3>
						</div>
						<div class="col-md-2"><br>
							{if Session::get('autenticado')}
								{if $_acl->permiso("editar_institucion") && isset($inst_usuario)}

								<a href="../../editar/investigacion/{$listaIns.Ins_IdInstitucion}">[Editar esta sección]</a>
								{/if}
							{/if}
						</div>
					</div><br>
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							{if isset($listaIns.ProyectosInv) && count($listaIns.ProyectosInv)}
								{foreach item=ES from=$listaIns.ProyectosInv}
								<div style="background-color: #E9F8CA; padding: 10px 10px 10px 10px;">
									<h4 style="color: blue;">{$ES.Ofe_Nombre}</h4>
									<p>{$ES.Ofe_Descripcion}</p>
									<p>Temática: {$ES.Tem_Nombre}</p>
								</div><br>
								{/foreach}
							{else}
							<p>No se encontraron registros.</p>
							{/if}
						</div>
					</div>					
				</div>
			</div>
		</div>
	</div>
    {/if}
</div>
<script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDSWBpyCFFqj_eluCnI0HbKeMb4k10vXnY&callback=initMap">
    </script>