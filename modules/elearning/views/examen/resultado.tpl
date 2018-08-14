{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-9" style="padding-left:0px; padding-right:0px;">
<div class="col-lg-12">
        <h3>Resultados</h3>
        <hr class="cursos-hr">
    </div>
   <div style="width: 100%; text-align:center;" class="panel-body contenedor-clase">
    <div class="row">

            
            <div class="col-lg-12">
            {if $abierta==2}
                <div class="alert alert-warning" role="alert">
                  <h3>Usted ha acumulado {$puntos} de {$peso} puntos</h3>
                  <h4>Ahora espere a que el docente corrija las preguntas faltantes.</h4>
                  <h3></h3>
              </div>
            {else}
            {if $puntos*100/$peso>50}
              <div class="alert alert-success" role="alert">
                  <h3>¡Enhorabuena!, ha aprobado el examen</h3>
                  <h4>Usted ha obtenido {$puntos} de {$peso} puntos</h4>
                  <h3></h3>
              </div>
            {else}
             <div class="alert alert-danger" role="alert">
                  <h3>Lo sentimos, no has superado el exámen.</h3>
                  <h4>Usted ha obtenido {$puntos} de {$peso} puntos</h4>
                  <h3></h3>
              </div>
            {/if}
            {/if}
            </div> 

           <!-- <div class="col-lg-12 circulo">
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
                10%
                </div>
              </div>
            </div> -->
<!--              {if isset($resultados) }
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
                <button class="btn btn-success" style="margin-right: 10px">
                  <span class="glyphicon glyphicon-book" aria-hidden="true"></span>
                  Volver al índice del curso
                </button>
              </a>

              <a href="{BASE_URL}elearning/cursos/modulo/{$curso}/{$next_mod[0].Mod_IdModulo}/{$next_mod[0].Leccion}">
                <button class="btn btn-success">
                  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                  Ir al siguiente módulo
                </button>
              </a>
            </div> -->
          </div>
    
    <form class="" role="form" method="post" action="" autocomplete="on">
        <input type="hidden" value="1" name="enviar" />
       
        <!-- <div class="form-group">
                
            <label class="col-lg-12 control-label">Usted ha obtenido {$puntos} de {$peso}</label>
            <div class="col-lg-12">
            <p></p>
                <p>Al presionar el botón de Comenzar Prueba se contabilizará un intento.</p>
            </div>
        </div> -->
        
        <div class="form-group">
            <div class="col-lg-12">
             <button class="btn btn-success margin-top-10" name="comenzar" id="comenzar">Comenzar Prueba</button>
            </div>
        </div>
    </form>
</div>
</div>
