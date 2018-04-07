<div class="container">
	<h2>Ofertas Académicas:</h2>
	<div class="row">
		<div class="buscarInstitucion">
			<div class="col-md-4 col-md-offset-4">
				<input type="hidden" id="filtro_pais" name="filtro_pais" value="">	
				<input type="text" name="palabra" id="palabra" class="form-control" placeholder="Buscar">
			<!--	<input type="submit" class="btn btn-success" value="Buscar">-->
				<button class="btn  btn-success btn-buscador" onclick="buscarPalabraDocumentos('palabra')" type="button" id="btnEnviar"><i class="glyphicon glyphicon-search"></i></button>
			</div>
		</div>
		<div class="demo-filtro">
		</div>
	</div>
	<div id="listarOfertas">
	{if (isset($listaIns) && count($listaIns))}
	        {foreach from=$listaIns item=b}
	            <a href="{$_layoutParams.root_clear}es/oferta/OfertasAcademicas/ficha/{$b.Ofe_IdOferta}">
	            	{$numeracion=$numeracion + 1}
	            	<h3 style="color: blue; ">{$numeracion}. {$b.Ofe_Nombre} ({$b.Ofe_Tipo})</h3>
	            	<h4>Por: {$b.Ins_Nombre}</h4>
	            	<h4>Temática: {$b.Tem_Nombre}</h4>
	            	<h5 style="color: black;">{$b.Ofe_Descripcion}</h5>
	            </a>         
	        {/foreach}
	        {$paginacion|default:""}
	        {else}
	    <h2>No se encontraron resultados</h2>{/if}
	</div>
</div>