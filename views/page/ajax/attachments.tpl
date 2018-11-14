{if (isset($search) && !empty($search) && $search!='undefined')}
<ul class="nav nav-tabs">
  <li class="active"><a tab_attach data-toggle="tab" href="#menu0">
  {$lenguaje.page_att_tab_titulo_documentos}
  </a></li>
  <li><a tab_attach data-toggle="tab" href="#menu1" class="">{$lenguaje.page_att_tab_titulo_legislacion}
  </a></li>
  <li><a tab_attach data-toggle="tab" href="#menu2">
  {$lenguaje.page_att_tab_titulo_inf_geografica}
  </a></li>
   <li><a tab_attach data-toggle="tab" href="#menu3">
   {$lenguaje.page_att_tab_titulo_otros_recursos}
   </a></li>
</ul>

<div class="tab-content">
  <div id="menu0" class="tab-pane fade in active">
  	 <h3>{$lenguaje.page_att_tab_cont_h3_documentos}</h3>
    <div id="attachments_dublin" title="{$search}">
    	{$lenguaje.page_att_tab_cont_cargando}
    </div>
  </div>
  <div id="menu1" class="tab-pane fade">
    <h3>{$lenguaje.page_att_tab_cont_h3_legislacion}</h3>
    <div id="attachments_legal" title="{$search}">
       {$lenguaje.page_att_tab_cont_cargando}
    </div>
  </div>
  <div id="menu2" class="tab-pane fade">
    <h3>{$lenguaje.page_att_tab_cont_h3_inf_geografica}</h3>
   <div id="attachments_inf_geografica" title="{$search}">
      {$lenguaje.page_att_tab_cont_cargando}
    </div>
  </div>
   <div id="menu3" class="tab-pane fade">
    <h3>{$lenguaje.page_att_tab_cont_h3_otros_recursos}</h3>
    <div id="attachments_otros_recursos" title="{$search}">
        {$lenguaje.page_att_tab_cont_cargando}
      </div>
  </div>
</div>
{else}
<div class="alert alert-warning" role="alert"> <strong>Warning!</strong>  {$lenguaje.page_att_alerta_sin_parametro}</div>
{/if}
