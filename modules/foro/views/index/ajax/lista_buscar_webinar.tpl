<div class="col-md-12 col-xs-12 col-sm-12 col-lg-12 p-rt-lt-0" style="margin-bottom: 30px;">
    {if count($lista_foros)>0}
        {foreach from=$lista_foros item=foro}
            {include file='modules/foro/views/index/ajax/include_item_list_forum.tpl'}
        {/foreach}
    {$paginacion|default:""}
    {else}
     <div class="col-md-12 col-xs-12 col-sm-12 col-lg-12">
    	<h4> {$lenguaje.str_sin_resuitados}!...</h4>
    </div> 
    {/if}
</div>
 