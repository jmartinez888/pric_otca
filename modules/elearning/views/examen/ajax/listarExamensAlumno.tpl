<div class="col-xs-12">
    <!-- <input type="hidden" name="porcentaje" id="porcentaje" value="{$porcentaje|default:'0'}"> -->
    {if isset($respuestas) && count($respuestas)}
        <div class="table-responsive">
            <table class="table" style="  margin: 20px auto">
                <tr >
                    <th style=" text-align: center">Nº</th>
                    <th style=" text-align: center">Alumno</th>
                    <th style=" text-align: center">Fecha</th>
                    <th style=" text-align: center">Intento</th>
                    <th style=" text-align: center">Estado</th>
                    <th style=" text-align: center">Opciones</th>
                </tr>
                {$i = 0}{$c = 0}{$z = 0}
                {foreach item=rl from=$respuestas}
                    <tr {if $rl.Row_Estado==0}
                            {if $_acl->permiso("ver_eliminados")}
                                class="btn-danger"
                            {else}
                                hidden {$numeropagina = $numeropagina-1}
                            {/if}
                        {/if} > 
                        {if $i == 0}
                            {$i = $rl.Usu_IdUsuario}
                            {$c = 1}
                            <!-- {$numeropagina} =={$rl.Usu_IdUsuario}==> 1.) i = {$i}; c = {$c}; <br> -->
                        {else}
                            {if $i == $rl.Usu_IdUsuario}
                                {$c = $c + 1}
                                <!-- {$numeropagina} =={$rl.Usu_IdUsuario}==> 2.) i = {$i}; c = {$c}; <br> -->
                            {else}
                                {$c = 1}{$i = $rl.Usu_IdUsuario}
                                <!-- {$numeropagina} =={$rl.Usu_IdUsuario}==> 3.) i = {$i}; c = {$c}; <br> -->
                            {/if}                                            
                        {/if}

                        <td style=" text-align: center">{$numeropagina++}</td>
                        <td style=" text-align: center">{$rl.Usu_Nombre} {$rl.Usu_Apellidos}</td>
                        <td style=" text-align: center">{$rl.Exl_Fecha}</td>
                        <td style=" text-align: center">{$rl.Exl_Intento|default:$c}</td>
                        <td style=" text-align: center">
                        {if $rl.Exl_Estado==0}
                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="{$lenguaje.label_deshabilitado}" style="color: #DD4B39;"></p>
                        {/if}
                        {if $rl.Exl_Estado==1}
                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="{$lenguaje.label_habilitado}" style="color: #088A08;"></p>
                        {/if}
                        </td>
                        <td style=" text-align: center">
                            <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-examen-alumno" title="{$lenguaje.tabla_opcion_cambiar_est}" 
                            id_examen_alumno="{$rl.Exl_IdExamenAlumno}" estado="{$rl.Exl_Estado}"> </a>

                            <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-eye-open" id="btn-Editar" title="Editar" href="{$_layoutParams.root}elearning/examen/corregirExamenAlumno/{$rl.Exa_IdExamen}/"></a>

                            <a
                            {if $rl.Row_Estado==0}
                                data-toggle="tooltip"
                                class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-examen" title="{$lenguaje.label_habilitar}"
                            {else}
                                data-book-id="{$rl.Pre_Descripcion}"
                                data-toggle="modal"  data-target="#confirm-delete"
                                class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-examen"  
                            {/if}
                            id_examen="{$rl.Exa_IdExamen}" data-placement="bottom" > </a>

                        </td>
                    </tr>
                {/foreach}
            </table>
        </div>
        {$paginacionExamensAlumno|default:""}
    {else}
        No hay registros
    {/if}
</div>