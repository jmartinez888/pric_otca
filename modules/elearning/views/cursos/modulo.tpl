<input value="{BASE_URL}" id="hiddenURL" hidden="hidden" />
<input value="{BASE_URL}elearning/" id="hidden_url" hidden="hidden" />
<input value="{$modulo.Cur_IdCurso}" id="hiddenCurso" hidden="hidden" />
<div class="col-lg-12 panel panel-default" style="margin-top:20px;">
  <div class="row gradiente">
      <br>
      <div class="col-lg-5 titulo-modulo">
         <h4><strong> Módulo {$mod_datos.INDEX}: {$modulo["Moc_Titulo"]}</strong></h4>
      </div>
      <div class="col-sm-6 col-lg-5 derecha" style="margin-top: 5px !important">
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
                {if ($ultimoexamen.Exl_Nota/$examen.Exa_Peso) > ($parametrosCurso.Par_NotaMinima/$parametrosCurso.Par_NotaMaxima)}
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
      <div class="col-sm-6 col-lg-2" style="margin-top: 5px !important">
        <a class="pull-right" href="{BASE_URL}elearning/cursos/curso/{$curso}">
        <button class="course-students-amount btn-regresar btn btn-group">
          <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
          Volver al curso
        </button>
      </a>
      </div>
  </div>

<div class="row">
  <div class="col-lg-12 ">
  <div class="col-sm-12 col-md-3 col-lg-3" style="padding-left:0px; padding-right: 0px;">

    {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}

  </div>
  <div class="col-sm-12 col-md-9 col-lg-9" style="padding-left:0px; padding-right: 0px;">


    {if $leccion["Lec_Tipo"]==1 || $leccion["Lec_Tipo"]==6}
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
          
            {if isset($html) && strlen({$html.CL_Descripcion}) > 0}
              <div class="col-md-offset-1 col-md-10 " id="div_video" style="padding: 5px; border: 2px solid #00a65a;">
                  <object width="100%" height="344">
                    <param name="movie" id="video_curso_param"  value="http://www.youtube.com/v/{$html.CL_Descripcion}"></param>
                    <param name="allowFullScreen" value="true"></param>
                    <param name="allowscriptaccess" value="always"></param>
                    <embed id="video_curso_embed" src="http://www.youtube.com/v/{$html.CL_Descripcion}" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="100%" height="344"></embed>
                  </object>
              </div>
          {/if}
        </div>
      </div>
    </div>
    {/if}

    {if $leccion["Lec_Tipo"]==3}

        {if isset($preguntas) && count($preguntas) > 0}

          <div class="col col-lg-12">
              <div class="panel-heading cabecera-titulo">
                <h3 class="panel-title">
                  <strong>{$leccion["Lec_Titulo"]}</strong>
                </h3>
              </div>
          </div>
          <div  class="col-lg-12 margin-t-10">
          <form class="" role="form" method="post" action="" autocomplete="on">
              <input type="hidden" value="1" name="enviar" />
              {if isset($preguntas) && count($preguntas)}
              {$i=1}
              {foreach item=rl from=$preguntas}
              <input type="hidden" value="{$rl.Pre_IdPregunta}"  name="id_preg{$i-1}" />
              <input type="hidden" value="{$rl.Pre_Tipo}"  name="tipo_preg{$i-1}" />
              <div class="row" style="margin-bottom: 20px;">
              {if $rl.Pre_Tipo==1}
              
                  <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                  {foreach item=ra from=$rl.Alt}
                  <div class="col-lg-12">
                      <input type="radio" value="{$ra.Alt_IdAlternativa}" class="radioalt margin-top-10" name="rpta_alt{$i-1}" style="margin-top:10px;"/><label class="control-label">{$ra.Alt_Etiqueta}</label>
                  </div>
                  {/foreach}
              {else if $rl.Pre_Tipo==2}                
                  <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                  {$t=0}
                  {foreach item=ra from=$rl.Alt}
                  <div class="col-lg-12">
                      <input type="checkbox" value="{$ra.Alt_IdAlternativa}" class="radioalt margin-top-10" name="rpta2_alt{$i-1}_index{$t}" style="margin-top:10px;"/><label class="control-label">{$ra.Alt_Etiqueta}</label>
                  </div>
                  {$t=$t+1}
                  {/foreach}
              {else if $rl.Pre_Tipo==3}
                  <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                  {$arraydescripcion=explode("|", $rl.Pre_Descripcion2)}
                  <div class="col-lg-12" style="margin-top:10px;">
                  {$k=0}
                  {for $j=0; $j<count($arraydescripcion);$j=$j+2}
                  <label class="control-label">{$arraydescripcion[$j]}</label>{if $j+1<=count($arraydescripcion)-1}<input type="text" value="" name="rpta3_{$i-1}_index_{$k}" style="margin-left:5px; margin-right:5px;"/>{$k=$k+1}{/if}
                  {/for}
                  </div>
              {else if $rl.Pre_Tipo==4}                
                  <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                  {for $j=0; $j<count($rl.Alt);$j=$j+2}
                  <div class="col-lg-12" style="margin-top:10px;">
                  <input type="hidden" value="{$rl.Alt[$j]['Alt_IdAlternativa']}"  name="rpta4_{$i-1}_index_{$j}" />
                  <label class="control-label col-lg-8">{$j+1} {$rl.Alt[$j]['Alt_Etiqueta']}</label>
                  {$l=1}
                  <div class="col-lg-4">
                  <select name="rpta4_alt{$i-1}_index_{$j}" class="form-control">
                  {for $k=1; $k<count($rl.Alt);$k=$k+2}
                  <option value="{$rl.Alt[$k]['Alt_IdAlternativa']}" >{$rl.Alt[$k]['Alt_Etiqueta']}</option>
                  {$l=$l+1}
                  {/for}
                  </select>
                  </div>
                  </div>
                  {/for}
                  <!-- {$m=1}
                  <div class="col-lg-2">
                  {for $j=1; $j<count($rl.Alt);$j=$j+2}
                  <label class="control-label col-lg-12">{$m}. {$rl.Alt[$j]['Alt_Etiqueta']}</label><br/>
                  {$m=$m+1}
                  {/for}
                  </div> -->
              {else if $rl.Pre_Tipo==5}                
                  <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                  <div class="col-lg-12">
                      <textarea rows="5" placeholder="Respuesta" class="form-control col-lg-12" name="rpta_alt{$i-1}" id="rpta_alt{$i-1}" style="margin-top:10px;"></textarea>
                  </div>
              {else if $rl.Pre_Tipo==7}                
                 <label class="col-lg-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                  {$t=0}
                  {foreach item=ra from=$rl.Alt}
                  <div class="col-lg-12">
                      <input type="checkbox" value="{$ra.Alt_IdAlternativa}" class="radioalt margin-top-10" name="rpta7_alt{$i-1}_index{$t}" style="margin-top:10px;"/><label class="control-label">{$ra.Alt_Etiqueta}</label>
                  </div>
                  {$t=$t+1}
                  {/foreach}
              {/if}

              </div>
              <hr class="cursos-hr">
              {$i=$i+1}
              {/foreach}
              {/if}
              <div class="form-group">
                  <div class="col-lg-12">
                   <button class="btn btn-success margin-top-10" name="terminar" id="terminar">Terminar</button>
                  </div>
              </div>
          </form>
      </div>


        {else}
        <div class="col-lg-12" id="leccion-contenido" style="padding-left:0px; padding-right:0px;">
          <div class="panel panel-default">
              <div class="panel-heading cabecera-titulo">
              <h3 class="panel-title">
                <strong>{$leccion["Lec_Titulo"]}</strong>
              </h3>
            </div>
            <div class="panel-body contenedor-clase">
              {if isset($ultimoexamen) && count($ultimoexamen) }
              {if ($ultimoexamen.Exl_Nota/$examen.Exa_Peso) > ($parametrosCurso.Par_NotaMinima/$parametrosCurso.Par_NotaMaxima)}
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
                            <div class="col-xs-offset-3 col-xs-3">
                             <button class="btn btn-success margin-t-10" name="comenzar" id="comenzar">Comenzar Prueba</button>
                            </div>
                        </div>
                    </form>
                    <!-- Validar -->
                    <form method="post" action="{BASE_URL}elearning/cursos/_next_leccion/" >
                      <input value="{$curso}" name="curso" hidden="hidden"/>
                      <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
                      <button class="margin-t-10 course-students-amount btn btn-primary btn-next-previous col-xs-3">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        Siguiente
                      </button>
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

    {/if}

  </div>
  </div>
</div>
</div>

      <div class="col-lg-12" style="padding-left:0px; padding-right: 0px;">
      {include file='modules/elearning/views/cursos/menu/info_leccion.tpl'}
      </div>

<script type="text/javascript" src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js"></script>
