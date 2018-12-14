<input type="text" id="inHiddenCurso" value="{$curso.Cur_IdCurso}" hidden="hidden"> <!-- RODRIGO 20180607 -->
<div class="col-lg-12">
  <div class="col-lg-12 referencia-curso-total">
    <a class="referencia-curso" href="{BASE_URL}elearning/cursos/">Cursos</a>  /  {$curso.Cur_Titulo}
  </div>
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-xs-12 col-sm-12 col-md-9 col-lg-10" style="margin-top: 20px; ">
    <div class="col-lg-12" style="padding-right: 0px;">
      <div class="panel panel-default">
        <div class="panel-body">
          <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
            <div class="col-lg-3 img-curso">
              <img class="w-100" src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$curso.Cur_UrlBanner}" />
              {if $curso.Moa_IdModalidad == 2}
              <div class="col-xs-12 text-center " style="background: #2196F3; color: white; font-weight: bold; font-size: 18px;">LMS</div>
              {/if}
            </div>
            <div class="col-lg-6">
            <br>
            <br>
              <h3 style="text-align: center; font-size: 35px;">
              <strong>{$curso.Cur_Titulo}</strong></h3>
            <br>
            </div>

            <div class="col-lg-3 row ic-sociales sharepost no-print" >
                <!-- <a class="btn fa fa-facebook im_sociales" id="im_sociales" style="background: #3B5998" href="#"></a>
                <a class="btn fa fa-twitter im_sociales" id="im_sociales" style="background: #55ACEE" href="#"></a>
                <a class="btn fa fa-google-plus im_sociales" id="im_sociales" style="background: #C03A2A" href="#"></a> -->
                <ul class="list-inline">                  
                  <li class="facebook">
                    <div class="icon">
                      <a href="https://www.facebook.com/sharer/sharer.php?u={$_layoutParams.root}elearning/cursos/curso_dirigido/{$curso.Cur_IdCurso}" target="_blank" title="Facebook">
                        <i class="fa fa-facebook"></i>
                      </a>
                    </div>
                  </li>
                  <li class="twitter">
                    <div class="icon">
                      <a href="https://twitter.com/home?status={$_layoutParams.root}elearning/cursos/curso_dirigido/{$curso.Cur_IdCurso}" target="_blank" title="Twitter">
                        <i class="fa fa-twitter"></i>
                      </a>
                    </div>
                  </li>
                  <li class="google-plus">
                    <div class="icon">
                      <a href="https://plus.google.com/share?url={$_layoutParams.root}elearning/cursos/curso_dirigido/{$curso.Cur_IdCurso}" target="_blank" title="Google+">
                        <i class="fa fa-google-plus"></i>
                      </a>
                    </div>
                  </li>
                </ul>
            </div>

          </div>

          <div class="col-lg-12">
            <hr class="cursos-hr">
          </div>

          <div class="col-lg-8">
            <iframe class="video-intro" width="100%" height="310" src="https://www.youtube.com/embed/{$curso.Cur_UrlVideoPresentacion}" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
          </div>

          <div class="col-lg-4">
            <center class="panel panel-default col-lg-10 info-curso">

              <div class="col-lg-12">
                <i class="glyphicon glyphicon-time" style="color: #16B8AD; font-size: 25px"></i>
                <br>
                <strong style="color: #393939; font-size: 16px">{$curso.Cur_Duracion|default: $duracion}</strong>
                <br><br>
              </div>

              <div class="col-lg-12" style="border-top: #ddd solid 0.2px; border-bottom: #ddd solid 0.2px;">
                <br>
                <i class="glyphicon glyphicon-user" style="color: #31A3BB; font-size: 25px"></i>
                <br>
                <strong style="color: #393939; font-size: 16px">{$inscritos}</strong>
                <br>
                <strong style="color: #393939; font-size: 16px">Alumnos</strong>
                <br><br>
              </div>

              <div class="col-lg-12">
                <br>
                <i class="glyphicon glyphicon-star" style="color: #E9BA46; font-size: 25px"></i>
                <br>
                <strong style="color: #393939; font-size: 16px">4/5</strong>
                <br>
                <strong style="color: #393939; font-size: 16px">Valoración media</strong>
              </div>

            </center>
          </div>

      <div class="col-lg-12 text-curso">
        <div>{$curso.Cur_Descripcion}</div> <br/>
      </div>

     <!--  <div class="col-lg-12 text-curso">
        <a href="{BASE_URL}elearning/cursos/calendario_curso/{$curso.Cur_IdCurso}" class="btn btn-success">
          <span class="glyphicon glyphicon-calendar"></span> Ver Calendario
        </a>
      </div> -->

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
            
            {foreach from=$detalle item=d}
             
                <div class="list-objetipvos">
                  <strong><i class="glyphicon glyphicon-record"></i>
            &nbsp;{$d.DC_Titulo} :</strong>
                </div>
                {$d.DC_Descripcion}
             
            {/foreach}
          </div>
          {/if}



      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-top: 10px; position: relative">

        {if $session==1}
          {if isset($inscripcion) && count($inscripcion)>0}
            {if $inscripcion[0].Mat_Valor==2 }
              <div class="tag-lms"><center>Esta pendiente la aprobación de tu registro</center></div>
            {else}
              {if $inscripcion[0].Mat_Valor==1 }
                {if $session && $progreso.Completo==10}
                  {if !count($certificado)}
                    <button class="btn btn-success btn-certificado" style="margin-bottom: 10px" id="btnCertificado">
                      <strong><span class="glyphicon glyphicon-list-alt"></span> &nbsp;Obtener certificado</strong>
                    </button>
                  {else}
                    <a class="btn btn-success btn-certificado" style="margin-bottom: 10px" href="">
                      <strong><span class="glyphicon glyphicon-list-alt"></span> &nbsp;Visualizar certificado</strong>
                    </a>
                  {/if}
                {/if}
                <center class="tag-inscrito">
                  <span><strong>Inscrito:</strong>
                  {$inscripcion[0].Mat_FechaReg}</span>
                </center>

                {if Session::get('id_usuario')}
                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 p-rt-lt-0">
                  <div class="progress progress-estilo">
                    <div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: {$progreso.Porcentaje}%">
                      <div class="progress-porcentaje">
                        <strong>{$progreso.Porcentaje}% Completado</strong>
                      </div>
                    </div>
                  </div>


                  <!--{if ($session==1 && isset($inscripcion) && count($inscripcion)>0 && $inscripcion[0].Mat_Valor==1) && ($curso.Usu_IdUsuario != Session::get('id_usuario')) }
                    <a href="{BASE_URL}elearning/clase/clase/{$curso.Cur_IdCurso}"><button class="btn btn-success">ir a clase</button></a>
                  {/if}
                  {if $curso.Usu_IdUsuario == Session::get('id_usuario')}
                    <a href="{BASE_URL}elearning/clase/clase/{$curso.Cur_IdCurso}"><button class="btn btn-success">Dar clase</button></a>
                  {/if}-->


                </div>
                {/if}

              {else}
                <div class="tag-lms"><center>Registro rechazado</center></div>
              {/if}
            {/if}
          {else}
            {if $curso.Usu_IdUsuario != Session::get("id_usuario")}
              <a href="{BASE_URL}elearning/cursos/_inscripcion/{$curso.Moa_IdModalidad}/{$curso.Cur_IdCurso}">
                <button class="btn btn-group btn-inscribir">Inscribirme</button>
              </a>
            {else}
              <a href="{BASE_URL}elearning/gestion/matriculados/{$curso.Cur_IdCurso}">
                <button class="btn btn-default btn-gestion">Gestión de Curso</button>
              </a>
            {/if}
          {/if}
        {else}
          <div class="col-lg-12 anuncio">
              <strong><i class="glyphicon glyphicon-warning-sign" style="font-size: 20px;"> </i>&nbsp; ¡Atención!</strong>
              Para inscribirte en el curso necesitas una cuenta.</div>
          <div class="col-lg-12">
                <button data-toggle="modal" data-target="#modal-login" class="btn btn-group btn-success ini-sesion">
                <strong>Iniciar Sesión</strong>
                <i class="glyphicon glyphicon-log-in"></i>
              </button>
              </div>
        {/if}
      </div>

      {if $session==1 && count($modulo)>0 }
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div><h3 style="font-family: 'Gill Sans MT';">Módulos del curso</h3></div>
        <hr class="cursos-hr">
      </div>
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-left: 0px; padding-right: 0px;">
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 xxxxxxxxxxxx">
        {$index = 1} {$iniciar = 0}
        {foreach from=$modulo item=o}
          <div class="ficha-mod col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-bottom: 15px; margin-top: 15px">
            <div class="col-xs-12 col-sm-2 col-md-2 col-lg-2" style="padding: 0px; text-align: center;">
              <img class="w-100 img-modulo pr-5 pl-5" class="img-modulo" src="{BASE_URL}modules/elearning/views/cursos/img/contador-modulo-{$index}.png"/>
              <div class="col col-xs-12 col-sm-12 col-md-12 col-lg-12">
                  <strong>Dedicación: {$o.Moc_TiempoDedicacion}</strong>  
              </div>   
            </div>
            <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10 ficha-mod-title">
              <strong>{$o.Moc_Titulo}</strong>
              {$o.Moc_Descripcion}
            </div>
            {if isset($o.LECCIONES[0]) && count($o.LECCIONES)>0}
              {if $o.LECCIONES[0]['Disponible'] == 0 && $iniciar == 0}
                <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10 ficha-mod-title">
                  <a  href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Moc_IdModuloCurso}" class="btn btn-success pull-right">Iniciar</a>
                </div>
                {$iniciar = 1}
              {/if}
            {/if}

          </div>
          {foreach from=$o.LECCIONES item=l}
            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="padding-left: 0px; padding-right: 0px;">
              <div class="ficha-leccion {if $l.Activo==1}lec-lms-activo{/if}">
                <h4><strong>{$l.Lec_Titulo}</strong></h4>
                <strong>Dedicación: {$l.Lec_TiempoDedicacion}</strong>
                <br>
                <span class="glyphicon glyphicon-calendar"></span> Fecha: 
                {if ($l.Lec_FechaDesde|date_format:"%H:%M:%S") > 0}
                    {$l.Lec_FechaDesde|date_format:" %D %H:%M:%S"}
                {else}
                    {$l.Lec_FechaDesde|date_format:"%Y-%m-%d"}
                {/if}
                   
                {if $l.Activo==0}
                  {if ($session==1 && isset($inscripcion) && count($inscripcion)>0 && $inscripcion[0].Mat_Valor==1) && $l.Disponible==1 }
                    <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Moc_IdModuloCurso}/{$l.Lec_IdLeccion}">
                      <div class="tag-terminado"><center><strong>Revisar</strong></center></div>
                    </a>
                  {else}
                    {if $curso.Usu_IdUsuario == Session::get('id_usuario')}
                      <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Moc_IdModuloCurso}/{$l.Lec_IdLeccion}">
                        <div class="tag-terminado"><center><strong>Revisar lección</strong></center></div>
                      </a>
                    {else}
                      {if $l.Lec_Tipo==4 }
                          {if ($l.Lec_FechaHasta|date_format) < ($smarty.now|date_format) }
                            <div class="tag-terminado"><center><strong>Clase Concluida</strong></center></div>
                          {/if}
                          {if ($l.Lec_FechaHasta|date_format) == ($smarty.now|date_format) }
                          <div class="div_en_linea">
                            <span class="en_linea text-success">En linea</span>
                          </div>
                            <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Moc_IdModuloCurso}/{$l.Lec_IdLeccion}">
                              <div class="tag-terminado"><center><strong>En linea</strong></center></div>
                            </a>
                          {/if}
                      {elseif $l.Lec_Tipo==5 }
                        <div class="tag-terminado"><center><strong>Exámen Concluido</strong></center></div>
                      {else}
                      {/if}
                    {/if}
                  {/if}
                {else}
                  {if $l.Lec_Tipo==4 }
                    <div class="tag-terminado pendiente"><center>Clase Pendiente</center></div>
                  {elseif $l.Lec_Tipo==5 }
                    <div class="tag-terminado pendiente"><center>Exámen Pendiente</center></div>
                  {else}
                  {/if}
                {/if}
              </div>
            </div>
          {/foreach}
          {$index = $index + 1}
        {/foreach}
      </div>
      </div>
      {/if}




      {if $session==1}
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"> <!-- RODRIGO 20180607 -->
        <label style="margin-top: 20px; font-size:16px">Calificar curso</label>
        <hr class="cursos-hr">
        <textarea class="form-control estilo-textarea" rows="4" id="txCComentario" maxlength="450" placeholder="Escriba su comentario aquí."></textarea>
        <input type="text" id="inCUsuario" value="{$curso.Cur_IdCurso}" hidden="hidden">
        <input type="text" id="inCCurso" value="{Session::get('id_usuario')}" hidden="hidden">
      </div>
      <div class="col-xs-12 col-sm-8 col-md-8 col-lg-8">
        <div class="corazones no-selecionable" style="padding-top: 10px">
          <span class="glyphicon glyphicon-star item-calificar" tag="1"></span>
          <span class="glyphicon glyphicon-star item-calificar" tag="2"></span>
          <span class="glyphicon glyphicon-star item-calificar" tag="3"></span>
          <span class="glyphicon glyphicon-star item-calificar" tag="4"></span>
          <span class="glyphicon glyphicon-star item-calificar" tag="5"></span>
        </div>
      </div>
      <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4">
        <button class="btn btn-default pull-right btn-calificar" id="btnCalificar">
          <strong><span class="glyphicon glyphicon-star"></span>&nbsp; Calificar</strong>
        </button>
      </div>
      {/if}
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" style="margin-top: 10px; font-size:16px">
        <label>Valoraciones del curso: </label>
      </div>
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <hr class="cursos-hr">
      </div>
      <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div id="calificaciones"></div>
      </div> <!-- RODRIGO 20180607 -->


          <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
            <br/>
          </div>

        </div>

      </div>

    </div>
  </div>
  </div>
</div>



<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">{$modulo[0]['Moc_Titulo']}</h4>
        </div>
        <div class="modal-body">
          <p>{$modulo[0]['Moc_Descripcion']}</p>
        </div>
        <div class="modal-footer">
          <a type="button" href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Moc_IdModuloCurso}/{$o.LECCIONES[0]['Lec_IdLeccion']}" class="btn btn-success" >Close</a>
        </div>
      </div>
      
    </div>
  </div>
  