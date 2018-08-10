{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10">
<div class="col-lg-12">
        <h3>Examenes</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">           
            <div class="row" style="text-align:right">
                <div style="display:inline-block;padding-right:2em">
                     <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
                    <input class="form-control" placeholder="Buscar examen" style="width: 300px; float: left; margin: 0px 10px;" name="palabraexamen" id="palabraexamen">
                    <button class="btn btn-success" style=" float: left" type="button" id="buscarexamen"  ><i class="glyphicon glyphicon-search"></i></button>
                </div>
            </div>
            <div id="listarexamens">
            <div class="col-lg-12">
                 {if $porcentaje<100}
                 <a href="{$_layoutParams.root}elearning/examen/nuevoexamen/{$idcurso}" class="btn btn-primary margin-top-10 glyphicon glyphicon-plus" id="btn_añadir1"> Nuevo</a>
            {else}
             <a data-toggle="modal"  data-target="#msj-invalido" class="btn btn-danger margin-top-10 glyphicon glyphicon-plus" data-placement="bottom" > Nuevo</a>
            {/if}
            
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
                                        {if  $rl.Emitido==0}
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-examen" title="{$lenguaje.tabla_opcion_cambiar_est}" id_examen="{$rl.Exa_IdExamen}" estado="{$rl.Exa_Estado}"> </a>
                                        {/if}
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="Editar" href="{$_layoutParams.root}elearning/examen/{$rl.Exa_IdExamen}"></a>

                                         <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-question-sign" title="Preguntas" href="{$_layoutParams.root}elearning/examen/preguntas/{$rl.Exa_IdExamen}"></a>

                                        {if  $rl.Emitido==0}
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
                                        
                                    </td>
                                    {/if}
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
        </div>
    </div>
</div>


<div class="modal " id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Confirmación de Eliminación</h4>
            </div>
            <div class="modal-body">
                <p>Estás a punto de borrar un item, este procedimiento es irreversible</p>
                <p>¿Deseas Continuar?</p>
                <p>Eliminar: <strong  class="nombre-es">examen</strong></p>
                <label id="texto_" name='texto_'></label>
                <!-- <input type='text' class='form-control' name='codigo' id='validate-number' placeholder='Codigo' required> --> 
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <a style="cursor:pointer"  data-dismiss="modal" class="btn btn-danger danger eliminar_examen">Eliminar</a>
            </div>
        </div>
    </div>
</div>

<div class="modal " id="msj-invalido" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Acción no Disponible</h4>
            </div>
            <div class="modal-body">
                <p>Ya se ha alcanzado el 100% con los examenes registrados. Si desea crear uno nuevo modifique los porcentajes de los examenes, o inhabilite o elimine algún examen.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <a style="cursor:pointer"  data-dismiss="modal" class="btn btn-danger danger eliminar_examen">Eliminar</a>
            </div>
        </div>
    </div>
</div>


