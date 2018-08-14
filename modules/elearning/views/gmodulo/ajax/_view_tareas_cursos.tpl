{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
{if $curso.Moa_IdModalidad == 2}
<div class="col-lg-12" style="margin-top: 10px">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>TAREAS ASIGNADAS</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
    {if isset($modulos) && count($modulos) > 0}
      {$index = 1}
      {foreach from=$modulos item=mod}
        <table class="table" style="border: 0px; background-color: #F5F5F5;">
          <tbody>
            <tr>
              <th>{$index}. {$mod.Moc_Titulo}</th>
            </tr>
            <tr>
              <td>
              {if isset($mod.TAREAS) && count($mod.TAREAS) > 0 }
                <table class="table" id="tblMisCursos">
                  <tr>
                      <th><center>Tarea</center></th>
                      <th><center>Operaciones</center></th>
                  </tr>
                  {foreach from=$mod.TAREAS item=tarea}
                  <tr>
                    <td style="padding: 10px 10px 10px 20px">{$tarea.Tra_Titulo}</td>
                    <td>
                      <center>
                        <button class="btn btn-success btnTarea" tag="{$tarea.Lec_IdLeccion}">
                          Ver Resultados
                        </button>
                      </center>
                    </td>
                  </tr>
                  {/foreach}
                </table>
              {else}
                <div>Este módulo no tiene tareas</div>
              {/if}
              </td>
            </tr>
          </tbody>
        </table>
        {$index = $index + 1}
      {/foreach}
    {else}
      <div>Aun no tiene módulos en este curso</div>
    {/if}
    </div>
  </div>
</div>
{else}
<div class="col-lg-12" style="margin-top: 10px">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        No se registran tareas en cursos MOOC
      </h3>
    </div>
  </div>
</div>
{/if}
<script type="text/javascript">
  $(document).ready(function(){
    $(".btnTarea").click(function(e){
      e.preventDefault();
      var tag = $(this).attr("tag");
      alert(tag);
    });
  });
</script>
