											<strong class="col col-xs-1 pull-right">&nbsp;{$comentarios.Nvaloraciones_comentario}&nbsp;</strong>
                                            <span class="col-xs-1 pull-right" style="padding-left:  1%; padding-right:  1%; width: 16%;">
                                                {if $comentarios.valoracion_comentario == 1}
                                                <img style="max-width: 110% !important;" src="{$_layoutParams.root_clear}/public/img/corazon_verde2.png">
                                                {else}
                                                    {if $comentarios.valoracion_comentario == 0}
                                                    <img src="{$_layoutParams.root_clear}/public/img/corazon.png">
                                                    {/if}
                                                {/if}
                                            </span>
                                            <span class="pull-right simulalink" style="font-size: 15px"> {if $comentarios.valoracion_comentario == 1}<b>{/if}<a id_comentario="{$comentarios.ID}" id_usuario="{Session::get('id_usuario')}" ajaxtpl="valoraciones_comentarios" class="valorar_comentario" valor="{$comentarios.valoracion_comentario}">Me gusta&nbsp;</a>{if $comentarios.valoracion_comentario == 1}</b>{/if}</span>

                                           <!--  <span class="col-xs-1" style="padding-top: 6%;">
                                                <img src="{$_layoutParams.root_clear}/public/img/corazon.png">{$comentarios.Nvaloraciones_comentario}</span>  
                                            <span class="pull-right simulalink" style="font-size: 15px">{if $comentarios.valoracion_comentario == 1}<b>{/if}<a id_comentario="{$comentarios.ID}" id_usuario="{Session::get('id_usuario')}" ajaxtpl="valoraciones_comentarios" class="valorar_comentario" valor="{$comentarios.valoracion_comentario}">Me gusta</a>{if $comentarios.valoracion_comentario == 1}</b>{/if}</span> -->
                                
                                     