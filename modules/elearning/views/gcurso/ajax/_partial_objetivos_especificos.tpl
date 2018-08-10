<div class="margin-bottom-10 col-xs-12" >
{foreach from=$objetivos item=o}
  <div class="margin-bottom-10 col col-xs-12" style="border: 1px solid; padding: 8px; border-radius: 10px;">
  	<div class="col col-xs-1 text-center">
  		<i class="glyphicon glyphicon-ok"></i>
  	</div>
    <span class="col col-xs-10">{$o.CO_Titulo}</span>
    <div class="col col-xs-1 text-right" >
    	<input class="Hidden_IdObjetivo estado" value="{$o.CO_IdObjetivo}" />
	    <button class="btn btn-sm btn-danger btnEliminarObjetivo" type="button">
	      <i class="glyphicon glyphicon-trash"></i>
	    </button>    	
    </div>
  </div>
{/foreach}
</div>
