<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">
        <h3 class="titulo-view"><strong>Estadísticas</strong> </h3>
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-3">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-xs-2">
                                        <i class="fa fa-users fa-4x"></i>                                    
                                    </div>    
                                    <div class="col-xs-10 text-right">
                                        <div class="stat-count">{$StdGeneral.Est_CantidadMiembros|default:0}</div>
                                        <div class="stat-title-min">Miembros</div>
                                    </div>
                                </div>
                            </div>                           
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-xs-2">
                                        <i class="fa fa-file-text fa-4x"></i>                                    
                                    </div>    
                                    <div class="col-xs-10 text-right">
                                        <div class="stat-count">{$StdGeneral.Est_CantidadForo|default:0}</div>
                                        <div class="stat-title-min">Temas</div>
                                    </div>
                                </div>
                            </div>                           
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-xs-2">
                                        <i class="fa fa-comments fa-4x"></i>                                    
                                    </div>    
                                    <div class="col-xs-10 text-right">
                                        <div class="stat-count">{$StdGeneral.Est_CantidadComentario|default:0}</div>
                                        <div class="stat-title-min">Comentarios</div>
                                    </div>
                                </div>
                            </div>                           
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="panel panel-default">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-xs-2">
                                        <i class="fa fa-eye fa-4x"></i>                                    
                                    </div>    
                                    <div class="col-xs-10 text-right">
                                        <div class="stat-count">{$StdGeneral.Est_CantidadVisita|default:0}</div>
                                        <div class="stat-title-min">Visitas</div>
                                    </div>
                                </div>
                            </div>                           
                        </div>
                    </div>

                </div>                
            </div>
            <div class="col-md-7">
                <h4><i class="fa fa-bar-chart-o fa-fw"></i> Comentarios por mes</h4>
                <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto">
                    
                </div>
            </div>   
            <div class="col-md-5">             
                <h4><i class="fa fa-folder-o fa-fw"></i> Temáticas</h4>              
                <div class="list-group">
                    <a href="#" class="list-group-item">
                        <i class="fa fa-folder fa-fw"></i> Recursos Forestales 
                        <span class="pull-right text-muted text-medium"> <strong> <em>36</em></strong>
                        </span>
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fa fa-folder fa-fw"></i> Cites y su uso
                        <span class="pull-right text-muted "><strong> <em>65</em></strong>
                        </span>
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fa fa-folder fa-fw"></i> Bosques
                        <span class="pull-right text-muted text-medium"><strong> <em>23</em></strong>
                        </span>
                    </a>            
                </div>
                <h4><i class="fa fa-folder-o fa-fw"></i> Actividades</h4>  
                  <div class="list-group">
                {foreach from=$StdActividades item=actividad}
                    <a href="{$_layoutParams.root}foro/index/{$actividad.For_Funcion}" class="list-group-item">
                        <i class="fa fa-folder fa-fw"></i>
                        {if $actividad.For_Funcion=="forum"}
                        Discusiones
                        {else if $actividad.For_Funcion=="query"}
                        Consultas
                        {else if $actividad.For_Funcion=="webinar"}
                        Webinar
                        {else if $actividad.For_Funcion=="workshop"}
                        Workshop
                        {/if}
                        <span class="pull-right text-muted text-medium"><strong> <em>{$actividad.For_CantidadForo|default:0}</em></strong>
                        </span>
                    </a>
                {/foreach}
                 </div>
            </div>  
            <div class="col-md-12">
                <h4><i class="fa fa-map-o fa-fw"></i> Miembros por pais
                <div id="container_map"></div>
            </div>

        </div>

    </div>
</div>
<script>
    data_char = JSON.parse('{$StdCharComentarios}');
</script>
