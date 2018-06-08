<input type="text" id="inHiddenCurso" value="{$curso.Cur_IdCurso}" hidden="hidden"> <!-- RODRIGO 20180607 -->
<div class="col-lg-12">
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-10" style="margin-top: 20px">
    <div class="col-lg-12">
<<<<<<< HEAD
      <div class="panel panel-default margin-top-10">
        <div class="panel-heading">
          <h3 class="panel-title">
            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
            <strong>{$curso.Cur_Titulo}</strong>
          </h3>
        </div>
        <div class="panel-body" style=" margin: 5px 0px 5px 0px">
          <div class="col-lg-6">
            <img src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$curso.Cur_UrlBanner}" />
=======
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
              <strong>{$curso.Cur_Titulo}</strong>
            </h3>
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
          <div class="col-lg-6">
            <div><strong>Descripción del curso</strong></div>
            <div>{$curso.Cur_Descripcion}</div> <br/>            
          </div>
          <div class="col-lg-3">
            <div><strong>Duración curso</strong></div>
            <div>{$curso.Cur_Duracion|default: $duracion}</div> <br/>
          </div>
          <div class="col-lg-3">
            <div><strong>Público objetivo</strong></div>
            <div>{$curso.Cur_PublicoObjetivo|default:"---"}</div> <br/>
          </div>
          <div class="col-lg-3">
            <div><strong>Metodología</strong></div>
            <div>{$curso.Cur_Metodologia|default:"---"}</div> <br/>
          </div>
          <div class="col-lg-3">
            <div><strong>Contacto</strong></div>
            <div>
              {$curso.Cur_Contacto|default:"---"}
              <a href="{BASE_URL}elearning/cursos/ficha/{$curso.Cur_IdCurso}" style="display: inline-block;">
                Detalle
                <!--button class="btn btn-success">
                  <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                </button-->
              </a>
            </div>
          </div>          
          {if isset($objetivos) && count($objetivos)>0}
          <div class="col-lg-6">
            <div><strong>Objetivos</strong></div>
            {foreach from=$objetivos item=o}
            <div style="margin-top: 10px">{$o.CO_Titulo}</div>
            {/foreach}
          </div>
          {/if}
          <div class="col-lg-3 margin-top-10" style="padding-top: 20px">
            {if $session==1}
              {if isset($inscripcion) && count($inscripcion)>0}
                {if $inscripcion[0].Mat_Valor==2 }
                  <div class="tag-lms"><center>Está pendiente la aprobación de tu inscripción</center></div>
                {else}
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
              <button data-toggle="modal" data-target="#modal-login" id="login-form-link" 
              class="btn btn-primary btn-md btn_login_user">
                Loguearme<i class="fa fa-sign-in"></i>
              </button>
            {/if}
          </div>
          <div class="col-lg-3"><br/>
            <div class="tag-lms" style="width: 100%"><center>Alumnos inscritos {$inscritos}</center></div>
          </div>


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
              {$index = 1} 
              {foreach from=$modulo item=o}
              <div class="col-lg-6">
                <div class="ficha-mod">
                  <div class="ficha-mod-icon"><span class="glyphicon glyphicon-th"/></div>
                  <div class="ficha-mod-title">{$index}. {$o.Mod_Titulo}</div>
                  <div class="ficha-mod-desc">{substr($o.Mod_Descripcion, 0, 70)}...</div>
                  {if ($o.Disponible==1 && isset($inscripcion) && count($inscripcion)>0) || ($curso.Usu_IdUsuario == Session::get('id_usuario') && $o.Disponible==1)}
                  <a href="{BASE_URL}elearning/cursos/modulo/{$curso.Cur_IdCurso}/{$o.Mod_IdModulo}/{$o.PrimerLeccion}">
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
              {$index = $index + 1} 
              {/foreach}
            </div>
          {/if}


          {if $session==1}
          <div class="col-lg-12"> <!-- RODRIGO 20180607 -->
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

        </div>
      </div>
    </div>
  </div>
</div>
