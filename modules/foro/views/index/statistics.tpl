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
                <h4><i class="fa fa-bar-chart-o fa-fw"></i>Comentarios por mes</h4>
                <div id="container" style="min-width: 310px; height: 400px; margin: 0 auto">
                    
                </div>
            </div>   
            <div class="col-md-5">             
                <h4><i class="fa fa-folder-o fa-fw"></i>Temáticas</h4>              
                <div class="list-group">
                    <a href="#" class="list-group-item">
                        <i class="fa fa-comment fa-fw"></i> New Comment
                        <span class="pull-right text-muted small"><em>4 minutes ago</em>
                        </span>
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fa fa-twitter fa-fw"></i> 3 New Followers
                        <span class="pull-right text-muted small"><em>12 minutes ago</em>
                        </span>
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fa fa-envelope fa-fw"></i> Message Sent
                        <span class="pull-right text-muted small"><em>27 minutes ago</em>
                        </span>
                    </a>            
                </div>
                <h4><i class="fa fa-folder-o fa-fw"></i>Actividades</h4>  
                <div class="list-group">
                    <a href="#" class="list-group-item">
                        <i class="fa fa-upload fa-fw"></i> Server Rebooted
                        <span class="pull-right text-muted small"><em>11:32 AM</em>
                        </span>
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fa fa-bolt fa-fw"></i> Server Crashed!
                        <span class="pull-right text-muted small"><em>11:13 AM</em>
                        </span>
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fa fa-warning fa-fw"></i> Server Not Responding
                        <span class="pull-right text-muted small"><em>10:57 AM</em>
                        </span>
                    </a>
                    <a href="#" class="list-group-item">
                        <i class="fa fa-shopping-cart fa-fw"></i> New Order Placed
                        <span class="pull-right text-muted small"><em>9:49 AM</em>
                        </span>
                    </a>                   
                </div>
            </div>  
            <div class="col-md-12">
                <h4><i class="fa fa-map-o fa-fw"></i>Miembros por país</h4>  
                <div id="container_map"></div>
            </div>

        </div>

    </div>
</div>
<script>
    data_char = JSON.parse('{$StdCharComentarios}');
</script>
