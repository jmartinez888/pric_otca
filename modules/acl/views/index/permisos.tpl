<div  class="container-fluid" >
    <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
        <h4 style="width: 80%;  margin: 0px auto; text-align: center;">{$lenguaje.permisos_label_titulo}</h4>
    </div>
    {if $_acl->permiso("editar_rol")}
        <div class="panel panel-default">
            <div class="panel-heading jsoftCollap">
                <h3 aria-expanded="false" data-toggle="collapse" href="#collapse3" class="panel-title collapsed"><i style="float:right" class="fa fa-ellipsis-v"></i><i class="fa fa-key"></i>&nbsp;&nbsp;<strong>{$lenguaje.permisos_nuevo_titulo}</strong></h3>
            </div>
            <div style="height: 0px;" aria-expanded="false" id="collapse3" class="panel-collapse collapse">
                <div class="panel-body" id="cont-form" style=" margin: 15px">
                    <form class="form-horizontal"  data-toggle="validator" id="form4" role="form" name="form4" action="" method="post">                    
                        <div class="form-group">
                            <label class="col-lg-2 control-label">{$lenguaje.label_permiso} (*): </label>
                            <div class="col-lg-10">
                                <input  class="form-control" type="text" name="permiso_" id="permiso_" placeholder="{$lenguaje.label_permiso}" required=""  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">{$lenguaje.label_clave} (*): </label>
                            <div class="col-lg-10">
                                <input  class="form-control" type="text" name="key_" id="key_" placeholder="{$lenguaje.label_clave}" required="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">{$lenguaje.label_modulo} : </label>
                            <div class="col-lg-4">
                                <select class="form-control" name="modulo_" id="modulo_">
                                    <option value="0" >{$lenguaje.select_option_seleccione}</option>
                                    {if isset($modulos) && count($modulos)}
                                    {foreach item=m from=$modulos}
                                        <option value="{$m.Mod_IdModulo}" >{$m.Mod_Nombre}</option>
                                    {/foreach}
                                    {/if}
                                </select>
                            </div>
                            <div class="col-lg-1">
                                <button class="btn btn-success" type="button" id="bt_agregarModulo" name="bt_agregarModulo" data-toggle="tooltip" data-placement="bottom" title="{$lenguaje.label_crear_modulo}"><i class="glyphicon glyphicon-plus-sign"> </i></button>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <button class="btn btn-success" type="submit" id="bt_guardarPermiso" name="bt_guardarPermiso" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.button_ok}</button>
                            </div>
                        </div>                 
                    </form> 
                </div>
            </div>
        </div>
    {/if}
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">
                <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
                <strong>{$lenguaje.permisos_buscar_titulo}</strong>                      
            </h3>
        </div>
        <div class="panel-body" style=" margin: 15px">
             <div class="row" style="text-align:right">
                <div style="display:inline-block;padding-right:2em">
                    <input class="form-control" placeholder="{$lenguaje.text_buscar_permisos}" style="width: 150px; float: left; margin: 0px 10px;" name="palabraPermiso" id="palabraPermiso">
                    <button class="btn btn-success" style=" float: left" type="button" id="buscarPermiso"  ><i class="glyphicon glyphicon-search"></i></button>
                </div>
            </div>
            <div id="listarPermisos">
                {if isset($permisos) && count($permisos)}
                <div class="table-responsivez">
                    <table class="table dt-responsive " id="tablas" style="  margin: 20px auto">
                        <tr>
                            <th style=" text-align: center">{$lenguaje.label_n}</th>
                            <th >{$lenguaje.label_permiso} </th>
                            <th >{$lenguaje.label_modulo} </th>
                            <th style=" text-align: center">{$lenguaje.label_clave}</th>
                            <th style=" text-align: center">{$lenguaje.label_estado}</th>
                            {if $_acl->permiso("editar_rol")}
                            <th style=" text-align: center">{$lenguaje.label_opciones}</th>
                            {/if}
                        </tr>
                        {foreach item=rl from=$permisos}
                            <tr {if $rl.Row_Estado==0}
                                    {if $_acl->permiso("ver_eliminados")}
                                        class="btn-danger"
                                    {else}
                                        hidden {$numeropagina=$numeropagina-1}
                                    {/if}
                                {/if} >
                                <td style=" text-align: center">{$numeropagina++}</td>
                                <td>{$rl.Per_Nombre}</td>
                                <td>{$rl.Mod_Nombre|default:" - "}</td>
                                <td style=" text-align: center">{$rl.Per_Ckey}</td>
                                
                                {if $_acl->permiso("editar_rol")}
                                <td style=" text-align: center">             
                                    {if $rl.Per_Estado==0}
                                        <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="{$lenguaje.label_deshabilitado}" style="color: #DD4B39;"/>
                                    {else}
                                        <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="{$lenguaje.label_habilitado}" style="color: #088A08;"/>
                                    {/if}
                                </td>
                                <td style=" text-align: center">
                                    <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-permiso" title="{$lenguaje.tabla_opcion_cambiar_est}"
                                    id_permiso="{$rl.Per_IdPermiso}" estado="{$rl.Per_Estado}"> </a>
                                    <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="{$lenguaje.tabla_opcion_editar}" href="{$_layoutParams.root}acl/index/editarPermiso/{$rl.Per_IdPermiso}"> </a>
                                    <a   
                                    {if $rl.Row_Estado==0}
                                        data-toggle="tooltip" 
                                        class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-permiso" title="{$lenguaje.label_habilitar}" 
                                    {else}
                                        data-book-id="{$rl.Per_Nombre}"
                                        data-toggle="modal"  data-target="#confirm-delete"
                                        class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-permiso" title="{$lenguaje.label_eliminar}"
                                    {/if} 
                                    id_permiso="{$rl.Per_IdPermiso}" data-placement="bottom" > </a>
                                </td>
                                {/if}
                            </tr>
                        {/foreach}
                    </table>
                </div>
                    {$paginacionPermisos|default:""}
                {else}
                    {$lenguaje.no_registros}
                {/if}                
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
                <p>Eliminar: <strong  class="nombre-es">Permiso</strong></p>
                <label id="texto_" name='texto_'></label>
                <!-- <input type='text' class='form-control' name='codigo' id='validate-number' placeholder='Codigo' required> --> 
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <a style="cursor:pointer"  data-dismiss="modal" class="btn btn-danger danger eliminar_permiso">Eliminar</a>
            </div>
        </div>
    </div>
</div>


