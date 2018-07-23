<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">       
        <h3 class="titulo-view titulo"><strong>{$lenguaje.foro_index_label_titulo}</strong> </h3>
        <p class="descripcion-foro">{$lenguaje.foro_index_label_descripcion}</p>   
        
        <div class="row">
            <div class="col-lg-12">
                <hr class="cursos-hr">
            </div>
            <div class="col-sm-12">
                <div class="input-group">
                    <input type ="text" class="form-control"  data-toggle="tooltip" data-original-title="Buscar Foro" placeholder="Buscar Foro" name="text_busqueda" id="text_busqueda" onkeypress="tecla_enter_foro(event)" value="{$palabrabuscada|default:''}">                  
                    <span class="input-group-btn">
                        <button class="btn  btn-success btn-buscador" type="button" id="buscar_foro"><i class="glyphicon glyphicon-search"></i></button>
                    </span>
                </div><!-- /input-group -->
            </div>  
            <div class="col-md-8">
                <div class="row">
                    
                    <div class="col-md-12">
                        <h3 class="subtitle-foro">Temáticas</h3>
                    </div>
                    <div class="col-md-12">
                        <hr class="cursos-hr">
                    </div>
                    <div class="col-md-12">
                        {foreach from=$lista_tematica item=tematica}
                            {if $tematica.Lit_Discussions!="" || $tematica.Lit_Query!=""|| $tematica.Lit_Webinar!=""|| $tematica.Lit_Workshop!=""}
                            <div class="col-md-6 tematica-foro margin-r-0">
                            <div class="row tem_titulo"><a class="link-foro" href="#"><h4>{$tematica.Lit_Nombre}</h4></a></div>
                         <div class="row detalles-tematica">
                                    {if $tematica.Lit_Discussions!=""}
                                    <div class="col-md-4 item-tematica">Discusiones: {$tematica.Lit_Discussions}</div> 
                                    {/if}
                                    {if $tematica.Lit_Query!=""}
                                    <div class="col-md-6 item-tematica">Consultas: {$tematica.Lit_Query}</div>  
                                    {/if}
                                    {if $tematica.Lit_Webinar!=""}
                                    <div class="col-md-4 item-tematica">Webinars: {$tematica.Lit_Webinar}</div> 
                                    {/if}
                                    {if $tematica.Lit_Workshop!=""}
                                    <div class="col-md-6 item-tematica">Workshop: {$tematica.Lit_Workshop}</div> 
                                    {/if}
                                    
                            <div class="row col-md-12 margin-t-5">
                              {$tematica.Lit_Members|default:0} Miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$tematica.Lit_Comentarios|default:0} Comentario(s) &nbsp;&nbsp;
                            </div>
                         </div>
                        </div>
                         {/if}
                        {/foreach}
                    </div>
                    <div class="col-lg-12"><br></div>

                    <div class="col-md-12">
                        <h3 class="subtitle-foro">Actividad reciente</h3>
                    </div>
                    <div class="col-lg-12">
                        <hr class="cursos-hr">
                    </div>
                    <div class="col-lg-12">
                        {foreach from=$lista_foros item=foro}
                        <div class="row col-lg-12 tematica-foro">
                            <div><a class="link-foro"  href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
                                    <h4 style="text-align: justify;">{$foro.For_Titulo}</h4></a></div>
                                    {if !empty($foro.For_Resumen) && $foro.For_Resumen!=""}
                                    <div style="padding-bottom: 10px;">
                                         <p style="text-align: justify;">{$foro.For_Resumen|truncate:120:"..."}</p>
                                    </div>
                                    {/if}
                                    <div class="detalles-act-reciente">{$foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace 1 mes &nbsp;&nbsp;-&nbsp;&nbsp; 3 votos &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.For_TParticipantes|default:0} miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp;{$foro.For_TComentarios|default:0} comentario(s)</div>
                        </div>
                        {/foreach}
                    </div>
                    <div class="col-lg-12"><br></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="subtitle-foro">Agenda</h3>
                    </div>
                    <div class="col-lg-12">
                        <hr class="cursos-hr">
                    </div>
                    <div class="col-md-12">
                        <div class="tab-pane fade in active show agenda-container">
                             {foreach from=$lista_agenda item=agenda}
                            <div class="contenedor-link-agenda">
                                <a href="#" class="link-tabs-jsoft" style="padding-top: 30px;">
                                    <div class="row ">
                                        <div class="col-md-4 fecha-agenda">
                                            <div class="text-uppercase" style="font-size: 13px;">{($agenda.For_FechaCreacion|date_format:"%A"|utf8_encode)|substr:0:4}</div>    
                                            <div style="font-size: 21px;"><strong>29</strong></div>
                                            <div class="text-uppercase" style="font-size: 13px;">{$agenda.For_FechaCreacion|date_format:"%B %Y"}</div>
                                        </div>
                                        <div class="col-md-8">
                                            <div class="card-block px-3">
                                                <h4 class="card-title" style="font-size: 17px;">{$agenda.For_Titulo|truncate:50:"..."}</h4>
                                                <p class="card-text" style="font-size: 13px;">
                                                <i class="glyphicon glyphicon-time"></i>
                                                {$agenda.For_FechaCreacion|date_format:"%d.%M.%Y %H:%M"}</p>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div> 
                             {/foreach}
                            
                            <a href="#" class="mas-jsoft">VER MÁS</a>         

                        </div>
                    </div>
                </div>
            </div>

        </div>

    </div>
</div>