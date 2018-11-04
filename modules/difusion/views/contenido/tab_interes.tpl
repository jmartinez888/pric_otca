


<ul class="nav nav-tabs jsoft-tabs bg-verde">
    <li class="active" ><a class=""  data-toggle="tab" href="#evento_interes">{$lenguaje['str_eventos_interes']}</a></li>
    <li><a data-toggle="tab" href="#dato_interes">{$lenguaje['str_datos_interes']}</a></li>
</ul>
<div class="tab-content content-interes pl-4 pr-4">
    <div id="evento_interes" class="tab-pane fade  active in scroll">
        {foreach App\ODifusion::eventos_interes()->limit(5)->get() as $item}
            <interes id="{$item->ODif_IdDifusion}"></interes>
        {/foreach}
        <a href="{$_layoutParams.root}difusion/evento/all" class="col-md-12 col-sm-12 col-xs-12 ver-mas">{$lenguaje['str_ver_mas']}</a>
    </div>
    <div id="dato_interes" class="tab-pane fade scroll">
        {foreach App\ODifusion::datos_interes()->limit(5)->get() as $item}
            <interes id="{$item->ODif_IdDifusion}"></interes>
        {/foreach}
        <a href="{$_layoutParams.root}difusion/datos/all" class="col-md-12 col-sm-12 col-xs-12 ver-mas">{$lenguaje['str_ver_mas']}</a>
    </div>
</div>