<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10">
        <div class="row ficha_foro">
            <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
                <div class="col-xs-8 col-sm-8 col-md-8 col-lg-8 p-rt-lt-0">
                    <div class="etiqueta">
                        {if $foro.For_Funcion == 'forum'}
                        Discusiones
                        {/if}
                        {if $foro.For_Funcion == 'webinar'}
                        Webinars
                        {/if}
                        {if $foro.For_Funcion == 'query'}
                        Consultas
                        {/if}
                        {if $foro.For_Funcion == 'workshop'}
                        Workshop
                        {/if}
                    </div>
                </div>                
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12  p-rt-lt-0">
                    <hr class="cursos-hr">
                </div>
                <div class="col col-xs-12 col-sm-12 col-md-12 col-lg-12 ">
                    <h3 class="titulo-ficha margin-t-10"><a title="{$foro.For_Titulo}" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">{$foro.For_Titulo}</a></h3>
                </div>
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0" style="font-size: 12px;">
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 p-rt-lt-0">
                        <i class="glyphicon glyphicon-user" style="color: #777; text-align: center; vertical-align: middle; margin-bottom: 5px;"></i>
                        {$lenguaje.foro_str_creado} {timediff date=$foro["For_FechaCreacion"] lang=Cookie::lenguaje()}  {$lenguaje.foro_str_por} <strong>{$nombre_usuario}</strong>
                    </div>
                    <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6 p-rt-lt-0">
                        <div class="pull-right">
                            <i class="fa fa-users" style="color: #777; text-align: center; vertical-align: middle;"></i>
                            {$lenguaje.foro_str_participantes}: <strong>{$Numero_participantes_x_idForo}</strong>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 p-rt-lt-0">
                    <hr class="cursos-hr">
                </div>
                <input type="hidden" id="comentario_completo" name="comentario_completo" value="comentario_completo">
               <div id="lista_comentarios" class="row"> 
                   {include file='modules/foro/views/index/ajax/lista_comentarios.tpl' is_hijo=false}
                </div>
            </div>
            <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
                 {include file='modules/foro/views/index/ajax/include_foro_detalle.tpl' }
            </div>
        </div>
    </div>
</div>
<!-- para el reportar comentario -->
<div class="modal fade top-space-0" id="modal-reportar-comentario" tabindex="-1" role="dialog">
    <div class="modal-dialog login-dialog">
        <div class="modal-content">
            <div class="modal-body">
                <div class="row">
                    <div class="col-md-12 col-xs-12 col-lg-12 col-sm-12">
                        <h2 class="col-xs-8">{$lenguaje.foro_str_reportarcomentario}</h2>
                        <input type="hidden" id="idcomentario" name="idcomentario">
                        <button title="cerrar" type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">×</span>
                        </button>
                        <div class="panel-group">
                            <div class="panel panel-default">
                                <div class="col-xs-12 panel-heading" style="color: #333; background-color: #F5F5AE; border-color: #ddd;">
                                <div class="col col-xs-1"><img src="{$_layoutParams.root_clear}public/img/advertencia.png">
                                </div>
                                <div class="col-xs-11">
                                    {$lenguaje.foro_str_inforeportarcomentario}
                                    </div>
                                </div>                                   
                                <div class="panel-body"> 
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label>{$lenguaje.foro_str_mensaje}</label>
                                                <textarea class="form-control" id="ta_mensaje_reportar" name="ta_mensaje_reportar"></textarea>  
                                            </div>
                                        </div>
                                    </div>
                                <button type="button" id_foro="{$foro.For_IdForo}" class="btn btn-primary btn-md enviar_reporte" data-dismiss="modal" style="margin-left: 88%;">{$lenguaje.foro_str_enviar}</button>
                                </div>                               
                            </div>
                        </div>
    
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>