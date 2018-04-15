<div class="container">
	<h2>Ficha de la Oferta</h2>
	{if isset($listaIns) && count($listaIns)}
	<div class="row">
		<div class="col-md-12">
			<div class="row">
				<div class="col-md-10 col-md-offset-1" style="border: 3px solid grey; ">
					<div class="row">
						<center><h2>{$listaIns.Ofe_Tipo} en {$listaIns.Ofe_Nombre}</h2></center>
					</div>
					<div class="row">
						<div class="col-md-8 col-md-offset-2">
							<h3>Por: {$listaIns.Ins_Nombre} <img width="40" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$listaIns.Pai_Nombre}.png" alt="{$listaIns.Pai_Nombre}" class="pais " data-toggle="tooltip" data-original-title="{$listaIns.Pai_Nombre}"></h3>	
						</div>
					</div>
					<div class="row">
						<div class="col-md-8 col-md-offset-2">
							<h3>Temática: {$listaIns.Tem_Nombre}</h3>	
						</div>
					</div>
					<div class="row">
						<div class="col-md-8 col-md-offset-2">
							<h3>Detalle: {$listaIns.Ofe_Descripcion}</h3>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
    {/if}
</div>