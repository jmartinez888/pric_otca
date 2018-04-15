<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}

    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">       
        <h3 class="titulo-view"><strong>{$lenguaje.foro_index_label_titulo}</strong> </h3>
        <p style="font-size: 15px;">{$lenguaje.foro_index_label_descripcion}</p>   
        <div class="row">
            <div class="col-md-9">
                <div class="row">
                    <div class="col-md-12">
                        <h4> <strong>Foros Recientes </strong></h4>
                    </div>
                    <div class="col-md-12">
                        <div class="row">
                            {foreach from=$lista_foros item=foro}
                                <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                    <div class="foro-item">
                                        <div class="page-header">
                                            <a href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">               
                                                <h4>{$foro.For_Titulo}</h4>                               
                                            </a>
                                        </div>
                                        <div class="body-item">                          
                                            <p>{$foro.For_Resumen|truncate:120:"..."}</p>
                                        </div>        
                                        <div class="footer-item row">
                                            <div class="col-md-6">
                                                {$end_date=($foro.For_FechaCierre|date_format:"%d-%m-%Y")}
                                                <span class="date">{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"} {if ($foro.For_FechaCierre|date_format:"%d-%m-%Y")!=""} / {($foro.For_FechaCierre|date_format:"%d-%m-%Y")}{/if}</span>
                                            </div>
                                            <div class="col-md-6 text-right">
                                                Colaboraciones <span class="badge">{$foro.For_TComentarios}</span> 
                                            </div>
                                        </div>               
                                    </div>

                                </div>
                            {/foreach}
                        </div>
                    </div>      
                    {if count($lista_webinars)>0}
                        <div class="col-md-12">
                            <h4> <strong>Webinars Recientes </strong></h4>
                        </div>
                        <div class="col-md-12">
                            <div class="row">
                                {foreach from=$lista_webinars item=foro}
                                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                                        <div class="foro-item">
                                            <div class="page-header">
                                                <a href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">               
                                                    <h4>{$foro.For_Titulo}</h4>                               
                                                </a>
                                            </div>
                                            <div class="body-item">                          
                                                <p>{$foro.For_Resumen|truncate:120:"..."}</p>
                                            </div>        
                                            <div class="footer-item row">
                                                <div class="col-md-6">
                                                    {$end_date=($foro.For_FechaCierre|date_format:"%d-%m-%Y")}
                                                    <span class="date">{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"} {if ($foro.For_FechaCierre|date_format:"%d-%m-%Y")!=""} / {($foro.For_FechaCierre|date_format:"%d-%m-%Y")}{/if}</span>
                                                </div>
                                                <div class="col-md-6 text-right">
                                                    Participantes <span class="badge">{$foro.For_TParticipantes}</span> 
                                                </div>
                                            </div>               
                                        </div>

                                    </div>
                                {/foreach}
                            </div>
                        </div>  
                    {/if}
                </div>
            </div>
            <div class="col-md-3">
                <div class="row">
                    <div class="col-md-12">
                        <h4> <strong>Agenda</strong></h4>
                    </div>
                    <div class="col-md-12">
                        <div id="agenda" class="tab-pane fade in active show" style="max-height: 500px;">
                            <div class="container py-3">
                                <a href="#" class="link-tabs-jsoft">
                                    <div class="row ">
                                        <div class="col col-md-3" style="text-align: center;">
                                            <span>JUEVES</span>    
                                            <h2 class="fecha-agenda">29</h2>
                                            <span>MARZO 2018</span>
                                        </div>
                                        <div class="col-md-9">
                                            <div class="card-block px-3">
                                                <h4 class="card-title" style="font-size: 15px;">Foro sobre áreas forestales</h4>
                                                <p class="card-text" style="font-size: 13px;">Hora: 4:00pm</p>
                                                <p class="card-text" style="font-size: 13px;">Lugar: Auditorio BIOINFO - IIAP</p>
                                            </div>
                                        </div>

                                    </div>
                                </a>
                            </div> 
                            <div class="container py-3">
                                <a href="#" class="link-tabs-jsoft">
                                    <div class="row ">
                                        <div class="col col-md-3" style="text-align: center;">
                                            <span>LUNES</span>    
                                            <h2 class="fecha-agenda">19</h2>
                                            <span>MARZO 2018</span>
                                        </div>
                                        <div class="col-md-9">
                                            <div class="card-block px-3">
                                                <h4 class="card-title" style="font-size: 15px;">Foro sobre áreas forestales</h4>
                                                <p class="card-text" style="font-size: 13px;">Hora: 4:00pm</p>
                                                <p class="card-text" style="font-size: 13px;">Lugar: Auditorio BIOINFO - IIAP</p>
                                            </div>
                                        </div>

                                    </div>
                                </a>
                            </div> 
                            <div class="container py-3">
                                <a href="#" class="link-tabs-jsoft">
                                    <div class="row ">
                                        <div class="col col-md-3" style="text-align: center;">
                                            <span>VIERNES</span>    
                                            <h2 class="fecha-agenda">23</h2>
                                            <span>MARZO 2018</span>
                                        </div>
                                        <div class="col-md-9">
                                            <div class="card-block px-3">
                                                <h4 class="card-title" style="font-size: 15px;">Feria Internacional CHINAFLOR 2018</h4>
                                                <p class="card-text" style="font-size: 13px;">Hora: 4:00pm</p>
                                                <p class="card-text" style="font-size: 13px;">Lugar: Auditorio BIOINFO - IIAP</p>
                                            </div>
                                        </div>

                                    </div>
                                </a>
                            </div>    
                            <a href="#" class="mas-jsoft">VER MÁS</a>         

                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>
</div>