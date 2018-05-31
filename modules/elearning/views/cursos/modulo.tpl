<input value="{BASE_URL}" id="hiddenURL" hidden="hidden" />
<input value="{$modulo.Cur_IdCurso}" id="hiddenCurso" hidden="hidden" />
<div class="row gradiente">
    <br>
    <div class="col-lg-5 titulo-modulo" style="color: #eceff1">
       <h4><strong> Módulo {$mod_datos.INDEX}: {$modulo["Mod_Titulo"]}</strong></h4>
    </div>
    <div class="col-lg-5 derecha" style="margin-top: 5px !important">
        <span style="color: #fff">Lección {$leccion["Index"]} de {count($lecciones)}</span>
        {if $leccion["Index"] > 1 }
        <form method="post" action="{BASE_URL}elearning/cursos/_previous_leccion/" style="display: inline-block">
          <input value="{$curso}" name="curso" hidden="hidden"/>
          <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
          <button class="course-students-amount btn btn-next-previous"> 
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>  
            Anterior
          </button>
        </form>
        {else}
        <button class="course-students-amount btn btn-default" disabled="disabled"> 
            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>  
            Anterior
        </button>
        {/if}
        {if $leccion["Index"] < {count($lecciones)} }
        <form method="post" action="{BASE_URL}elearning/cursos/_next_leccion/" style="display: inline-block">
          <input value="{$curso}" name="curso" hidden="hidden"/>
          <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
          <button class="course-students-amount btn btn-next-previous"> 
            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
            Siguiente
          </button>
        </form>
        {else}
          <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
            <button class="course-students-amount btn-regresar btn btn-group"> 
              <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
              Ir al curso
            </button>
          </a>
        {/if}
    </div>
    <div class="col-lg-2" style="margin-top: 5px !important">
      <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
      <button class="course-students-amount btn-regresar btn btn-group"> 
        <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
        Volver al curso
      </button>
    </a>
    </div>
</div>

<div class="row">
  <div class="col-lg-12 leccion-container">
  <div class="col-lg-3" style="padding-right: 0px">
    
    {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
  </div>
  <div class="col-lg-9" style="padding-left:0px;"> 


    {if $leccion["Lec_Tipo"]==1}
    <div class="col-lg-12" style="padding-left:0px; padding-right:0px;">
      <div class="panel panel-default" style="border: none !important;">
         <div class="panel-heading cabecera-titulo">
          <h3 class="panel-title">
            
            <strong>{$leccion["Lec_Titulo"]}</strong>
          </h3>
        </div>
        <div class="panel-body contenedor-clase">
            {if isset($cont_html) && count($cont_html)>0}
              {foreach from=$cont_html item=h}        
                <div class="col-lg-12" style="text-align: justify;">{html_entity_decode($h.CL_Descripcion)}</div>          
              {/foreach}
            {/if}
        </div>
      </div>
    </div>
    {/if}



    {if $leccion["Lec_Tipo"]==2}
    <div class="col-lg-12" style="padding-left:0px; padding-right:0px;">
      <div class="panel panel-default" style="border: none !important;">
         <div class="panel-heading cabecera-titulo">
          <h3 class="panel-title">
            
            <strong>{$leccion["Lec_Titulo"]}</strong>
          </h3>
        </div>
        <div class="panel-body contenedor-clase">
          {if isset($html) && count($html) > 0 }
            <div class="video" id="video" >
              <iframe width="100%" src="{$html.CL_Descripcion}" frameborder="0" 
              allow="autoplay; encrypted-media" id="frame-video" allowfullscreen> </iframe>
            </div>
          {/if}
        </div>
      </div>
    </div>
    {/if} 



    {if $leccion["Lec_Tipo"]==3}
    {include file='modules/elearning/views/cursos/examen.tpl'}
    <div class="col-lg-12" id="leccion-contenido" style="padding-left:0px; padding-right:0px;">
      <div class="panel panel-default" style="border: none !important;">
          <div class="panel-heading cabecera-titulo">
          <h3 class="panel-title">
            
            <strong>{$leccion["Lec_Titulo"]}</strong>
          </h3>
        </div>
        <div class="panel-body contenedor-clase">
     
          {if $leccion["Progreso"]==1}
          <div class="row">
            <div class="col-lg-9">
              <div class="alert alert-success" role="alert">
                  <h3>!Enhorabuena¡ !Usted ya aprobó su exámen¡</h3>
                  <small>Superaste el {$examen.Exa_Porcentaje}% de preguntas correctas, puedes continuar con el siguiente módulo.
                  </small>
                  <h3></h3>
              </div>
            </div> 
            <div class="col-lg-3 circulo">
              <div class="progress" data-toggle="tooltip" data-placement="top" title="" data-original-title="Your progress">
                <div class="clip-1">
                  <div class="slice-1" style="-webkit-transform:rotate({$ang_1}deg);-moz-transform:rotate({$ang_1}deg);-o-transform:rotate({$ang_1}deg);transform:rotate({$ang_1}deg);">                  
                  </div>
                </div>
                <div class="clip-2">
                  <div class="slice-2" style="-webkit-transform:rotate({$ang_2}deg);-moz-transform:rotate({$ang_2}deg);-o-transform:rotate({$ang_2}deg);transform:rotate({$ang_2}deg);">                      
                  </div>
                </div>
                <div class="label">
                {$resultados.CORRECTAS*100/($resultados.CORRECTAS + $resultados.INCORRECTAS)}%
                </div>
              </div> 
            </div>
            {if isset($resultados) }
            <div class="col-lg-12">
              <label>Informe de Resultados: </label>              
            </div>
            <div class="col-lg-12">
              <div class="progress">
                {if $resultados.CORRECTAS > 0}
                <div class="progress-bar progress-bar-success" style="width:{$resultados.CORRECTAS*100/($resultados.CORRECTAS + $resultados.INCORRECTAS)}%">
                  <span class="sr-only">{$resultados.CORRECTAS}/{($resultados.CORRECTAS + $resultados.INCORRECTAS)}</span>
                </div>
                {/if}
                {if $resultados.INCORRECTAS > 0}
                <div class="progress-bar progress-bar-danger" style="width:{$resultados.INCORRECTAS*100/($resultados.CORRECTAS + $resultados.INCORRECTAS)}%">
                  <span class="sr-only">{$resultados.INCORRECTAS}/{($resultados.CORRECTAS + $resultados.INCORRECTAS)}</span>
                </div>
                {/if}
              </div>
            </div>
            {/if}
            <div class="col-lg-12"><label>¿Y ahora qué?, puedes:</label></div>
            <div class="col-lg-12">
              <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
                <button class="btn btn-success">
                  <span class="glyphicon glyphicon-book" aria-hidden="true"></span>
                  Volver al índice del curso
                </button>
              </a>
            </div>
            <div class="col-lg-12" style="margin-top: 5px">
              <a href="{BASE_URL}elearning/cursos/modulo/{$curso}/{$next_mod[0].Mod_IdModulo}/{$next_mod[0].Leccion}">
                <button class="btn btn-success">
                  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                  Ir al siguiente módulo
                </button>
              </a>
            </div>
          </div>
          {else} 

            {if $intentos == 0}
            <div class="col-lg-12"><!--id="leccion-contenido"-->
              <button id="btnExamen" class="btn btn-success">
                <span class="glyphicon glyphicon-file" aria-hidden="true"></span>
                Iniciar exámen
              </button>
            </div>   
            {else}



            <div class="col-lg-9">
              <div class="alert alert-danger" role="alert">
                  <h3>Lo sentimos, no has superado el exámen.</h3>
                  <small>Obtuviste {$resultados.CORRECTAS*100/($resultados.CORRECTAS + $resultados.INCORRECTAS)}% de aciertos en tu última evaluación. El procentaje mínimo de preguntas correctas para superar el exámen es {$examen.Exa_Porcentaje}%</small>
                  <h3></h3>
              </div>
            </div> 
            <div class="col-lg-3 circulo">
              <div class="progress" data-toggle="tooltip" data-placement="top" title="" data-original-title="Your progress">
                <div class="clip-1">
                  <div class="slice-1" style="-webkit-transform:rotate({$ang_1}deg);-moz-transform:rotate({$ang_1}deg);-o-transform:rotate({$ang_1}deg);transform:rotate({$ang_1}deg);">                  
                  </div>
                </div>
                <div class="clip-2">
                  <div class="slice-2" style="-webkit-transform:rotate({$ang_2}deg);-moz-transform:rotate({$ang_2}deg);-o-transform:rotate({$ang_2}deg);transform:rotate({$ang_2}deg);">                      
                  </div>
                </div>
                <div class="label">
                {$resultados.CORRECTAS*100/($resultados.CORRECTAS + $resultados.INCORRECTAS)}%
                </div>
              </div> 
            </div>
            {if isset($resultados) }
            <div class="col-lg-12">
              <label>Informe de Resultados: </label>              
            </div>
            <div class="col-lg-12">
              <div class="progress">
                {if $resultados.CORRECTAS > 0}
                <div class="progress-bar progress-bar-success" style="width:{$resultados.CORRECTAS*100/($resultados.CORRECTAS + $resultados.INCORRECTAS)}%">
                  <span class="sr-only">{$resultados.CORRECTAS}/{($resultados.CORRECTAS + $resultados.INCORRECTAS)}</span>
                </div>
                {/if}
                {if $resultados.INCORRECTAS > 0}
                <div class="progress-bar progress-bar-danger" style="width:{$resultados.INCORRECTAS*100/($resultados.CORRECTAS + $resultados.INCORRECTAS)}%">
                  <span class="sr-only">{$resultados.INCORRECTAS}/{($resultados.CORRECTAS + $resultados.INCORRECTAS)}</span>
                </div>
                {/if}
              </div>
            </div>
            {/if}

            <div class="col-lg-12"><label>¿Y ahora qué?, puedes:</label></div>
            <div class="col-lg-12">
              <button id="btnExamen" class="btn btn-danger">
                <span class="glyphicon glyphicon-repeat" aria-hidden="true"></span>
                Volver a intentar el exámen
              </button>
            </div>
            <div class="col-lg-12" style="margin-top: 5px">
              <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
                <button class="btn btn-danger">
                  <span class="glyphicon glyphicon-repeat" aria-hidden="true"></span>
                  Repasar las lecciones del módulo
                </button>
              </a>
            </div>
            {/if}



            <!-- {if ($examen["Exa_Intentos"]==0 || ($examen["Exa_Intentos"] != 0 
            && $examen["Exa_Intentos"] >= $intentos))}
                 
            {/if} -->


          {/if}
        </div>
      </div>
    </div>
    {/if}
  </div>
  </div>

      <div class="col-lg-12">
      {include file='modules/elearning/views/cursos/menu/info_leccion.tpl'}
      </div>

</div>

<script type="text/javascript" src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js"></script>