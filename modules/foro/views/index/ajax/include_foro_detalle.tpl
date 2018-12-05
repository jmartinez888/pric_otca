<div class="addon">
                    <label class="tit-integrante">Facilitado Por</label>
                    <ul>
                            {foreach from=$facilitadores item=facilitador}
                            <li class=" clearfix">
                                                <a href="{$_layoutParams.root}usuarios/perfil/index/{$facilitador.Usu_IdUsuario}" target="_blank">
                                                    <div class="col col-xs-3 col-sm-3 col-md-3 col-lg-3">
                                                        {if !empty($facilitador.Usu_URLImage)}
                                                        <img class="round" src="$facilitador.Usu_URLImage}" alt="falta">
                                                        {else}
                                                        <img class="round" src="{$_layoutParams.root_clear}/views/layout/frontend/img/user2-160x160.jpg" alt="Perfil">
                                                        {/if}
                                                    </div>
                                                    <div class="col col-xs-9 col-sm-9 col-md-9 col-lg-9">
                                                        <strong class="underline">{$facilitador.Usu_Nombre}  {$facilitador.Usu_Apellidos}</strong>
                                                    </div>
                                                </a>
                            </li>
                            {/foreach}
                    </ul>
                </div>
                {if count($foro.Archivos)>0}
                <div class="addon">
                    <label class="tit-integrante">Recursos</label>
                    <ul id="div_show_{$foro.For_IdForo}">
                                            {foreach from=$foro.Archivos  item=file}
                                            <li tabindex="-1" id="">
                                                <div class="col col-xs-1 col-sm-1 col-md-1 col-lg-1">
                                                {if $file.Fif_TipoFile|strstr:"video"}
                                                <i class="fa fa-video-camera"></i>        
                                                {elseif $file.Fif_TipoFile|strstr:"image"}
                                                <i class="fa fa-picture-o"></i>
                                                {elseif $file.Fif_TipoFile|strstr:"application"}
                                                <i class="fa fa-file-o"></i>
                                                {else}
                                                <i class="fa fa-file-o"></i>
                                                {/if}
                                                </div>
                                                {if $file.Fif_EsOutForo==1}
                                                <div class="col col-xs-11 col-sm-11 col-md-11 col-lg-11">
                                                    <a class="file_titulo2 underline" href="{$_layoutParams.root_archivo_fisico}{$file.Fif_NombreFile}"  title="Descargar {$file.Fif_Titulo}" target="_blank">
                                                        <strong>{substr($file.Fif_Titulo, 0, 27)}... </strong></a>
                                                </div>
                                                {else}
                                                <div class="col col-xs-11 col-sm-11 col-md-11 col-lg-11">
                                                    <a class="file_titulo2 underline" href="{$_layoutParams.root_archivo_fisico}{$file.Fif_NombreFile}"  title="Descargar {$file.Fif_NombreFile}" target="_blank">{substr($file.Fif_NombreFile, 0, 27)}...</a>
                                                </div>
                                                {/if}
                                                
                                                {$file.Fif_SizeFile=$file.Fif_SizeFile/1024}
                                                <div class="pull-right file_size">({if $file.Fif_SizeFile<1024}{$file.Fif_SizeFile|string_format:"%.1f"} KB {else} {$file.Fif_SizeFile=$file.Fif_SizeFile/1024} {$file.Fif_SizeFile|string_format:"%.1f"} MB{/if})</div>
                                            </li>
                                            {/foreach}
                    </ul>
                </div>
                {/if}
                {if $foro.For_Funcion != 'query' && !empty($actvidades) && count($actvidades)>0}
                <div class="addon">
                    <label class="tit-integrante">Actividades</label>
                    <ul>
                                            {foreach from=$actvidades item=act}
                                            <li tabindex="-1" id="{$act.id}">
                                                <h4><a title="{$act.resumen}" style="cursor: pointer;">{$act.title}</a> </h4>
                                                <div class="col col-xs-12 col-sm-12 col-md-4 col-lg-12 f-z-14">
                                                    {assign var="inicio" value=" "|explode:$act.start}
                                                    {assign var="fin" value=" "|explode:$act.end}
                                                    {if $inicio[0]==$fin[0]}
                                                    <i class="glyphicon glyphicon-calendar"></i>
                                                    {$inicio[0]|replace:'-':'.'} <i class="fa fa-clock-o" aria-hidden="true"></i> {$act.start|date_format:"%H:%M"} -
                                                    {$act.end|date_format:"%H:%M"}
                                                    
                                                    {else}
                                                    <i class="glyphicon glyphicon-calendar"></i>
                                                    {$inicio[0]|replace:'-':'.'} <i class="fa fa-clock-o" aria-hidden="true"></i> {$yesterday|date_format:"%H:%M:%S"}
                                                    <br>
                                                    <i class="glyphicon glyphicon-calendar"></i>
                                                    {$fin[0]|replace:'-':'.'} <i class="fa fa-clock-o" aria-hidden="true"></i>{$fin[1]}
                                                    {/if}
                                                </div>
                                                
                                                
                                            </li>
                                            {/foreach}
                    </ul>
                </div>
                {/if}
                {if Session::get('autenticado')}
                    {if !$comentar_foro && $Rol_Ckey != "administrador_foro" && $Rol_Ckey != "administrador"}
                    <!-- <hr>                    
                    <div class="card">
                                        <span class="group-btn">
                                            <button class="btn btn-primary btn-md inscribir_foro" id_foro="{$foro.For_IdForo}">Inscríbete <i class="fa fa-sign-in"></i></button>
                                        </span>
                    </div> -->
                    {/if}
                    {else}
                    <hr>
                    <div class="card">
                        <div class="form-login">
                            {if $foro.For_Funcion=="forum"}
                            <h5>Iniciar sesión para contribuir</h5>
                            {else}
                            <h5>Iniciar sesión para participar</h5>
                            {/if}
                            <div>
                                <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-group btn-success">Inicie Sesion <i class="glyphicon glyphicon-log-in"></i></button>
                            </div>
                        </div>
                    </div>
                    <hr>
                {/if}