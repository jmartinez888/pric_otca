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