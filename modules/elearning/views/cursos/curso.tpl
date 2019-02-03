<input type="text" id="inHiddenCurso" value="{$curso.Cur_IdCurso}" hidden="hidden"> <!-- RODRIGO 20180607 -->
<div class="col col-xs-12">
  <div class="col-xs-12">
    <div class="col-xs-12 referencia-curso-total">
      <a class="referencia-curso" href="{BASE_URL}elearning/cursos/">{$lang->get('str_cursos')}</a>  /  {$curso.Cur_Titulo}
    </div>
  </div>
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-xs-12 col-sm-12 col-md-9 col-lg-10" style="margin-top: 20px;">
    <div class="">
      <div class="panel panel-default">
        <div class="panel-body">
          <div class="col-xs-12" style="padding-left: 0px; padding-right: 0px;">
            <div class="col-lg-3 img-curso">
              <img class="w-100" src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$curso.Cur_UrlBanner}" />
              {if $curso.Moa_IdModalidad == 1}
              <div class="col-xs-12 text-center mooc" style="color: white; font-weight: bold; font-size: 18px;">MOOC</div>
              {else}
              <div class="col-xs-12 text-center pres" style="color: white; font-weight: bold; font-size: 18px;">{$lang->get('str_presencial')}</div>
              {/if}
            </div>
            <div class="col-lg-6">
            <br>
            <br>
            <h3 style="text-align: center; font-size: 35px;"><strong>{$curso.Cur_Titulo}</strong></h3>
            <br>
            </div>
            <div class="col-lg-3 row ic-sociales">
            <br>
            <br>
                <a class="btn fa fa-facebook im_sociales" id="im_sociales" style="background: #3B5998" href="#"></a>
                <a class="btn fa fa-twitter im_sociales" id="im_sociales" style="background: #55ACEE" href="#"></a>
                <a class="btn fa fa-google-plus im_sociales" id="im_sociales" style="background: #C03A2A" href="#"></a>
            </div>



          </div>

          <div class="col-xs-12">
            <hr class="cursos-hr">
          </div>

          <div class="col-lg-8">
            <iframe class="video-intro" width="100%" height="310" src="https://www.youtube.com/embed/{$curso.Cur_UrlVideoPresentacion}" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
          </div>

          <div class="col-lg-4">
            <center class="panel panel-default col-lg-10 info-curso">
              {if $curso.Moa_IdModalidad == 1}
              <div class="col-xs-12">
                <i class="glyphicon glyphicon-time" style="color: #16B8AD; font-size: 25px"></i>
                <br>
                <strong style="color: #393939; font-size: 16px">{$curso.Cur_Duracion|default: $duracion}</strong>
                <br><br>
              </div>
              {/if}

              {if $curso.Moa_IdModalidad == 1}
              <div class="col-xs-12" style="border-top: #ddd solid 0.2px; border-bottom: #ddd solid 0.2px;">
                <br>
                <i class="glyphicon glyphicon-user" style="color: #31A3BB; font-size: 25px"></i>
                <br>
                <strong style="color: #393939; font-size: 16px">{$inscritos}</strong>
                <br>
                {if $inscritos >= 2 }
                <strong style="color: #393939; font-size: 16px">{$lang->get('str_alumnos')}</strong>
                {else}
                <strong style="color: #393939; font-size: 16px">{$lang->get('str_alumno')}</strong>
                {/if}
                <br><br>
              </div>
              {/if}
              {if $curso.Moa_IdModalidad == 3}
              <a href="{$_layoutParams.root}elearning/cursos/respuestas_formulario/{$curso['Cur_IdCurso']}" title="">
              <div class="col-xs-12" style=" border-bottom: #ddd solid 0.2px;">
                <br>
                <i class="glyphicon glyphicon-user" style="color: #31A3BB; font-size: 25px"></i>
                <br>
                <strong style="color: #393939; font-size: 16px">{$inscritos}</strong>
                <br>
                {if $inscritos >= 2 }
                <strong style="color: #393939; font-size: 16px">{$lang->get('str_alumnos')}</strong>
                {else}
                <strong style="color: #393939; font-size: 16px">{$lang->get('str_alumno')}</strong>
                {/if}
                <br><br>
              </div>
              </a>
              {/if}


              <div class="col-xs-12">
                <br>
                <i class="glyphicon glyphicon-star" style="color: #E9BA46; font-size: 25px"></i>
                <br>
                <strong style="color: #393939; font-size: 16px">4/5</strong>
                <br>
                <strong style="color: #393939; font-size: 16px">{$lang->get('elearning_cursos_valoracion_media')}</strong>
              </div>

            </center>
          </div>

          <div class="col-xs-12 text-curso">
            <div>{$curso.Cur_Descripcion}</div> <br/>
          </div>

          {if isset($objetivos) && count($objetivos)>0}
          <div class="col-xs-12 text-curso">
            <div><strong><i class="glyphicon glyphicon-record"></i>
            &nbsp;Objetivos</strong></div>
            {foreach from=$objetivos item=o}
              <ul>
                <li class="list-objetivos">
                {$o.CO_Titulo}</li>
              </ul>
            {/foreach}
          </div>
          {/if}

          <div class="col-xs-12">
            <br/>
          </div>
          {if strlen($curso.Cur_PublicoObjetivo) > 2 && !empty($curso.Cur_PublicoObjetivo)}
          <div class="col-xs-12" style="font-size: 16px;">
            <div><strong><i class="glyphicon glyphicon-globe"></i>
            &nbsp;{$lang->get('elearning_cursos_publico_objetivo')}</strong></div>
            <div style="padding-left: 25px">{$curso.Cur_PublicoObjetivo|default:"---"}</div> <br/>
          </div>
          {/if}
          {if strlen($curso.Cur_Metodologia) > 2 && !empty($curso.Cur_Metodologia)}
          <div class="col-xs-12" style="font-size: 16px;">
            <div><strong><i class="glyphicon glyphicon-cog"></i>
            &nbsp;{$lang->get('str_metodologia')}</strong></div>
            <div style="padding-left: 25px">{$curso.Cur_Metodologia|default:"---"}</div> <br/>
          </div>
          {/if}
          {if strlen($curso['Detalle'].Docente) > 2 && !empty($curso['Detalle'].Docente)}
          <div class="col-xs-12" style="font-size: 16px;">
            <div><strong><i class="glyphicon glyphicon-education"></i>
            &nbsp;{$lang->get('str_docente')}</strong></div>
            <div style="padding-left: 25px"><a href="{BASE_URL}elearning/cursos/ficha/{$curso.Cur_IdCurso}">{$curso['Detalle'].Docente|default:"---"}</a>   </div> <br/>
          </div>
          {/if}
          {if strlen($curso.Cur_Contacto) > 2 && !empty($curso.Cur_Contacto)}
          <div class="col-xs-12" style="font-size: 16px;">
            <div><strong><i class="glyphicon glyphicon-user"></i>
            &nbsp;{$lang->get('str_contacto')}</strong></div>
            <div style="padding-left: 25px">
              {$curso.Cur_Contacto|default:"---"}
              <!-- <a href="{BASE_URL}elearning/cursos/ficha/{$curso.Cur_IdCurso}" style="display: inline-block;">
                {$lang->get('str_detalle')}
              </a> -->
            </div> <br/>
          </div>
          {/if}

          {if isset($detalle) && count($detalle)>0}
          <div class="col-xs-12 text-curso">
            <div><strong><i class="glyphicon glyphicon-record"></i>
            &nbsp;Información Adicional</strong></div>
            {foreach from=$detalle item=d}
              <ul>
                <li class="list-objetivos">
                <b>{$d.DC_Titulo} :</b></li>
                {$d.DC_Descripcion}
              </ul>
            {/foreach}
          </div>
          {/if}

          <div class="col-xs-12">

            {if $session==1}
              {if isset($inscripcion) && count($inscripcion)>0}
                {if $inscripcion[0].Mat_Valor==2 }
                  <div class="tag-lms"><center>{$lang->get('elearning_cursos_pendiente_aprobacion_inscripcion')}</center></div>
                {else}
                  {if $session && $progreso.Completo==1}
                    {if isset($inscripcion) && count($inscripcion)>0}
                    {if !count($certificado)}
                      <button class="btn btn-success btn-certificado btn-certificado-size" style="margin-bottom: 10px" id="btnCertificado">
                        <strong><span class="glyphicon glyphicon-list-alt"></span> &nbsp;{$lang->get('elearning_cursos_obtener_certificado')}</strong>
                      </button>
                    {else}
                      <a target="_blank" class="btn btn-success btn-certificado btn-certificado-size" style="margin-bottom: 10px" href="{BASE_URL}elearning/cursos/obtenerCertificado/{$certificado[0]['Cer_IdCertificado']}">
                        <strong><span class="glyphicon glyphicon-list-alt"></span> &nbsp;{$lang->get('elearning_cursos_visualizar_certificado')}</strong>
                      </a>
                    {/if}
                    {/if}
                  {/if}

                  {if $curso.Moa_IdModalidad != 3}
                    <div class="col-sm-12 pl-0 pr-0">
                      <center class="tag-inscrito">
                        <span><strong>{$lang->get('str_inscrito')}:</strong>
                        {$inscripcion[0].Mat_FechaReg}</span>
                      </center>
                    </div>
                  {else}
                    {if $respuesta_completada}
                      <div class="col-sm-12 pl-0 pr-0">
                        <center class="tag-inscrito">
                          <span><strong>{$lang->get('str_inscrito')}:</strong>
                          {$inscripcion[0].Mat_FechaReg}</span>
                        </center>
                      </div>
                    {else}

                      <div class="col-xs-12 anuncio">
                        <strong>
                          <i class="glyphicon glyphicon-warning-sign" style="font-size: 20px;"> </i>&nbsp; ¡{$lang->get('str_atencion')}!
                        </strong>
                        {* Para inscribirte en el curso presencial debe llenar el formulario de inscripción. *}
                        {$lang->get('elearning_cursos_llenar_formulario_inscripcion')}.
                      </div>
                      <div class="col-xs-12">
                        <a href="{$_layoutParams.root}elearning/formulario/responder/{$curso['Cur_IdCurso']}"  target="" >
                          {* <button class="btn btn-group btn-inscribir">Inscribirme</button> *}
                          <button class="btn btn-group btn-inscribir">{$lang->get('elearning_cursos_ir_a_formulario')}</button>
                        </a>
                      </div>
                    {/if}
                  {/if}

                  {if Session::get('id_usuario') && $curso.Moa_IdModalidad != 3}
                  <div class="col-xs-12 p-rt-lt-0">
                    <div class="progress progress-estilo">
                      <div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: {$progreso.Porcentaje}%">
                        <div class="progress-porcentaje">
                          <strong>{$progreso.Porcentaje}% {$lang->get('str_completado')}</strong>
                        </div>
                      </div>
                    </div>
                  </div>
                  {/if}

                {/if}
              {else}
                {if $curso.Usu_IdUsuario != Session::get("id_usuario")}
                  <a href="{BASE_URL}elearning/cursos/_inscripcion/{$curso.Moa_IdModalidad}/{$curso.Cur_IdCurso}">
                    <button class="btn btn-group btn-inscribir">{$lang->get('str_inscribirme')}</button>
                  </a>
                {else}
                  <a href="{BASE_URL}elearning/gestion/matriculados/{$curso.Cur_IdCurso}">
                    <button class="btn btn-success btn-gestion">{$lang->get('elearning_cursos_gestion_curso')}</button>
                  </a>
                {/if}
              {/if}
            {else}
              {if $curso.Moa_IdModalidad != 3}
                <div class="col-xs-12 anuncio">
                <strong><i class="glyphicon glyphicon-warning-sign" style="font-size: 20px;"> </i>&nbsp; ¡{$lang->get('str_atencion')}!</strong>
                {$lang->get('elearning_cursos_necesitas_una_cuenta')}.</div>
                <div class="col-xs-12">
                  <button data-toggle="modal" data-target="#modal-login" class="btn btn-group btn-success ini-sesion">
                    <strong>{$lang->get('str_iniciar_session')}</strong>
                    <i class="glyphicon glyphicon-log-in"></i>
                  </button>
                </div>
              {else}
                {* <div class="col-xs-12 anuncio">
                <strong><i class="glyphicon glyphicon-warning-sign" style="font-size: 20px;"> </i>&nbsp; ¡Atención!</strong>
                Para inscribirte en el curso presencial debe llenar el formulario de inscripción.</div>
                <div class="col-xs-12">
                  <a href="{$_layoutParams.root}elearning/formulario/responder" target="_blank">
                    <button class="btn btn-group btn-inscribir">Inscribirme</button>
                  </a>
                </div> *}

                <div class="col-xs-12 anuncio">
                <strong><i class="glyphicon glyphicon-warning-sign" style="font-size: 20px;"> </i>&nbsp; ¡{$lang->get('str_atencion')}!</strong>
                {$lang->get('elearning_cursos_necesitas_una_cuenta')}.</div>
                <div class="col-xs-12">
                  <button data-toggle="modal" data-target="#modal-login" class="btn btn-group btn-success ini-sesion">
                    <strong>{$lang->get('str_iniciar_session')}</strong>
                    <i class="glyphicon glyphicon-log-in"></i>
                  </button>
                </div>
              {/if}
            {/if}
          </div>




          {if $session==1 && count($modulo)>0 }
              <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                <div><h3 style="font-family: 'Gill Sans MT';">{$lang->get('str_modulos_curso')}</h3></div>
                <hr class="cursos-hr">
              </div>
              <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-left: 0px; padding-right: 0px;">
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 xxxxxxxxxxxx">
                {$index = 1} {$iniciar = 0} {$iniciarLeccion = 0}
                {foreach from=$modulo item=o}

                  <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                      <div class="box box-solid  " >
                        <div class="box-body bg-success">

                            <div class=" col-xs-12 col-sm-2 col-md-2 col-lg-2 text-center" >
                              <div class="col col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                  <img class="w-100  pr-5 pl-5" src="{BASE_URL}modules/elearning/views/cursos/img/contador-modulo-{$index}.png"/>
                              </div>
                              <div class="col col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                  <strong>{$lang->get('str_dedicacion')}: {$o.Moc_TiempoDedicacion}</strong>
                              </div>
                            </div>

                            <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10 ficha-mod-title">
                                <div class="col col-xs-12" >
                                  <strong>{$o.Moc_Titulo}</strong>
                                  {$o.Moc_Descripcion}
                                </div>
                                {if isset($o.LECCIONES[0]) && count($o.LECCIONES)>0 &&  isset($inscripcion) && count($inscripcion)>0 && $inscripcion[0].Mat_Valor==1}
                                    {$falta = 0}
                                    {foreach from = $o.LECCIONES item = ol}
                                      {if $ol.Disponible == 0}
                                        {$falta = $falta + 1}
                                      {/if}
                                    {/foreach}
                                    {if $falta == count($o.LECCIONES) && $iniciar == 0}
                                      <div class="col col-xs-12">
                                        <a  href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Moc_IdModuloCurso}" class="btn btn-success pull-right">{$lang->get('str_iniciar')}</a>
                                      </div>
                                      {$iniciar = 1}
                                    {else}
                                      <!-- {if $o.LECCIONES[0]['Disponible'] == 0 && $iniciar == 0}
                                          <div class="col col-xs-12 ">
                                            <a  href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Moc_IdModuloCurso}" class="btn btn-success pull-right">{$lang->get('str_iniciar')}</a>
                                          </div>
                                        {$iniciar = 1}
                                      {/if} -->
                                    {/if}
                                {/if}
                            </div>

                            
                          
                        </div>
                      </div>
                  </div>
                  <!--  <div class="modulo-lecciones" data-ref-modulo="{$o.Moc_IdModuloCurso}" style="display: none">-->
                  <div class="col-xs-12 modulo-leccionesssss">
                  {foreach from=$o.LECCIONES item=l}
                    <div class="box box-solid " >
                      <div class=" box-body  bg-info {if $l.Activo==1}lec-lms-activo{/if}">
                        <div class=" col-xs-12">
                            <h4><strong>{$l.Lec_Titulo}</strong></h4>
                        </div>
                        <div class=" col-xs-12">
                        <strong>{$lang->get('str_dedicacion')}: {$l.Lec_TiempoDedicacion}</strong>
                        </div>
                        <div class=" col-xs-9">
                            <span class="glyphicon glyphicon-calendar"></span> Fecha:
                            {if ($l.Lec_FechaDesde|date_format:"%H:%M:%S") > 0}
                                {$l.Lec_FechaDesde|date_format:" %D %H:%M:%S"}
                            {else}
                                {$l.Lec_FechaDesde|date_format:"%Y-%m-%d"}
                            {/if}
                        </div>
                        

                          {if ($session==1 && isset($inscripcion) && count($inscripcion)>0 && $inscripcion[0].Mat_Valor==1)}
                              <div class="col-xs-3">
                                  {if $l.Disponible == 1 }
                                      <a class=" btn btn-md btn-danger pull-right" href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Moc_IdModuloCurso}/{$l.Lec_IdLeccion}">
                                          {$lang->get('elearning_cursos_revisar_leccion')}
                                      </a>
                                  {else}
                                      {if $iniciarLeccion == 0 && $iniciar == 0}
                                          <a class=" btn btn-md btn-success pull-right" href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Moc_IdModuloCurso}/{$l.Lec_IdLeccion}">
                                              {$lang->get('str_iniciar')}
                                          </a>
                                          {$iniciarLeccion = 1}
                                      {/if}
                                  {/if}
                              </div>
                              
                          {else}
                            {if $curso.Usu_IdUsuario == Session::get('id_usuario')}
                              <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Moc_IdModuloCurso}/{$l.Lec_IdLeccion}">
                                <div class="tag-terminado"><center><strong>{$lang->get('elearning_cursos_revisar_leccion')}</strong></center></div>
                              </a>
                            {else}
                              {if $l.Lec_Tipo==4}
                                  {if ($l.Lec_FechaHasta|date_format) < ($smarty.now|date_format) }
                                    <div class="tag-terminado"><center><strong>{$lang->get('elearning_cursos_clase_concluida')}</strong></center></div>
                                  {/if}
                                  {if ($l.Lec_FechaHasta|date_format) == ($smarty.now|date_format) }
                                  <div class="div_en_linea">
                                    <span class="en_linea text-success">{$lang->get('str_en_linea')}</span>
                                  </div>
                                    <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Moc_IdModuloCurso}/{$l.Lec_IdLeccion}">
                                      <div class="tag-terminado"><center><strong>{$lang->get('str_en_linea')}</strong></center></div>
                                    </a>
                                  {/if}
                              {elseif $l.Lec_Tipo==5}
                                <div class="tag-terminado"><center><strong>{$lang->get('elearning_cursos_examen_concluido')}</strong></center></div>                 
                              {/if}
                            {/if}
                          {/if} 
                          
                      </div>
                    </div>
                  {/foreach}
                  </div>

                  {$index = $index + 1}
                {/foreach}
              </div>
              </div>
          {/if}

          {if $session==1}
          <div class="col-xs-12"> <!-- RODRIGO 20180607 -->
            <label style="margin-top: 10px; font-size:16px">{$lang->get('elearning_cursos_calificar_curso')}</label>
            <hr class="cursos-hr">
            <textarea class="form-control estilo-textarea" rows="4" id="txCComentario" maxlength="450" placeholder="{$lang->get('elearning_cursos_escriba_comentario_aqui')}."></textarea>
            <input type="text" id="inCUsuario" value="{$curso.Cur_IdCurso}" hidden="hidden">
            <input type="text" id="inCCurso" value="{Session::get('id_usuario')}" hidden="hidden">
          </div>
          <div class="col-lg-8">
            <div class="corazones no-selecionable" style="padding-top: 10px">
              <span class="glyphicon glyphicon-star item-calificar" tag="1"></span>
              <span class="glyphicon glyphicon-star item-calificar" tag="2"></span>
              <span class="glyphicon glyphicon-star item-calificar" tag="3"></span>
              <span class="glyphicon glyphicon-star item-calificar" tag="4"></span>
              <span class="glyphicon glyphicon-star item-calificar" tag="5"></span>
            </div>
          </div>
          <div class="col-lg-4">
            <button class="btn btn-default pull-right btn-calificar" id="btnCalificar">
              <strong><span class="glyphicon glyphicon-star"></span>&nbsp; {$lang->get('str_calificar')}</strong>
            </button>
          </div>
          {/if}
          <div class="col-xs-12" style="margin-top: 10px; font-size:16px">
            <label>{$lang->get('elearning_cursos_valoracion_curso')}: </label>
          </div>
          <div class="col-xs-12">
            <hr class="cursos-hr">
          </div>
          <div class="col-xs-12">
            <div id="calificaciones"></div>
          </div> <!-- RODRIGO 20180607 -->

          <div class="col-xs-12">
            <br/>
          </div>

        </div>
      </div>
    </div>
  </div>
</div>