<div class="col-lg-12" style="padding: 10px 0 0 0">
  {foreach from=$curso item=o}
  <div class="col-lg-4">
    <div class="curso-item">
    <img class="curso-item-img" src="{BASE_URL}public/resources/cursos/{$o.Cur_UrlBanner}" />
    <div class="curso-item-mod {if $o.Mod_IdModCurso==1} mooc {else} lms {/if}">{$o.Modalidad}</div>
    <h4 class="curso-item-title">{$o.Cur_Titulo}</h4>
    <br/>
    <div class="curso-item-desc">
      {$o.Cur_Descripcion}
    </div>
    <a href="{BASE_URL}elearning/cursos/curso/{$o.Cur_IdCurso}">
      <button class="btn btn-default btn-ficha">Ver ficha</button>
    </a>
    </div>
  </div>
  {/foreach}
</div>
