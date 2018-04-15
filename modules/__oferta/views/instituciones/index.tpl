<div class="container">
	<h2>Instituciones Registradas:</h2>
	<div class="row">
		<div class="buscarInstitucion">
			<div class="col-md-4 col-md-offset-4">
				<input type="hidden" id="filtro_pais" name="filtro_pais" value="">	
				<input type="text" name="palabra" id="palabra" class="form-control" placeholder="Buscar">
			<!--	<input type="submit" class="btn btn-success" value="Buscar">-->
				<button class="btn  btn-success btn-buscador" onclick="buscarPalabraDocumentos('palabra','')" type="button" id="btnEnviar"><i class="glyphicon glyphicon-search"></i></button>
			</div>
		</div>
		<div class="demo-filtro">

		</div>
	</div>
	<!--paises-->
	<div class="col-md-12 text-center">
      	{if isset($paises) && count($paises)}
            {foreach item=datos from=$paises}
               <div style="margin-top:17px;display:inline-block;vertical-align:top;text-align:center;">
                  <img class="pais " onclick="asignarFiltroPais('{$datos.Nombre}')" data-toggle="tooltip" data-original-title="Haga click para agregar a {$datos.Nombre} como filtro de búsqueda" style="cursor:pointer;width:40px" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$datos.Nombre}.png" 
                          pais="{$datos.Nombre}" alt="{$datos.Nombre}" />
                          <br>
                          <b>{$datos.Nombre}</b>
                          <p style="font-size:.8em">({$datos.Conteo|default:0})</p>
                  </div>
                  {/foreach}
             {else}
                  <p><strong>{$lenguaje["sin_resultados"]}</strong></p>
             {/if}             
    </div>
	<!--fin paises-->
	<div id="listarInstituciones">
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
	                <td><img width="40" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$b.Pai_Nombre}.png" alt="{$b.Pai_Nombre}" class="pais " data-toggle="tooltip" data-original-title="{$b.Pai_Nombre}"></td>
	                	              
	                <td>{$b.Ubi_Sede}</td>
	                <td>{$b.Ins_CorreoPagina}</td>
	                <td>{$b.Ins_Tipo}</td>
	                <td><a href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$b.Ins_IdInstitucion}"><i class="fa fa-eye"></i></a></td>
	            </tr>         
	        {/foreach}

	        </table>
	        {$paginacion|default:""}
	        {else}
	    <h2>No se encontraron resultados</h2>{/if}
	</div>
</div>