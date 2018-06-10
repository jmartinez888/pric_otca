<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">
        <h3 class="titulo-view"><strong>Búsqueda de Foros</strong> </h3>
        <div class="row">
            <div class="col-sm-offset-6 col-sm-6">
                <div class="input-group">
                    <input type ="text" class="form-control"  data-toggle="tooltip" data-original-title="Buscar Foro" placeholder="Buscar Foro" name="text_busqueda" id="text_busqueda" onkeypress="tecla_enter_foro(event)" value="{$palabrabuscada|default:''}">                  
                    <span class="input-group-btn">
                        <button class="btn  btn-success btn-buscador" type="button" id="buscar_foro"><i class="glyphicon glyphicon-search"></i></button>
                    </span>
                </div><!-- /input-group -->
            </div>
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            {if count($lista_foros)>0}
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>Detalles de histórico de Foro</th>
                                            <th>Fechas</th>
                                        </tr>
                                    </thead>  
                                    <tbody>
                                        {foreach from=$lista_foros item=foro}
                                            <tr>
                                                <td>
                                                    {if $foro.For_Funcion=="forum"}
                                                        Discusión
                                                    {else if  $foro.For_Funcion=="webinar"}
                                                        Webinar
                                                    {else if  $foro.For_Funcion=="worshop"}
                                                        Workshop
                                                    {else if  $foro.For_Funcion=="query"}
                                                        Consulta                                                        
                                                    {/if}
                                                    <br>
                                                    <a href="#" target="_blank">{$foro.For_Titulo}</a>                                                    
                                                    <br/>
                                                    <small>
                                                        <strong>Iniciado por:</strong> {$foro.Usu_Nombre} {$foro.Usu_Apellidos}
                                                    </small>
                                                    <br>
                                                    <small class="pull-left">
                                                        <strong>Participantes:</strong> {$foro.For_NParticipantes} 
                                                    </small>
                                                    <small class="pull-right" style="margin-right: 5px">
                                                        <strong>Comentarios:</strong> {$foro.For_NComentarios}
                                                    </small>
                                                </td>
                                                <td>
                                                    <small>
                                                        <strong>Finalizado:</strong>
                                                    </small>
                                                    {$foro.For_FechaCierre}
                                                    <br>
                                                    <a href="#">Descargar Reporte</a>
                                                </td>
                                            </tr>
                                            <!--washington-->
                                        {/foreach}
                                    </tbody>
                                </table>
                            {else}
                                <h4>No se encontraron Resultados</h4>
                            {/if}
                        </div>
                    </div>

                </div>
            </div>


        </div>

    </div>
</div>