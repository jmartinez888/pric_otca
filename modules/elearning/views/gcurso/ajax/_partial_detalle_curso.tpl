<div class="col-lg-12"></br></div>
{if count($detalles)}
  {foreach from=$detalles item=d}
  <div class="col-lg-12 margin-bottom-10 div-detalle">
    <div><strong>{$d.DC_Titulo}</strong></div>
    <div>{$d.DC_Descripcion}</div>
    <input class="Hidden_IdDetalle" hidden="hidden" value="{$d.DC_IdDetCurso}"/>
    <button class="btn btn-default btn-detalle">Quitar</button>
  </div>
  {/foreach}
{else}
  <div class="col-lg-12 margin-bottom-10">
    Puedes agregar información adicional en esta sección
  </div>
{/if}
