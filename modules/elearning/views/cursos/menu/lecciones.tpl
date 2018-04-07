<div class="sidebar-left">
  <div class="side-menu">
    <ul>
      {foreach from=$lecciones key=i item=o}
        {if $o["Progreso"] == 1 || ($i>0 && $lecciones[$i-1]["Progreso"] == 1)}
        <a href="{BASE_URL}elearning/cursos/modulo/{$curso}/{$modulo.Mod_IdModulo}/{$o.Lec_IdLeccion}" class="nounderline">
        {/if}
          <li style="position: relative; color: #263238" {if $o["Lec_IdLeccion"] == $leccion["Lec_IdLeccion"]}class="item-active"{/if}>
            {if $o["Progreso"] == 1 && $o["Lec_Tipo"] == 3 }
            <div style="color: gray">Lección {$o.Index}: <div>
            <span style="color: gray"> {$o.Lec_Titulo} <strong>(Aprobado)</strong></span>
            {else}
            Lección {$o.Index}: <br>
            <span> {$o.Lec_Titulo}</span>
            {/if}
            {if $o["Progreso"] == 1}<span class="glyphicon glyphicon-star item-leccion-concluida"></span>{/if}
          </li>
        {if $o["Progreso"] == 1 || ($i>0 && $lecciones[$i-1]["Progreso"] == 1)}
        </a>
        {/if}
      {/foreach}
    </ul>
  </div>
</div>
