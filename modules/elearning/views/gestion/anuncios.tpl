<div class="col-lg-12">
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-9" style="margin-top: 20px">
     {if  $tipo==0}
    <div class="panel panel-default">
        <div class="panel-heading jsoftCollap">
            <h3 aria-expanded="false" data-toggle="collapse" href="#collapse3" class="panel-title collapsed"><i style="float:right" class="fa fa-ellipsis-v"></i><i class="fa fa-user-plus"></i>&nbsp;&nbsp;<strong>Nuevo Anuncio</strong></h3>
        </div>
        <div style="height: 0px;" aria-expanded="false" id="collapse3" class="panel-collapse collapse">
            <div class="panel-body">
                <div id="nuevoRegistro">
                    <div style="width: 90%; margin: 0px auto">                        
                        <form class="form-horizontal" id="form1" role="form" data-toggle="validator" method="post" action="" autocomplete="on">
<!--                            <input type="hidden" value="1" name="enviar" />-->                           
                            <div class="form-group">
                                    
                                <label class="col-lg-3 control-label">Titulo : </label>
                                <div class="col-lg-8">
                                    <input class="form-control" id ="titulo" type="text" name="titulo" value="{$datos.nombre|default:""}" placeholder="Titulo" required=""/>
                                </div>
                            </div>
                                
                            <div class="form-group">
                                <label class="col-lg-3 control-label" >Descripción : </label>
                                <div class="col-lg-8">
                                    <textarea class="form-control" id ="descripcion" type="text" name="descripcion" placeholder="Descripción" required=""  rows="5">{$datos.apellidos|default:""}</textarea>
                                </div>
                            </div>
                                
                            
                            <div class="form-group">
                                <div class="col-lg-offset-2 col-lg-8">
                                <button class="btn btn-success" id="bt_guardar" name="bt_guardar" type="submit" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; Guardar</button>
                                </div>
                            </div>
                        </form>
                    </div>        
                </div>
            </div>
        </div>
    </div>
    {/if}


     <div class="panel-body" style=" margin: 15px">
        <input type="hidden" name="idCurso" value="{$id}" id="idCurso">
             <div class="row" style="text-align:right">
                <div style="display:inline-block;padding-right:2em">
                    <input class="form-control" placeholder="Buscar anuncio" style="width: 150px; float: left; margin: 0px 10px;" name="palabraanuncio" id="palabraanuncio">
                    <button class="btn btn-success" style=" float: left" type="button" id="buscaranuncio"  ><i class="glyphicon glyphicon-search"></i></button>
                </div>
            </div>

                <input type="hidden" name="tipo" id="tipo" value="{if $tipo==0}0{else}1{/if}">
            <div id="listaranuncios">
                {if isset($anuncios) && count($anuncios)}
                <div class="table-responsive">
                    <table class="table" style="  margin: 20px auto">
                        <tr>
                            <th style=" text-align: center">Nº</th>
                            <th style=" text-align: center">Titulo</th>
                            <th style=" text-align: center">Descripción</th>
                            <th style=" text-align: center">Fecha</th>
                            {if $tipo==0}
                             <th style=" text-align: center">Estado</th>
                            {if $_acl->permiso("editar_rol")}
                            <th style=" text-align: center">Opciones</th>
                            {/if}
                            {/if}
                        </tr>
                        {foreach item=rl from=$anuncios}
                        {if $tipo==0}
                            <tr {if $rl.Row_Estado==0}
                                        {if $_acl->permiso("ver_eliminados")}
                                            class="btn-danger"
                                        {else}
                                            hidden {$numeropagina = $numeropagina-1}
                                        {/if}
                                    {/if} >
                                <td style=" text-align: center">{$numeropagina++}</td>
                                <td style=" text-align: center">{$rl.Anc_Titulo}</td>
                                <td style=" text-align: center">{$rl.Anc_DescripcionRec}...</td>
                                <td style=" text-align: center">{$rl.Anc_FechaReg}</td>
                                 <td style=" text-align: center">
                                        {if $rl.Anc_Estado==0}
                                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="{$lenguaje.label_denegado}" style="color: #DD4B39;"></p>
                                        {/if}                            
                                        {if $rl.Anc_Estado==1}
                                            <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="{$lenguaje.label_habilitado}" style="color: #088A08;"></p>
                                        {/if}
                                    </td>

                               {if $_acl->permiso("editar_rol")}
                                    <td style=" text-align: center">
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-anuncio" title="{$lenguaje.tabla_opcion_cambiar_est}" id_anuncio="{$rl.Anc_IdAnuncioCurso}" estado="{$rl.Anc_Estado}"> </a>
                                        
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="Editar" href="{$_layoutParams.root}elearning/gestion/editarAnuncios/{$rl.Anc_IdAnuncioCurso}"></a>

                                        <!-- <button class="btn" id="bt_guardar" name="bt_enviar" type="submit" ><i class="glyphicon glyphicon-envelope"> </i></button> -->

                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-envelope" title="Enviar email" href="{$_layoutParams.root}anuncios/gestion/enviarEmailAnuncios/{$rl.Anc_IdAnuncioCurso}/elearning"></a>

                                         <a   
                                        {if $rl.Row_Estado==0}
                                            data-toggle="tooltip" 
                                            class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-anuncio" title="{$lenguaje.label_habilitar}" 
                                        {else}
                                            data-book-id="{$rl.Anc_Titulo}"
                                            data-toggle="modal"  data-target="#confirm-delete"
                                            class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-anuncio" title="{$lenguaje.label_eliminar}"
                                        {/if} 
                                        id_anuncio="{$rl.Anc_IdAnuncioCurso}" data-placement="bottom" > </a>

                                    </td>
                                    {/if}
                            </tr>
                            {else}

                               
                                <tr >

                                <td style=" text-align: center"> <a data-book-id="{$rl.Anc_Titulo}" data-book-texto="{$rl.Anc_Descripcion}"
                                            data-toggle="modal"  data-target="#confirm-leer"
                                            title="{$lenguaje.label_eliminar}"
                                        data-book-id-anuncio="{$rl.Anc_IdAnuncioCurso}" data-book-id-curso="{$rl.Cur_IdCurso}" data-placement="bottom" > {if $rl.Anu_Leido==0}<b>{/if}{$numeropagina++}{if $rl.Anu_Leido==0}</b>{/if}</a></td>
                                <td style=" text-align: center"> <a data-book-id="{$rl.Anc_Titulo}" data-book-texto="{$rl.Anc_Descripcion}"
                                            data-toggle="modal"  data-target="#confirm-leer"
                                            title="{$lenguaje.label_eliminar}"
                                        data-book-id-anuncio="{$rl.Anc_IdAnuncioCurso}" 
                                        data-book-id-curso="{$rl.Cur_IdCurso}"
                                        data-placement="bottom" > {if $rl.Anu_Leido==0}<b>{/if}{$rl.Anc_Titulo}{if $rl.Anu_Leido==0}</b>{/if}</a></td>
                                <td style=" text-align: center"> <a data-book-id="{$rl.Anc_Titulo}" data-book-texto="{$rl.Anc_Descripcion}"
                                            data-toggle="modal"  data-target="#confirm-leer"
                                            title="{$lenguaje.label_eliminar}"
                                        data-book-id-anuncio="{$rl.Anc_IdAnuncioCurso}" 
                                        data-book-id-curso="{$rl.Cur_IdCurso}"
                                        data-placement="bottom" > {if $rl.Anu_Leido==0}<b>{/if}{$rl.Anc_DescripcionRec}...{if $rl.Anu_Leido==0}</b>{/if}</a></td>
                                <td style=" text-align: center"> <a data-book-id="{$rl.Anc_Titulo}" data-book-texto="{$rl.Anc_Descripcion}"
                                            data-toggle="modal"  data-target="#confirm-leer"
                                            title="{$lenguaje.label_eliminar}"
                                        data-book-id-anuncio="{$rl.Anc_IdAnuncioCurso}" 
                                        data-book-id-curso="{$rl.Cur_IdCurso}"
                                        data-placement="bottom" > {if $rl.Anu_Leido==0}<b>{/if}{$rl.Anc_FechaReg}{if $rl.Anu_Leido==0}</b>{/if}</a></td>
                                </tr>
                                
                            {/if}
                        {/foreach}
                    </table>
                </div>
                    {$paginacionanuncios|default:""}
                {else}
                    No hay registros
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
                <p>Eliminar: <strong  class="nombre-es">Anuncio</strong></p>
                <label id="texto_" name='texto_'></label>
                <!-- <input type='text' class='form-control' name='codigo' id='validate-number' placeholder='Codigo' required> --> 
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <a style="cursor:pointer"  data-dismiss="modal" class="btn btn-danger danger eliminar_anuncio">Eliminar</a>
            </div>
        </div>
    </div>
</div>

<div class="modal " id="confirm-leer" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="titulo_" name='titulo_'>Anuncio</h4>
            </div>
            <div class="modal-body">
                <!-- <p> <strong  class="nombre-es"><label id="titulo_" name='titulo_'></label></strong></p> -->
                <label id="texto_" name='texto_'></label>
                <!-- <input type='text' class='form-control' name='codigo' id='validate-number' placeholder='Codigo' required> --> 
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Volver</button>
            </div>
        </div>
    </div>
</div>
