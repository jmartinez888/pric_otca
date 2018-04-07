<div class="container">
	<h2>Instituciones Registradas:</h2>
	<div class="row">
		<div class="buscarInstitucion">
			<div class="col-md-4 col-md-offset-7">
				
				<input type="text" name="palabra" id="palabra" class="form-control" placeholder="Buscar">
			<!--	<input type="submit" class="btn btn-success" value="Buscar">-->
				<button class="btn  btn-success btn-buscador" onclick="buscarPalabraDocumentos('palabra')" type="button" id="btnEnviar"><i class="glyphicon glyphicon-search"></i></button>
			</div>
		</div>
	</div>
	<div id="listarInstituciones">
	{if (isset($listaIns) && count($listaIns))}
	    <table class="table table-bordered">
	        <th>Pais</th>
	        <th>Sede</th>
	        <th>Institucion</th>
	        <th>Correo / Página Web</th>
	        <th>Tipo</th>
	        <th>Representante</th>
	        <th>Telefono</th>
	        <th>Direccion</th>
	        <th>Ver Ficha</th>
	        {foreach from=$listaIns item=b}
	            <tr>
	                {if $b.Pai_Nombre =="BOLIVIA"}
	                <td><img width="40" src="http://localhost:8080/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/bolivia.png"></td>
	                {/if}
	                {if $b.Pai_Nombre =="BRASIL"}
	                <td><img width="40" src="http://localhost:8080/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/brasil.png"></td>
	                {/if}
	                {if $b.Pai_Nombre =="COLOMBIA"}
	                <td><img width="40" src="http://localhost:8080/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/colombia.png"></td>
	                {/if}
	                {if $b.Pai_Nombre =="ECUADOR"}
	                <td><img width="40" src="http://localhost:8080/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/ecuador.png"></td>
	                {/if}
	                {if $b.Pai_Nombre =="GUYANA"}
	                <td><img width="40" src="http://localhost:8080/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/guyana.png"></td>
	                {/if}
	                {if $b.Pai_Nombre =="PERU"}
	                <td><img width="40" src="http://localhost:8080/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/peru.png"></td>
	                {/if}
	                {if $b.Pai_Nombre =="SURINAME"}
	                <td><img width="40" src="http://localhost:8080/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/surinam.png"></td>
	                {/if}
	                {if $b.Pai_Nombre =="VENEZUELA"}
	                <td><img width="40" src="http://localhost:8080/framework_mvc_php_multi-idioma/modules/oferta/views/instituciones/img/venezuela.png"></td>
	                {/if}
	              
	                <td>{$b.Ubi_Sede}</td>
	                <td>{$b.Ins_Nombre}</td>
	                <td>{$b.Ins_CorreoPagina}</td>
	                <td>{$b.Ins_Tipo}</td>
	                <td>{$b.Ins_Representante}</td>
	                <td>{$b.Ins_Telefono}</td>
	                <td>{$b.Ins_Direccion}</td>
	                <td><a href="#"><i class="fa fa-eye"></i></a></td>
	            </tr>         
	        {/foreach}
	        
	        </table>
	        {$paginacion|default:""}
	        {/if}
	    
	</div>
</div>