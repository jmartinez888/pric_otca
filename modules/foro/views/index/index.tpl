<div class="row foro_banner">
    <div class="col-xs-12 col-sm-12 col-md-5 col-lg-5" style="color: #333; font-weight: bold; font-size: 18px;">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <h1 class="titulo">{$lenguaje.foro_index_label_titulo}</h1>
            <div class="col-lg-12 p-rt-lt-0">
                <hr class="cursos-hr-title-foro2">
            </div>
            <p class="descripcion-foro">{$lenguaje.foro_index_label_descripcion}</p>
        </div>
    </div>
</div>
<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}

    <div  class="col-md-10 col-xs-12 col-sm-9 col-lg-10" style="margin-top: 10px;">       
        <!-- <h2 class="titulo">{$lenguaje.foro_index_label_titulo}</h2>
        <div class="col-lg-12 p-rt-lt-0">
            <hr class="cursos-hr-title-foro">
        </div>
        <p class="descripcion-foro">{$lenguaje.foro_index_label_descripcion}</p> -->   
        
        <div class="row">
            <div class="col-md-12" style="margin-bottom: 15px; margin-top: 10px;">
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
                        <hr class="cursos-hr-title-foro">
                    </div>
                    <div class="col-md-12">
                        {foreach from=$lista_tematica item=tematica}
                            {if $tematica.Lit_Discussions!="" || $tematica.Lit_Query!=""|| $tematica.Lit_Webinar!=""|| $tematica.Lit_Workshop!=""}
                        <div class="col-md-6 col-xs-12 col-sm-12 col-lg-6 tematica-foro margin-r-0">
                            <div class="row tem_titulo"><a class="link-foro" href="{$_layoutParams.root}foro/tematica/detalles/{$tematica.Lit_IdLineaTematica}"><h4><strong>{$tematica.Lit_Nombre}</strong></h4></a></div>
                            <div class="row detalles-tematica">
                                {if $tematica.Lit_Discussions!=""}
                                <div class="col-md-6 col-xs-3 col-sm-3 col-lg-6 item-tematica"><a class="simulalink underline" href="{$_layoutParams.root}foro/index/discussions">Discusiones: {$tematica.Lit_Discussions}</a></div>
                                {/if}
                                {if $tematica.Lit_Query!=""}
                                <div class="col-md-6 col-xs-3 col-sm-3 col-lg-6 item-tematica"><a class="simulalink underline" href="{$_layoutParams.root}foro/index/query">Consultas: {$tematica.Lit_Query}</a></div>  
                                {/if}
                                {if $tematica.Lit_Webinar!=""}
                                <div class="col-md-6 col-xs-3 col-sm-3 col-lg-6 item-tematica"><a class="simulalink underline" href="{$_layoutParams.root}foro/index/webinar">Webinars: {$tematica.Lit_Webinar}</a></div> 
                                {/if}
                                {if $tematica.Lit_Workshop!=""}
                                <div class="col-md-6 col-xs-3 col-sm-3 col-lg-6 item-tematica"><a class="simulalink underline" href="{$_layoutParams.root}foro/index/workshop">Workshop: {$tematica.Lit_Workshop}</a></div> 
                                {/if}
                                
                                <div class="row col-md-12 col-xs-12 col-sm-12 col-lg-12 margin-t-5">
                                {$tematica.Lit_Members|default:0} Miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$tematica.Lit_Comentarios|default:0} Comentario(s)
                                </div>
                            </div>
                        </div>
                         {/if}
                        {/foreach}
                    </div>
                  
                    <div class="clearfix"> </div>
                    <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12 margin-t-10">
                        <h3 class="subtitle-foro">Actividad reciente</h3>
                    </div>
                    <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
                        <hr class="cursos-hr-title-foro">
                    </div>
                    <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
                        {foreach from=$lista_foros item=foro}
                        <div class="row col-md-12 col-xs-12 col-sm-12 col-lg-12 tematica-foro">
                                <div>
                                    <a class="link-foro"  href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">
                                        <h4 style="text-align: justify;"><strong>{$foro.For_Titulo}</strong></h4>
                                    </a>
                                </div>
                                    {if !empty($foro.For_Resumen) && $foro.For_Resumen!=""}
                                    <div style="padding-bottom: 10px;">
                                         <p style="text-align: justify;">{$foro.For_Resumen|truncate:120:"..."}</p>
                                    </div>
                                    {/if}
                                <div class="detalles-act-reciente">{$foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace {timediff date=$foro.tiempo  lang=Cookie::lenguaje()}&nbsp;&nbsp;-&nbsp;&nbsp; {$foro.votos} voto(s) &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.For_TParticipantes|default:0} miembro(s) &nbsp;&nbsp;-&nbsp;&nbsp;{$foro.For_TComentarios|default:0} comentario(s)
                                </div>
                        </div>
                        {/foreach}
                    </div>
                    <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12"><br></div>
                </div>
            </div>
            <div class="col-md-4 col-xs-12 col-sm-12 col-lg-4">
                {include file ='modules/foro/views/index/ajax/tab_top5_agenda.tpl'}
            </div>

        </div>

    </div>
</div>