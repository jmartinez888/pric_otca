<div class="col-md-12">
    <div class="row">
        {foreach from=$lista_foros item=foro}
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div class="foro-item">
                    <div class="page-header">
                        <a class="link-foro" href="{$_layoutParams.root}foro/index/ficha/{$foro.For_IdForo}">               
                            <h4>{$foro.For_Titulo}</h4>                               
                        </a>
                    </div>
                    <div class="body-item">                          
                        <p>{$foro.For_Resumen|truncate:120:"..."}</p>
                    </div>  
                    <!--<div class="body-item">                          
                        <p>{$foro.For_Resumen|truncate:120:"..."}</p>
                    </div>-->        
                    <div class="footer-item row">
                        <div class="col-md-6">
                            {$end_date=($foro.For_FechaCierre|date_format:"%d-%m-%Y")}
                            <span class="date">{$foro.For_FechaCreacion|date_format:"%d-%m-%Y"} {if ($foro.For_FechaCierre|date_format:"%d-%m-%Y")!=""} / {($foro.For_FechaCierre|date_format:"%d-%m-%Y")}{/if}</span>
                        </div>
                        <div class="col-md-6 text-right">
                            Colaboraciones <span class="badge">{$foro.For_NComentarios}</span> 
                        </div>
                    </div>               
                </div>

            </div>
        {/foreach}
    </div>
</div>  