<div class="container">
	<a href="javascript: history.back()" class="btn btn-danger">{$lenguaje["volver"]}</a>
	<h2>{$lenguaje["ficha_oferta"]}</h2>
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
							<h3>{$oferta} {$listaOfe.Ofe_Nombre}</h3>
						</div>
					</div><br>
					<div class="row">
						<div class="col-md-12">
							
							{if $listaOfe.Ofe_Descripcion !=='' && $listaOfe.Ofe_Descripcion !== null}
							<div class="row">
								<div class="col-md-8 col-md-offset-1">
									<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["ficha_descripcion"]} {$listaOfe.Ofe_Descripcion}</li>	
								</div>
							</div>
							{/if}<br>
							<div class="row">
								<div class="col-md-8 col-md-offset-1">
									<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["ficha_sede"]} {$listaIns.Ubi_Sede}, {$listaIns.Pai_Nombre}<img width="40" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$listaIns.Pai_Nombre}.png" alt="{$listaIns.Pai_Nombre}" class="pais " data-toggle="tooltip" data-original-title="{$listaIns.Pai_Nombre}"></li>
								</div>
							</div><br>
							{if $listaIns.Ins_CorreoPagina !=='' && $listaIns.Ins_CorreoPagina !== null}
							<div class="row">
								<div class="col-md-8 col-md-offset-1">
									<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["Contacto"]} {$listaOfe.Contacto}</li>	
								</div>
							</div><br>
							{/if}
							{if $listaOfe.Tem_Nombre !=='' && $listaOfe.Tem_Nombre !== null}
							<div class="row">
								<div class="col-md-8 col-md-offset-1">
									<li style="list-style-image: url('{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/verde_claro.jpg');">{$lenguaje["ficha_tematica"]} {$listaOfe.Tem_Nombre}</li>	
								</div>
							</div><br>
							{/if}
						</div>
					</div>					
				</div>
			</div>
		</div>
	</div>
    {/if}
</div>