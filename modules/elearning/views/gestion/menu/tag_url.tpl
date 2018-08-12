{if isset($curso)}
<div class="col-lg-12" >
  <!-- <div class="panel panel-default" style="margin-bottom: 0px !important"> -->
    <div class="text-center">
      <h3 style="text-transform: uppercase; margin: 0">
        {$curso.Cur_Titulo}
          <!-- {if isset($modulo) && isset($modulo.Moc_Titulo)}
          <i class="glyphicon glyphicon-menu-right"></i>&nbsp;&nbsp;
          <div class="tag-url" id="tag-url-modulo">{$modulo.Moc_Titulo}</div>
            {if isset($leccion) && isset($leccion.Lec_Titulo)}
            <i class="glyphicon glyphicon-menu-right"></i>&nbsp;&nbsp;
            <div class="tag-url" id="tag-url-leccion">{$leccion.Lec_Titulo}</div>
            {/if}
          {/if} -->
      </h3>
    </div>
  <!-- </div> -->
</div>
{/if}
