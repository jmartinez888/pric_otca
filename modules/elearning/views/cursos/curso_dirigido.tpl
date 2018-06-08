<input type="text" id="inHiddenCurso" value="{$curso.Cur_IdCurso}" hidden="hidden"> <!-- RODRIGO 20180607 -->
<div class="col-lg-12">
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-10" style="margin-top: 20px">
<<<<<<< HEAD
    <div class="col-lg-12 curso-item">
      <div class="col-lg-12">
        <h3><div>{$curso.Cur_Titulo}</div></h3>
      </div>
      <div class="col-lg-4">
        <img class="img-banner" src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$curso.Cur_UrlBanner}" />
      </div>
      <div class="col-lg-8">
        <div><strong>Descripción del curso</strong></div>
        <div>{$curso.Cur_Descripcion}</div> <br/>
        <div class="col-lg-6">
          <div><strong>Duración curso</strong></div>
          <div>{$curso.Cur_Duracion|default: $duracion}</div> <br/>
        </div>
        <div class="col-lg-6">
          <div><strong>Público objetivo</strong></div>
          <div>{$curso.Cur_PublicoObjetivo}</div> <br/>
        </div>
        <div class="col-lg-6">
          <div><strong>Metodología</strong></div>
          <div>{$curso.Cur_Metodologia}</div> <br/>
        </div>
        <div class="col-lg-6">
          <div><strong>Contacto</strong></div>
          <div>
            {$curso.Cur_Contacto}
            <a href="{BASE_URL}elearning/cursos/ficha/{$curso.Cur_IdCurso}" style="display: inline-block;">
                Detalle
                <!--button class="btn btn-success">
                  <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                </button-->
              </a>
=======
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
            <iframe class="video-intro" width="100%" height="310" src="https://www.youtube.com/embed/eBVvD85Ml2c" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
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
                <strong style="color: #393939; font-size: 16px">4.5/5</strong>
                <br>
                <strong style="color: #393939; font-size: 16px">Valoración media</strong>
              </div>

            </center>
          </div>
          
          <div class="col-lg-12 text-curso">
            <div>{$curso.Cur_Descripcion}</div> <br/>
>>>>>>> a6522c2515c35f0438b639ba27d4092b77c55751
          </div>
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
                  {if !count($certificado)}
                    <button class="btn btn-info" style="margin-bottom: 10px" id="btnCertificado">
                      <span class="glyphicon glyphicon-list-alt"></span> Obtener certificado
                    </button>
                  {else}
                    <a class="btn btn-info" style="margin-bottom: 10px" href="">
                      <span class="glyphicon glyphicon-list-alt"></span> Visualizar certificado
                    </a>
                  {/if}
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
        <button data-toggle="modal" data-target="#modal-login" id="login-form-link" class="btn btn-primary btn-md btn_login_user">Loguearme<i class="fa fa-sign-in"></i></button>
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

      {if $session==1 && count($modulo)>0 }
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
                {if $l.Activo==0}
                  {if ($session==1 && isset($inscripcion) && count($inscripcion)>0 && $inscripcion[0].Mat_Valor==1) }
                  <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}/{$l.Lec_IdLeccion}">
                  <div class="tag-terminado"><center>Revisar</center></div>
                  </a>
                  {else}
                    {if $curso.Usu_IdUsuario == Session::get('id_usuario')}
                    <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}/{$l.Lec_IdLeccion}">
                    <div class="tag-terminado"><center>Revisar lección</center></div>
                    </a>
                    {else}
                      {if $l.Lec_Tipo==4}
                      <div class="tag-terminado"><center>Clase Concluida</center></div>
                      {elseif $l.Lec_Tipo==5 }
                      <div class="tag-terminado"><center>Exámen Concluido</center></div>
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
          </div>
          {/foreach}
        {/foreach}
      </div>
      {/if}




      {if $session==1}
      <div class="col-lg-12" style="margin-top: 30px"> <!-- RODRIGO 20180607 -->
        <label>Calificar curso</label>
        <textarea class="form-control" rows="4" id="txCComentario" maxlength="450"></textarea>
        <input type="text" id="inCUsuario" value="{$curso.Cur_IdCurso}" hidden="hidden">
        <input type="text" id="inCCurso" value="{Session::get('id_usuario')}" hidden="hidden">
      </div>
      <div class="col-lg-8">
        <div class="corazones no-selecionable" style="padding-top: 10px">
          <span class="glyphicon glyphicon-heart item-calificar" tag="1"></span>
          <span class="glyphicon glyphicon-heart item-calificar" tag="2"></span>
          <span class="glyphicon glyphicon-heart item-calificar" tag="3"></span>
          <span class="glyphicon glyphicon-heart item-calificar" tag="4"></span>
          <span class="glyphicon glyphicon-heart item-calificar" tag="5"></span>
        </div>            
      </div>
      <div class="col-lg-4">
        <button class="btn btn-default pull-right" style="margin-top: 10px" id="btnCalificar">
          <span class="glyphicon glyphicon-heart"></span> Calificar
        </button>
      </div> 
      {/if}
      <div class="col-lg-12" style="margin-top: 30px">
        <label>Valoraciones del curso: </label>
      </div> 
      <div class="col-lg-12">
        <div id="calificaciones"></div>
      </div> <!-- RODRIGO 20180607 -->


      <div class="col-lg-12">
        <br/>
      </div>
    </div>
  </div>
</div>
