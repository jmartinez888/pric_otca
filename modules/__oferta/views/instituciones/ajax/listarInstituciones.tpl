{if (isset($listaIns) && count($listaIns))}
	    <table class="table table-bordered">
	        <th>#</th>
	        <th>Institucion</th>
	        <th>Pais</th>
	        <th>Sede</th>
	        <th>Correo / Página Web</th>
	        <th>Tipo</th>
	        <th>Ver Ficha</th>
	        {foreach from=$listaIns item=b}
	            <tr>
	            	{$numeracion=$numeracion + 1}
	            	<td>{$numeracion}</td>
	            	<td>{$b.Ins_Nombre}</td>
	                <td><img class="pais " data-toggle="tooltip" data-original-title="{$b.Pai_Nombre}" style="cursor:pointer;width:40px" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$b.Pai_Nombre}.png" 
                          pais="{$b.Pai_Nombre}" alt="{$b.Pai_Nombre}"></td>
	                <td>{$b.Ubi_Sede}</td>
	                <td>{$b.Ins_CorreoPagina}</td>
	                <td>{$b.Ins_Tipo}</td>
	                <td><a href="#"><i class="fa fa-eye"></i></a></td>
	            </tr>         
	        {/foreach}

	        </table>
	        {$paginacion|default:""}
	        {/if}