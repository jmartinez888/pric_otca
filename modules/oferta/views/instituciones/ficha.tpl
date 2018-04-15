<div class="container">
	<a href="javascript: history.back()" class="btn btn-danger">{$lenguaje["volver"]}</a>
	<h2>{$lenguaje["ficha_titulo"]}</h2>
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
						<div class="col-md-9">
							<h3>{$lenguaje["ficha_datos_generales"]}</h3>
						</div>
						<div class="col-md-3"><br>
							{if Session::get('autenticado')}
								{if $_acl->permiso("editar_institucion") && isset($inst_usuario)}
								<a href="../../editar/index/{$listaIns.Ins_IdInstitucion}">{$lenguaje["ficha_editar"]}</a>
									{if isset($tiene_traduccion)}
									<a href="../../editar/idiomas/{$listaIns.Ins_IdInstitucion}">[{$lenguaje["ficha_editar_traduccion"]}]
									</a>
									{else}
									<a href="../../registro/idiomas/{$listaIns.Ins_IdInstitucion}">[{$lenguaje["ficha_registrar_traduccion"]}]
									</a>
									{/if}
								{/if}
							{/if}
						</div>
					</div><br>
					<div class="row">
						<div class="col-md-7">
							<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["ficha_sede"]} {$listaIns.Ubi_Sede}, {$listaIns.Pai_Nombre}<img width="40" src="{$_layoutParams.root_clear}public/img/legal/{$listaIns.Pai_Nombre}.png" alt="{$listaIns.Pai_Nombre}" class="pais " data-toggle="tooltip" data-original-title="{$listaIns.Pai_Nombre}"></li>
						</div>
					</div><br>
					{if $listaIns.Ins_CorreoPagina !=='' && $listaIns.Ins_CorreoPagina !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["Contacto"]}: <b>{$listaIns.Ins_CorreoPagina}</b></li>	
						</div>
					</div><br>
					{/if}
					{if $listaIns.Ins_Descripcion !=='' && $listaIns.Ins_Descripcion !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["ficha_descripcion"]}: <br>{$listaIns.Ins_Descripcion}</li>	
						</div>
					</div><br>
					{/if}
					{if $listaIns.Ins_Tipo !=='' && $listaIns.Ins_Tipo !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["ficha_tipo"]} : <b>{$listaIns.Ins_Tipo}</b></li>
						</div>
					</div>
					{/if}
					{if $listaIns.Ins_Representante !=='' && $listaIns.Ins_Representante !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["ficha_representante"]} {$listaIns.Ins_Representante}</li>
						</div>
					</div>
					{/if}
					{if $listaIns.Ins_Telefono !=='' && $listaIns.Ins_Telefono !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["ficha_tel"]}: {$listaIns.Ins_Telefono}</li>
						</div>
					</div>
					{/if}
					{if $listaIns.Ins_Direccion !=='' && $listaIns.Ins_Direccion !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["ficha_dir"]} {$listaIns.Ins_Direccion}</li>
						</div>
					</div>
					{/if}
					{if $listaIns.Ins_WebSite !=='' && $listaIns.Ins_WebSite !== null}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["ficha_pagweb"]} {$listaIns.Ins_WebSite}</li>	
						</div>
					</div>
					{/if}
					{if isset($listaIns.Otros_Datos) && count($listaIns.Otros_Datos)}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
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
							<h4>{$lenguaje["ficha_dif"]}</h4>
							<ul>
								{foreach item=OD from=$listaIns.Difusion}
								<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$OD.Dif_Nombre} ({$OD.Dif_Link})<br> {$OD.Dif_Descripcion}</li>
								{/foreach}
							</ul>
						</div>
					</div><br>
					{/if}
					{if isset($listaIns.Padre) && count($listaIns.Padre) || isset($listaIns.Hijos) && count($listaIns.Hijos)}
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<h4>{$lenguaje["ficha_anexas"]}</h4>
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
							<h3>{$lenguaje["busqueda_avanzada_label_ofertasR"]}</h3>
						</div>
						<div class="col-md-2"><br>
							{if Session::get('autenticado')}
								{if $_acl->permiso("editar_institucion") && isset($inst_usuario)}
								<a href="../../editar/ofertas_academicas/{$listaIns.Ins_IdInstitucion}">{$lenguaje["ficha_editar"]}</a>
								{if isset($tiene_traduccion)}
									<a href="../../editar/idiomas/{$listaIns.Ins_IdInstitucion}/oferta">[{$lenguaje["ficha_editar_traduccion"]}]
									</a>
									{else}
									<a href="../../registro/idiomas/{$listaIns.Ins_IdInstitucion}">[{$lenguaje["ficha_registrar_traduccion"]}]
									</a>
									{/if}

								{/if}
							{/if}
						</div>
					</div>
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							<h3><li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["busqueda_avanzada_label_esp"]}</li></h3>
							{if isset($listaIns.Especializaciones) && count($listaIns.Especializaciones)}
							
								{foreach item=ES from=$listaIns.Especializaciones}
								<a href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$listaIns.Ins_IdInstitucion}/Especializacion/{$ES.Ofe_IdOferta}"><div style="background-color: #E9F8CA; padding: 10px 10px 10px 10px;">
								<h4 style="color: blue;">{$ES.Ofe_Nombre}</h4>
								<p>{$ES.Ofe_Descripcion}</p>
								<p>{$lenguaje["ficha_tematica"]} {$ES.Tem_Nombre}</p>
							</div></a><br>
								{/foreach}
							
							{else}
							<p>{$lenguaje["ficha_no_esp"]}</p>
							{/if}
							<h3><li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["busqueda_avanzada_label_mae"]}</li></h3>
							{if isset($listaIns.Maestrias) && count($listaIns.Maestrias)}
							
								{foreach item=ES from=$listaIns.Maestrias}
								<a href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$listaIns.Ins_IdInstitucion}/Maestria/{$ES.Ofe_IdOferta}"><div style="background-color: #E9F8CA; padding: 10px 10px 10px 10px;">
								<h4 style="color: blue;">{$ES.Ofe_Nombre}</h4>
								<p>{$ES.Ofe_Descripcion}</p>
								<p>{$lenguaje["ficha_tematica"]} {$ES.Tem_Nombre}</p>
							</div></a><br>
								{/foreach}
							
							{else}
							<p>{$lenguaje["ficha_no_mae"]}</p>
							{/if}
							<h3><li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["busqueda_avanzada_label_doc"]}</li></h3>
							{if isset($listaIns.Doctorados) && count($listaIns.Doctorados)}
							
								{foreach item=ES from=$listaIns.Doctorados}
								<a href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$listaIns.Ins_IdInstitucion}/Doctorado/{$ES.Ofe_IdOferta}"><div style="background-color: #E9F8CA; padding: 10px 10px 10px 10px;">
								<h4 style="color: blue;">{$ES.Ofe_Nombre}</h4>
								<p>{$ES.Ofe_Descripcion}</p>
								<p>{$lenguaje["ficha_tematica"]} {$ES.Tem_Nombre}</p>
							</div></a><br>
								{/foreach}
							
							{else}
							<p>{$lenguaje["ficha_no_doc"]}</p>
							{/if}
						</div>
					</div>
					<div class="row" style="background-color: #E9F8CA;">
						<div class="col-md-10">
							<h3>{$lenguaje["busqueda_avanzada_label_proyectosR"]}</h3>
						</div>
						<div class="col-md-2"><br>
							{if Session::get('autenticado')}
								{if $_acl->permiso("editar_institucion") && isset($inst_usuario)}
								<a href="../../editar/investigacion/{$listaIns.Ins_IdInstitucion}">{$lenguaje["ficha_editar"]}</a>
									{if isset($tiene_traduccion)}
										<a href="../../editar/idiomas/{$listaIns.Ins_IdInstitucion}/investigacion">[{$lenguaje["ficha_editar_traduccion"]}]
										</a>
									{else}
										<a href="../../registro/idiomas/{$listaIns.Ins_IdInstitucion}">[{$lenguaje["ficha_registrar_traduccion"]}]
										</a>
									{/if}
								{/if}
							{/if}
						</div>
					</div><br>
					<div class="row">
						<div class="col-md-8 col-md-offset-1">
							{if isset($listaIns.ProyectosInv) && count($listaIns.ProyectosInv)}
								{foreach item=ES from=$listaIns.ProyectosInv}
								<a href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$listaIns.Ins_IdInstitucion}/Investigacion/{$ES.Ofe_IdOferta}"><div style="background-color: #E9F8CA; padding: 10px 10px 10px 10px;">
									<h4 style="color: blue;">{$ES.Ofe_Nombre}</h4>
									<p>{$ES.Ofe_Descripcion}</p>
									<p>{$lenguaje["ficha_tematica"]} {$ES.Tem_Nombre}</p>
								</div></a><br>
								{/foreach}
							{else}
							<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
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
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDsQ0_EnWx2iLb77-ao0oQYj0OkyLMgHMA&callback=initMap">
</script>