<input value="{BASE_URL}" id="hiddenURL" hidden="hidden" />
<input value="{BASE_URL}elearning/" id="hidden_url" hidden="hidden" />
<input value="{$modulo.Cur_IdCurso}" id="hiddenCurso" hidden="hidden" />
<div class="col-xs-12 panel panel-default" style="margin-top:20px;">
    <div class="row gradiente">
        <br>
        {if isset($leccion) && count($leccion)}
        <div class="col-lg-5 titulo-modulo">
           <h4><strong> {$lang->get('str_modulo')} {$mod_datos.INDEX}: {$modulo["Moc_Titulo"]}</strong></h4>
        </div>

        <div class="col-sm-6 col-lg-5 derecha" style="margin-top: 5px !important">
            <span>{$lang->get('str_leccion')} {$leccion["Index"]} {$lang->get('str_de')} {count($lecciones)}</span>
            {if $leccion["Index"] > 1 }
            <form method="post" action="{BASE_URL}elearning/cursos/_previous_leccion/" style="display: inline-block">
              <input value="{$curso}" name="curso" hidden="hidden"/>
              <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
              <button class="course-students-amount btn btn-next-previous">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                {$lang->get('str_anterior')}
              </button>
            </form>
            {else}
            <button class="course-students-amount btn btn-default" disabled="disabled">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                {$lang->get('str_anterior')}
            </button>
            {/if}
            {if $leccion["Index"] < {count($lecciones)} }
            <form method="post" action="{BASE_URL}elearning/cursos/_next_leccion/" style="display: inline-block">
              <input value="{$curso}" name="curso" hidden="hidden"/>
              <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
              <button class="course-students-amount btn btn-next-previous">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                {$lang->get('str_siguiente')}
              </button>
            </form>
            {else}
              {if $leccion.Lec_Tipo == 3 }
                {if isset($ultimoexamen) && count($ultimoexamen) }
                  {if $ultimoexamen.Exl_Nota / $examen.Exa_Peso >= $parametrosCurso.Par_NotaMinima / $parametrosCurso.Par_NotaMaxima}
                    <!-- Para siguiente modulo tiene que aprobar el examen -->
                    <form method="post" action="{BASE_URL}elearning/cursos/_next_leccion/" style="display: inline-block">
                      <input value="{$curso}" name="curso" hidden="hidden"/>
                      <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
                      <button class="course-students-amount btn btn-next-previous">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        {$lang->get('str_siguiente')}
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
                    {$lang->get('str_siguiente')}
                  </button>
                </form>
              {/if}
            {/if}
        </div>
        {else}
        <div class="col-sm-6 col-lg-10"></div>
        {/if}
        <div class="col-sm-6 col-lg-2" style="margin-top: 5px !important">
          <a class="pull-right" href="{BASE_URL}elearning/cursos/curso/{$curso}">
          <button class="course-students-amount btn-regresar btn btn-group">
            <span class="glyphicon glyphicon-hand-left" aria-hidden="true"></span>
            {$lang->get('elearning_cursos_volver_curso')}
          </button>
        </a>
        </div>
    </div>

    <div class="row">
      <div class="col-xs-12 " style="background: #a0a0a0;">
        <div class="col-sm-12 col-md-3 col-lg-3" style="padding-left:0px; padding-right: 0px;">
          {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
        </div>
        <div class="col-sm-12 col-md-9 col-lg-9" style="padding-left:0px; padding-right: 0px;">
          
          <div class="col-xs-12"  style="padding-left:0px; padding-right:0px;">
            <div class="panel panel-default">
              
              <div class="panel-heading cabecera-titulo">
                <h3 class="panel-title">
                  {if isset($leccion) && count($leccion)}
                  <strong>{$leccion["Lec_Titulo"]}</strong>
                  {else}
                  <strong>Bienvenido al  {$lang->get('str_modulo')}  {$mod_datos.INDEX}: {$modulo[$mod_datos.INDEX]["Moc_Titulo"]}</strong>
                  {/if}
                </h3>
              </div>

              <div class="panel-body contenedor-clase">
                {if isset($leccion) && count($leccion)}
                    {if $leccion["Lec_Tipo"]==1 || $leccion["Lec_Tipo"]==6}
                      {if isset($cont_html) && count($cont_html)>0}
                          {foreach from=$cont_html item=h}
                            <div class="col-xs-12" style="text-align: justify;">{html_entity_decode($h.CL_Descripcion)}</div>
                          {/foreach}
                      {/if}
                    {/if}
                    {if $leccion["Lec_Tipo"]==2}
                      {if isset($html) && count($html) > 0 }
                        <div class="col-md-offset-1 col-md-10 " id="div_video" style="padding: 5px; border: 2px solid #00a65a;">
                              <object width="100%" height="344">
                                <param name="movie" id="video_curso_param"  value="http://www.youtube.com/v/{$html.CL_Descripcion}"></param>
                                <param name="allowFullScreen" value="true"></param>
                                <param name="allowscriptaccess" value="always"></param>
                                <embed id="video_curso_embed" src="http://www.youtube.com/v/{$html.CL_Descripcion}" type="application/x-shockwave-flash" allowscriptaccess="always" allowfullscreen="true" width="100%" height="344"></embed>
                              </object>
                          </div>
                      {/if}
                    {/if}
                    {if $leccion["Lec_Tipo"]==3}
                        {if isset($preguntas) && count($preguntas)}                        
                            <div  class="col-xs-12" style="padding-bottom: 20px;">
                                <form class="" role="form" method="post" action="" autocomplete="on">
                                    <input type="hidden" value="1" name="enviar" />

                                        {$i=1}
                                        {foreach item=rl from=$preguntas}
                                        <input type="hidden" value="{$rl.Pre_IdPregunta}"  name="id_preg{$i-1}" />
                                        <input type="hidden" value="{$rl.Pre_Tipo}"  name="tipo_preg{$i-1}" />
                                        <div class="row" >
                                        {if $rl.Pre_Tipo==1}
                                        
                                            <label class="col-xs-12 control-label " style="margin-bottom: 15px;">{$i}. {$rl.Pre_Descripcion}</label>
                                            {$j = 1}
                                            {foreach item=ra from=$rl.Alt}
                                            <div class="col-xs-12 alt_">
                                              <div class="col col-xs-1">
                                                
                                                {if $j == 1}
                                                <p class="col col-xs-3">a) </p>
                                                {/if}
                                                {if $j == 2}
                                                <p class="col col-xs-3">b) </p>
                                                {/if}
                                                {if $j == 3}
                                                <p class="col col-xs-3">c) </p>
                                                {/if}
                                                {if $j == 4}
                                                <p class="col col-xs-3">d) </p>
                                                {/if} 
                                                {if $j == 5}
                                                <p class="col col-xs-3">e) </p>
                                                {/if}
                                                {if $j == 6}
                                                <p class="col col-xs-3">f) </p>
                                                {/if}
                                                {if $j == 7}
                                                <p class="col col-xs-3">g) </p>
                                                {/if} 
                                                <input type="radio" value="{$ra.Alt_IdAlternativa}" required="" onclick="selectRadioClick(this);" class="col col-xs-9 radioalt" name="rpta_alt{$i-1}" id="rpta_alt{$i-1}_{$j}" /> 
                                              </div>
                                              <div class="col col-xs-11">
                                                <p class="">{$ra.Alt_Etiqueta}</p>
                                              </div>
                                            </div>
                                            {$j=$j+1}
                                            {/foreach}

                                        {else if $rl.Pre_Tipo==2}                
                                            <label class="col-xs-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                                            {$t = 0}{$j = 1}
                                            {foreach item=ra from=$rl.Alt}
                                            <div class="col-xs-12 alt_">
                                              <div class="col col-xs-1">  
                                                {if $j == 1}
                                                <p class="col col-xs-3">a) </p>
                                                {/if}
                                                {if $j == 2}
                                                <p class="col col-xs-3">b) </p>
                                                {/if}
                                                {if $j == 3}
                                                <p class="col col-xs-3">c) </p>
                                                {/if}
                                                {if $j == 4}
                                                <p class="col col-xs-3">d) </p>
                                                {/if} 
                                                {if $j == 5}
                                                <p class="col col-xs-3">e) </p>
                                                {/if}
                                                {if $j == 6}
                                                <p class="col col-xs-3">f) </p>
                                                {/if}
                                                {if $j == 7}
                                                <p class="col col-xs-3">g) </p>
                                                {/if} 

                                                <input type="checkbox" value="{$ra.Alt_IdAlternativa}" onclick="selectRadioClick(this);" class=" col col-xs-9 radioalt " name="rpta2_alt{$i-1}_index{$t}" id="rpta_alt{$i-1}_{$j}"/> 

                                                {if $ra.Alt_Check == 0}
                                                <input type="hidden" value="{$ra.Alt_IdAlternativa}" name="rpta2_alt{$i-1}_index{$t}_hd" id="rpta_alt{$i-1}_{$j}_hd">
                                                {/if}
                                              </div>
                                              <div class="col col-xs-11">
                                                <p class="control-lasbel">{$ra.Alt_Etiqueta}</p>
                                              </div>                                            
                                            </div>
                                            {$t=$t+1}
                                            {$j=$j+1}
                                            {/foreach}
                                        {else if $rl.Pre_Tipo==3}
                                            <label class="col-xs-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                                            {$arraydescripcion=explode("|", $rl.Pre_Descripcion2)}
                                            <div class="col-xs-12" style="margin-top:10px;">
                                            {$k = 0}
                                            {for $j = 0; $j < count($arraydescripcion); $j = $j + 2}
                                            {$arraydescripcion[$j]} {if $j + 1 <= count($arraydescripcion) - 1}<input type="text" value="" required="" class="text-bold text-success" name="rpta3_{$i-1}_index_{$k}" id="espacio_blanco" />{$k = $k + 1}{/if}
                                            {/for}
                                            </div>
                                        {else if $rl.Pre_Tipo==4}                
                                            <label class="col-xs-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                                            {for $j=0; $j<count($rl.Alt);$j=$j+2}
                                            <div class="col-xs-12" style="margin-top:10px;">
                                            <input type="hidden" value="{$rl.Alt[$j]['Alt_IdAlternativa']}"  name="rpta4_{$i-1}_index_{$j}" />
                                            <label class="control-label col-lg-8">{$j+1} {$rl.Alt[$j]['Alt_Etiqueta']}</label>
                                            {$l=1}
                                            <div class="col-lg-4">
                                            <select name="rpta4_alt{$i-1}_index_{$j}" class="form-control">
                                              <option value="" > Select </option>
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
                                            <label class="control-label col-xs-12">{$m}. {$rl.Alt[$j]['Alt_Etiqueta']}</label><br/>
                                            {$m=$m+1}
                                            {/for}
                                            </div> -->
                                        {else if $rl.Pre_Tipo==5}                
                                            <label class="col-xs-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                                            <div class="col-xs-12">
                                                <textarea rows="5" placeholder="Respuesta" class="form-control col-xs-12" name="rpta_alt{$i-1}" required="" id="rpta_alt{$i-1}" style="margin-top:10px;"></textarea>
                                            </div>
                                        {else if $rl.Pre_Tipo==7}                
                                           <label class="col-xs-12 control-label">{$i}. {$rl.Pre_Descripcion}</label>
                                            {$t=0}
                                            {foreach item=ra from=$rl.Alt}
                                            <div class="col-xs-12">
                                                <input type="checkbox" value="{$ra.Alt_IdAlternativa}" class="radioalt margin-top-10" name="rpta7_alt{$i-1}_index{$t}" style="margin-top:10px;"/><label class="control-label">{$ra.Alt_Etiqueta}</label>
                                            </div>
                                            {$t=$t+1}
                                            {/foreach}
                                        {/if}

                                        </div>
                                        <hr class="cursos-hr">
                                        {$i=$i+1}
                                        {/foreach}

                                    <div class="form-group">
                                        <button class="btn btn-success margin-t-10" name="terminar" id="terminar">Terminar</button>
                                    </div>
                                </form>
                            </div>
                        {else}
                            {if isset($ultimoexamen) && count($ultimoexamen) }
                                {if $ultimoexamen.Exl_Nota / $examen.Exa_Peso >= $parametrosCurso.Par_NotaMinima / $parametrosCurso.Par_NotaMaxima}
                                    <div class="row">
                                        <div class="col-xs-12">
                                          <div class="alert alert-success" role="alert">
                                              <h3>¡{$lang->get('str_enhorabuen')}! ¡{$lang->get('elearning_cursos_usted_aprobo_examen')}!</h3>
                                              <small>Porcentaje minimo para aprobar el examen: <strong style="font-size: 15px;"> {($parametrosCurso.Par_NotaMinima / $parametrosCurso.Par_NotaMaxima) * 100}% </strong>.</small><br>
                                              <small>{$lang->get('str_obtuviste')} {$ultimoexamen.Exl_Nota} {$lang->get('elearning_cursos_puntos_de')} {$examen.Exa_Peso}
                                              </small>
                                              <h3></h3>
                                          </div>
                                        </div>
                                        <div class="col-xs-12 circulo">
                                          <div class="progress" data-toggle="tooltip" data-placement="top" title="{$lang->get('elearning_cursos_tu_progeso')}" data-original-title="{$lang->get('elearning_cursos_tu_progeso')}">
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
                                                    <label class="col-xs-12 control-label">{$lang->get('elearning_cursos_numero_intentos')}: {$intentos.intentos} {$lang->get('str_de')} {$examen.Exa_Intentos}</label>
                                                    <div class="col-xs-12">
                                                      <p></p>
                                                      <p>{$lang->get('elearning_cursos_presionar_comenzar_cuenta_intento')}.</p>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                  <div class="col-xs-offset-3 col-xs-3">
                                                    <button class="btn btn-success margin-top-10" name="comenzar" id="comenzar">{$lang->get('elearning_cursos_comenzar_prueba')}</button>
                                                  </div>
                                                </div>
                                            </form>
                                            <!-- Para siguiente modulo tiene que aprobar el examen -->
                                            <form method="post" action="{BASE_URL}elearning/cursos/_next_leccion/" >
                                              <input value="{$curso}" name="curso" hidden="hidden"/>
                                              <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
                                              <button class="col-xs-offset-2 col-xs-2 btn btn-primary btn-next-previous">
                                                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                                {$lang->get('str_siguiente')}
                                              </button>
                                            </form>
                                          </div>
                                        {else}
                                        <div style="width: 100%; margin: 0px auto; text-align:center;">
                                            <div class="form-group">
                                                <label class="col-xs-12 control-label">{$lang->get('elearning_cursos_numero_intentos')}: {$intentos.intentos} {$lang->get('str_de')} {$examen.Exa_Intentos}</label>
                                                <div class="col-xs-12">
                                                <p></p>
                                                    <p>{$lang->get('elearning_cursos_usted_no_mas_intento')}</p>
                                                </div>
                                            </div>
                                            <!-- Para siguiente modulo tiene que aprobar el examen -->
                                            <form method="post" action="{BASE_URL}elearning/cursos/_next_leccion/" >
                                              <input value="{$curso}" name="curso" hidden="hidden"/>
                                              <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
                                              <button class="col-xs-offset-5 col-xs-2 btn btn-primary btn-next-previous">
                                                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                                {$lang->get('str_siguiente')}
                                              </button>
                                            </form>
                                          </div>
                                        {/if}
                                    </div>                            
                                {else}
                                    <div class="col-xs-12">
                                      <div class="alert alert-danger" role="alert">
                                          <h3>{$lang->get('elearning_cursos_losiento_no_supera_examen')}.</h3>
                                          <small>Porcentaje minimo para aprobar el examen: <strong style="font-size: 15px;"> {($parametrosCurso.Par_NotaMinima / $parametrosCurso.Par_NotaMaxima) * 100}% </strong>.</small><br>
                                          <small>{$lang->get('str_obtuviste')} {$ultimoexamen.Exl_Nota} {$lang->get('elearning_cursos_puntos_de')} {$examen.Exa_Peso}</small>
                                          <h3></h3>
                                      </div>
                                    </div>
                                    <div class="col-xs-12 circulo">
                                      <div class="progress" data-toggle="tooltip" data-placement="top" title="{$lang->get('elearning_cursos_tu_progeso')}" data-original-title="{$lang->get('elearning_cursos_tu_progeso')}">
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
                                                  <label class="col-xs-12 control-label">{$lang->get('elearning_cursos_numero_intentos')}: {$intentos.intentos} {$lang->get('str_de')} {$examen.Exa_Intentos}</label>
                                                  <div class="col-xs-12">
                                                      
                                                      <p>{$lang->get('elearning_cursos_presionar_comenzar_cuenta_intento')}.</p>
                                                  </div>
                                              </div>
                                              <div class="form-group">
                                                  <div class="col-xs-12">
                                                   <button class="btn btn-success margin-top-10" name="comenzar" id="comenzar">{$lang->get('elearning_cursos_comenzar_prueba')}</button>
                                                  </div>
                                              </div>
                                          </form>
                                      </div>
                                    {else}
                                      <div style="width: 100%; margin: 0px auto; text-align:center;">
                                        <div class="form-group">
                                            <label class="col-xs-12 control-label">{$lang->get('elearning_cursos_numero_intentos')}: {$intentos.intentos} {$lang->get('str_de')} {$examen.Exa_Intentos}</label>
                                            <div class="col-xs-12">
                                            <p></p>
                                                <p>{$lang->get('elearning_cursos_usted_no_mas_intento')}</p>
                                            </div>
                                            <div class="col-xs-12" style="font-size: 16px;">
                                              <div><strong><i class="glyphicon glyphicon-education"></i>
                                              &nbsp;{$lang->get('str_docente')}</strong></div>
                                              <div style="padding-left: 25px"><a href="{BASE_URL}elearning/cursos/ficha/{$curso_datos.Cur_IdCurso}">{$curso_datos['Detalle'].Docente|default:"---"}</a>   </div> <br/>
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
                                          <h3>{$lang->get('elearning_cursos_usted_no_realizo_intento')}</h3>
                                          <label class="col-xs-12 control-label">{$lang->get('elearning_cursos_numero_intentos')} {strtolower($lang->get('str_disponibles'))}: {$examen.Exa_Intentos}</label>
                                          <div class="col-xs-12">
                                          <p></p>
                                              <p>{$lang->get('elearning_cursos_presionar_comenzar_cuenta_intento')}.</p>
                                          </div>
                                      </div>
                                      <div class="form-group">
                                          <div class="col-xs-12">
                                           <button class="btn btn-success margin-top-10" name="comenzar" id="comenzar">{$lang->get('elearning_cursos_comenzar_prueba')}</button>
                                          </div>
                                      </div>
                                  </form>
                                </div>
                                <!-- {if ($examen["Exa_Intentos"]==0 || ($examen["Exa_Intentos"] != 0
                                && $examen["Exa_Intentos"] >= $intentos))}

                                {/if} -->
                            {/if}
                        {/if}
                    {/if}
                {else}
                    {$modulo[$mod_datos.INDEX]["Moc_Descripcion"]}

                    {if isset($modulo[$mod_datos.INDEX][LECCIONES][0]) && count($modulo[$mod_datos.INDEX][LECCIONES])>0}
                        {if $modulo[$mod_datos.INDEX][LECCIONES][0]['Disponible'] == 0 && $iniciar == 0}
                          <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10 ficha-mod-title">
                            <a  href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$modulo[$mod_datos.INDEX].Moc_IdModuloCurso}/{$modulo[$mod_datos.INDEX].LECCIONES[0]['Lec_IdLeccion']}" class="btn btn-success pull-right">Iniciar</a>
                          </div>
                        {/if}
                    {/if}

                {/if}
              </div>

              {if isset($leccion) && count($leccion)}
              <div class="panel-footer" style="background-color: transparent;">
                  <div class="row" style="padding-left:0px; padding-right: 0px;">
                    {include file='modules/elearning/views/cursos/menu/info_leccion.tpl'}
                  </div>
              </div>
              {/if}

            </div>
          </div>



        </div>

<!-- 
              <div class="col-xs-12" style="padding-left:0px; padding-right: 0px;">
                {include file='modules/elearning/views/cursos/menu/info_leccion.tpl'}
              </div> -->


      </div>
    </div>
</div>

      

<script type="text/javascript" src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js"></script>
