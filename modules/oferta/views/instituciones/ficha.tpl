<div class="container-fluid col-lg-12 p-rt-lt-0">
	<div class="col-lg-12"><h2>{$lenguaje["ficha_titulo"]}</h2></div>
	<a href="javascript: history.back()" class="btn btn-success" style="position: absolute; top: 15px; right: 15px;">
		<i class="glyphicon glyphicon-chevron-left"></i>
		{$lenguaje["volver"]}
	</a>
	<div class="col-lg-12 p-rt-lt-0">
		<hr class="cursos-hr">
	</div>
	{if isset($listaIns) && count($listaIns)}
	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-default">
				<div class="panel-body">
				<div class="col-md-12">
					<div class="row">
						<center>
							{if $listaIns.Ins_img == ''}
							{$listaIns.Ins_img = 'logos/default.png'}			
							{/if}
							<div class="col-md-12">
								<div class="col-md-2">
									<img width="80" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$listaIns.Ins_img}" alt="{$listaIns.Ins_img}" class="pais" style="padding-top: 5px; padding-bottom: 5px;" data-toggle="tooltip" data-original-title="{$listaIns.Ins_Nombre}">
								</div>
								<div class="col-md-7">
									<h2 class="nombre_uni"><strong>{$listaIns.Ins_Nombre}</strong></h2>
								</div>
								<div class="col-md-3 ic-sociales">
					                <a class="btn fa fa-facebook im_sociales" id="im_sociales" style="background: #3B5998" href="#"></a>
					                <a class="btn fa fa-twitter im_sociales" id="im_sociales" style="background: #55ACEE" href="#"></a>
					                <a class="btn fa fa-google-plus im_sociales" id="im_sociales" style="background: #C03A2A" href="#"></a>
            					</div>
							</div>
							<div class="col-lg-12">
								<hr class="cursos-hr">
							</div>
						</center>
					</div>
					<div class="row">
						<div class="col-md-9">
							<h3>{$lenguaje["ficha_datos_generales"]}</h3>
						</div>
						<div class="col-md-3">
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
						<div class="col-lg-12">
							<hr class="cursos-hr">
						</div>
					</div>
					<div class="row">
						<div class="col-md-8">
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<li style="list-style: none;">
										<i class="glyphicon glyphicon-stats"></i>
										&nbsp;{$lenguaje["ficha_sede"]} {$listaIns.Ubi_Sede}, {$listaIns.Pai_Nombre}
										&nbsp;<img width="35" src="{$_layoutParams.root_clear}public/img/legal/{$listaIns.Pai_Nombre}.png" alt="{$listaIns.Pai_Nombre}" class="pais " data-toggle="tooltip" data-original-title="{$listaIns.Pai_Nombre}">
									</li>
								</div>
							</div><br>
							{if $listaIns.Ins_CorreoPagina !=='' && $listaIns.Ins_CorreoPagina !== null}
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<li style="list-style: none;">
										<i class="glyphicon glyphicon-user"></i>
										&nbsp;{$lenguaje["Contacto"]}: <b>{$listaIns.Ins_CorreoPagina}</b>
									</li>
								</div>
							</div><br>
							{/if}
							{if $listaIns.Ins_Descripcion !=='' && $listaIns.Ins_Descripcion !== null}
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<li style="list-style: none;">
										<i class="glyphicon glyphicon-list-alt"></i>
										&nbsp;{$lenguaje["ficha_descripcion"]}: <br>{$listaIns.Ins_Descripcion}
									</li>	
								</div>
							</div><br>
							{/if}
							{if $listaIns.Ins_Tipo !=='' && $listaIns.Ins_Tipo !== null}
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<li style="list-style: none;">
										<i class="glyphicon glyphicon-briefcase"></i>
										&nbsp;{$lenguaje["ficha_tipo"]} : <b>{$listaIns.Ins_Tipo}</b>
									</li>
								</div>
							</div><br>
							{/if}
							{if $listaIns.Ins_Representante !=='' && $listaIns.Ins_Representante !== null}
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<li style="list-style: none;">				
										<i class="glyphicon glyphicon-user"></i>
										&nbsp;{$lenguaje["ficha_representante"]} {$listaIns.Ins_Representante}
									</li>
								</div>
							</div><br>
							{/if}
							{if $listaIns.Ins_Telefono !=='' && $listaIns.Ins_Telefono !== null}
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<li style="list-style: none;">
										<i class="glyphicon glyphicon-earphone"></i>
										&nbsp;{$lenguaje["ficha_tel"]}: {$listaIns.Ins_Telefono}
									</li>
								</div>
							</div><br>
							{/if}
							{if $listaIns.Ins_Direccion !=='' && $listaIns.Ins_Direccion !== null}
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<li style="list-style: none;">
										<i class="glyphicon glyphicon-map-marker"></i>
										&nbsp;{$lenguaje["ficha_dir"]} {$listaIns.Ins_Direccion}
									</li>
								</div>
							</div><br>
							{/if}
							{if $listaIns.Ins_WebSite !=='' && $listaIns.Ins_WebSite !== null}
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<li style="list-style: none;">
										<i class="glyphicon glyphicon-link"></i>
										&nbsp;{$lenguaje["ficha_pagweb"]} {$listaIns.Ins_WebSite}
									</li>	
								</div>
							</div><br>
							{/if}
							{if isset($listaIns.Otros_Datos) && count($listaIns.Otros_Datos)}
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<ul>
										{foreach item=OD from=$listaIns.Otros_Datos}
										<li style="list-style-type: disc;">
											{$OD.Atributo}: {$OD.Valor}
										</li>
										{/foreach}
									</ul>
								</div>
							</div><br>
							{/if}
							{if isset($listaIns.Difusion) && count($listaIns.Difusion)}
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<h4>{$lenguaje["ficha_dif"]}</h4>
									<div class="col-lg-12 p-rt-lt-0">
										<hr class="cursos-hr">
									</div>
									<ul>
										{foreach item=OD from=$listaIns.Difusion}
										<li style="list-style-type: disc;">
											{$OD.Dif_Nombre} ({$OD.Dif_Link})<br> {$OD.Dif_Descripcion}
										</li>
										{/foreach}
									</ul>
								</div>
							</div><br>
							{/if}
							{if isset($listaIns.Padre) && count($listaIns.Padre) || isset($listaIns.Hijos) && count($listaIns.Hijos)}
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<h4>{$lenguaje["ficha_anexas"]}</h4>
									<div class="col-lg-12 p-rt-lt-0">
										<hr class="cursos-hr">
									</div>
									{if isset($listaIns.Padre) && count($listaIns.Padre)}
									<ul>
										{foreach item=Pa from=$listaIns.Padre}
										<a class="title-resumen" style="color: #000;" href="{$_layoutParams.root_clear}es/oferta/instituciones/ficha/{$Pa.Ins_IdInstitucion}"><li style="list-style-type: disc;">{$Pa.Ins_Nombre}</li></a>
										{/foreach}
									</ul>
									{/if}
									{if isset($listaIns.Hijos) && count($listaIns.Hijos)}
									<ul>
										{foreach item=Hi from=$listaIns.Hijos}
										<a class="title-resumen" style="color: #000;" href="{$_layoutParams.root_clear}es/oferta/instituciones/ficha/{$Hi.Ins_IdInstitucion}"><li style="list-style-type: disc;">{$Hi.Ins_Nombre}</li></a>
										{/foreach}
									</ul>
									{/if}
								</div>
							</div><br>
							{/if}
						</div>
						<div class="col-md-4" style="padding-bottom: 5px;">
							<div style="width: 320px; height: 240px;" data-lat="{$listaIns.Ins_latX}" data-lng="{$listaIns.Ins_lngY}" id="map"></div>
						</div>
					</div>
					<div class="row">
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
						<div class="col-lg-12">
							<hr class="cursos-hr">
						</div>
					</div>
					<div class="row">
						<div class="col-md-11 col-md-offset-1">
							<h3><li style="list-style-type: circle; color: #3c763d;"><strong>{$lenguaje["busqueda_avanzada_label_esp"]}</strong></li></h3>
							{if isset($listaIns.Especializaciones) && count($listaIns.Especializaciones)}
							
								{foreach item=ES from=$listaIns.Especializaciones}
								<a class="title-resumen" href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$listaIns.Ins_IdInstitucion}/Especializacion/{$ES.Ofe_IdOferta}">
									<div class="div-resumen">
										<h4><strong>{$ES.Ofe_Nombre}</strong></h4>
										<p>{$ES.Ofe_Descripcion}</p>
										<p>{$lenguaje["ficha_tematica"]} {$ES.Tem_Nombre}</p>
									</div>
								</a>
								{/foreach}
							
							{else}
							<p>{$lenguaje["ficha_no_esp"]}</p>
							{/if}
							<h3><li style="list-style-type: circle; color: #3c763d;"><strong>{$lenguaje["busqueda_avanzada_label_mae"]}</strong></li></h3>
							{if isset($listaIns.Maestrias) && count($listaIns.Maestrias)}
							
								{foreach item=ES from=$listaIns.Maestrias}
								<a class="title-resumen" href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$listaIns.Ins_IdInstitucion}/Maestria/{$ES.Ofe_IdOferta}">
									<div class="div-resumen">
										<h4><strong>{$ES.Ofe_Nombre}</strong></h4>
										<p>{$ES.Ofe_Descripcion}</p>
										<p>{$lenguaje["ficha_tematica"]} {$ES.Tem_Nombre}</p>
									</div>
								</a>
								{/foreach}
							
							{else}
							<p>{$lenguaje["ficha_no_mae"]}</p>
							{/if}
							<h3><li style="list-style-type: circle; color: #3c763d;"><strong>{$lenguaje["busqueda_avanzada_label_doc"]}</strong></li></h3>
							{if isset($listaIns.Doctorados) && count($listaIns.Doctorados)}
							
								{foreach item=ES from=$listaIns.Doctorados}
								<a class="title-resumen" href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$listaIns.Ins_IdInstitucion}/Doctorado/{$ES.Ofe_IdOferta}">
									<div class="div-resumen">
										<h4><strong>{$ES.Ofe_Nombre}</strong></h4>
										<p>{$ES.Ofe_Descripcion}</p>
										<p>{$lenguaje["ficha_tematica"]} {$ES.Tem_Nombre}</p>
									</div>
								</a>
								{/foreach}
							
							{else}
							<p>{$lenguaje["ficha_no_doc"]}</p>
							{/if}
						</div>
					</div>
					<div class="row">
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
						<div class="col-lg-12">
							<hr class="cursos-hr">
						</div>
					</div>
					<div class="row">
						<div class="col-md-11 col-md-offset-1">
							{if isset($listaIns.ProyectosInv) && count($listaIns.ProyectosInv)}
								{foreach item=ES from=$listaIns.ProyectosInv}
								<a class="title-resumen" href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$listaIns.Ins_IdInstitucion}/Investigacion/{$ES.Ofe_IdOferta}">
									<div class="div-resumen">
										<h4><strong>{$ES.Ofe_Nombre}</strong></h4>
										<p>{$ES.Ofe_Descripcion}</p>
										<p>{$lenguaje["ficha_tematica"]} {$ES.Tem_Nombre}</p>
									</div>
								</a>
								{/foreach}
							{else}
							<p>{$lenguaje["busqueda_avanzada_resultados_no"]}</p>
							<br>
							{/if}
						</div>
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