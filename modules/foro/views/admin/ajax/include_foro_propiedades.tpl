{if !empty($foro_padre)}
<div class="panel panel-default">
	<div class="panel-heading"><label>{$lenguaje.foro_form_discusionprincipal}</label> </div>
	<div class="panel-body">
		
		<a class="link-foro" href="http://pric.github:82/es/foro/index/ficha/52" target="_blank">
			<strong>{$foro_padre.For_Titulo}</strong>
		</a>
		<p>
			{if strlen($foro_padre.For_Resumen)>150}
			{substr($foro_padre.For_Resumen, 0, 60)}...
			{else}
			{$foro_padre.For_Resumen}
			{/if}
		</p>
		<div class="detalles-act-reciente f-z-14">{$foro_padre.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace {$foro_padre.tiempo} &nbsp;&nbsp;-&nbsp;&nbsp; {$foro_padre.votos} {$lenguaje.foro_str_votos} &nbsp;&nbsp;-&nbsp;&nbsp; {$foro_padre.For_TParticipantes|default:0} {$lenguaje.foro_str_participantes} &nbsp;&nbsp;-&nbsp;&nbsp;{$foro_padre.For_TComentarios|default:0} {$lenguaje.str_comentarios}</div>
		
		
	</div>
</div>
{/if}
<div class="panel panel-default">
	<div class="panel-heading panel_collapse" data-toggle="collapse" data-target="#panel_propiedades"><label>{$lenguaje.foro_form_propiedadespublicacion}</label> </div>
	<div id="panel_propiedades" class="panel-body collapse in" >
		<div class="form-horizontal">
			<div class="form-group">
				<label for="s_lista_tematica" class="col-lg-3 control-label">{$lenguaje.foro_str_tematica}</label>
				<div class="col-lg-8 col-md-6">
					<select  class="form-control selectpicker" id="s_lista_tematica" name="s_lista_tematica" data-live-search="true" required>
						<option value="">{$lenguaje.foro_form_seleccione}</option>
						{foreach from=$linea_tematica item=item}
						<option style="cursor: pointer;" value="{$item.Lit_IdLineaTematica}" {if !empty($foro)&&$foro.Lit_IdLineaTematica==$item.Lit_IdLineaTematica}selected{/if}>{$item.Lit_Nombre}</option>
						{/foreach}
					</select>
				</div>
			</div>
			{if $Form_Funcion!="query"}
			<div class="form-group">
				<label for="s_lista_entidad" class="col-lg-3 control-label">{$lenguaje.foro_form_entidad}</label>
				<div id="select_entidad" class="col-lg-8 col-md-6">
					{include file='modules/foro/views/admin/ajax/include_select_entidad.tpl'}
				</div>
			</div>
			
			<div class="form-group">
				<label for="text_date" class="col-lg-3 control-label">{$lenguaje.foro_form_fecha}</label>
				<div class="col-lg-8">
					<div class="checkbox">
						<label>
							<input id="cb_start_date" name="cb_start_date"  type="checkbox" value="" class="cb_select_fecha" div_time="start_date_div">
							{$lenguaje.foro_form_indicarfechainicio}
						</label>
						<div id="start_date_div" class="input-group" style="display: none">
							<span class="input-group-btn">
								<button class="bt_start_time btn btn-default" type="button" title="Reiniciar ">
								<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
								<span class="sr-only">{$lenguaje.foro_form_calendario}</span>
								</button>
							</span>
							<input id="start_time" class="form-control" name="start_time" type="text" value="" readonly>
							<span class="input-group-btn">
								<button class="bt_clear_start_time btn btn-default" type="button" title="Reiniciar ">
								<span class="glyphicon glyphicon-trash text-danger" aria-hidden="true"></span>
								<span class="sr-only">{$lenguaje.foro_form_reiniciar} </span>
								</button>
							</span>
						</div>
					</div>
					<div class="checkbox">
						<label>
							<input type="checkbox" id="cb_end_date" name="cb_end_date"  value="" class="cb_select_fecha" div_time="end_date_div">
							{$lenguaje.foro_form_indicarfechafin}
						</label>
						<div id="end_date_div"  class="input-group" style="display: none">
							<span class="input-group-btn">
								<button class="bt_end_time btn btn-default" type="button" title="Reiniciar ">
								<span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
								<span class="sr-only">{$lenguaje.foro_form_calendario}</span>
								</button>
							</span>
							<input id="end_time" class="form-control" name="end_time" type="text" value="" readonly>
							<span class="input-group-btn">
								<button class="bt_clear_end_time btn btn-default" type="button" title="Reiniciar ">
								<span class="glyphicon glyphicon-trash text-danger" aria-hidden="true"></span>
								<span class="sr-only">{$lenguaje.foro_form_reiniciar} </span>
								</button>
							</span>
						</div>
					</div>
				</div>
			</div>
			
			<div class="form-group">
				<label for="s_lista_tipo" class="col-lg-3 control-label">{$lenguaje.foro_form_tipo}</label>
				<div class="col-lg-6 col-md-6">
					<select class="form-control" id="s_lista_tipo" name="s_lista_tipo">
						<option value="1"{if !empty($foro)&&$foro.For_Tipo==1}selected{/if}>{$lenguaje.foro_form_abierto}</option>
						<option value="0"{if !empty($foro)&&$foro.For_Tipo==0}selected{/if}>{$lenguaje.foro_form_cerrado}</option>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label for="s_lista_estado" class="col-lg-3 control-label">{$lenguaje.foro_form_visible}</label>
				<div class="col-lg-6 col-md-6">
					<select class="form-control" id="s_lista_estado" name="s_lista_estado">
						<option value="1"{if !empty($foro)&&$foro.For_Estado==1}selected{/if}>{$lenguaje.foro_form_publico}</option>
						<option value="0"{if !empty($foro)&&$foro.For_Estado==0}selected{/if}>{$lenguaje.foro_form_oculto}</option>
					</select>
				</div>
			</div>
			{/if}
		</div>
	</div>
</div>
<div class="panel panel-default status-upload">
	<div class="panel-heading">
		<div class="col col-xs-12 col-sm-12 col-md-4 col-lg-6">
			<label>{$lenguaje.foro_form_materialesapoyo}</label>
		</div>
		
		<div class="col col-xs-12 col-sm-12 col-md-8 col-lg-6">
			<ul class="pull-right">
				<li><span title="PDF|DOC|PPT|Files" data-toggle="tooltip" data-placement="bottom" data-original-title="PDF|DOC|PPT|Files" class="form_fileinput" for="files_doc" ><i class="glyphicon glyphicon-file"></i> <input name="files_doc" type="file" multiple="" class="files_form"                                                                                                                                                            accept=".pptx, .pptm, .ppt, .pdf, .xps, .potx, .potm, .pot,.thmx, .ppsx, .ppsm, .pps, .ppam, .ppam, .ppa, .xml, .pptx,.pptx,.rar, .zip"></span></li>
				<li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Picture"  class="form_fileinput" for="file_img"><i class="glyphicon glyphicon-picture"></i><input name="files_doc" type="file" multiple="" class="files_form" accept="image/*"></span></li>
				<li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Video"  class="form_fileinput" for="files_video"><i class="glyphicon glyphicon-facetime-video"></i><input name="files_doc" type="file" multiple="" class="files_form" accept="video/*"></span></li>
				<li><span title="" data-toggle="tooltip" data-placement="bottom" data-original-title="Audio"  class="form_fileinput" for="files_son"><i class="glyphicon glyphicon-music"></i><input name="files_doc" type="file" multiple="" class="files_form" accept="audio/*"></span></li>
			</ul>
		</div>
		<div class="clearfix"></div>
		<input id="hd_file_form" name="hd_file_form" type="hidden" value="">
	</div>
	{if !empty($foro)&&count($foro.Archivos)>0}
	<div id="div_loading_file" class="panel-body load_files d-block">
		{foreach from=$foro.Archivos key=key item=file}
		<div class="files" tabindex="-1" id="">
			<input id="file-e{$key}" name="attach_form" type="hidden" value="{$file.Fif_NombreFile}" checked="" f-size="{$file.Fif_SizeFile}" f-type="{$file.Fif_TipoFile}" f-fout="{$file.Fif_EsOutForo}">
			<div class="file_titulo">
				<a class="file_titulo2 underline" href="{$_layoutParams.root_archivo_fisico}{$file.Fif_NombreFile}"  title="Descargar {$file.Fif_Titulo}" target="_blank">
					{$file.Fif_NombreFile}
				</a>
			</div>
			{$Fif_SizeFile=$file.Fif_SizeFile/1024}
			<div class="file_size">({if $Fif_SizeFile<1}{$Fif_SizeFile|string_format:"%.3f"} K {else} {$Fif_SizeFile=$Fif_SizeFile/1024} {$Fif_SizeFile|string_format:"%.3f"} M{/if})</div>
			<div class="file_loading off"></div>
			<div role="button" class="file_close" tabindex="-1"></div>
		</div>
		{/foreach}
	</div>
	{else}
	<div id="div_loading_file" class="panel-body load_files d-none">
	</div>
	{/if}
</div>
<div class="panel panel-default">
	<div class="panel-heading"><label>{$lenguaje.foro_form_publicar}</label> </div>
	<div class="panel-body">
		{if !empty($foro)}
		<a id="bt_regresar" name="bt_regresar" class="btn btn-link"
			href="{$_layoutParams.root}foro/index/ficha/{$idForo}"
		>{$lenguaje.foro_form_regresar}</a>
		{else}
		<a id="bt_regresar" name="bt_regresar" class="btn btn-link"
			href="{$_layoutParams.root}foro/index/{$Form_Funcion}"
		>Regresar</a>
		{/if}
		{if !empty($foro)}
		<a target="_blank" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}" class="btn btn-default " style="    margin-left: 10px;">{$lenguaje.foro_form_vistaprevia}</a>
		{/if}
		<button id="bt_guardar" name="bt_guardar" type="submit" class="btn btn-primary ">{$lenguaje.foro_form_guardar}</button>
	</div>
	<div class="panel-heading">
	</div>
</div>