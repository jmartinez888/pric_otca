<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
	{if count($lista_foros)>0}
	<table class="table table-striped">
		<thead>
			<tr>
				<th colspan="2">Detalles de histórico de Foro</th>
			</tr>
		</thead>
		<tbody>
			{foreach from=$lista_foros item=foro}
			<tr>
				<td>
					<a class="link-foro" href="{$_layoutParams.root_clear}foro/index/ficha/{$foro.For_IdForo}" target="_blank"><h4 style="text-align: justify;"><strong>{$foro.For_Titulo}</strong> </h4></a>
					<div  style="padding-bottom: 10px; font-size: 12px;">
						<span class="badge" style="border-radius: 4px;">{$foro.For_Funcion}
						</span>
						&nbsp;&nbsp;-&nbsp;&nbsp;
						{$foro.Usu_Usuario}
						&nbsp;&nbsp;-&nbsp;&nbsp;
						{timediff date=$foro.tiempo  lang=Cookie::lenguaje()}
						&nbsp;&nbsp;-&nbsp;&nbsp;
						{shortnumber number=$foro.Nvaloraciones_foro} voto(s)
						&nbsp;&nbsp;-&nbsp;&nbsp;
						{$foro.For_NParticipantes} participante(s)
						&nbsp;&nbsp;-&nbsp;&nbsp;
						{$foro.For_NComentarios}  comentario(s)
					</div>
					
				</td>
				<td class="f-z-14">
					<small>
					<strong>Finalizado:</strong>
					</small>
					{assign var="date" value=" "|explode:$foro.For_FechaCierre}
					<br>
					<i class="glyphicon glyphicon-calendar"></i>
					{$date[0]|replace:'-':'.'}
					<i class="fa fa-clock-o" aria-hidden="true"></i> {$date[1]}
					<br>
					{foreach from=$foro.Archivos item=file}
					{if $file.Fif_EsOutForo == 1}
					<a class="reporte" target="_blank" href="{$_layoutParams.root_archivo_fisico}{$file.Fif_NombreFile}">Descargar Reporte</a>
					{break}
					{/if}
					{/foreach}
				</td>
			</tr>
			<!--washington-->
			{/foreach}
		</tbody>
	</table>
	{$paginacion|default:""}
	{else}
	<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    	<h4>No se encontraron resultados!...</h4>
    </div> 
	{/if}
</div>
