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
        <div class="tag-lms"><center>Esta pendiente la aprobación de tu inscripción</center></div>
        {else}

        {if $session && $progreso.Completo==1}
        <img src="{BASE_URL}modules/elearning/views/cursos/img/certificado.png" class="img-certificado"/>
        {/if}
        <div class="tag-inscrito">
          <center>Inscrito {$inscripcion[0].Mat_FechaReg}</center>
        </div>
        {/if}
        {else}
          {if $curso.Usu_IdUsuario != Session::get("id_usuario")}
          <a href="{BASE_URL}elearning/cursos/_inscripcion/{$curso.Mod_IdModCurso}/{$curso.Cur_IdCurso}">
            <button class="btn btn-success btn-ficha">Inscribirme</button>
          </a>
          {else}
          <a href="{BASE_URL}elearning/gestion/matriculados/{$curso.Cur_IdCurso}">
            <button class="btn btn-default btn-gestion">Gestión de Curso</button>
          </a>
          {/if}
        {/if}
        {else}
        <div>Para inscribirte en el curso necesitas una cuenta</div>
        <!-- <a href="{BASE_URL}login/login/elearning!cursos!curso!{$curso.Cur_IdCurso}">
          <button class="btn btn-default btn-ficha">Loguearme</button> -->
          <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-primary btn-md btn_login_user">Loguearme <i class="fa fa-sign-in"></i></button>
        <!-- </a> -->
        {/if}
      </div>
      <div class="col-lg-6"><br/>
        <div class="tag-lms" ><center>Alumnos inscritos {$inscritos}</center></div>
      </div>
      <!--div class="col-lg-6"><br/>
        <div class="tag-lms" style="background-color: #90CAF9" ><center>{$progreso.Porcentaje}% completado</center></div>
      </div-->
      <div class="col-lg-12">
        <div class="progress" style="margin-top: 20px">
          <div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: {$progreso.Porcentaje}%">
            {$progreso.Porcentaje}% Completado
          </div>
        </div>
      </div>

      {if $session==1 && count($modulo)>0 }
      <div class="col-lg-12">
        <div><h4><strong>Módulos del curso</strong></h4></div>
      </div>
      <div class="col-lg-12" style="padding-left: 0px !important">
        {foreach from=$modulo item=o}
        <div class="col-lg-6">
          <div class="ficha-mod">
            <div class="ficha-mod-icon"><span class="glyphicon glyphicon-th"/></div>
            <div class="ficha-mod-title">{$o.Mod_Titulo}</div>
            <div class="ficha-mod-desc">{substr($o.Mod_Descripcion, 0, 100)}...</div>
            {if $o.Disponible==1 && isset($inscripcion) && count($inscripcion)>0}
            <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}">
              <button class="btn btn-success btn-modulo">
                {if $o.Completo == 0}
                Iniciar - {$o.Porcentaje}% completado
                {else}
                Repasar - 100% completado
                {/if}
              </button>
            </a>
            {else}
            <button class="btn btn-block btn-modulo" disabled=disabled>No disponible</button>
            {/if}
          </div>

        </div>
        {/foreach}
      </div>
      {/if}
      <div class="col-lg-12">
        <br/>
      </div>
    </div>
  </div>
</div>
