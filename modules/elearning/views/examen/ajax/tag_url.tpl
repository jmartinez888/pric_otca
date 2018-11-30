<style type="text/css">
  .tag-url{
    color: #75ACE5;
    display: inline-block;
    cursor: pointer;
  }
</style>

{if isset($curso)}
<input type="hidden" id="hidden_curso" value="{$curso.Cur_IdCurso|default:'0'}" />

<div class="col-lg-12" >
  <div class=" " style="margin-bottom: 0px !important">
    <div class="text-center text-bold" style="margin-bottom: 20px; color: #267161;">
      <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
        {$curso.Cur_Titulo}
          {if isset($modulo) && isset($modulo.Moc_Titulo)}

          <input type="hidden"  id="hidden_modulo" value="{$modulo.Moc_IdModuloCurso|default:'0'}"  />

          <i class="glyphicon glyphicon-menu-right"></i>&nbsp;&nbsp;
          <div class="tag-url" id="tag-url-modulo">{$modulo.Moc_Titulo}</div>
            {if isset($leccion) && isset($leccion.Lec_Titulo)}

            <input type="hidden" id="hidden_leccion" value="{$leccion.Lec_IdLeccion|default:'0'}"  />
            
            <i class="glyphicon glyphicon-menu-right"></i>&nbsp;&nbsp;
            <div class="tag-url" id="tag-url-leccion">{$leccion.Lec_Titulo}</div>
            {/if}
          {/if}
      </h3>
    </div>
  </div>
</div>
{/if}

<script type="text/javascript">
  function RefreshTagUrl(){
    $("#tag-url-curso").unbind("click").click(function(){
        var IdCurso = $("#hidden_curso").val();
        location.href = _root_ + _modulo + "/gcurso/_view_finalizar_registro/" + IdCurso;
        // CargarPagina("gcurso/_view_finalizar_registro", { id : IdCurso}, false, $(this));
    });
    $("#tag-url-modulo").unbind("click").click(function(){
        var IdCurso = $("#hidden_curso").val();
        var IdModulo = $("#hidden_modulo").val();
        location.href = _root_ + _modulo + "/gleccion/_view_lecciones_modulo/" + IdCurso + "/" + IdModulo;
        // CargarPagina("gleccion/_view_lecciones_modulo", { curso: IdCurso, modulo : IdModulo }, false, $(this));
    }); 
    $("#tag-url-leccion").unbind("click").click(function(){
        var IdCurso = $("#hidden_curso").val();
        var IdModulo = $("#hidden_modulo").val();
        var IdLeccion = $("#hidden_leccion").val();
        location.href = _root_ + _modulo + "/gleccion/_view_leccion/" + IdCurso + "/" + IdModulo + "/" + IdLeccion;
        // CargarPagina("gleccion/_view_leccion", {
        //   curso: IdCurso,
        //   modulo : IdModulo,
        //   leccion : IdLeccion,
        // }, false, false);
    });
  }
</script>
