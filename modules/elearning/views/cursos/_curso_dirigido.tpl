<div class="col-lg-12">
  <div class="col-lg-12 referencia-curso-total" style="padding-top:20px;">
    <strong><a class="referencia-curso" href="{BASE_URL}elearning/cursos/">Cursos</a>  /  {$curso.Cur_Titulo}</strong>
  </div>
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-10" style="margin-top: 20px">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="panel-body">
          <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
            <div class="col-lg-3 img-curso">
              <img src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$curso.Cur_UrlBanner}" />
            </div>
            <div class="col-lg-6">
            <br>
            <br>
              <h3 style="text-align: center; font-size: 35px;">
              <strong>{$curso.Cur_Titulo}</strong></h3>
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

          <div class="col-lg-12">
            <hr class="cursos-hr">
          </div>

          <div class="col-lg-8">
            <iframe width="100%" height="300" src="https://www.youtube.com/embed/eBVvD85Ml2c" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
          </div>

          <div class="col-lg-4">
            <center class="panel panel-default col-lg-10 info-curso">

              <div class="col-lg-12">
                <i class="glyphicon glyphicon-time" style="color: #16B8AD; font-size: 25px"></i>
                <br>
                <strong style="color: #393939; font-size: 16px">{$curso.Cur_Duracion|default: $duracion}</strong>
                <br><br>
              </div>

              <div class="col-lg-12" style="border-top: #ddd solid 2px; border-bottom: #ddd solid 2px;">
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
                <strong style="color: #393939; font-size: 16px">4.5/5</strong>
                <br>
                <strong style="color: #393939; font-size: 16px">Valoración media</strong>
              </div>

            </center>
          </div>
          
          <div class="col-lg-12 text-curso">
            <div>{$curso.Cur_Descripcion}</div> <br/>
          </div>

            <div class="col-lg-5">
            <!--<div  style="font-size: 16px;">
            <div><strong><i class="glyphicon glyphicon-time"></i>
            Duración curso</strong></div>
            <div style="padding-left: 20px">{$curso.Cur_Duracion|default: $duracion}</div> <br/>
          </div>-->
            <div  style="font-size: 16px;">
              <div><strong><i class="glyphicon glyphicon-globe"></i>
              Público objetivo</strong></div>
              <div style="padding-left: 20px">{$curso.Cur_PublicoObjetivo|default:"---"}</div> <br/>
            </div>
            <div  style="font-size: 16px;">
              <div><strong><i class="glyphicon glyphicon-cog"></i>
              Metodología</strong></div>
              <div style="padding-left: 20px">{$curso.Cur_Metodologia|default:"---"}</div> <br/>
            </div>
            <div  style="font-size: 16px;">
              <div><strong><i class="glyphicon glyphicon-user"></i>
              Docente</strong></div>
              <div style="padding-left: 20px">
                {$curso.Cur_Contacto|default:"---"}
                <a href="{BASE_URL}elearning/cursos/ficha/{$curso.Cur_IdCurso}" style="display: inline-block;">
                    Detalle
                    <!--button class="btn btn-success">
                      <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                    </button-->
                  </a>
              </div> <br/>
            </div>
            </div>

          <div class="col-lg-12">
            {if $session==1}
              {if isset($inscripcion) && count($inscripcion)>0}
                {if $inscripcion[0].Mat_Valor==2 }
                  <div class="anuncio">Esta pendiente la aprobación de tu registro.</div>
                {else}
                  {if $inscripcion[0].Mat_Valor==1 }
                    {if $session && $progreso.Completo==1}
                    <!--img src="{BASE_URL}modules/elearning/views/cursos/img/certificado.png" class="img-certificado"/-->
                    {/if}
                    <div class="tag-inscrito">
                      <span><strong>Inscrito:</strong>
                      {$inscripcion[0].Mat_FechaReg}</span>
                    </div>
                  {else}
                    <div class="anuncio2">Registro rechazado.</div>
                  {/if}
                {/if}
              {else}
                {if $curso.Usu_IdUsuario != Session::get("id_usuario")}
                <a href="{BASE_URL}elearning/cursos/_inscripcion/{$curso.Mod_IdModCurso}/{$curso.Cur_IdCurso}">
                  <button class="btn btn-group btn-inscribir"><strong>Inscribirme</strong></button>
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
            <!-- <a href="{BASE_URL}login/login/elearning!cursos!curso_dirigido!{$curso.Cur_IdCurso}">
              <button class="btn btn-success btn-ficha">Loguearme</button>
            </a> -->
            <div class="col-lg-12">
            <button data-toggle="modal" data-target="#modal-login" class="btn btn-group btn-success ini-sesion">
            <strong>Iniciar Sesión</strong>
            <i class="glyphicon glyphicon-log-in"></i>
            </button>
            </div>
            {/if}
          </div>
          <!--<div class="col-lg-12">
            <div class="tag-lms"><span><strong>Alumnos inscritos:</strong>
            {$inscritos}</span></div>
          </div>-->


          <div class="col-lg-12">
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

          {if $session==1 && count($modulo)>0 }
          <div class="col-lg-12">
            <div><h3 style="font-family: 'Gill Sans MT';">Módulos del curso</h3></div>
            <hr class="cursos-hr">
            <br>
          </div>
          <div class="col-lg-12" style="padding-left: 0px !important">
            {foreach from=$modulo item=o}
            <div class="col-lg-12">
              <div class="ficha-mod col-lg-12">
                <div class="col-lg-2"><img class="img-modulo" src="{BASE_URL}modules/elearning/views/cursos/img/contador-modulo-lms.png"/></div>
                <div class="col-lg-10 ficha-mod-title"><strong>{$o.Mod_Titulo}</strong></div>
                <div class="col-lg-10 ficha-mod-desc">{$o.Mod_Descripcion}</div>
              </div>
            </div>
              {foreach from=$o.LECCIONES item=l}
                <div class="col-lg-12">
                  <div class="ficha-leccion {if $l.Activo==1}lec-lms-activo{/if}">
                    <h4><strong>{$l.Lec_Titulo}</strong></h4>
                    <span class="glyphicon glyphicon-calendar"></span>
                    Fecha: {$l.Lec_FechaDesde}
                    {if $l.Activo==0}
                      {if ($session==1 && isset($inscripcion) && count($inscripcion)>0 && $inscripcion[0].Mat_Valor==1) }
                      <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}/{$l.Lec_IdLeccion}">
                      <div class="tag-terminado"><center><strong>Revisar</strong></center></div>
                      </a>
                      {else}
                        {if $curso.Usu_IdUsuario == Session::get('id_usuario')}
                        <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}/{$l.Lec_IdLeccion}">
                        <div class="tag-terminado"><center><strong>Revisar lección</strong></center></div>
                        </a>
                        {else}
                          {if $l.Lec_Tipo==4}
                          <div class="tag-terminado"><center><strong>Clase Concluida</strong></center></div>
                          {elseif $l.Lec_Tipo==5 }
                          <div class="tag-terminado"><center><strong>Exámen Concluido</strong></center></div>
                          {else}
                          {/if}
                        {/if}
                      {/if}
                    {else}
                      {if $l.Lec_Tipo==4 }
                      <div class="tag-terminado pendiente"><center><strong>Clase Pendiente</strong></center></div>
                      {elseif $l.Lec_Tipo==5 }
                      <div class="tag-terminado pendiente"><center><strong>Exámen Pendiente</strong></center></div>
                      {else}

                      {/if}
                    {/if}
                  </div>
                </div>
              {/foreach}
            {/foreach}
          </div>
          {/if}

        </div>
      </div>
    </div>
  </div>
</div>
