<div class="margin-bottom-10 col-lg-6">
{foreach from=$objetivos item=o}
  <div class="margin-bottom-5" style="width: 100%; position: relative; margin-bottom: 10px">
    <i class="glyphicon glyphicon-ok"></i>&nbsp;&nbsp;
    <input class="Hidden_IdObjetivo estado" value="{$o.CO_IdObjetivo}" />
    {$o.CO_Titulo}
    <button class="btnEliminarObjetivo" style="position:absolute; top: 0; right: 0" type="button">
      <i class="glyphicon glyphicon-trash"></i>
    </button>
  </div>
{/foreach}
</div>
