{* <div class="sidebar sidebar-reduce"> *}
<div class="container-menu-lecciones">
  {* <div class="side-menu"> *}
    <ul>
      {foreach from=$lecciones key=i item=o}


          <li style="position: relative; color: #fff" class="item-leccion {if isset($leccion) && count($leccion)} {if $o["Lec_IdLeccion"] == $leccion["Lec_IdLeccion"]} item-active {else} hidden {/if} {/if}">
            {* {if $o["Progreso"] == 1 || ($i>0 && $lecciones[$i-1]["Progreso"] == 1)} *}
            <a href="{BASE_URL}elearning/cursos/modulo/{$curso}/{$modulo.Moc_IdModuloCurso}/{$o.Lec_IdLeccion}" class="nounderline  cancel-href ">
            {* {else}
            <a href="#" onclick="return false" class="nounderline ">
            {/if} *}
              <p>
                {if $o["Progreso"] == 1 && $o["Lec_Tipo"] == 3 }
                    <span style="color: #d5ff67">{$lang->get('str_leccion')} {$o.Index}: </span></br>
                    <span style="color: #d5ff67"> {$o.Lec_Titulo} <strong>({$lang->get('str_aprobado')})</strong></span>
                {else}
                    <span>{$lang->get('str_leccion')} {$o.Index}: </span></br>
                    <span> {$o.Lec_Titulo}</span>
                {/if}
                </br>
                <span class="tiempo-dedicacion" style="font-weight: normal; font-size: 12px">{$lang->get('str_dedicacion')}: {$o.Lec_TiempoDedicacion}</span>
              </p>
            </a>
            {if $o["Progreso"] == 1}
                <span class="glyphicon glyphicon-star item-menus"></span>
            {else}
              <span></span>
            {/if}
            {if $i == 0}
              <span class="glyphicon glyphicon-triangle-bottom item-menus hidden" id="btn-close-leccion"></span>
            {/if}
            {if isset($leccion) && count($leccion)}
              {if $o["Lec_IdLeccion"] == $leccion["Lec_IdLeccion"]}
                <span class="glyphicon glyphicon-triangle-left item-menus" id="btn-show-leccion"></span>
              {/if}
            {/if}


          </li>

      {/foreach}
    </ul>
  {* </div> *}
</div>
