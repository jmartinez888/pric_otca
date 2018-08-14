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