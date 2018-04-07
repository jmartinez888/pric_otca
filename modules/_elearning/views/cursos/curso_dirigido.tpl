<div class="col-lg-12">
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-10" style="margin-top: 20px">
    <div class="col-lg-12 curso-item">
      <div class="col-lg-12">
        <h3><div>{$curso.Cur_Titulo}</div></h3>
      </div>
      <div class="col-lg-4">
        <img src="{BASE_URL}public/resources/cursos/{$curso.Cur_UrlBanner}" />
      </div>
      <div class="col-lg-8">
        <div><strong>Descripción del curso</strong></div>
        <div>{$curso.Cur_Descripcion}</div> <br/>
        <div class="col-lg-6">
          <div><strong>Duración curso</strong></div>
          <div>{$curso.Cur_Duracion}</div> <br/>
        </div>
        <div class="col-lg-6">
          <div><strong>Public objetivo</strong></div>
          <div>{$curso.Cur_PublicoObjetivo}</div> <br/>
        </div>
        <div class="col-lg-6">
          <div><strong>Metodología</strong></div>
          <div>{$curso.Cur_Metodologia}</div> <br/>
        </div>
        <div class="col-lg-6">
          <div><strong>Contacto</strong></div>
          <div>{$curso.Cur_Contacto}</div>
        </div>
      </div>
      <div class="col-lg-12" style="padding-top: 10px; position: relative">
        {if $session==1}
          {if isset($inscripcion) && count($inscripcion)>0}
            {if $inscripcion[0].Mat_Valor==2 }
              <div class="tag-lms"><center>Esta pendiente la aprobación de tu registro</center></div>
            {else}
              {if $inscripcion[0].Mat_Valor==1 }
                {if $session && $progreso.Completo==1}
                <img src="{BASE_URL}modules/elearning/views/cursos/img/certificado.png" class="img-certificado"/>
                {/if}
                <div class="tag-inscrito">
                  <center>Inscrito {$inscripcion[0].Mat_FechaReg}</center>
                </div>
              {else}
                <div class="tag-lms"><center>Registro rechazado</center></div>
              {/if}
            {/if}
          {else}
            {if $curso.Usu_IdUsuario != Session::get("id_usuario")}
            <a href="{BASE_URL}elearning/cursos/_inscripcion/{$curso.Mod_IdModCurso}/{$curso.Cur_IdCurso}">
              <button class="btn btn-success btn-ficha">Registrarme en curso</button>
            </a>
            {else}
            <a href="{BASE_URL}elearning/gestion/matriculados/{$curso.Cur_IdCurso}">
              <button class="btn btn-default btn-gestion">Gestión de Curso</button>
            </a>
            {/if}
          {/if}
        {else}
        <div>Para inscribirte en el curso necesitas una cuenta</div>
        <!-- <a href="{BASE_URL}login/login/elearning!cursos!curso_dirigido!{$curso.Cur_IdCurso}">
          <button class="btn btn-success btn-ficha">Loguearme</button>
        </a> -->
        <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-success btn-md btn_login_user">Loguearme <i class="fa fa-sign-in"></i></button>
        {/if}
      </div>
      <div class="col-lg-6"><br/>
        <div class="tag-lms" ><center>Alumnos inscritos {$inscritos}</center></div>
      </div>
      <div class="col-lg-12">
        <div class="progress" style="margin-top: 20px">
          <div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: {$progreso.Porcentaje}%">
            {$progreso.Porcentaje}% Completado
          </div>
        </div>
        <!--{if ($session==1 && isset($inscripcion) && count($inscripcion)>0 && $inscripcion[0].Mat_Valor==1) && ($curso.Usu_IdUsuario != Session::get('id_usuario')) }
          <a href="{BASE_URL}elearning/clase/clase/{$curso.Cur_IdCurso}"><button class="btn btn-success">ir a clase</button></a>
        {/if}
        {if $curso.Usu_IdUsuario == Session::get('id_usuario')}
          <a href="{BASE_URL}elearning/clase/clase/{$curso.Cur_IdCurso}"><button class="btn btn-success">Dar clase</button></a>
        {/if}-->
      </div>

      {if count($modulo)>0} <!-- Se quitó la validación de sesión-->
      <div class="col-lg-12">
        <div><h4><strong>Módulos del curso</strong></h4></div>
      </div>
      <div class="col-lg-12" style="padding-left: 0px !important">
        {foreach from=$modulo item=o}
        <div class="col-lg-12" style="margin-top: 10px">
          <div class="ficha-mod">
            <div class="ficha-mod-icon"><span class="glyphicon glyphicon-th"/></div>
            <div class="ficha-mod-title">{$o.Mod_Titulo}</div>
            <div class="ficha-mod-desc">{substr($o.Mod_Descripcion, 0, 100)}...</div>
          </div>
        </div>
          {foreach from=$o.LECCIONES item=l}
          <div class="col-lg-12">
            <div class="col-lg-12">
              <div class="ficha-leccion {if $l.Activo==1}lec-lms-activo{/if}">
                {$l.Lec_Titulo}<br/>
                Fecha: {$l.Lec_FechaDesde}

                {if ($session==1 && isset($inscripcion) && count($inscripcion)>0 && $inscripcion[0].Mat_Valor==1) }
                  {if $l.Lec_Tipo < 4}
                    <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}/{$l.Lec_IdLeccion}">
                      <div class="tag-terminado tag-nodirigda"><center>Revisar</center></div>
                    </a>
                  {else}
                    {if $l.Activo==0}
                      {if $l.Lec_Tipo==4 }
                      <div class="tag-terminado tag-concluido"><center>Clase concluida</center></div>
                      {elseif $l.Lec_Tipo==5 }
                      <div class="tag-terminado tag-concluido"><center>Examen concluido</center></div>
                      {/if}
                    {elseif $l.Activo==1}

                      {if $l.Lec_LMSEstado==0 }
                        <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}/{$l.Lec_IdLeccion}">
                          <div class="tag-terminado tag-pendiente"><center>Ir a lección</center></div>
                        </a>
                      {elseif $l.Lec_LMSEstado==1}
                        <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}/{$l.Lec_IdLeccion}">
                          <div class="tag-terminado tag-proceso"><center>Clase en proceso</center></div>
                        </a>
                      {else}
                        <div class="tag-terminado tag-concluida"><center>Clase concluida</center></div>
                      {/if}

                    {else}
                      {if $l.Lec_Tipo==4 }
                        <div class="tag-terminado tag-pendiente"><center>Clase Pendiente</center></div>
                      {elseif $l.Lec_Tipo==5 }
                        <div class="tag-terminado tag-pendiente"><center>Examen Pendiente</center></div>
                      {/if}
                    {/if}
                  {/if}
                {else}
                  {if $curso.Usu_IdUsuario == Session::get('id_usuario')}

                    {if $l.Activo==1 && ($l.Lec_Tipo==4 || $l.Lec_Tipo==5) }
                      <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}/{$l.Lec_IdLeccion}">
                        <div class="tag-terminado tag-proceso"><center>Clase de hoy</center></div>
                      </a>
                    {else}
                      <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}/{$l.Lec_IdLeccion}">
                        <div class="tag-terminado"><center>Revisar lección</center></div>
                      </a>
                    {/if}

                  {else}

                    {if $l.Lec_Tipo < 4}
                      <div class="tag-terminado tag-nodirigda"><center>Lección no dirigida</center></div>
                    {/if}

                    {if $l.Activo==0}

                      {if $l.Lec_Tipo==4}
                      <div class="tag-terminado tag-concluido"><center>Clase Concluida</center></div>
                      {elseif $l.Lec_Tipo==5 }
                      <div class="tag-terminado tag-concluido"><center>Examen Concluido</center></div>
                      {/if}

                    {elseif $l.Activo==1}

                      {if $l.Lec_Tipo==4}
                      <div class="tag-terminado tag-proceso"><center>Clase en proceso</center></div>
                      {elseif $l.Lec_Tipo==5 }
                      <div class="tag-terminado tag-proceso"><center>Examen</center></div>
                      {/if}

                    {else}

                      {if $l.Lec_Tipo==4}
                      <div class="tag-terminado tag-pendiente"><center>Clase Dirigida</center></div>
                      {elseif $l.Lec_Tipo==5 }
                      <div class="tag-terminado tag-pendiente"><center>Examen</center></div>
                      {/if}

                    {/if}





                  {/if}
                {/if}

                <!--

                {if $l.Activo==0}
                  {if ($session==1 && isset($inscripcion) && count($inscripcion)>0 && $inscripcion[0].Mat_Valor==1) }
                  <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}/{$l.Lec_IdLeccion}">
                  <div class="tag-terminado"><center>Revisar</center></div>
                  </a>
                  {else}
                  {/if}
                {else}
                  {if $l.Lec_Tipo==4 }
                  <div class="tag-terminado pendiente"><center>Clase Pendiente</center></div>
                  {elseif $l.Lec_Tipo==5 }
                  <div class="tag-terminado pendiente"><center>Examen Pendiente</center></div>
                  {else}
                  {/if}
                {/if}-->



              </div>
            </div>
          </div>
          {/foreach}
        {/foreach}
      </div>
      {/if}
      <div class="col-lg-12">
        <br/>
      </div>
    </div>
  </div>
</div>
