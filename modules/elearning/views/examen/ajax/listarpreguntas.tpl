<div class="row">
                <div style="display:inline-block;padding-right:2em">
                
                    <a {if $puntos_maximo>0} href="{$_layoutParams.root}elearning/examen/registrarRespuestaUnica/{$examen}" {else}
                 data-toggle="modal"  data-target="#msj-invalido" data-placement="bottom" 
                {/if}><img src="https://campus.chamilo.org/main/img/icons/64/mcua.png" alt="Respuesta única" title="Respuesta única"></a>
                
                </div>
                <div style="display:inline-block;padding-right:2em">
                    <a {if $puntos_maximo>0} href="{$_layoutParams.root}elearning/examen/registrarRespuestaMultiple/{$examen}" {else}
                 data-toggle="modal"  data-target="#msj-invalido" data-placement="bottom" 
                {/if}><img src="https://campus.chamilo.org/main/img/icons/64/mcma.png" alt="Respuesta múltiple" title="Respuesta múltiple"></a>
                </div>
                <div style="display:inline-block;padding-right:2em">
                    <a {if $puntos_maximo>0} href="{$_layoutParams.root}elearning/examen/registrarRespuestaBlanco/{$examen}" {else}
                 data-toggle="modal"  data-target="#msj-invalido" data-placement="bottom" 
                {/if}><img src="https://campus.chamilo.org/main/img/icons/64/fill_in_blanks.png" alt="Rellenar blancos" title="Rellenar blancos"></a>
                </div>
                <div style="display:inline-block;padding-right:2em">
                    <a {if $puntos_maximo>0} href="{$_layoutParams.root}elearning/examen/registrarRespuestaRelacionar/{$examen}" {else}
                 data-toggle="modal"  data-target="#msj-invalido" data-placement="bottom" 
                {/if}><img src="https://campus.chamilo.org/main/img/icons/64/matching.png" alt="Relacionar" title="Relacionar"></a>
                </div>
                <div style="display:inline-block;padding-right:2em">
                    <a {if $puntos_maximo>0} href="{$_layoutParams.root}elearning/examen/registrarRespuestaAbierta/{$examen}" {else}
                 data-toggle="modal"  data-target="#msj-invalido" data-placement="bottom" 
                {/if}><img src="https://campus.chamilo.org/main/img/icons/64/open_answer.png" alt="Respuesta abierta" title="Respuesta abierta"></a>
                </div>
                <!-- <div style="display:inline-block;padding-right:2em">
                    <a href="{$_layoutParams.root}elearning/examen/registrarRespuestaZonasImagen/{$examen}"><img src="https://campus.chamilo.org/main/img/icons/64/hotspot.png" alt="Zonas de Imagen" title="Zonas de Imagen"></a>
                </div> -->
                <div style="display:inline-block;padding-right:2em">
                    <a {if $puntos_maximo>0} href="{$_layoutParams.root}elearning/examen/registrarRespuestaCombinacionExacta/{$examen}" {else}
                 data-toggle="modal"  data-target="#msj-invalido" data-placement="bottom" 
                {/if}><img src="https://campus.chamilo.org/main/img/icons/64/mcmac.png" alt="Combinación Exacta" title="Combinación Exacta"></a>
                </div>
            </div>
                {if isset($preguntas) && count($preguntas)}
                    <div class="table-responsive">
                        <table class="table" style="  margin: 20px auto">
                            <tr>
                                <th style=" text-align: center">Nº</th>
                                <th style=" text-align: center">Preguntas</th>
                                <th style=" text-align: center">Tipo</th>
                                <th style=" text-align: center">Estado</th>
<!--                                 <th style=" text-align: center">Fecha</th>
                                    {if $_acl->permiso("editar_rol")} -->
                                    <th style=" text-align: center">Opciones</th>
<!--                                     {/if} -->
                            </tr>
                            {foreach item=rl from=$preguntas}
                                <tr {if $rl.Row_Estado==0}
                                        {if $_acl->permiso("ver_eliminados")}
                                            class="btn-danger"
                                        {else}
                                            hidden {$numeropagina = $numeropagina-1}
                                        {/if}
                                    {/if} >
                                    <td style=" text-align: center">{$numeropagina++}</td>
                                    <td style=" text-align: center">{$rl.Pre_Descripcion}</td>
                                    <td style=" text-align: center">{if $rl.Pre_Tipo==1}Respuesta Única{/if}{if $rl.Pre_Tipo==2}Respuesta Múltiple{/if}{if $rl.Pre_Tipo==3}Rellenar blancos{/if}{if $rl.Pre_Tipo==4}Respuestas Relacionadas{/if}{if $rl.Pre_Tipo==5}Respuesta Abierta{/if}{if $rl.Pre_Tipo==6}Respuesta con Zonas de Imagen{/if}{if $rl.Pre_Tipo==7}Combinación Exacta{/if}</td>
<!--                                     <td style=" text-align: center">{$rl.Cer_FechaReg}</td> -->
                                    <td style=" text-align: center">
                                                {if $rl.Pre_Estado==0}
                                                    <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="{$lenguaje.label_deshabilitado}" style="color: #DD4B39;"></p>
                                                {/if}                            
                                                {if $rl.Pre_Estado==1}
                                                    <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="{$lenguaje.label_habilitado}" style="color: #088A08;"></p>
                                                {/if}
                                            </td>               
                                    {if $_acl->permiso("editar_rol")}
                                    <td style=" text-align: center">
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-pregunta" title="{$lenguaje.tabla_opcion_cambiar_est}" id_pregunta="{$rl.Pre_IdPregunta}" estado="{$rl.Pre_Estado}"> </a>
                                        
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="Editar" href="{$_layoutParams.root}elearning/examen/{if $rl.Pre_Tipo==1}editarRespuestaUnica{/if}{if $rl.Pre_Tipo==2}editarRespuestaMultiple{/if}{if $rl.Pre_Tipo==3}editarRespuestaBlanco{/if}{if $rl.Pre_Tipo==4}editarRespuestaRelacionar{/if}{if $rl.Pre_Tipo==5}editarRespuestaAbierta{/if}{if $rl.Pre_Tipo==6}editarRespuestaZonasImagen{/if}{if $rl.Pre_Tipo==7}editarRespuestaCombinacionExacta{/if}/{$rl.Pre_IdPregunta}"></a>

                                        <a   
                                        {if $rl.Row_Estado==0}
                                            data-toggle="tooltip" 
                                            class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-pregunta" title="{$lenguaje.label_habilitar}" 
                                        {else}
                                            data-book-id="{$rl.Pre_Descripcion}"
                                            data-toggle="modal"  data-target="#confirm-delete"
                                            class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-pregunta" {/if}
                                        id_pregunta="{$rl.Pre_IdPregunta}" data-placement="bottom" > </a>
                                        
                                    </td>
                                    {/if}
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                    {$paginacionpreguntas|default:""}
                {else}
                    No hay registros
                {/if}                