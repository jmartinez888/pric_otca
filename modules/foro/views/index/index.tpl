<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}

    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">       
        <h3 class="titulo"><strong>{$lenguaje.foro_index_label_titulo}</strong> </h3>
        <div class="col-lg-12 p-rt-lt-0">
            <hr class="cursos-hr-title-foro">
        </div>
        <p class="descripcion-foro">{$lenguaje.foro_index_label_descripcion}</p>   
        
        <div class="row">
            <div class="col-md-8">
                <div class="row">
                    <div class="col-md-12">
                        <div class="input-group">
                            <input type ="text" class="form-control"  data-toggle="tooltip" data-original-title="Buscar Foro" placeholder="Buscar Foro" name="text_busqueda" id="text_busqueda" onkeypress="tecla_enter_foro(event)" value="{$palabrabuscada|default:''}">                  
                            <span class="input-group-btn">
                                <button class="btn  btn-success btn-buscador" type="button" id="buscar_foro"><i class="glyphicon glyphicon-search"></i></button>
                            </span>
                        </div><!-- /input-group -->
                    </div>                    

                    <div class="col-md-12">
                        <h3 class="subtitle-foro"><strong>Temáticas</strong></h3>
                    </div>
                    <div class="col-md-12">
                        <hr class="cursos-hr-title-foro">
                    </div>
                    <div class="col-md-12">
                        {foreach from=$lista_tematica item=tematica}
                            {if $tematica.Lit_Discussions!="" || $tematica.Lit_Query!=""|| $tematica.Lit_Webinar!=""|| $tematica.Lit_Workshop!=""}
                        <div class="col-md-6 tematica-foro margin-r-0">
                            <div class="row tem_titulo"><a class="link-foro" href="{$_layoutParams.root}foro/index/searchForo/{trim($tematica.Lit_Nombre)}"><h4><strong>{$tematica.Lit_Nombre}</strong></h4></a></div>
                            <div class="row detalles-tematica">
                                {if $tematica.Lit_Discussions!=""}
                                <div class="col-md-4 item-tematica"><a class="simulalink underline" href="{$_layoutParams.root}foro/index/discussions">Discusiones: {$tematica.Lit_Discussions}</a></div>
                                {/if}
                                {if $tematica.Lit_Query!=""}
                                <div class="col-md-6 item-tematica"><a class="simulalink underline" href="{$_layoutParams.root}foro/index/query">Consultas: {$tematica.Lit_Query}</a></div>  
                                {/if}
                                {if $tematica.Lit_Webinar!=""}
                                <div class="col-md-4 item-tematica"><a class="simulalink underline" href="{$_layoutParams.root}foro/index/webinar">Webinars: {$tematica.Lit_Webinar}</a></div> 
                                {/if}
                                {if $tematica.Lit_Workshop!=""}
                                <div class="col-md-6 item-tematica"><a class="simulalink underline" href="{$_layoutParams.root}foro/index/workshop">Workshop: {$tematica.Lit_Workshop}</a></div> 
                                {/if}
                                
                                <div class="row col-md-12 margin-t-5">
                                {$tematica.Lit_Members|default:0} Miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$tematica.Lit_Comentarios|default:0} Comentario(s)
                                </div>
                            </div>
                        </div>
                         {/if}
                        {/foreach}
                    </div>
                    <div class="col-lg-12"><br></div>

                    <div class="col-md-12">
                        <h3 class="subtitle-foro"><strong>Actividad reciente</strong></h3>
                    </div>
                    <div class="col-lg-12">
                        <hr class="cursos-hr-title-foro">
                    </div>
                    <div class="col-lg-12">
                        {foreach from=$lista_foros item=foro}
                        <div class="row col-lg-12 tematica-foro">
<<<<<<< HEAD
                            {if $foro.For_Tipo == 1}
                                {if $foro.For_Estado != 0 && $foro.Row_Estado == 1} 
                                    <div><a class="link-foro"  href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
                                    <h4 style="text-align: justify;">{$foro.For_Titulo}</h4></a></div>
=======
                            <div><a class="link-foro"  href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
                                    <h4 style="text-align: justify;"><strong>{$foro.For_Titulo}</strong></h4></a></div>
>>>>>>> aa976114709e62ef61ecd6a0583628fa8063e3f5
                                    {if !empty($foro.For_Resumen) && $foro.For_Resumen!=""}
                                    <div style="padding-bottom: 10px;">
                                         <p style="text-align: justify;">{$foro.For_Resumen|truncate:120:"..."}</p>
                                    </div>
                                    {/if}
                                    <div class="detalles-act-reciente">{$foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace {$foro.tiempo} &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.votos} voto(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.For_TParticipantes|default:0} miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp;{$foro.For_TComentarios|default:0} comentario(s)</div>
                                {else}
                                    {if $foro.Row_Estado == 1}
                                        {if $Rol_Ckey == "lider_foro" || $Rol_Ckey == "moderador_foro" || $Rol_Ckey == "facilitador_foro" || $Rol_Ckey == "administrador_foro" || $Rol_Ckey == "administrador"}
                                        <div><a class="link-foro"  href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
                                        <h4 style="text-align: justify;">{$foro.For_Titulo}</h4></a></div>
                                        {if !empty($foro.For_Resumen) && $foro.For_Resumen!=""}
                                        <div style="padding-bottom: 10px;">
                                             <p style="text-align: justify;">{$foro.For_Resumen|truncate:120:"..."}</p>
                                        </div>
                                        {/if}
                                        <div class="detalles-act-reciente">{$foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace {$foro.tiempo} &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.votos} voto(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.For_TParticipantes|default:0} miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp;{$foro.For_TComentarios|default:0} comentario(s)</div>
                                        {/if}
                                    {else}
                                        {if $Rol_Ckey == "administrador_foro" || $Rol_Ckey == "administrador"}
                                        <div><a class="link-foro"  href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
                                        <h4 style="text-align: justify;">{$foro.For_Titulo}</h4></a></div>
                                        {if !empty($foro.For_Resumen) && $foro.For_Resumen!=""}
                                        <div style="padding-bottom: 10px;">
                                             <p style="text-align: justify;">{$foro.For_Resumen|truncate:120:"..."}</p>
                                        </div>
                                        {/if}
                                        <div class="detalles-act-reciente">{$foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace {$foro.tiempo} &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.votos} voto(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.For_TParticipantes|default:0} miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp;{$foro.For_TComentarios|default:0} comentario(s)</div>
                                        {/if}  
                                    {/if}
                                {/if}                                  
                            {else}
                                {if $foro.For_Estado != 0 && $foro.Row_Estado == 1 && ($Rol_Ckey == "lider_foro" || $Rol_Ckey == "moderador_foro" || $Rol_Ckey == "facilitador_foro" || $Rol_Ckey == "administrador_foro" || $Rol_Ckey == "administrador" || $Rol_Ckey == "participante_foro")} 
                                    <div><a class="link-foro"  href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
                                    <h4 style="text-align: justify;">{$foro.For_Titulo}</h4></a></div>
                                    {if !empty($foro.For_Resumen) && $foro.For_Resumen!=""}
                                    <div style="padding-bottom: 10px;">
                                         <p style="text-align: justify;">{$foro.For_Resumen|truncate:120:"..."}</p>
                                    </div>
                                    {/if}
                                    <div class="detalles-act-reciente">{$foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace {$foro.tiempo} &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.votos} voto(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.For_TParticipantes|default:0} miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp;{$foro.For_TComentarios|default:0} comentario(s)</div>
                                {else}
                                    {if $foro.Row_Estado == 1}
                                        {if $Rol_Ckey == "lider_foro" || $Rol_Ckey == "moderador_foro" || $Rol_Ckey == "facilitador_foro" || $Rol_Ckey == "administrador_foro" || $Rol_Ckey == "administrador"}
                                        <div><a class="link-foro"  href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
                                        <h4 style="text-align: justify;">{$foro.For_Titulo}</h4></a></div>
                                        {if !empty($foro.For_Resumen) && $foro.For_Resumen!=""}
                                        <div style="padding-bottom: 10px;">
                                             <p style="text-align: justify;">{$foro.For_Resumen|truncate:120:"..."}</p>
                                        </div>
                                        {/if}
                                        <div class="detalles-act-reciente">{$foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace {$foro.tiempo} &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.votos} voto(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.For_TParticipantes|default:0} miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp;{$foro.For_TComentarios|default:0} comentario(s)</div>
                                        {/if}
                                    {else}
                                        {if $Rol_Ckey == "administrador_foro" || $Rol_Ckey == "administrador"}
                                        <div><a class="link-foro"  href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
                                        <h4 style="text-align: justify;">{$foro.For_Titulo}</h4></a></div>
                                        {if !empty($foro.For_Resumen) && $foro.For_Resumen!=""}
                                        <div style="padding-bottom: 10px;">
                                             <p style="text-align: justify;">{$foro.For_Resumen|truncate:120:"..."}</p>
                                        </div>
                                        {/if}
                                        <div class="detalles-act-reciente">{$foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace {$foro.tiempo} &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.votos} voto(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.For_TParticipantes|default:0} miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp;{$foro.For_TComentarios|default:0} comentario(s)</div>
                                        {/if}  
                                    {/if}
                                {/if}  
                            {/if}
                        </div>
                        {/foreach}
                    </div>
                    <div class="col-lg-12"><br></div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="subtitle-foro"><strong>Agenda</strong></h3>
                    </div>
                    <div class="col-lg-12">
                        <hr class="cursos-hr-title-foro">
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