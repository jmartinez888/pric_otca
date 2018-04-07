{if $leccion["Lec_Tipo"]==3 }
  {if $examen["Exa_Intentos"]==0 || ($examen["Exa_Intentos"]!=0 && $examen["Exa_Intentos"] >= $intentos)}
  <div class="col-lg-12" id="panel-contenedor-pregunta" style="display: none">
    <div class="panel panel-default margin-top-10">
      <div class="panel-heading">
        <h3 class="panel-title">
          <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
          <strong id="titulo_examen">{$examen["Exa_Descripcion"]}</strong>
        </h3>
      </div>
      {if strlen($leccion["Lec_Descripcion"]) > 0 }
      <div class="panel-body" style=" margin: 15px 25px">          
        <div  class="col-lg-12" style="padding-bottom: 10px; display: none"  id="examen-contenido">

          <div class="col-lg-12" style="font-weight: bolt; color:red;margin-bottom: 20px !important">
            {if $intentos == 0 && $examen.Exa_Intentos!=0}
              <div>Primera vez por aquí, tienes <strong>{$examen.Exa_Intentos} intentos</strong> para terminar éste exámen con un <strong>{$examen.Exa_Porcentaje}%</strong> de preguntas correctas.</div>
            {else}
              <div><strong>{($intentos+1)}° intento</strong> para terminar éste exámen {if $examen.Exa_Porcentaje!=0} con un <strong>{$examen.Exa_Porcentaje}%</strong> de preguntas correctas.{/if}</div>
            {/if}
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
            <button class="btn btn-success" id="btnFinalizar">
              <span class="glyphicon glyphicon-check" aria-hidden="true"></span>
              Finalizar
            </button>
          </div>
        </div>
        <div class="col-lg-12" style="padding-bottom: 10px; display: none"  id="resultados-contenido">
          <center><h4><strong>Resultados</strong></h4></center>
          <div class="col-lg-12">
            <!--div class="alignelem answer-sorry">
              <h3>Lo sentimos, no has superado el examen</h3>
              <p class="answer-text">La nota mínima para superar el examen es un 80.0%</p>
            </div-->        
        
            <!--div class="alignelem circle answer-circle">
                <div class="c100 p30 red">
                    <span>30%</span>
                    <div class="slice">
                        <div class="bar"></div>
                        <div class="fill"></div>
                    </div>
                </div>
                <div class="answer-module-progress">

                </div>
            </div-->
          </div>
          <div id="contenido-respuestas" style="margin-bottom: 10px">
            
          </div>


          <div class="col-lg-12 margin-top-10" style="margin-top: 20px" >
            <div class="alert" role="alert" id="resultador-alerta">
              <span class="glyphicon" aria-hidden="true" id="resultador-alerta-icon"></span>
              <span class="sr-only">Error:</span>              
            </div>

            <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
              <button class="btn btn-success">
                <span class="glyphicon glyphicon-th-list" aria-hidden="true"></span>
                Ir a curso
              </button>
            </a>
          </div>


          



        </div>
      </div>   
      {else}  
      <div class="col-lg-12" style="margin-top: 20px">
        <strong>Ups!</strong>
        <div>Te quedaste sin intentos para terminar este examen :(</div>
      </div>
      {/if}
    </div>
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
