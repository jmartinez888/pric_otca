{if $from=='elearning'}
<div class="col-lg-12">
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-10" style="margin-top: 20px">
{/if}
        <div class="panel panel-default">
            <div class="panel-heading ">
                <h3 class="panel-title "><i style="float:right"class="fa fa-ellipsis-v"></i><i class="fa fa-user-secret"></i>&nbsp;&nbsp;<strong>Enviar Email</strong></h3>
            </div>
                        <div class="panel-body">   
                <form method="POST">                       
                    <div class="form-group ">
                       <!--  <div class="well-sm col-sm-12">
                            <div id="botones" class="btn-group pull-right">
                                <button type="submit" id="export_data_excel" name="export_data_excel" class="btn btn-info">IMPORTAR EXCEL</button>
                            </div>
                        </div> -->
                        <div class="col-xs-3">
                            <input class="form-control" placeholder="{$lenguaje.text_buscar_usuario}"  name="palabra" id="palabra">                        
                        </div>
                        <button class=" btn btn-primary" type="button" id="buscar"  ><i class="glyphicon glyphicon-search"></i></button>
                    </div>
                <div style="margin: 15px 25px">
                <h4 class="panel-title"> <b>{$lenguaje.usuarios_buscar_tabla_titulo}</b></h4>
                    <div id="listaregistros">
                        {if isset($usuarios) && count($usuarios)}
                            <div class="table-responsive" >
                                <table class="table" style=" text-align: center">
                                    <tr >
                                        <th style=" text-align: center">{$lenguaje.label_n}</th>
                                        <th style=" text-align: center">Nombres y Apellidos</th>
                                        <th style=" text-align: center">Seleccionar</th>
                                    </tr>
                                    {$cont=1}
                                    {foreach from=$usuarios item=us}
                                        <tr>
                                            <td>{$numeropagina++}</td>
                                            <td>{$us.Usu_Nombre} {$us.Usu_Apellidos}</td>                
                                            <td >
                                                <input type="checkbox" name="usu{$cont}" value="{$us.Usu_IdUsuario}">
                                                {$cont=$cont+1}
                                            </td>                                            
                                        </tr>
                                    {/foreach}
                                </table>
                            </div>
                        {else}
                            {$lenguaje.no_registros}
                        {/if}                        
                    </div>
                </div>
                <div class="form-group ">
                        <div class="col-xs-6 col-sm-2 col-lg-offset-2 col-lg-2">
                            <div id="botones" class="btn-group pull-right">
                                <button type="submit" id="enviar" name="enviar" class="btn btn-info">Enviar</button>
                            </div>
                        </div>
                            <div class="col-xs-6 col-sm-offset-1 col-sm-2 col-lg-2">
                                <button class="btn btn-danger" type="submit" id="bt_cancelarEditarAnuncio" name="bt_cancelarEditarAnuncio" ><i class="glyphicon glyphicon-remove"> </i>&nbsp; {$lenguaje.button_cancel}</button>
                            </div>
                    </div>

                </form>
            </div>    
                </div>
                {if $from=='elearning'}
            </div>
        </div>
        {/if}