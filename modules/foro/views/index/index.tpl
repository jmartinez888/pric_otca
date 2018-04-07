<div  class="col-md-12 col-xs-12 col-sm-6 col-lg-12" style="margin-top: 10px;" >   
    <h3 class="titulo-view">{$lenguaje.foro_index_label_titulo}</h3>
    <p style="font-size: 15px;">{$lenguaje.foro_index_label_descripcion}</p>   
    <div class="row">
        <diV class="col-md-9">
            <div class="col-md-12">
                 <h4> RECIENTES <h4>
            </div>
            <div class="col-md-12">
                {foreach from=$lista_foros item=foro}
                <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4">
                    <div class="foro-item">
                     <div class="page-header">
                        <a href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">               
                        <h4>{$foro.For_Titulo}</h4>                               
                        </a>
                    </div>
                    <div class="body-item">                          
                       <p>{$foro.For_Objetivo|truncate:120:"..."}</p>
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
            <div class="col-md-12" style="margin-top: 10px;">
                 <div class="col-md-12">
                       <h4> WEBINARS Y/O TARRERES VIRTUALES <h4>
                 </div>
               
            </div>  
        </diV>
        <div class="col-md-3">
            <div class="col-md-12">
                 <h4>AGENDA</h4>
            </div>
           


                <div class="col-md-12">
                    <div id="agenda" class="tab-pane fade in active show">

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
                              <h4 class="card-title" style="font-size: 15px;">Migración rural, agricultura y desarrollo rural</h4>                           
                              <p class="card-text" style="font-size: 12px;">OTCA</p>
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
                        <p class="card-text" style="font-size: 12px;">OTCA</p>
                            </div>
                          </div>

                        </div>
                      </a>
              </div> 
              <div class="container py-3">
                    <a href="http://www.domotexasiachinafloor.com/" class="link-tabs-jsoft">
                      <div class="row ">
                        <div class="col col-md-3" style="text-align: center;">
                          <span>VIERNES</span>    
                          <h2 class="fecha-agenda">23</h2>
                          <span>MARZO 2018</span>
                        </div>
                        <div class="col-md-9">
                            <div class="card-block px-3">
                              <h4 class="card-title" style="font-size: 15px;">Feria Internacional CHINAFLOR 2018</h4>
                             <p class="card-text" style="font-size: 12px;">OTCA</p>
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
     <div class="col-md-12">
            
        </div>
         <div class="col-md-12">
            <h1></h1>
        </div>
</div>