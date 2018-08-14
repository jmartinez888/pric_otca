{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-9">
<div class="col-lg-12">
        <h3>Correción de Examen: Respuesta Abierta</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form class="" id="form1" role="form" data-toggle="validator" method="post" action="" autocomplete="on">
        <input type="hidden" value="1" name="enviar" />
        {if isset($respuestas) && count($respuestas)}
        {$i=1}
        {foreach item=rl from=$respuestas}
        <input type="hidden" value="{$rl.Res_IdRespuesta}"  name="id_preg{$i-1}" />
        <input type="hidden" value="{$rl.Pre_Tipo}"  name="tipo_preg{$i-1}" />
        <div class="row" style="margin-bottom: 20px;">
        {if $rl.Pre_Tipo==1}                
            <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            <div class="col-lg-12">
                <p class="col-lg-12" name="rpta_alt{$i-1}" id="rpta_alt{$i-1}" style="margin-top:10px;"><b>Rpta:</b> {foreach item=ra from=$rl.Rpta}{$ra.Alt_Etiqueta }{/foreach}</p>
            </div>
        {else if $rl.Pre_Tipo==2}                
            <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            <div class="col-lg-12">
                <p class="col-lg-12" name="rpta_alt{$i-1}" id="rpta_alt{$i-1}" style="margin-top:10px;"><b>Rpta:</b> {foreach item=ra from=$rl.Rpta}{$ra.Alt_Etiqueta }, {/foreach}</p>
            </div>
        {else if $rl.Pre_Tipo==3}                
            <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            {$arraydescripcion=explode("|", $rl.Pre_Descripcion2)}
            <div class="col-lg-12" style="margin-top:10px;">
            {$k=0}
            {for $j=0; $j<count($arraydescripcion);$j=$j+2}
            <label class="control-label">{$arraydescripcion[$j]}</label>{if $j+1<=count($arraydescripcion)-1}_____________{$k=$k+1}{/if}
            {/for}
            </div>
            <div class="col-lg-12">
                <p class="col-lg-12" name="rpta_alt{$i-1}" id="rpta_alt{$i-1}" style="margin-top:10px;"><b>Rpta:</b> {foreach item=ra from=$rl.Rpta}{$ra.Res_Respuesta }, {/foreach}</p>
            </div>
        {else if $rl.Pre_Tipo==4}                
            <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            {foreach item=ra from=$rl.Rpta}
            <div class="col-lg-12">
                <p class="col-lg-12" name="rpta_alt{$i-1}" id="rpta_alt{$i-1}" style="margin-top:10px;">{$ra.rpta } <b>-->Rpta:</b> {$ra.rpta2 }</p>
            </div>
            {/foreach}
        {else if $rl.Pre_Tipo==5}          
            <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            <div class="col-lg-12">
                <p class="col-lg-12" name="rpta_alt{$i-1}" id="rpta_alt{$i-1}" style="margin-top:10px;">{foreach item=ra from=$rl.Rpta}{$ra.Res_Respuesta }{/foreach}</p>
            </div>
            <label class="col-lg-1 control-label">Puntos:</label>
             <div class="col-lg-3">
                <input placeholder="Puntos" class="form-control" name="rpta_puntos{$i-1}" id="rpta_puntos{$i-1}" type="number" min="0" max="{$rl.Pre_Puntos}" required value="{$rl.Res_Puntos|default:""}"/>
              </div>
        {else if $rl.Pre_Tipo==7}                
            <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            <div class="col-lg-12">
                <p class="col-lg-12" name="rpta_alt{$i-1}" id="rpta_alt{$i-1}" style="margin-top:10px;"><b>Rpta:</b> {foreach item=ra from=$rl.Rpta}{$ra.Alt_Etiqueta }, {/foreach}</p>
            </div>
        {/if}
        </div>
        <hr class="cursos-hr">
        {$i=$i+1}
        {/foreach}
        {/if}
        <div class="form-group">
            <div class="col-lg-12">
             <button class="btn btn-success margin-top-10" name="corregir" id="corregir">Corregir</button>
            </div>
        </div>
    </form>
        </div>
    </div>
</div>
