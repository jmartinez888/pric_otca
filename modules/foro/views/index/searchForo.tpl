<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">
        <h3 class="titulo"><strong>Búsqueda de Foros</strong> </h3>
        <div class="col-lg-12 p-rt-lt-0">
            <hr class="cursos-hr-title-foro">
        </div>
        <div class="row">
            <div class="col-sm-offset-6 col-sm-6">
                <div class="input-group">
                    <input type ="text" class="form-control"  data-toggle="tooltip" data-original-title="Buscar Foro" placeholder="Buscar Foro" name="text_busqueda" id="text_busqueda" onkeypress="tecla_enter_foro(event)" value="{$palabrabuscada|default:''}">                  
                    <span class="input-group-btn">
                        <button class="btn  btn-success btn-buscador" type="button" id="buscar_foro"><i class="glyphicon glyphicon-search"></i></button>
                    </span>
                </div><!-- /input-group -->
            </div>
            <div class="col-md-12" style="margin-top: 15px;">
                <div class="">
                    <div class="col-md-12">
                        <div class="row">
                            {if count($lista_foros)>0}                             
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th style="border-top: 1px solid #ddd;"><h4>Detalles de resultado</h4></th>
                                            <th style="border-top: 1px solid #ddd;"><h4>Fechas</h4></th>
                                        </tr>
                                    </thead>  
                                    <tbody>
                                        {foreach from=$lista_foros item=foro}
                                            <tr>
                                                <td class="col-xs-10">                
                                                    <h4><a class="simulalink" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}" target="_blank"><strong>{$foro.For_Titulo}</strong></a></h4>

                                                    <a class="simulalink" style="color: black; text-align: justify;" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}" target="_blank">{$foro.For_Resumen}</a>    
                                                    <br>                      
                                                    <small>
                                                        <strong>Iniciado por:</strong> {$foro.Usu_Usuario} 
                                                    </small>
                                                    <br/>                                                   
                                                    <small class="pull-left">
                                                        <strong>Participantes:</strong> {$foro.For_NParticipantes} 
                                                    </small>
                                                    <small class="pull-right" style="margin-right: 5px">
                                                        <strong>Comentarios:</strong> {$foro.For_NComentarios}
                                                    </small>
                                                    <br>
                                                    <em>
                                                    {if $foro.For_Funcion=="forum"}
                                                        Discusión
                                                    {else if  $foro.For_Funcion=="webinar"}
                                                        Webinar
                                                    {else if  $foro.For_Funcion=="worshop"}
                                                        Workshop
                                                    {else if  $foro.For_Funcion=="query"}
                                                        Consulta                                                        
                                                    {/if}
                                                    </em>
                                                </td>
                                                <td class="col-xs-2">
                                                    <small>
                                                        <strong>Iniciado:</strong>
                                                    </small>
                                                    <br>
                                                    <i class="glyphicon glyphicon-calendar"></i>
                                                    {$foro.For_FechaCreacion}
                                                    <br>
                                                    {if !empty($foro.For_FechaCierre) && $foro.For_FechaCierre!=""}
                                                     <small>
                                                        <strong>Finalizado:</strong>
                                                    </small>
                                                     <br>
                                                     <i class="glyphicon glyphicon-calendar"></i>
                                                     {$foro.For_FechaCierre}
                                                     {/if}
                                                    
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