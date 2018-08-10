<div class="container-fluid col-lg-12 p-rt-lt-0">
	<div class="col-lg-12"><h2>{$lenguaje["ficha_oferta"]}</h2></div>
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
									<img width="80" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$listaIns.Ins_img}" alt="{$listaIns.Ins_img}" class="pais " style="padding-top: 5px; padding-bottom: 5px;" data-toggle="tooltip" data-original-title="{$listaIns.Ins_Nombre}">
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
						<div class="col-md-12">
							<h3>{$oferta} {$listaOfe.Ofe_Nombre}</h3>
						</div>
						<div class="col-lg-12">
							<hr class="cursos-hr">
						</div>
					</div>
					<div class="row">
						<div class="col-md-12">
							
							{if $listaOfe.Ofe_Descripcion !=='' && $listaOfe.Ofe_Descripcion !== null}
							<div class="row">
								<div class="col-md-11 col-md-offset-1">
									<li style="list-style: none;">
										<i class="glyphicon glyphicon-list-alt"></i>
										&nbsp;{$lenguaje["ficha_descripcion"]} {$listaOfe.Ofe_Descripcion}
									</li>	
								</div>
							</div>
							{/if}<br>
							<div class="row">
								<div class="col-md-8 col-md-offset-1">
									<li style="list-style: none;">
										<i class="glyphicon glyphicon-stats"></i>
										&nbsp;{$lenguaje["ficha_sede"]} {$listaIns.Ubi_Sede}, {$listaIns.Pai_Nombre}
										&nbsp;<img width="35" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$listaIns.Pai_Nombre}.png" alt="{$listaIns.Pai_Nombre}" class="pais " data-toggle="tooltip" data-original-title="{$listaIns.Pai_Nombre}">
									</li>
								</div>
							</div><br>
							{if $listaIns.Ins_CorreoPagina !=='' && $listaIns.Ins_CorreoPagina !== null}
							<div class="row">
								<div class="col-md-8 col-md-offset-1">
									<li style="list-style: none;">
										<i class="glyphicon glyphicon-user"></i>
										&nbsp;{$lenguaje["Contacto"]} {$listaOfe.Contacto}
									</li>	
								</div>
							</div><br>
							{/if}
							{if $listaOfe.Tem_Nombre !=='' && $listaOfe.Tem_Nombre !== null}
							<div class="row">
								<div class="col-md-8 col-md-offset-1">
									<li style="list-style: none;">
										<i class="glyphicon glyphicon-star"></i>
										&nbsp;{$lenguaje["ficha_tematica"]} {$listaOfe.Tem_Nombre}
									</li>	
								</div>
							</div><br>
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