<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">
        <h3 class="titulo-view titulo"><strong>Histórico</strong> </h3>
        <div class="row">
            <div class="col-md-12">
                                                    <br>                                                   
                
                {if count($lista_foros)>0}
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Detalles de histórico de Foro</th>
                                <th>Foro Fechas</th>
                            </tr>
                        </thead>  
                        <tbody>
                            {foreach from=$lista_foros item=foro}
                                <tr>
                                    <td>
                                         <a class="link-foro" href="#" target="_blank"><h4 style="text-align: justify;">{$foro.For_Titulo}</h4></a>

                                        <div style="padding-bottom: 10px;">{if $foro.For_Funcion=="forum"}
                                            Discusión
                                        {else if  $foro.For_Funcion=="webinar"}
                                            Webinar
                                        {else if  $foro.For_Funcion=="worshop"}
                                            Workshop
                                        {else if  $foro.For_Funcion=="query"}
                                            Consulta                                                        
                                        {/if}</div>

                                        <small>
                                            <strong>Iniciado por:</strong> {$foro.Usu_Nombre} {$foro.Usu_Apellidos}
                                        </small>
                                        <br>
                                        <small class="pull-left">
                                            <strong>Participantes:</strong> {$foro.For_TParticipantes} 
                                        </small>
                                        <small class="pull-right" style="margin-right: 5px">
                                            <strong>Comentarios:</strong> {$foro.For_TComentarios}
                                        </small>
                                    </td>
                                    <td>
                                        <small>
                                            <strong>Finalizado:</strong>
                                        </small>
                                        {$foro.For_FechaCierre}
                                        <br>
                                        <a class="reporte" href="#">Descargar Reporte</a>
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