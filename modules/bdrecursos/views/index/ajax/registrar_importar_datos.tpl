<ul class="nav nav-pills"> 
    <li role="presentation">
        <b>Nuevo Registro desde:</b> 
    </li>
    {if $_acl->permiso("registro_individual")}
        <li role="presentation">
            <a href="{$_layoutParams.root}{if $controlador == '1'}{str_replace(' ','',strtolower($recurso.Esr_Nombre))}/registrar/index{else if $controlador == '0'}{str_replace(' ','',strtolower($recurso.Esr_Nombre))}/monitoreo/registrar{else}bdrecursos/registros/index{/if}/{$recurso.Rec_IdRecurso}" target="_blank">
                <p class="text-success"><strong>{$lenguaje["individual_bdrecursos"]}</strong></p>
            </a>
        </li>
    {/if}
    {if $_acl->permiso("registro_desde_excel")}
        <li role="presentation">
            <a href="{$_layoutParams.root}bdrecursos/import/excel/{$recurso.Rec_IdRecurso}" target="_blank">
                <p class="text-success"><strong>{$lenguaje["excel_bdrecursos"]}</strong></p>
            </a>
        </li>
    {/if}
    {if $_acl->permiso("registro_desde_web_servicie")}
        <li role="presentation">
            <a href="{$_layoutParams.root}bdrecursos/import/webservices/{$recurso.Rec_IdRecurso}" target="_blank">
                <p class="text-success"><strong>Web Services</strong></p>
            </a>
        </li>
    {/if}
    {if $_acl->permiso("registro_desde_pecari")}
        <li role="presentation">
            <a href="{$_layoutParams.root}pecari/registrar/index/{$recurso.Rec_IdRecurso}" target="_blank">
                <p class="text-success"><strong>Pecari</strong></p>
            </a>
        </li>
    {/if}
    {if $_acl->permiso("registro_desde_rss")}
        <li role="presentation">
            <a href="{$_layoutParams.root}bdrecursos/import/rss/{$recurso.Rec_IdRecurso}" target="_blank">
                <p class="text-success"><strong>RSS</strong></p>
            </a>
        </li>
    {/if}
    {if $_acl->permiso("registro_desde_json")}
        <li role="presentation">
            <a href="{$_layoutParams.root}bdrecursos/import/json/{$recurso.Rec_IdRecurso}" target="_blank">
                <p class="text-success"><strong>JSON</strong></p>
            </a>
        </li>
    {/if}
</ul>