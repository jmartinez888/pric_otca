<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
	<div class="discusion">
		<div class="cabecera-discusion">
			<a class="link-foro" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
				<h4 style="text-align: justify;"><strong>{$foro.For_Titulo}</strong></h4>
			</a>
		</div>
		<div>
			<p style="text-align: justify;">{$foro.For_Resumen|truncate:120:"..."}</p>
		</div>
		<div class="">{$foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp;  {timediff date=$foro.tiempo  lang=Cookie::lenguaje()} &nbsp;&nbsp;-&nbsp;&nbsp; {shortnumber number=$foro.Nvaloraciones_foro} voto(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.For_TComentarios|default:0} comentario(s)</div>
		<!-- <div class="footer-item row">
			<div class="col-md-6 detalles-discusion">
				{$end_date=($foro.For_FechaCierre|date_format:"%d-%m-%Y")}
				<span class="date">{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"} {if ($foro.For_FechaCierre|date_format:"%d-%m-%Y")!=""} / {($foro.For_FechaCierre|date_format:"%d-%m-%Y")}{/if}</span>
			</div>
			<div class="col-md-6 text-right detalles-discusion">
				Colaboraciones <span class="badge">{$foro.For_TComentarios}</span>
			</div>
		</div>  -->
	</div>
</div>