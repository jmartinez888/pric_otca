{if $leccion["Lec_Tipo"]==3}
  {if $examen["Exa_Intentos"] >= $intentos}
  <div  class="col-lg-12 contenedor" style="padding-bottom: 10px; display: none"  id="examen-contenido">
    <div class="col-lg-12">
      <center><h4><strong>{$examen["Exa_Descripcion"]}</strong></h4></center>
    </div>
    <form method="post" action="#" id="form-examen">
    <input value="{$examen['Exa_IdExamen']}" id="IdExamen" hidden="hidden">
    {foreach from=$examen["PREGUNTAS"] item=p}
      <div class="col-lg-12 contenedor-pregunta" style="margin-bottom: 10px !important">
        <strong>{$p["INDEX"]}. {$p["Pre_Descripcion"]}</strong><p></p>
        {if $p["TP_IdTpoPregunta"]==1}
          <div class="col-lg-12">
            <input value="{$p['Pre_IdPregunta']}" class="IdPregunta" hidden="hidden">
            <fieldset id="group{$p['Pre_IdPregunta']}">
            {foreach from=$p["ALTERNATIVAS"] item=a}
              <input id="in{$a['Alt_IdAlternativa']}" type="radio" class="IdAlternativa" name="group{$p['Pre_IdPregunta']}" value="{$a['Alt_Valor']}" />
              <label for="in{$a['Alt_IdAlternativa']}" style="font-weight: 400 !important">{$a["Alt_Etiqueta"]}</label><br>
            {/foreach}
            </fieldset>
          </div>
        {/if}
      </div>
    {/foreach}
    </form>
    <div class="col-lg-12">
      <button class="btn btn-success" id="btnFinalizar">Finalizar</button>
    </div>
    <div class="col-lg-12" style="font-weight: bolt; color:red;margin-top: 10px !important">
      {if $intentos == 0}
        <div>Primera vez por aquí tienes <strong>{$examen.Exa_Intentos} intentos</strong> para terminar este examen con un <strong>{$examen.Exa_Porcentaje}%</strong> de preguntas correctas</div>
      {else}
        <div><strong>{($intentos+1)}° intento</strong> para terminar este examen con un <strong>{$examen.Exa_Porcentaje}%</strong> de preguntas correctas</div>
      {/if}
    </div>
  </div>
  <div  class="col-lg-12 contenedor" style="padding-bottom: 10px; display: none"  id="resultados-contenido">
  <center><h4><strong>Respuestas erroneas</strong></h4></center>
  <div id="contenido-errores" style="margin-bottom: 10px"></div>
  <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
    <button class="btn btn-success">Ir a curso</button>
  </a>
</div>
  {else}
  <div class="col-lg-9" style="margin-top: 20px">
    <strong>Ups!</strong>
    <div>Te quedaste sin intentos para terminar este examen :(</div>
  </div>
  {/if}
{/if}


<!--div class="col-lg-12">
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-9" style="margin-top: 20px">
    <strong>Ups!</strong>
    <div>Te quedaste sin intentos para terminar este examen :(</div>
  </div>
</div-->
