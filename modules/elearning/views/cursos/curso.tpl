<div class="col-lg-12">
  <div class="col-lg-12 referencia-curso-total" style="padding-top:20px;">
    <strong><a class="referencia-curso" href="{BASE_URL}elearning/cursos/">Cursos</a>  /  {$curso.Cur_Titulo}</strong>
  </div>
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-10" style="margin-top: 20px">
    <div class="col-lg-12">
      <div class="panel panel-default">
        
        <div class="panel-body" style="background: #E3F2FD">
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
          <div class="col-lg-12 text-curso">
            <div>{$curso.Cur_Descripcion}</div> <br/>   
          </div>

          {if isset($objetivos) && count($objetivos)>0}
          <div class="col-lg-12 text-curso">
            <div><strong><i class="glyphicon glyphicon-record"></i>
            &nbsp;Objetivos</strong></div>
            {foreach from=$objetivos item=o}
              <ul>
                <li class="list-objetivos">
                {$o.CO_Titulo}</li>
              </ul>
            <!--<div style="padding: 10px 0px 0px 20px">{$o.CO_Titulo}</div>-->
            {/foreach}
          </div>
          {/if}

          <div class="col-lg-12">
            <br/>
          </div>

          <div class="col-lg-5">
          <!--<div  style="font-size: 16px;">
            <div><strong><i class="glyphicon glyphicon-time"></i>
            Duración curso</strong></div>
            <div style="padding-left: 20px">{$curso.Cur_Duracion|default: $duracion}</div> <br/>
          </div>-->
          <div  style="font-size: 16px;">
            <div><strong><i class="glyphicon glyphicon-globe"></i>
            &nbsp;Público objetivo</strong></div>
            <div style="padding-left: 25px">{$curso.Cur_PublicoObjetivo|default:"---"}</div> <br/>
          </div>

          <div  style="font-size: 16px;">
            <div><strong><i class="glyphicon glyphicon-cog"></i>
            &nbsp;Metodología</strong></div>
            <div style="padding-left: 25px">{$curso.Cur_Metodologia|default:"---"}</div> <br/>
          </div>
          <div  style="font-size: 16px;">
            <div><strong><i class="glyphicon glyphicon-comment"></i>
            &nbsp;Contacto</strong></div>
            <div style="padding-left: 25px">
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

          <div class="col-lg-7">
            <center class="col-lg-10 info-curso">

              <div class="col-lg-4" style="border-right: #90CAF9 solid 2px; height: 100px;">
                <i class="glyphicon glyphicon-user" style="color: #16B8AD; font-size: 25px"></i>
                <br>
                <strong style="color: #393939; font-size: 16px">{$inscritos}</strong>
                <br>
                <strong style="color: #393939; font-size: 16px">Alumnos</strong>
                <br><br>
              </div>

              <div class="col-lg-4" style="border-right: #90CAF9 solid 2px; height: 100px;">
                <i class="glyphicon glyphicon-time" style="color: #31A3BB; font-size: 25px"></i>
                <br>
                <strong style="color: #393939; font-size: 16px">{$curso.Cur_Duracion|default: $duracion}</strong>
                <br><br>
              </div>
              
              <div class="col-lg-4">
                <i class="glyphicon glyphicon-star" style="color: #E9BA46; font-size: 25px"></i>
                <br>
                <strong style="color: #393939; font-size: 16px">4.5/5</strong>
                <br>
                <strong style="color: #393939; font-size: 16px">Valoración media</strong>
              </div>

            </center>
          </div>

          
          <div class="col-lg-12">
            {if $session==1}
              {if isset($inscripcion) && count($inscripcion)>0}
                {if $inscripcion[0].Mat_Valor==2 }
                  <div class="tag-lms"><span>Está pendiente la aprobación de tu inscripción</span></div>
                {else}
                  {if $session && $progreso.Completo==1}
                    <!--img src="{BASE_URL}modules/elearning/views/cursos/img/certificado.png" class="img-certificado"/-->
                  {/if}
                  <div class="tag-inscrito">
                    <span><strong>Inscrito:</strong>
                    {$inscripcion[0].Mat_FechaReg}</span>
                  </div>
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
              <strong>¡Atención!</strong>
              Para inscribirte en el curso necesitas una cuenta.</div>
              <div class="col-lg-12">
                <button data-toggle="modal" data-target="#modal-login" class="btn btn-group btn-ini-sesion">
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
          </div>

          <!--<div class="col-lg-12">
            <div class="circular-progress"></div>
          </div>-->



          {if $session==1 && count($modulo)>0 }
            <div class="col-lg-12">
              <div><h4><strong>Módulos del curso</strong></h4></div>
            </div>
            <div class="col-lg-12" style="padding-left: 0px !important">
              {$index = 1} 
              {foreach from=$modulo item=o}
              <div class="col-lg-12">
                <div class="ficha-mod col-lg-12">

                  <div class="col-lg-3 ficha-mod-icon"><span class="glyphicon glyphicon-th"/>{$index}</div>
                  <div class="col-lg-9 ficha-mod-title"> {$o.Mod_Titulo}</div>
                  <div class="col-lg-9 ficha-mod-desc">{substr($o.Mod_Descripcion, 0, 70)}...</div>
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
                  <button class="btn btn-modulo" disabled=disabled>No disponible</button>
                  {/if}
                </div>

              </div>
              {$index = $index + 1} 
              {/foreach}
            </div>
          {/if}

        </div>
      </div>
    </div>
  </div>
</div>
