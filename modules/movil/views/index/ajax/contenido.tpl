<div class="col-lg-12 panel panel-default" style="margin-top:20px;">
<div class="row">
  <div class="col-lg-12 leccion-container">
  <div class="col-lg-9" style="padding-left:0px; padding-right: 0px;">
    <div class="col-lg-12" style="padding-left:0px; padding-right:0px;">
      <div class="panel panel-default">
        
        <div class="panel-body contenedor-clase">
            {if isset($cont_html) && count($cont_html)>0}
              {foreach from=$cont_html item=h}
                <div class="col-lg-12" style="text-align: justify;">{html_entity_decode($h.CL_Descripcion)}</div>
              {/foreach}
            {/if}
        </div>
      </div>
    </div>
  </div>
  </div>
</div>
</div>
