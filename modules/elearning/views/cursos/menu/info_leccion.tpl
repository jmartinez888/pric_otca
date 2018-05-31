      <div class="col-lg-12" style="padding-left:0px; padding-right:0px;">  
      <div class="panel panel-default">
          <ul class="nav nav-tabs">
              {if strlen($leccion["Lec_Descripcion"]) > 0 }
              <li class="active"><a data-toggle="tab" href="#inf_curso">Información de la Lección</a></li>
             {/if}
             {if isset($materiales) && count($materiales) > 0 }
              <li><a data-toggle="tab" href="#mat_ditac">Material didáctico</a></li>
             {/if}
             {if isset($referencias) && count($referencias) > 0 }
              <li><a data-toggle="tab" href="#ref_mat">Referencias</a></li>
              {/if}
        </ul>
        {if strlen($leccion["Lec_Descripcion"]) > 0 }
        <div class="panel-body" style=" margin: 0px 25px">
          <div class="tab-content">
            {if strlen($leccion["Lec_Descripcion"]) > 0 }
          <div id="inf_curso" class="tab-pane fade in active">
            <div style="text-align: justify">
                      {$leccion["Lec_Descripcion"]|default:"-"}
                    </div>
          </div>
            {/if}
            {if isset($materiales) && count($materiales) > 0 }
            <div id="mat_ditac" class="tab-pane fade">
              {foreach from=$materiales item=r}
                  <div>
                    <a href="{BASE_URL}elearning/clase/download/{$r.Mat_Enlace}">
                      <strong>{$r.Mat_Descripcion}</strong>
                    </a>        
                  </div>
                {/foreach}
            </div>
            {/if}
            {if isset($referencias) && count($referencias) > 0 }
          <div id="ref_mat" class="tab-pane fade">
             {foreach from=$referencias item=r}
                <div><strong>{$r.Ref_Titulo}</strong></div>
                <div>{$r.Ref_Descripcion}</div>
              {/foreach}
            
          </div>
        {/if}
        </div>
         
        </div>
        {/if}
      </div>
    </div>
