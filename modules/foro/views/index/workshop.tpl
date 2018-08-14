<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">       
        <h3 class="titulo"><strong>Workshop</strong></h3>
        <div class="col-lg-12 p-rt-lt-0">
            <hr class="cursos-hr-title-foro">
        </div>
        <div class="row">
            <div class="col-md-12" style="margin-bottom: 30px;">
                
               {if count($lista_foros)>0}
                {foreach from=$lista_foros item=foro}
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                        <div class="">
                            <div class="cabecera-discusion">
                                <a class="link-foro" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">               
                                    <h4 style="text-align: justify;"><strong>{$foro.For_Titulo}</strong></h4>                               
                                </a>
                            </div>
                            <div style="padding-bottom: 10px;">                          
                                <p style="text-align: justify;">{$foro.For_Resumen|truncate:120:"..."}</p>
                            </div>
                            <div class="detalles-act-reciente">{$foro.Usu_Usuario} &nbsp;&nbsp;-&nbsp;&nbsp; hace {$foro.tiempo} &nbsp;&nbsp;-&nbsp;&nbsp; 3 votos &nbsp;&nbsp;-&nbsp;&nbsp; {$foro.For_TComentarios|default:0} comentario(s)</div>     
                            <!-- <div class="footer-item row">
                                <div class="col-md-6">
                                    {$end_date=($foro.For_FechaCierre|date_format:"%d-%m-%Y")}
                                    <span class="date">{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"} {if ($foro.For_FechaCierre|date_format:"%d-%m-%Y")!=""} / {($foro.For_FechaCierre|date_format:"%d-%m-%Y")}{/if}</span>
                                </div>
                                <div class="col-md-6 text-right">
                                    Colaboraciones <span class="badge">{$foro.For_TComentarios}</span> 
                                </div>
                            </div>  -->              
                        </div>

                    </div>
                {/foreach}
                {else}
                    <h4>No se encontraron Resultados</h4>
                {/if}

            </div>
           

        </div>

    </div>
</div>