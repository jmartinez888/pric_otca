{if isset($preguntas) && count($preguntas)}                        
    <div  class="col-xs-12" style="padding-bottom: 20px;">
        <form class="" role="form" method="post" action="" autocomplete="on">
            <input type="hidden" value="1" name="enviar" />

                {$i=1}
                {foreach item=rl from=$preguntas}
                <input type="hidden" value="{$rl.Pre_IdPregunta}"  name="id_preg{$i-1}" />
                <input type="hidden" value="{$rl.Pre_Tipo}"  name="tipo_preg{$i-1}" />
                <div class="row" >
                {if $rl.Pre_Tipo==1}
                
                    <label class="col-xs-12 control-label " style="margin-bottom: 15px;">{$i}. {$rl.Pre_Descripcion}</label>
                    {$j = 1}
                    {foreach item=ra from=$rl.Alt}
                    <div class="col-xs-12 alt_">
                      <div class="col col-xs-1">
                        
                        {if $j == 1}
                        <p class="col col-xs-3">a) </p>
                        {/if}
                        {if $j == 2}
                        <p class="col col-xs-3">b) </p>
                        {/if}
                        {if $j == 3}
                        <p class="col col-xs-3">c) </p>
                        {/if}
                        {if $j == 4}
                        <p class="col col-xs-3">d) </p>
                        {/if} 
                        {if $j == 5}
                        <p class="col col-xs-3">e) </p>
                        {/if}
                        {if $j == 6}
                        <p class="col col-xs-3">f) </p>
                        {/if}
                        {if $j == 7}
                        <p class="col col-xs-3">g) </p>
                        {/if} 
                        <input type="radio" value="{$ra.Alt_IdAlternativa}" required="" onclick="selectRadioClick(this);" class="col col-xs-9 radioalt" name="rpta_alt{$i-1}" id="rpta_alt{$i-1}_{$j}" /> 
                      </div>
                      <div class="col col-xs-11">
                        <p class="">{$ra.Alt_Etiqueta}</p>
                      </div>
                    </div>
                    {$j=$j+1}
                    {/foreach}

                {else if $rl.Pre_Tipo==2}                
                    <label class="col-xs-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                    {$t = 0}{$j = 1}
                    {foreach item=ra from=$rl.Alt}
                    <div class="col-xs-12 alt_">
                      <div class="col col-xs-1">  
                        {if $j == 1}
                        <p class="col col-xs-3">a) </p>
                        {/if}
                        {if $j == 2}
                        <p class="col col-xs-3">b) </p>
                        {/if}
                        {if $j == 3}
                        <p class="col col-xs-3">c) </p>
                        {/if}
                        {if $j == 4}
                        <p class="col col-xs-3">d) </p>
                        {/if} 
                        {if $j == 5}
                        <p class="col col-xs-3">e) </p>
                        {/if}
                        {if $j == 6}
                        <p class="col col-xs-3">f) </p>
                        {/if}
                        {if $j == 7}
                        <p class="col col-xs-3">g) </p>
                        {/if} 

                        <input type="checkbox" value="{$ra.Alt_IdAlternativa}" onclick="selectRadioClick(this);" class=" col col-xs-9 radioalt " name="rpta2_alt{$i-1}_index{$t}" id="rpta_alt{$i-1}_{$j}"/> 

                        {if $ra.Alt_Check == 0}
                        <input type="hidden" value="{$ra.Alt_IdAlternativa}" name="rpta2_alt{$i-1}_index{$t}_hd" id="rpta_alt{$i-1}_{$j}_hd">
                        {/if}
                      </div>
                      <div class="col col-xs-11">
                        <p class="control-lasbel">{$ra.Alt_Etiqueta}</p>
                      </div>                                            
                    </div>
                    {$t=$t+1}
                    {$j=$j+1}
                    {/foreach}
                {else if $rl.Pre_Tipo==3}
                    <label class="col-xs-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                    {$arraydescripcion=explode("|", $rl.Pre_Descripcion2)}
                    <div class="col-xs-12" style="margin-top:10px;">
                    {$k = 0}
                    {for $j = 0; $j < count($arraydescripcion); $j = $j + 2}
                    {$arraydescripcion[$j]} {if $j + 1 <= count($arraydescripcion) - 1}<input type="text" value="" required="" class="text-bold text-success" name="rpta3_{$i-1}_index_{$k}" id="espacio_blanco" />{$k = $k + 1}{/if}
                    {/for}
                    </div>
                {else if $rl.Pre_Tipo==4}                
                    <label class="col-xs-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                    {for $j=0; $j<count($rl.Alt);$j=$j+2}
                    <div class="col-xs-12" style="margin-top:10px;">
                    <input type="hidden" value="{$rl.Alt[$j]['Alt_IdAlternativa']}"  name="rpta4_{$i-1}_index_{$j}" />
                    <label class="control-label col-lg-8">{$j+1} {$rl.Alt[$j]['Alt_Etiqueta']}</label>
                    {$l=1}
                    <div class="col-lg-4">
                    <select name="rpta4_alt{$i-1}_index_{$j}" class="form-control">
                      <option value="" > Select </option>
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
                    <label class="control-label col-xs-12">{$m}. {$rl.Alt[$j]['Alt_Etiqueta']}</label><br/>
                    {$m=$m+1}
                    {/for}
                    </div> -->
                {else if $rl.Pre_Tipo==5}                
                    <label class="col-xs-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                    <div class="col-xs-12">
                        <textarea rows="5" placeholder="Respuesta" class="form-control col-xs-12" name="rpta_alt{$i-1}" required="" id="rpta_alt{$i-1}" style="margin-top:10px;"></textarea>
                    </div>
                {else if $rl.Pre_Tipo==7}                
                   <label class="col-xs-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                    {$t=0}
                    {foreach item=ra from=$rl.Alt}
                    <div class="col-xs-12">
                        <input type="checkbox" value="{$ra.Alt_IdAlternativa}" class="radioalt margin-top-10" name="rpta7_alt{$i-1}_index{$t}" style="margin-top:10px;"/><label class="control-label">{$ra.Alt_Etiqueta}</label>
                    </div>
                    {$t=$t+1}
                    {/foreach}
                {/if}

                </div>
                <hr class="cursos-hr">
                {$i=$i+1}
                {/foreach}

            <div class="form-group">
                <button class="btn btn-success margin-t-10" name="terminar" id="terminar">Terminar</button>
            </div>
        </form>
    </div>
{/if}