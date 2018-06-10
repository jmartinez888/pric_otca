<div  class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    {include file='modules/foro/views/index/menu/lateral.tpl'}
    <div  class="col-md-10 col-xs-12 col-sm-8 col-lg-10" style="margin-top: 10px;">       
        <h3 class="titulo-view titulo"><strong>Discusiones</strong> </h3>
        <div class="col-lg-12"><br></div>        
        <div class="row">
            <div class="col-md-12">

                {if count($lista_foros)>0}
                {foreach from=$lista_foros item=foro}
                    <div class="col-xs-12 col-sm-12 col-md-6 col-lg-6">
                        <div class="discusion">
                            <div class="cabecera-discusion">
                                <a class="link-foro" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">               
                                    <h4>{$foro.For_Titulo}</h4>                               
                                </a>
                            </div>
                            <div style="padding-bottom: 10px;">                          
                                <p>{$foro.For_Resumen|truncate:120:"..."}</p>
                            </div>
                            <div class="detalles-act-reciente">Usuario &nbsp;&nbsp;-&nbsp;&nbsp; hace 1 mes &nbsp;&nbsp;-&nbsp;&nbsp; 3 votos &nbsp;&nbsp;-&nbsp;&nbsp; 5 comentarios</div>       
                            <!-- <div class="footer-item row">
                                <div class="col-md-6 detalles-discusion">
                                    {$end_date=($foro.For_FechaCierre|date_format:"%d-%m-%Y")}
                                    <span class="date">{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"} {if ($foro.For_FechaCierre|date_format:"%d-%m-%Y")!=""} / {($foro.For_FechaCierre|date_format:"%d-%m-%Y")}{/if}</span>
                                </div>
                                <div class="col-md-6 text-right detalles-discusion">
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