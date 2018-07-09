<div  class="container-fluid" >
    <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
        <h4 style="width: 80%;  margin: 0px auto; text-align: center;">Administración de Módulos</h4>
    </div>
    {if $_acl->permiso("editar_rol")}
        <div class="panel panel-default">
            <div class="panel-heading jsoftCollap">
                <h3 aria-expanded="false" data-toggle="collapse" href="#collapse3" class="panel-title collapsed"><i style="float:right" class="fa fa-ellipsis-v"></i><i class="fa fa-key"></i>&nbsp;&nbsp;<strong>Nuevo Módulo</strong></h3>
            </div>
            <div style="height: 0px;" aria-expanded="false" id="collapse3" class="panel-collapse collapse">
                <div class="panel-body" id="cont-form" style=" margin: 15px">
                    <form class="form-horizontal"  data-toggle="validator" id="form4" role="form" name="form4" action="" method="post">                    
                        <div class="form-group">
                            <label class="col-lg-2 control-label">Módulo (*): </label>
                            <div class="col-lg-10">
                                <input  class="form-control" type="text" name="modulo_" id="modulo_" placeholder="Nombre de Módulo" required=""  />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">Código (*): </label>
                            <div class="col-lg-10">
                                <input  class="form-control" type="text" name="codigo_" id="codigo_" placeholder="Código" required="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">Descripción (*): </label>
                            <div class="col-lg-10">
                                <input  class="form-control" type="text" name="descripcion_" id="descripcion_" placeholder="Descripción" required="" />
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <button class="btn btn-success" type="submit" id="bt_guardarModulo" name="bt_guardarModulo" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.button_ok}</button>
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
                <strong>Buscar Módulo</strong>                      
            </h3>
        </div>
        <div class="panel-body" style=" margin: 15px">
            <form method="POST">
                <div class="row" style="text-align:right">
                    <div class="well-sm col-sm-12">
                        <div id="botones" class="btn-group pull-right">
                            <button type="submit" id="export_data_excel" name="export_data_excel" class="btn btn-info">EXCEL</button>
                            <button type="submit" id="export_data_csv" name="export_data_csv" class="btn btn-info">CSV</button>
                            <button type="submit" id="export_data_pdf" name="export_data_pdf" class="btn btn-info">PDF</button>
                        </div>
                    </div>
                    <div style="display:inline-block;padding-right:2em">
                        <input class="form-control" placeholder="Buscar Módulo" style="width: 150px; float: left; margin: 0px 10px;" name="palabraModulo" id="palabraModulo">
                        <button class="btn btn-success" style=" float: left" type="button" id="buscarModulo"  ><i class="glyphicon glyphicon-search"></i></button>
                    </div>
                </div>
            </form>
            <div id="listarmodulos">
                {if isset($modulos) && count($modulos)}
                <div class="table-responsive">
                    <table class="table" style="  margin: 20px auto">
                        <tr>
                            <th style=" text-align: center">{$lenguaje.label_n}</th>
                            <th >Módulo</th>
                            <th style=" text-align: center">Código</th>
                            <th style=" text-align: center">Descripción</th>
                            <th style=" text-align: center">Estado</th>
                            {if $_acl->permiso("editar_rol")}
                            <th style=" text-align: center">Opciones</th>
                            {/if}
                        </tr>
                        {foreach item=rl from=$modulos}
                            <tr {if $rl.Row_Estado==0}
                                    {if $_acl->permiso("ver_eliminados")}
                                        class="btn-danger"
                                    {else}
                                        hidden {$numeropagina=$numeropagina-1}
                                    {/if}
                                {/if} >
                                <td style=" text-align: center">{$numeropagina++}</td>
                                <td>{$rl.Mod_Nombre}</td>
                                <td style=" text-align: center">{$rl.Mod_Codigo}</td>
                                <td style=" text-align: center">{$rl.Mod_Descripcion}</td>
                                
                                {if $_acl->permiso("editar_rol")}
                                <td style=" text-align: center">             
                                    {if $rl.Mod_Estado==0}
                                        <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign" title="{$lenguaje.label_deshabilitado}" style="color: #DD4B39;"/>
                                    {else}
                                        <i data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign" title="{$lenguaje.label_habilitado}" style="color: #088A08;"/>
                                    {/if}
                                </td>
                                <td style=" text-align: center">
                                    <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-modulo" title="{$lenguaje.tabla_opcion_cambiar_est}"
                                    id_modulo="{$rl.Mod_IdModulo}" estado="{$rl.Mod_Estado}"> </a>
                                    <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="{$lenguaje.tabla_opcion_editar}" href="{$_layoutParams.root}acl/index/editarModulo/{$rl.Mod_IdModulo}"> </a>
                                    <a   
                                    {if $rl.Row_Estado==0}
                                        data-toggle="tooltip" 
                                        class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-modulo" title="{$lenguaje.label_habilitar}" 
                                    {else}
                                        data-book-id="{$rl.Mod_Nombre}"
                                        data-toggle="modal"  data-target="#confirm-delete"
                                        class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-modulo" title="{$lenguaje.label_eliminar}"
                                    {/if} 
                                    id_modulo="{$rl.Mod_IdModulo}" data-placement="bottom" > </a>
                                </td>
                                {/if}
                            </tr>
                        {/foreach}
                    </table>
                </div>
                    {$paginacionmodulos|default:""}
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
                <p>Eliminar: <strong  class="nombre-es">Módulo</strong></p>
                <label id="texto_" name='texto_'></label>
                <!-- <input type='text' class='form-control' name='codigo' id='validate-number' placeholder='Codigo' required> --> 
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <a style="cursor:pointer"  data-dismiss="modal" class="btn btn-danger danger eliminar_modulo">Eliminar</a>
            </div>
        </div>
    </div>
</div>


