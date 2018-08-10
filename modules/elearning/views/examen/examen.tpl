{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10">
<div class="col-lg-12">
        <h3>Examen</h3>
        <hr class="cursos-hr">
    </div>
   <div  class="col-lg-12">
    <form class="" role="form" method="post" action="" autocomplete="on">
        <input type="hidden" value="1" name="enviar" />
        {if isset($preguntas) && count($preguntas)}
        {$i=1}
        {foreach item=rl from=$preguntas}
        <input type="hidden" value="{$rl.Pre_IdPregunta}"  name="id_preg{$i-1}" />
        <input type="hidden" value="{$rl.Pre_Tipo}"  name="tipo_preg{$i-1}" />
        <div class="row" style="margin-bottom: 20px;">
        {if $rl.Pre_Tipo==1}
        
            <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            {foreach item=ra from=$rl.Alt}
            <div class="col-lg-12">
                <input type="radio" value="{$ra.Alt_IdAlternativa}" class="radioalt margin-top-10" name="rpta_alt{$i-1}" style="margin-top:10px;"/><label class="control-label">{$ra.Alt_Etiqueta}</label>
            </div>
            {/foreach}
        {else if $rl.Pre_Tipo==2}                
            <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            {$t=0}
            {foreach item=ra from=$rl.Alt}
            <div class="col-lg-12">
                <input type="checkbox" value="{$ra.Alt_IdAlternativa}" class="radioalt margin-top-10" name="rpta2_alt{$i-1}_index{$t}" style="margin-top:10px;"/><label class="control-label">{$ra.Alt_Etiqueta}</label>
            </div>
            {$t=$t+1}
            {/foreach}
        {else if $rl.Pre_Tipo==3}
            <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            {$arraydescripcion=explode("|", $rl.Pre_Descripcion2)}
            <div class="col-lg-12" style="margin-top:10px;">
            {$k=0}
            {for $j=0; $j<count($arraydescripcion);$j=$j+2}
            <label class="control-label">{$arraydescripcion[$j]}</label>{if $j+1<=count($arraydescripcion)-1}<input type="text" value="" name="rpta3_{$i-1}_index_{$k}" style="margin-left:5px; margin-right:5px;"/>{$k=$k+1}{/if}
            {/for}
            </div>
        {else if $rl.Pre_Tipo==4}                
            <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            {for $j=0; $j<count($rl.Alt);$j=$j+2}
            <div class="col-lg-12" style="margin-top:10px;">
            <input type="hidden" value="{$rl.Alt[$j]['Alt_IdAlternativa']}"  name="rpta4_{$i-1}_index_{$j}" />
            <label class="control-label col-lg-8">{$j+1} {$rl.Alt[$j]['Alt_Etiqueta']}</label>
            {$l=1}
            <div class="col-lg-4">
            <select name="rpta4_alt{$i-1}_index_{$j}" class="form-control">
            {for $k=1; $k<count($rl.Alt);$k=$k+2}
            <option value="{$rl.Alt[$k]['Alt_IdAlternativa']}" >{$rl.Alt[$k]['Alt_Etiqueta']}</option>
            {$l=$l+1}
            {/for}
            </select>
            </div>
            </div>
            {/for}
            <!-- {$m=1}
            <div class="col-lg-2">
            {for $j=1; $j<count($rl.Alt);$j=$j+2}
            <label class="control-label col-lg-12">{$m}. {$rl.Alt[$j]['Alt_Etiqueta']}</label><br/>
            {$m=$m+1}
            {/for}
            </div> -->
        {else if $rl.Pre_Tipo==5}                
            <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            <div class="col-lg-12">
                <textarea rows="5" placeholder="Respuesta" class="form-control col-lg-12" name="rpta_alt{$i-1}" id="rpta_alt{$i-1}" style="margin-top:10px;"></textarea>
            </div>
        {else if $rl.Pre_Tipo==7}                
           <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
            {$t=0}
            {foreach item=ra from=$rl.Alt}
            <div class="col-lg-12">
                <input type="checkbox" value="{$ra.Alt_IdAlternativa}" class="radioalt margin-top-10" name="rpta7_alt{$i-1}_index{$t}" style="margin-top:10px;"/><label class="control-label">{$ra.Alt_Etiqueta}</label>
            </div>
            {$t=$t+1}
            {/foreach}
        {/if}

        </div>
        <hr class="cursos-hr">
        {$i=$i+1}
        {/foreach}
        {/if}
        <div class="form-group">
            <div class="col-lg-12">
             <button class="btn btn-success margin-top-10" name="terminar" id="terminar">Terminar</button>
            </div>
        </div>
    </form>
</div>
</div>
