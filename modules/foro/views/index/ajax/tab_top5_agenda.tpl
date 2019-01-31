<div class="row">
    <div class="col-md-12">
        <h3 class="subtitle-foro">{$lenguaje.str_agenda}</h3>
    </div>
    <div class="col-lg-12">
        <hr class="cursos-hr-title-foro">
    </div>
    <div class="col-md-12">
        <div class="tab-pane fade in active show agenda-container">
           {if isset($lista_agenda) && count($lista_agenda)}
        {foreach from=$lista_agenda item=agenda}
        <a  href="{$_layoutParams.root}foro/index/ficha/{$agenda.For_IdForo}" class="link-tabs-jsoft">
            <div class="jsoft_card">
                <div class="image fecha_evento pull-left">
                    <h2>
                    <span class="badge badge-secondary">{$agenda.For_FechaCreacion|date_format:"%d"}</span>
                    </h2>
                    <h4>{($agenda.For_FechaCreacion|date_format:"%B %Y")|upper}</h4>
                </div>
                <div class="content pull-left">
                    <h4 class="card-title" style="font-size: 16px;">{$agenda.For_Titulo|truncate:60:"..."}
                    </h4>
                    <ul class="list-inline">
                        <li class="list-inline-item"><i class="fa fa-calendar-o" aria-hidden="true"></i> {($agenda.For_FechaCreacion|date_format:"%A"|utf8_encode)|capitalize}</li>
                        <li class="list-inline-item"><i class="fa fa-clock-o" aria-hidden="true"></i> {$agenda.For_FechaCreacion|date_format:"%H:%M"}</li>                   
                    </ul>                  
                </div>
            </div>
        </a>
        {/foreach}
        {/if}
        <a href="{$_layoutParams.root}foro/index/searchForo/" class="mas-jsoft">{$lenguaje.str_vermas}</a>
        </div>
    </div>
</div>
