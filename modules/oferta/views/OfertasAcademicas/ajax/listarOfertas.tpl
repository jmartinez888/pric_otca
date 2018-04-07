{if (isset($listaIns) && count($listaIns))}
	        {foreach from=$listaIns item=b}
	            <a href="http://localhost:8080/framework_mvc_php_multi-idioma/es/oferta/OfertasAcademicas/ficha/{$b.Ofe_IdOferta}">
	            	{$numeracion=$numeracion + 1}
	            	<h3 style="color: blue; ">{$numeracion}. {$b.Ofe_Nombre} ({$b.Ofe_Tipo})</h3>
	            	<h4>Por: {$b.Ins_Nombre}</h4>
	            	<h4>Temática: {$b.Tem_Nombre}</h4>
	            	<h5 style="color: black; ">{$b.Ofe_Descripcion}</h5>
	            </a>         
	        {/foreach}
	        </table>
	        {$paginacion|default:""}
	        {else}
	    <h2>No se encontraron resultados</h2>{/if}