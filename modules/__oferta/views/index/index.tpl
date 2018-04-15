
<div class="container-fluid">
	<div class="row">
		<center><h1>Directorio Institucional</h1></center>
	</div>
	<div class="row">
		<div class="col-md-2">
			{if isset($busqueda) || isset($busquedaAvanzada)}
			<h4>Resumen de Búsqueda</h4>
      		<div class="panel-group" id="accordion">
        		<div class="panel panel-default">
          			<div class="panel-heading">
              			<h4 class="panel-title">
              			<a data-toggle="collapse" data-parent="#accordion" href="#accordionOne">
              			<strong>Tipo de Institucion
			                {if isset($cantidadResultados)}
			                    <span class="badge pull-right">{$cantidadResultados}</span> 
			                {/if}
              			</strong>  
              			</a>
             			</h4>
           			</div>       
		          	<div id="accordionOne" class="panel-collapse collapse" >
			            <ul id="tematicas" class="list-group scroll"   style="height: auto;overflow-y: auto;">
			                {if isset($pais_buscado)}
		    			{$BPais = $pais_buscado}
		    			{else}
		    			{$BPais = 'all'}
		    			{/if}
		    			{if isset($datos_buscado)}
		    			{$BDatos=$datos_buscado}
		    			{else}
		    			{$BDatos = 'all'}
		    			{/if}
		    			{if isset($proyectos_buscado)}
		    			{$BProyectos=$proyectos_buscado}
		    			{else}
		    			{$BProyectos = 'all'}
		    			{/if}
		    			{if isset($ofertas_buscado)}
		    			{$BOfertas=$ofertas_buscado}
		    			{else}
		    			{$BOfertas = 'all'}
		    			{/if}
		    			{if isset($esp_buscado)}
		    			{$BEsp=$esp_buscado}
		    			{else}
		    			{$BEsp = 'no'}
		    			{/if}
		    			{if isset($mae_buscado)}
		    			{$BMae=$mae_buscado}
		    			{else}
		    			{$BMae = 'no'}
		    			{/if}
		    			{if isset($doc_buscado)}
		    			{$BDoc=$doc_buscado}
		    			{else}
		    			{$BDoc = 'no'}
		    			{/if}
			                {if isset($resumen1) && count($resumen1)}
			                  	{foreach item=datos from = $resumen1}
			                       	<li class="list-group-item">
			                      		<span class="badge">{$datos.CantidadRegistros}</span>
			                      		<a href="" style="cursor:pointer"><span class="temadocumento" id="temadocumento">{$datos.Tipo}</span></a>
			                    	</li>                            
			                  	{/foreach}
			                {/if}
			            </ul>
		          	</div>
        		</div>
		        <div class="panel panel-default">
		            <div class="panel-heading">
		            	<h4 class="panel-title">
		            		<a data-toggle="collapse" data-parent="#accordion" href="#accordionOne2">
		               		<strong>Proyectos de Investigación</strong> 
		               		{if isset($rowcount2)}
		                  		<span class="badge pull-right">{$rowcount2}</span>
		                	{/if}
		              		</a>
		             	</h4>
		            </div>       
		          	<div id="accordionOne2" class="panel-collapse collapse" >
			            <ul id="tipodocumento" class="list-group scroll"   style="height: auto;overflow-y: auto;">
			             	{if isset($resumen2) && count($resumen2)}
			              		{foreach item=datos from = $resumen2}
			                  	<li class="list-group-item">
			                      <span class="badge">{$datos.CantidadRegistros}</span>
			                      <a href="" style="cursor:pointer"><span class="palabraclave" id="palabraclave">{$datos.Tipo}</span></a>
			                    </li>        
			                  	{/foreach}
			                {/if}             
			            </ul>
		          	</div>
		        </div>
        		<!-- Filtro Autor -->
        		<div class="panel panel-default">
	        <div class="panel-heading">
        	    <h4 class="panel-title">
	                <a data-toggle="collapse" data-parent="#accordion" href="#accordionAutor">
	                	<strong>Ofertas Académicas</strong> 
		                {if isset($rowcount3)}
		                	<span class="badge pull-right">{$rowcount3}</span>
		                {/if}
        	      </a>
        	    </h4>
	        </div>       
	        <div id="accordionAutor" class="panel-collapse collapse" >
	        	<ul id="autor" class="list-group scroll"   style="height: auto;overflow-y: auto;">
	               {if isset($resumen3) && count($resumen3)}
	                {foreach item=a from = $resumen3}
	                <li class="list-group-item">
	                    <span class="badge">{$a.CantidadRegistros}</span>
	                    {if $a.Tipo == 'ESPECIALIZACION'}
	                    	{$IR_e = 'especializaciones'}
	                    {else}
							{$IR_e = 'no'}
	                    {/if}
	                    {if $a.Tipo == 'MAESTRÍA'}
	                    	{$IR_m = 'maestrias'}
	                    {else}
	                    	{$IR_m = 'no'}
	                    {/if}
	                    {if $a.Tipo == 'DOCTORADO'}
	                    	{$IR_d = 'doctorados'}
	                    {else}
	                    	{$IR_d = 'no'}
	                    {/if}
	                    <a href="{$_layoutParams.root_clear}oferta/index/busquedaAvanzada/{$BPais}/{$BDatos}/{$BProyectos}/{$BOfertas}/{$IR_e}/{$IR_m}/{$IR_d}" style="cursor:pointer"><span class="autordocumento" id="autorDocumento">{$a.Tipo}</span></a>
	                  </li>        
	                {/foreach}
	                {/if}             
	            </ul>
	        </div>
        		</div>
      		</div>
      		{/if}
  		</div>
  		<div class="col-md-9">
			<div class="panel panel-default">
				<div class="panel-heading">
				  <h4 class="panel-title">
				    <strong>Instituciones</strong> 
				  </h4>
				</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-md-2 col-md-offset-10">
						{if Session::get('autenticado')}
							{if $_acl->permiso("registrar_institucion")}
							<a href="{$_layoutParams.root_clear}es/oferta/registro" class="btn btn-primary">Registrar Institucion</a>
							{/if}
						{/if}
					</div>
				</div>
				<div class="row">
					<div class="buscarInstitucion">
						<div class="col-md-4 col-md-offset-4">
							<div class="input-group">
								<input type="hidden" id="filtro_pais" name="filtro_pais" value="">
								<input type="text" name="palabra" id="palabra" class="form-control" placeholder="Buscar Institución por Datos Generales">
								<span class="input-group-btn">
								<button class="btn  btn-success btn-buscador" onclick="buscarPalabraDocumentos('palabra')" type="button" id="btnEnviar"><i class="glyphicon glyphicon-search"></i></button>
								</span>	
							</div>
						</div>
					</div>
				</div>
				<br>
				<div class="row">
					<div class="col-md-1 col-md-offset-4">
						<div class="demo-filtro">

						</div>
					</div>
					<div class="col-md-2 col-md-offset-1">
						<div class="demo-filtro2">

						</div>
					</div>
				</div>
				<!--paises-->
				<div class="col-md-12 text-center">
			      	{if isset($paises) && count($paises)}
			            {foreach item=datos from=$paises}
			               <div style="margin-top:17px;display:inline-block;vertical-align:top;text-align:center;">
			                  <a href="{$_layoutParams.root_clear}es/oferta/index/busquedaAvanzada/{$datos.Nombre}/all/all/all/no/no/no"><img class="pais "  data-toggle="tooltip" data-original-title="Haga click para buscar Instituciones de {$datos.Nombre}" style="cursor:pointer;width:40px" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$datos.Nombre}.png" pais="{$datos.Nombre}" alt="{$datos.Nombre}" /></a>
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
				<input type="hidden" id="filtro_pais" name="filtro_pais" value="">
				<input type="hidden" id="filtro_2" name="filtro_2" value="">
				<center><a id="activar_avanzado" onclick="mostrar_seccion()" style="cursor: pointer;">Activar Búsqueda Avanzada</a></center>
				<center><a id="desactivar_avanzado" onclick="quitar_seccion()" style="cursor: pointer;">Cerrar Búsqueda Avanzada</a></center>
				<div class="col-md-12 text-center" id="seccion_filtros">
					<form>
						<div class="row">
							<div class="col-md-8 col-md-offset-2">
								<br><div class="col-md-4">
										<label>Por País: </label>
									</div>
								<div class="col-md-3">
									<select id="selectPais" class="form-control">
									<option>--Seleccione--</option>
									{if isset($paises) && count($paises)}
					            		{foreach item=datos from=$paises}
					                	<option value="{$datos.Nombre}">{$datos.Nombre}</option>
				                		{/foreach}
				            		{else}
					            	<p><strong>{$lenguaje["sin_resultados"]}</strong></p>
				            		{/if}
				            		</select>
								</div>
								<div class="col-md-1">
									<div class="mapita"></div>
								</div>
			            	</div>
						</div>
						<div class="row">
							<br>
							<div class="col-md-8 col-md-offset-2">
								<div class="col-md-4">
									<label>En Otros Datos de la Institución: </label>
								</div>
								<div class="col-md-6">
									<input type="text" id="datos" class="form-control">
								</div>
							</div>
					 	</div>
					 	<div class="row">
							<br>
							<div class="col-md-8 col-md-offset-2">
								<div class="col-md-4">
									<label>En Proyectos de Investigación: </label>
								</div>
								<div class="col-md-6">
									<input type="text" id="proyectos" class="form-control">
								</div>
							</div>
					 	</div>
					 	<div class="row">
							<br>
							<div class="col-md-8 col-md-offset-2">
								<div class="col-md-4">
									<label>En Ofertas Académicas: </label>
								</div>
								<div class="col-md-6">
									<input type="text" id="ofertas" class="form-control">
								</div>
							</div>
					 	</div>
					 	<div class="row">
							<br>
							<div class="col-md-8 col-md-offset-2">
								<div class="col-md-4">
									<label>Tipos de Ofertas Académicas: </label>
								</div>
								<div class="col-md-2">
									<label for="esp">Especializaciones</label>
									<input id="esp" type="checkbox">
								</div>
								<div class="col-md-2">
									<label for="mae">Maestrías</label><br>
									<input id="mae" type="checkbox">
								</div>
								<div class="col-md-2">
									<label for="doc">Doctorados</label><br>
									<input id="doc" type="checkbox">
								</div>
							</div>
					 	</div><br>
					 	<button type="button" class="btn btn-success" onclick="busquedaAvanzada()">Realizar Búsqueda Avanzada</button>
					</form>
		    	</div>
		    	<div class="col-md-12">
		    		{if isset($busqueda) || isset($busquedaAvanzada)}
			    		<br>
			    		{if isset($cantidad)}
			    			<p>Instituciones Registradas: {$cantidad}</p>
			    		{/if}
			    		{if isset($cantidadResultados) && isset($palabra_buscada)}
			    			<p>Resultados Encontrados: {$cantidadResultados} Instituciones. Palabra Buscada: {$palabra_buscada}</p>
			    		{/if}
			    		{if isset($busquedaAvanzada)}
			    			<p>Resultados Encontrados: {$cantidadResultados} Instituciones. <b>Filtros:</b>
			    			{if isset($pais_buscado)}
			    				Pais: {$pais_buscado}
			    				<input type="hidden" id="pais_buscado" value="{$pais_buscado}">
			    			{/if}
			    			{if isset($datos_buscado)}
			    				En Otros Datos: {$datos_buscado}
			    				<input type="hidden" id="datos_buscado" value="{$datos_buscado}">
			    			{/if}
			    			{if isset($proyectos_buscado)}
			    				En Proyectos: {$proyectos_buscado}
			    				<input type="hidden" id="proyectos_buscado" value="{$proyectos_buscado}">
			    			{/if}
			    			{if isset($ofertas_buscado)}
			    				En Ofertas Académicas: {$ofertas_buscado}
			    				<input type="hidden" id="ofertas_buscado" value="{$ofertas_buscado}">
			    			{/if}
			    			{if isset($esp_buscado)}
			    				{$esp_buscado}
			    				<input type="hidden" id="especializaciones" value="especializaciones">
			    			{/if}
			    			{if isset($mae_buscado)}
			    				{$mae_buscado}
			    				<input type="hidden" id="maestrias" value="maestrias">
			    			{/if}
			    			{if isset($doc_buscado)}
			    				{$doc_buscado}
			    				<input type="hidden" id="doctorados" value="doctorados">
			    			{/if}
			    		</p>
			    		{/if}
		    		{else}
		    		<h3>Resumen General</h3>
					<div class="col-md-4">
		    			<div class="panel-group" id="accordion">
			        		<div class="panel panel-default">
			          			<div class="panel-heading">
			              			<h4 class="panel-title">
			              			<a data-toggle="collapse" data-parent="#accordion" href="#accordionOne">
			              			<strong>Instituciones Registradas:
					                    <span class="badge pull-right">{$cantidad}</span> 
			              			</strong>  
			              			</a>
			             			</h4>
			           			</div>       
					          	<div id="accordionOne" class="" >
						            <ul id="tematicas" class="list-group scroll"   style="height: auto;overflow-y: auto;">
						                {if isset($resumen1) && count($resumen1)}
						                  	{foreach item=datos from = $resumen1}
						                       	<li class="list-group-item">
						                      		<span class="badge">{$datos.CantidadRegistros}</span>
						                      		<a href="{$_layoutParams.root_clear}oferta/index/buscarporpalabras/{$datos.Tipo}" style="cursor:pointer"><span class="temadocumento" id="temadocumento">{$datos.Tipo}</span></a>
						                    	</li>                            
						                  	{/foreach}
						                {/if}
						            </ul>
					          	</div>
        					</div>
		    			</div>
		    		</div>
		    		<div class="col-md-4">
		    			<div class="panel-group" id="accordion">
			        		<div class="panel panel-default">
			          			<div class="panel-heading">
			              			<h4 class="panel-title">
			              			<a data-toggle="collapse" data-parent="#accordion" href="#accordionOne">
			              			<strong>Proyectos de Investigacion:
					                    <span class="badge pull-right">{$rowcount2}</span> 
			              			</strong>  
			              			</a>
			             			</h4>
			           			</div>       
					          	<div id="accordionOne" class="" >
						            <ul id="tematicas" class="list-group scroll"   style="height: auto;overflow-y: auto;">
						                {if isset($resumen2) && count($resumen2)}
						                  	{foreach item=datos from = $resumen2}
						                       	<li class="list-group-item">
						                      		<span class="badge">{$datos.CantidadRegistros}</span>
						                      		<a href="{$_layoutParams.root_clear}es/oferta/index/buscarportematica/{$datos.Tipo}" style="cursor:pointer"><span class="temadocumento" id="temadocumento">{$datos.Tipo}</span></a>
						                    	</li>                            
						                  	{/foreach}
						                {/if}
						            </ul>
					          	</div>
        					</div>
		    			</div>
		    		</div>
		    		<div class="col-md-4">
		    			<div class="panel-group" id="accordion">
			        		<div class="panel panel-default">
			          			<div class="panel-heading">
			              			<h4 class="panel-title">
			              			<a data-toggle="collapse" data-parent="#accordion" href="#accordionOne">
			              			<strong>Ofertas Académicas:
					                    <span class="badge pull-right">{$rowcount3}</span> 
			              			</strong>  
			              			</a>
			             			</h4>
			           			</div>       
					          	<div id="accordionOne" class="" >
						            <ul id="tematicas" class="list-group scroll"   style="height: auto;overflow-y: auto;">
						                {if isset($resumen3) && count($resumen3)}
						                  	{foreach item=datos from = $resumen3}
						                       	<li class="list-group-item">
						                      		<span class="badge">{$datos.CantidadRegistros}</span>
						                      		{if $datos.Tipo == 'ESPECIALIZACION'}
								                    	{$IR_e = 'especializaciones'}
								                    {else}
														{$IR_e = 'no'}
								                    {/if}
								                    {if $datos.Tipo == 'MAESTRÍA'}
								                    	{$IR_m = 'maestrias'}
								                    {else}
								                    	{$IR_m = 'no'}
								                    {/if}
								                    {if $datos.Tipo == 'DOCTORADO'}
								                    	{$IR_d = 'doctorados'}
								                    {else}
								                    	{$IR_d = 'no'}
								                    {/if}
						                      		<a href="{$_layoutParams.root_clear}oferta/index/busquedaAvanzada/all/all/all/all/{$IR_e}/{$IR_m}/{$IR_d}" style="cursor:pointer"><span class="temadocumento" id="temadocumento">{$datos.Tipo}</span></a>
						                    	</li>                            
						                  	{/foreach}
						                {/if}
						            </ul>
					          	</div>
        					</div>
		    			</div>
		    		</div>
		    		{/if}
		    		{if isset($busqueda) || isset($busquedaAvanzada)}
		    		<div id="listarInstituciones">
		    		{if (isset($listaIns) && count($listaIns))}
		        		{foreach key=key from=$listaIns item=b}
		        			<div class="row" style="background: #E9F8CA; -webkit-box-shadow: 0 15px 10px #777; -moz-box-shadow: 0 10px 10px #777; box-shadow: 0 10px 10px #777;">
			        			<div class="col-md-10">
			        				<a style="color: black;" href="{$_layoutParams.root_clear}es/oferta/instituciones/ficha/{$b.Ins_IdInstitucion}">
					            	{$numeracion=$numeracion + 1}	
					            	<h3>{$numeracion}. {$b.Ins_Nombre} <img width="30" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$b.Pai_Nombre}.png" alt="{$b.Pai_Nombre}" class="pais " data-toggle="tooltip" data-original-title="{$b.Ubi_Sede}, {$b.Pai_Nombre}"></h3>
					            	<h4><b>Contacto:</b> 
					            		{if $b.Ins_CorreoPagina !== '' && $b.Ins_CorreoPagina !== null } 
					            		{$b.Ins_CorreoPagina} 
					            		{else}
					            		No Consta
					            		{/if} 
					            		{if isset($busqueda) || isset($busquedaAvanzada)}
						            		{if isset($listaO) && count($listaO)}
						            		{$contadorO = 0}
						            			{foreach from=$listaO item=no}
						            			{if ($b.Ins_IdInstitucion == $no.Ins_IdInstitucion)}
						            				|| <b>Ofertas Académicas:</b> {$no.nroOfertas}
						            				{$contadorO=1}
						            			{/if}		
						            			{/foreach}
						            			{if $contadorO == 0}
													|| <b>Ofertas Académicas:</b> 0
						            			{/if}
						            		{/if}
					            		{else}
					            		<b>Ofertas Académicas:</b> {$b.nroOfertas}
					            	{$contador=0}
					            	{if (isset($lista2) && count($lista2))}
					            	{foreach key=key2 from=$lista2 item=b2}
					            	{if $b.Ins_IdInstitucion==$b2.Ins_IdInstitucion}
					            	|| <b>Proyectos de Investigación:</b> {$b2.nroInv}
					            	{$contador=1}
					            	{/if}
					            	{/foreach}
					            	{if $contador==0}
					            	|| <b>Proyectos de Investigación:</b> 0
					            	{/if}
					            	{else}
					            	|| <b>Proyectos de Investigación:</b> 0
					            	{/if}
					            	{/if}

					            	</h4>
					            	</a>
			        			</div>
			        			<div class="col-md-2" style="padding-top: 5px;">
			        				
			        				{if $b.Ins_img == ''}
									{$b.Ins_img = 'logos/default.png'}			
									{/if}
									<img width="80" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$b.Ins_img}" alt="{$b.Ins_img}" class="pais " data-toggle="tooltip" style="padding-bottom: 5px;" data-original-title="{$b.Ins_Nombre}">
			        			</div>
		        			</div>
		        			<br>
			        	{/foreach}
			        	{$paginacion|default:""}
			        {else}
		    			<h2>No se encontraron resultados</h2>
		    		{/if}
		    		</div>
		    		{/if}
		    	</div>
		    </div>
		</div>
	</div>
</div>