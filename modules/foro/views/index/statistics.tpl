<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">
        <h3 class="titulo-view"><strong>Estadísticas</strong> </h3>
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-12">
                        <div class="row">
                            {if count($lista_foros)>0}
                                <div class="panel panel-default" >
                                    <div class="panel-heading">
                                        <h3 class="panel-title">
                                            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
                                            <strong>Actividad de Foro</strong>
                                        </h3>
                                    </div>
                                    <ul class="list-group panel-body  col-md-8">
                                        <li class="list-group-item">Cras justo odio</li>
                                        <li class="list-group-item">Dapibus ac facilisis in</li>
                                        <li class="list-group-item">Morbi leo risus</li>
                                        <li class="list-group-item">Porta ac consectetur ac</li>
                                        <li class="list-group-item">Vestibulum at eros</li>
                                    </ul>

                                    <div class="panel-body col-md-4">
                                        Torta
                                    </div>
                                </div>
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