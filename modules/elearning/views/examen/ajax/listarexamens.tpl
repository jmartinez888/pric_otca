           <div class="col-lg-12">


                 <!-- {if $porcentaje<100} -->
                 <a href="{$_layoutParams.root}elearning/examen/nuevoexamen/{$idcurso}" class="btn btn-primary margin-top-10 glyphicon glyphicon-plus" id="btn_nuevo"> Nuevo</a>
<!--             {else}
             <a data-toggle="modal"  data-target="#msj-invalido" class="btn btn-danger margin-top-10 glyphicon glyphicon-plus" data-placement="bottom" > Nuevo</a>
            {/if} -->
            
                {if isset($examens) && count($examens)}
                    <div class="table-responsive">
                        <table class="table" style="  margin: 20px auto">
                            <tr>
                                <th style=" text-align: center">Nº</th>
                                <th style=" text-align: center">Título</th>
                                <th style=" text-align: center">Intentos</th>
                                <th style=" text-align: center">Porcentaje</th>
<!--                                 <th style=" text-align: center">Fecha</th>
                                    {if $_acl->permiso("editar_rol")} -->
                                <th style=" text-align: center">Opciones</th>
<!--                                     {/if} -->
                            </tr>
                            {foreach item=rl from=$examens}
                                <tr>
                                    <td style=" text-align: center">{$numeropagina++}</td>
                                    <td style=" text-align: center">{$rl.Exa_Titulo}</td>
                                    <td style=" text-align: center">{$rl.Exa_Intentos}</td>
                                    <td style=" text-align: center">{$rl.Exa_Porcentaje}%</td>
<!--                                     <td style=" text-align: center">{$rl.Cer_FechaReg}</td> -->
                                    {if $_acl->permiso("editar_rol")}
                                    <td style=" text-align: center">
                                       <!--  {if  $rl.Emitido==0}
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-examen" title="{$lenguaje.tabla_opcion_cambiar_est}" id_examen="{$rl.Exa_IdExamen}" estado="{$rl.Exa_Estado}"> </a>
                                        {/if} -->
<!--                                         <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" id="btn-Editar" title="Editar" href=""></a> -->

                                         <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-question-sign btn-preguntas" title="Preguntas" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$rl.Exa_IdExamen}"></a>

                                        <!-- {if  $rl.Emitido==0}
                                        <a   
                                        {if $rl.Row_Estado==0}
                                            data-toggle="tooltip" 
                                            class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-examen" title="{$lenguaje.label_habilitar}" 
                                        {else}
                                            data-book-id="{$rl.Pre_Descripcion}"
                                            data-toggle="modal"  data-target="#confirm-delete"
                                            class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-examen" {/if}
                                        id_examen="{$rl.Exa_IdExamen}" data-placement="bottom" > </a>
                                        {/if}
                                        {/if} -->
                                    </td>
                                    
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                    {$paginacionexamens|default:""}
                {else}
                    No hay registros
                {/if}                
            </div>
            </div>             