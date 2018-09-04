<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0" style="background-image: url({BASE_URL}modules/oferta/views/index/img/encabezado-oferta.jpg); background-repeat: no-repeat;">
    <div class="col-md-5 col-lg-5" style="color: white; font-weight: bold; font-size: 18px;">
          <div class="col-lg-12">
			<center><h1 class="titulo2">{$lenguaje["label_h1_titulo"]}</h1></center>
		</div>
		<div class="col-lg-12">
			<hr class="cursos-hr3">
		</div>
		<div class="col-lg-12">
			<p class="descripcion-oferta">{$lenguaje["label_h2_descripcion"]}</p>
		</div>
    </div>
</div>
<div class="container-fluid">
	<!-- <div class="row">
		<div class="col-lg-12">
			<center><h2 class="titulo2">{$lenguaje["label_h1_titulo"]}</h2></center>
		</div>
		<div class="col-lg-12">
			<hr class="cursos-hr">
		</div>
		<div class="col-lg-12">
			<h4 class="descripcion-oferta">{$lenguaje["label_h2_descripcion"]}</h4>
		</div>
	</div> -->
	<div class="row">
		{if isset($busqueda) || isset($busquedaAvanzada)}
		<div class="col-md-3" style="margin-top: 66px;">
			<h4 class="resumen-busqueda"><strong>{$lenguaje["busqueda_avanzada_label_resumen_busqueda"]}</strong></h4>
      		<div class="panel-group" id="accordion">
        		<div class="side-menu2 col-md-12 p-rt-lt-0">
              		<a data-toggle="collapse" data-parent="#accordion" href="#accordionOne">
              			<div class="col-lg-12 side-menu">
              				<div class="col-md-9 col-lg-9 p-rt-lt-0">
	              				<h4 class="panel-title">
		              				{$lenguaje["busqueda_avanzada_label_tipo_ins"]}
				                </h4>
				            </div>
			                <div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 10%; right: 5%;">
			                	{if isset($cantidadResultados)}
				                    <span class="badge pull-right position-badge">{$cantidadResultados}</span>
				                {/if}
			                </div>
			            </div>
              		</a>
             			
           			       
		          	<div id="accordionOne" class="panel-collapse collapse col-md-12 p-rt-lt-0" >
			            <ul id="tematicas" class="list-group scroll"   style="max-height: 300px;overflow-y: auto; margin-bottom: 0px;">
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
			                  	{foreach item=datos1 from = $resumen1}
			                       	<li class="list-group-item-jp col-md-12 p-rt-lt-0 padding-li2">
			                      		<div class="col-md-9 col-lg-9 p-rt-lt-0">
			                      			<a href="" style="cursor:pointer; color: #222;"><span class="temadocumento underline" id="temadocumento">{$datos1.Ins_Tipo}</span></a>
			                      		</div>
			                      		<div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 20%; right: 5%;">
			                      			<span class="badge pull-right">{$datos1.CantidadRegistros}</span>
			                      		</div>
			                    	</li>                            
			                  	{/foreach}
			                {/if}
			            </ul>
		          	</div>
        		</div>
		        <div class="side-menu2 col-md-12 p-rt-lt-0">
		            <a data-toggle="collapse" data-parent="#accordion" href="#accordionOne2">
		            	<div class="col-lg-12 side-menu">
		            		<div class="col-md-9 col-lg-9 p-rt-lt-0">
			            		<h4 class="panel-title">
				               		{$lenguaje["busqueda_avanzada_label_proyectosR"]}
			                	</h4>
			                </div>
		                	<div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 20%; right: 5%;">
		                		{if isset($rowcount2)}
			                  		<span class="badge pull-right position-badge">{$rowcount2}</span>
			                	{/if}
		                	</div>
		                </div> 
		            </a>
		             	
		                  
		          	<div id="accordionOne2" class="panel-collapse collapse col-md-12 p-rt-lt-0" >
			            <ul id="tipodocumento" class="list-group scroll"   style="max-height: 300px;overflow-y: auto; margin-bottom: 0px;">
			             	{if isset($resumen2) && count($resumen2)}
			              		{foreach item=datos2 from = $resumen2}
			                  	<li class="list-group-item-jp col-md-12 p-rt-lt-0 padding-li2">
			                      <div class="col-md-9 col-lg-9 p-rt-lt-0">
			                      	<a href="" style="cursor:pointer; color: #222;"><span class="palabraclave underline" id="palabraclave">{$datos2.Tem_Nombre}</span></a>
			                      </div>
			                      <div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 10%; right: 5%;">
			                      	<span class="badge pull-right position-badge">{$datos2.CantidadRegistros}</span>
			                      </div>
			                    </li>        
			                  	{/foreach}
			                {/if}             
			            </ul>
		          	</div>
		        </div>
        		<!-- Filtro Autor -->
				<div class="side-menu2 col-md-12 p-rt-lt-0">
			        <a data-toggle="collapse" data-parent="#accordion" href="#accordionAutor">
			            <div class="col-lg-12 side-menu">
			            	<div class="col-md-9 col-lg-9 p-rt-lt-0">
				                <h4 class="panel-title">
				                	{$lenguaje["busqueda_avanzada_label_ofertasR"]}
					            </h4>
					        </div>
				            <div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 10%; right: 5%;">
				            	{if isset($rowcount3)}
				                	<span class="badge pull-right position-badge">{$rowcount3}</span>
				                {/if}
				            </div>
				        </div>
		        	</a>
		        	    
			               
			        <div id="accordionAutor" class="panel-collapse collapse col-md-12 p-rt-lt-0" >
			        	<ul id="autor" class="list-group scroll"   style="max-height: 300px;overflow-y: auto;margin-bottom: 0px;">
			               {if isset($resumen3) && count($resumen3)}
			                {foreach item=a from = $resumen3}
			                <li class="list-group-item-jp col-md-12 p-rt-lt-0 padding-li2">
			                    
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
				                <div class="col-md-9 col-lg-9 p-rt-lt-0">
				                    <a href="{$_layoutParams.root_clear}oferta/index/busquedaAvanzada/{$BPais}/{$BDatos}/{$BProyectos}/{$BOfertas}/{$IR_e}/{$IR_m}/{$IR_d}" style="cursor:pointer; color: #222;"><span class="autordocumento underline" id="autorDocumento">{$a.Tipo}</span></a>
				                </div>
			                    <div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 10%; right: 5%;">
			                    	<span class="badge pull-right position-badge">{$a.CantidadRegistros}</span>
			                    </div>
			                  </li>        
			                {/foreach}
			                {/if}             
			            </ul>
			        </div>
				</div>
      		</div>
  		</div>
  		{/if}
  		<div {if isset($busqueda) || isset($busquedaAvanzada)} class="col-md-9" {else} class="col-lg-12"
  		{/if} >
				<div class="panel-body p-rt-lt-0">
					<div class="row">
						<div class="col-md-2 col-md-offset-10">
							{if Session::get('autenticado')}
								{if $_acl->permiso("registrar_institucion")}
								<a href="{$_layoutParams.root_clear}oferta/registro" class="btn btn-primary">{$lenguaje["registrar_ins"]}</a>
								{/if}
							{/if}
						</div>
					</div>
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
						
					<div class="row">
						<div class="col-lg-12" style="padding-top: 10px;">
						<div class="pull-right">
							<center><a id="activar_avanzado" onclick="mostrar_seccion()" style="cursor: pointer;"><button class="btn btn-success pull-right">{$lenguaje["activar_busqueda_avanzada"]}</button></a></center>
							<center><a id="desactivar_avanzado" onclick="quitar_seccion()" style="cursor: pointer; display: none;"><button class="btn btn-success pull-right">{$lenguaje["desactivar_busqueda_avanzada"]}</button></a></center>
						</div>

						<div class="buscarInstitucion">
							<div class="col-md-5 pull-right">
								<div class="input-group">
									<input type="hidden" id="filtro_pais" name="filtro_pais" value="">
									<input type="text" name="palabra" id="palabra" class="form-control" placeholder="{$lenguaje['placeholder_buscador_general']}">
									<span class="input-group-btn">
									<button class="btn btn-success btn-buscador" onclick="buscarPalabraDocumentos('palabra')" type="button" id="btnEnviar"><i class="glyphicon glyphicon-search"></i></button>
									</span>	
								</div>
							</div>
						</div>
						</div>
					</div>
					<div class="col-md-12 text-center p-rt-lt-0" id="seccion_filtros" style="display: none;">
						<form class="col-md-12 busqueda-avanzada" style="text-align: left; margin-top: 15px;">
							<div class="col-md-8 col-md-offset-2">
							<div class="row">
								<div class="col-md-12">
									<br><div class="col-md-5">
											<label>{$lenguaje["busqueda_avanzada_label_pais"]}</label>
										</div>
									<div class="col-md-4">
										<select id="selectPais" class="form-control">
										<option>{$lenguaje["busqueda_avanzada_select_pais"]}</option>
										{if isset($paises) && count($paises)}
						            		{foreach item=datos from=$paises}
						                	<option value="{$datos.Nombre}">{$datos.Nombre}</option>
					                		{/foreach}
					            		{else}
						            	<p><strong>{$lenguaje["sin_resultados"]}</strong></p>
					            		{/if}
					            		</select>
									</div>
									<div class="col-md-2">
										<div class="mapita">
											<img style="max-height: 30px;" id="banderita" src=""/>
											<input type="hidden" id="bandera" value="{BASE_URL}">
										</div>
									</div>
				            	</div>
							</div>
							<div class="row">
								<br>
								<div class="col-md-12">
									<div class="col-md-5">
										<label>{$lenguaje["busqueda_avanzada_label_otros_datos"]} </label>
									</div>
									<div class="col-md-6">
										<input type="text" id="datos" class="form-control">
									</div>
								</div>
						 	</div>
						 	<div class="row">
								<br>
								<div class="col-md-12">
									<div class="col-md-5">
										<label>{$lenguaje["busqueda_avanzada_label_proyectos"]}</label>
									</div>
									<div class="col-md-6">
										<input type="text" id="proyectos" class="form-control">
									</div>
								</div>
						 	</div>
						 	<div class="row">
								<br>
								<div class="col-md-12">
									<div class="col-md-5">
										<label>{$lenguaje["busqueda_avanzada_label_ofertas"]}</label>
									</div>
									<div class="col-md-6">
										<input type="text" id="ofertas" class="form-control">
									</div>
								</div>
						 	</div>
						 	<div class="row">
								<br>
								<div class="col-md-12">
									<div class="col-md-5">
										<label>{$lenguaje["busqueda_avanzada_label_tipo_ofertas"]}</label>
									</div>
									<div class="col-md-3">
										<label for="esp">{$lenguaje["busqueda_avanzada_label_esp"]}</label><br>
										<input id="esp" type="checkbox">
									</div>
									<div class="col-md-2">
										<label for="mae">{$lenguaje["busqueda_avanzada_label_mae"]}</label><br>
										<input id="mae" type="checkbox">
									</div>
									<div class="col-md-2">
										<label for="doc">{$lenguaje["busqueda_avanzada_label_doc"]}</label><br>
										<input id="doc" type="checkbox">
									</div>
								</div>
						 	</div><br>
						 	<button type="button" class="btn btn-primary col-md-offset-5" onclick="busquedaAvanzada()">{$lenguaje["busqueda_avanzada_boton_buscar"]}</button>
						 	<br><br>
						 	</div>
						</form>
			    	</div>
			    	<!--paises-->
			    	{if isset($paises) && count($paises)}
			    	<div class="col-lg-12 p-rt-lt-0">
						<center><h3 class="titulo2">Instituciones por países</h3></center>
					</div>
					<div class="col-lg-12 p-rt-lt-0">
						<hr class="cursos-hr">
					</div>
					
					<div class="col-md-12 text-center p-rt-lt-0">
				      	
				            {foreach item=datos from=$paises}
				               <div class="instituciones-paises">
				                  <a href="{$_layoutParams.root_clear}oferta/index/busquedaAvanzada/{$datos.Nombre}/all/all/all/no/no/no"><img class="pais "  data-toggle="tooltip" data-original-title="{$lenguaje['busqueda_avanzada_label_tooltip']} {$datos.Nombre}" style="cursor:pointer;width:40px" src="{$_layoutParams.root_clear}public/img/legal/{$datos.Nombre}.png" pais="{$datos.Nombre}" alt="{$datos.Nombre}" /></a>
		                          <br>
		                          <b>{$datos.Nombre}</b>
		                          <br>
		                          <span class="badge-pais" style="font-size:.8em">{$datos.Conteo|default:0}</span>
				                </div>
		        	        {/foreach}
				        {/if}             
				    </div>
					<!--fin paises-->
					<input type="hidden" id="filtro_pais" name="filtro_pais" value="">
					<input type="hidden" id="filtro_2" name="filtro_2" value="">
			    	<div class="col-md-12 p-rt-lt-0">
			    		{if isset($busqueda) || isset($busquedaAvanzada)}
				    		{if isset($cantidad)}
				    			<h4 class="resumen-busqueda">Instituciones Registradas: <b>{$cantidad}</b></h4>
				    		{/if}
				    		{if isset($cantidadResultados) && isset($palabra_buscada)}
				    			<h4 class="resumen-busqueda">{$lenguaje["resultados_busqueda_avanzada_label_1"]} <b>{$cantidadResultados}</b> {$lenguaje["resultados_busqueda_avanzada_label_2"]} <b>{$palabra_buscada}</b></h4>
				    		{/if}
				    		{if isset($busquedaAvanzada)}
				    			<h4 class="resumen-busqueda">{$lenguaje["resultados_busqueda_avanzada_label_1"]} <b>{$cantidadResultados}</b> {$lenguaje["instituciones"]}.{$lenguaje["resultados_busqueda_avanzada_label_filtros"]}
				    			{if isset($pais_buscado)}
				    				{$lenguaje["resultados_busqueda_avanzada_label_filtros_pais"]} <b>{$pais_buscado}</b>
				    				<input type="hidden" id="pais_buscado" value="{$pais_buscado}">
				    			{/if}
				    			{if isset($datos_buscado)}
				    				{$lenguaje["resultados_busqueda_avanzada_label_filtros_otros_datos"]} <b>{$datos_buscado}</b>
				    				<input type="hidden" id="datos_buscado" value="{$datos_buscado}">
				    			{/if}
				    			{if isset($proyectos_buscado)}
				    				{$lenguaje["resultados_busqueda_avanzada_label_filtros_proyectos"]} <b>{$proyectos_buscado}</b>
				    				<input type="hidden" id="proyectos_buscado" value="{$proyectos_buscado}">
				    			{/if}
				    			{if isset($ofertas_buscado)}
				    				{$lenguaje["resultados_busqueda_avanzada_label_filtros_ofertas"]} <b>{$ofertas_buscado}</b>
				    				<input type="hidden" id="ofertas_buscado" value="{$ofertas_buscado}">
				    			{/if}
				    			{if isset($esp_buscado)}
				    				{$lenguaje["resultados_busqueda_avanzada_label_filtros_esp"]}
				    				<input type="hidden" id="especializaciones" value="especializaciones">
				    			{/if}
				    			{if isset($mae_buscado)}
				    				{$lenguaje["resultados_busqueda_avanzada_label_filtros_mae"]}
				    				<input type="hidden" id="maestrias" value="maestrias">
				    			{/if}
				    			{if isset($doc_buscado)}
				    				{$lenguaje["resultados_busqueda_avanzada_label_filtros_doc"]}
				    				<input type="hidden" id="doctorados" value="doctorados">
				    			{/if}
				    		</h4>
				    		{/if}
			    		{else}
			    		<h3>{$lenguaje["busqueda_avanzada_label_resumen_general"]}</h3>
			    		<div class="col-lg-12 p-rt-lt-0">
			            	<hr class="cursos-hr">
			            </div>
						<div class="col-md-4 resumen-home">
			    			<div class="" id="accordion">
				        		<div class="">
				          			<div class="cabecera-resumenes">
				              			<h4 class="panel-title">
				              			<div class="title-resumen" data-toggle="collapse" data-parent="#accordion" href="">
				              			<strong>{$lenguaje["busqueda_avanzada_label_ins_reg"]}
						                    <span class="badge pull-right">{$cantidad}</span> 
				              			</strong>  
				              			</div>
				             			</h4>
				           			</div>       
						          	<div id="accordionOne" class="col-md-12 p-rt-lt-0" >
							            <ul id="tematicas" class="list-group scroll"   style="height: auto;overflow-y: auto;">
							                {if isset($resumen1) && count($resumen1)}
							                  	{foreach item=datos1 from = $resumen1}
							                       	<li class="list-group-item-jp col-md-12 p-rt-lt-0 padding-li">
							                      		<div class="col-md-9 col-lg-9 p-rt-lt-0">
							                      			<a class="subtitle-resumen" href="{$_layoutParams.root_clear}oferta/index/buscarporpalabras/{$datos1.Ins_Tipo}" style="cursor:pointer"><span class="temadocumento" id="temadocumento">{$datos1.Ins_Tipo}</span></a>
							                      		</div>
							                      		<div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 30%; right: 5%;">
							                      			<span class="badge pull-right">{$datos1.CantidadRegistros}</span>
							                      		</div>
							                    	</li>                            
							                  	{/foreach}
							                {/if}
							            </ul>
						          	</div>
	        					</div>
			    			</div>
			    		</div>
			    		<div class="col-md-4 resumen-home">
			    			<div class="" id="accordion">
				        		<div class="">
				          			<div class="cabecera-resumenes">
				              			<h4 class="panel-title">
				              			<div class="title-resumen" data-toggle="collapse" data-parent="#accordion" href="">
				              			<strong>{$lenguaje["busqueda_avanzada_label_proyectosR"]}
						                    <span class="badge pull-right">{$rowcount2}</span> 
				              			</strong>  
				              			</div>
				             			</h4>
				           			</div>       
						          	<div id="accordionOne" class="col-md-12 p-rt-lt-0" >
							            <ul id="tematicas" class="list-group scroll"   style="height: auto;overflow-y: auto;">
							                {if isset($resumen2) && count($resumen2)}
							                  	{foreach item=datos2 from = $resumen2}
							                       	<li class="list-group-item-jp col-md-12 p-rt-lt-0 padding-li">
							                      		<div class="col-md-9 col-lg-9 p-rt-lt-0">
							                      			<a class="subtitle-resumen" href="{$_layoutParams.root_clear}oferta/index/buscarportematica/{$datos2.Tem_Nombre}" style="cursor:pointer"><span class="temadocumento" id="temadocumento">{$datos2.Tem_Nombre}</span></a>
							                      		</div>
							                      		<div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 30%; right: 5%;">
							                      			<span class="badge pull-right">{$datos2.CantidadRegistros}</span>
							                      		</div>
							                    	</li>                            
							                  	{/foreach}
							                {/if}
							            </ul>
						          	</div>
	        					</div>
			    			</div>
			    		</div>
			    		<div class="col-md-4 resumen-home">
			    			<div class="" id="accordion">
				        		<div class="">
				          			<div class="cabecera-resumenes">
				              			<h4 class="panel-title">
				              			<div class="title-resumen" data-toggle="collapse" data-parent="#accordion" href="">
				              			<strong>{$lenguaje["busqueda_avanzada_label_ofertasR"]}
						                    <span class="badge pull-right">{$rowcount3}</span> 
				              			</strong>  
				              			</div>
				             			</h4>
				           			</div>       
						          	<div id="accordionOne" class="col-md-12 p-rt-lt-0" >
							            <ul id="tematicas" class="list-group scroll"   style="height: auto;overflow-y: auto;">
							                {if isset($resumen3) && count($resumen3)}
							                  	{foreach item=datos from = $resumen3}
							                       	<li class="list-group-item-jp col-md-12 p-rt-lt-0 padding-li">
							                      		
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
										                <div class="col-md-9 col-lg-9 p-rt-lt-0">
							                      			<a class="subtitle-resumen" href="{$_layoutParams.root_clear}oferta/index/busquedaAvanzada/all/all/all/all/{$IR_e}/{$IR_m}/{$IR_d}" style="cursor:pointer"><span class="temadocumento" id="temadocumento">{$datos.Tipo}</span></a>
							                      		</div>
							                      		<div class="col-md-3 col-lg-3 p-rt-lt-0" style="position: absolute; top: 30%; right: 5%;">
							                      			<span class="badge pull-right">{$datos.CantidadRegistros}</span>
							                      		</div>
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
			        		<div class="col-md-12 col-lg-12">
			        			<div class="row" style="border-bottom: 1px solid #ddd; padding-bottom: 10px;">
				        			<div class="col-md-10">
				        				<a class="underline" style="color: black;" href="{$_layoutParams.root_clear}oferta/instituciones/ficha/{$b.Ins_IdInstitucion}">
						            	{$numeracion=$numeracion + 1}	
						            	<h3>{$numeracion}. {$b.Ins_Nombre} <img width="30" src="{$_layoutParams.root_clear}public/img/legal/{$b.Pai_Nombre}.png" alt="{$b.Pai_Nombre}" class="pais " data-toggle="tooltip" data-original-title="{$b.Ubi_Sede}, {$b.Pai_Nombre}"></h3>
						            	<h4><b>{$lenguaje["Contacto"]}</b> 
						            		{if $b.Ins_CorreoPagina !== '' && $b.Ins_CorreoPagina !== null } 
						            		{$b.Ins_CorreoPagina} 
						            		{else}
						            		{$lenguaje["busqueda_avanzada_resultados_nulo"]}
						            		{/if} 
						            		{if isset($busqueda) || isset($busquedaAvanzada)}
							            		{if isset($listaO) && count($listaO)}
							            		{$contadorO = 0}
							            			{foreach from=$listaO item=no}
							            			{if ($b.Ins_IdInstitucion == $no.Ins_IdInstitucion)}
							            				|| <b>{$lenguaje["busqueda_avanzada_label_ofertasR"]}</b> {$no.nroOfertas}
							            				{$contadorO=1}
							            			{/if}		
							            			{/foreach}
							            			{if $contadorO == 0}
														|| <b>{$lenguaje["busqueda_avanzada_label_ofertasR"]}</b> 0
							            			{/if}
							            		{/if}
						            		{else}
						            		<b>{$lenguaje["busqueda_avanzada_label_ofertasR"]}</b> {$b.nroOfertas}
						            	{$contador=0}
						            	{if (isset($lista2) && count($lista2))}
						            	{foreach key=key2 from=$lista2 item=b2}
						            	{if $b.Ins_IdInstitucion==$b2.Ins_IdInstitucion}
						            	|| <b>{$lenguaje["busqueda_avanzada_label_proyectosR"]}</b> {$b2.nroInv}
						            	{$contador=1}
						            	{/if}
						            	{/foreach}
						            	{if $contador==0}
						            	|| <b>{$lenguaje["busqueda_avanzada_label_proyectosR"]}</b> 0
						            	{/if}
						            	{else}
						            	|| <b>{$lenguaje["busqueda_avanzada_label_proyectosR"]}</b> 0
						            	{/if}
						            	{/if}

						            	</h4>
						            	</a>
				        			</div>
				        			<div class="col-md-2" style="padding-top: 10px;">
				        				
				        				{if $b.Ins_img == ''}
										{$b.Ins_img = 'logos/default.png'}			
										{/if}
										<img width="80" src="{$_layoutParams.root_clear}modules/oferta/views/instituciones/img/{$b.Ins_img}" alt="{$b.Ins_img}" class="pais " data-toggle="tooltip" style="padding-bottom: 5px;" data-original-title="{$b.Ins_Nombre}">
				        			</div>
			        			</div>
			        		</div>
				        	{/foreach}
				        	{$paginacion|default:""}
				        {else}
			    			<h2>{$lenguaje["busqueda_avanzada_resultados_no"]}</h2>
			    		{/if}
			    		</div>
			    		{/if}
			    	</div>
			    </div>

		</div>
	</div>
</div>