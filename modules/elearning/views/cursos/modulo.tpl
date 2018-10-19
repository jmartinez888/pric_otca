<input value="{BASE_URL}" id="hiddenURL" hidden="hidden" />
<input value="{BASE_URL}elearning/" id="hidden_url" hidden="hidden" />
<input value="{$modulo.Cur_IdCurso}" id="hiddenCurso" hidden="hidden" />
<div class="col-lg-12 panel panel-default" style="margin-top:20px;">
  <div class="row gradiente">
      <br>
      <div class="col-lg-5 titulo-modulo">
         <h4><strong> Módulo {$mod_datos.INDEX}: {$modulo["Moc_Titulo"]}</strong></h4>
      </div>
      <div class="col-lg-5 derecha" style="margin-top: 5px !important">
          <span>Lección {$leccion["Index"]} de {count($lecciones)}</span>
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
            {if $leccion.Lec_Tipo == 3 }
              {if isset($ultimoexamen) && count($ultimoexamen) }
                {if $ultimoexamen.Exl_Nota*100/$examen.Exa_Peso>50}
                <!-- Para siguiente modulo tiene que aprobar el examen -->
                <form method="post" action="{BASE_URL}elearning/cursos/_next_leccion/" style="display: inline-block">
                  <input value="{$curso}" name="curso" hidden="hidden"/>
                  <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
                  <button class="course-students-amount btn btn-next-previous">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    Siguiente
                  </button>
                </form>
                {/if}
              {/if}
            {else}
            <!-- para el siguiente modulo -->
              <form method="post" action="{BASE_URL}elearning/cursos/_next_leccion/" style="display: inline-block">
                <input value="{$curso}" name="curso" hidden="hidden"/>
                <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
                <button class="course-students-amount btn btn-next-previous">
                  <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                  Siguiente
                </button>
              </form>
            {/if}
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
  <div class="col-lg-3" style="padding-left:0px; padding-right: 0px;">

    {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
  </div>
  <div class="col-lg-9" style="padding-left:0px; padding-right: 0px;">


    {if $leccion["Lec_Tipo"]==1}
    <div class="col-lg-12" style="padding-left:0px; padding-right:0px;">
      <div class="panel panel-default">
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
      <div class="panel panel-default">
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
    <div class="col-lg-12" id="leccion-contenido" style="padding-left:0px; padding-right:0px;">
      <div class="panel panel-default">
          <div class="panel-heading cabecera-titulo">
          <h3 class="panel-title">

            <strong>{$leccion["Lec_Titulo"]}</strong>
          </h3>
        </div>
        <div class="panel-body contenedor-clase">
          {if isset($ultimoexamen) && count($ultimoexamen) }
          {if $ultimoexamen.Exl_Nota*100/$examen.Exa_Peso>50}
          <div class="row">
            <div class="col-lg-12">
              <div class="alert alert-success" role="alert">
                  <h3>¡Enhorabuena! ¡Usted ya aprobó su exámen!</h3>
                  <small>Obtuviste {$ultimoexamen.Exl_Nota} puntos de {$examen.Exa_Peso}
                  </small>
                  <h3></h3>
              </div>
            </div> 
            <div class="col-lg-12 circulo">
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
                {$ultimoexamen.Exl_Nota*100/$examen.Exa_Peso}%
                </div>
              </div>
            </div>

          {if $restantes > 0}
            <div style="width: 100%; margin: 0px auto; text-align:center;">
            <form class="" role="form" method="post" action="" autocomplete="on">
                <input type="hidden" value="1" name="enviar" />
               
                <div class="form-group">
                        
                    <label class="col-lg-12 control-label">Número de intentos: {$intentos.intentos} de {$examen.Exa_Intentos}</label>
                    <div class="col-lg-12">
                    <p></p>
                        <p>Al presionar el botón de Comenzar Prueba se contabilizará un intento.</p>
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="col-lg-12">
                     <button class="btn btn-success margin-top-10" name="comenzar" id="comenzar">Comenzar Prueba</button>
                    </div>
                </div>
            </form>
        </div>
            {else}
            <div style="width: 100%; margin: 0px auto; text-align:center;">
                <div class="form-group">
                        
                    <label class="col-lg-12 control-label">Número de intentos: {$intentos.intentos} de {$examen.Exa_Intentos}</label>
                    <div class="col-lg-12">
                    <p></p>
                        <p>Usted ya no cuenta con más intentos</p>
                    </div>
                </div>
              </div>
            {/if}
          </div>
          {else}
            <div class="col-lg-12">
              <div class="alert alert-danger" role="alert">
                  <h3>Lo sentimos, no has superado el exámen.</h3>
                  <small>Obtuviste {$ultimoexamen.Exl_Nota} puntos de {$examen.Exa_Peso}</small>
                  <h3></h3>
              </div>
            </div> 
            <div class="col-lg-12 circulo">
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
                {$ultimoexamen.Exl_Nota*100/$examen.Exa_Peso}%
                </div>
              </div>
            </div>
            {if $restantes > 0}
            <div style="width: 100%; margin: 0px auto; text-align:center;">
            <form class="" role="form" method="post" action="" autocomplete="on">
                <input type="hidden" value="1" name="enviar" />
               
                <div class="form-group">
                        
                    <label class="col-lg-12 control-label">Número de intentos: {$intentos.intentos} de {$examen.Exa_Intentos}</label>
                    <div class="col-lg-12">
                    <p></p>
                        <p>Al presionar el botón de Comenzar Prueba se contabilizará un intento.</p>
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="col-lg-12">
                     <button class="btn btn-success margin-top-10" name="comenzar" id="comenzar">Comenzar Prueba</button>
                    </div>
                </div>
            </form>
        </div>
            {else}
            <div style="width: 100%; margin: 0px auto; text-align:center;">
                <div class="form-group">
                        
                    <label class="col-lg-12 control-label">Número de intentos: {$intentos.intentos} de {$examen.Exa_Intentos}</label>
                    <div class="col-lg-12">
                    <p></p>
                        <p>Usted ya no cuenta con más intentos</p>
                    </div>
                </div>
              </div>
            {/if}
            {/if}
            {else}
              <div style="width: 100%; margin: 0px auto; text-align:center;">
               <form class="" role="form" method="post" action="" autocomplete="on">
                <input type="hidden" value="1" name="enviar" />
               
                <div class="form-group">
                    <h3>Usted no ha realizado ningún intento hasta el momento</h3>
                    <label class="col-lg-12 control-label">Número de intentos disponibles: {$examen.Exa_Intentos}</label>
                    <div class="col-lg-12">
                    <p></p>
                        <p>Al presionar el botón de Comenzar Prueba se contabilizará un intento.</p>
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="col-lg-12">
                     <button class="btn btn-success margin-top-10" name="comenzar" id="comenzar">Comenzar Prueba</button>
                    </div>
                </div>
            </form>
            </div>
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
</div>
</div>

      <div class="col-lg-12" style="padding-left:0px; padding-right: 0px;">
      {include file='modules/elearning/views/cursos/menu/info_leccion.tpl'}
      </div>

<script type="text/javascript" src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js"></script>
