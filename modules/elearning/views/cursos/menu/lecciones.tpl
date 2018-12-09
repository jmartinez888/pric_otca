<div class="sidebar sidebar-reduce">
  <div class="side-menu">
    <ul>
      {foreach from=$lecciones key=i item=o}
        {if $o["Progreso"] == 1 || ($i>0 && $lecciones[$i-1]["Progreso"] == 1)}
        <a href="{BASE_URL}elearning/cursos/modulo/{$curso}/{$modulo.Moc_IdModuloCurso}/{$o.Lec_IdLeccion}" class="nounderline">
        {/if}
          <li style="position: relative; color: #fff" {if $o["Lec_IdLeccion"] == $leccion["Lec_IdLeccion"]}class="item-active"{/if}>
            {if $o["Progreso"] == 1 && $o["Lec_Tipo"] == 3 }
                <div style="color: #d5ff67">Lección {$o.Index}: <div>
                <span style="color: #d5ff67"> {$o.Lec_Titulo} <strong>(Aprobado)</strong></span>
            {else}
                Lección {$o.Index}: <br>
                <span> {$o.Lec_Titulo}</span>
            {/if}
            {if $o["Progreso"] == 1}
                <span class="glyphicon glyphicon-star item-leccion-concluida"></span>
            {/if}
            <br> <span style="font-weight: normal; font-size: 12px">Dedicación: {$o.Lec_TiempoDedicacion}</span>
          </li>
        {if $o["Progreso"] == 1 || ($i>0 && $lecciones[$i-1]["Progreso"] == 1)}
        </a>
        {/if}
<!--
        {foreach from=$examenes item=e}
          {if $o.Lec_IdLeccion == $e.Lec_IdLeccion}
          <a href="{BASE_URL}elearning/cursos/modulo/{$curso}/{$modulo.Moc_IdModuloCurso}/{$e.Exa_IdExamen}/2" class="nounderline">
            <li style="position: relative; color: #fff" >
              {if $o["Progreso"] == 1 && $o["Lec_Tipo"] == 3 }
              <div style="color: #d5ff67">Lección {$o.Index}: <div>
              <span style="color: #d5ff67"> {$o.Lec_Titulo} <strong>(Aprobado)</strong></span>
              {else}
              Examen <br>
              <span> {$e.Exa_Titulo}</span>
<!--               {/if}
<!--               {if $o["Progreso"] == 1}<span class="glyphicon glyphicon-star item-leccion-concluida"></span>{/if}
            </li>
<!--           {if $o["Progreso"] == 1 || ($i>0 && $lecciones[$i-1]["Progreso"] == 1)}
          </a>
        {/if}
        {/if}
        {/foreach} -->
      {/foreach}
    </ul>
  </div>
</div>
