<div class="col-lg-12">
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-10" style="padding: 10px 0 0 0">
    <div class="col-lg-12" style="margin-bottom: 20px">
      <form method="post" action="{BASE_URL}elearning/index/_busqueda_curso">
        <input class="form-control" name="busqueda" placeholder="Buscar curso"/>
      </form>
    </div>
    {if count($curso) > 0}
      {foreach from=$curso item=o}
      <div class="col-lg-4" style="margin-bottom: 10px">
        <div class="curso-item">
          <img class="curso-item-img" src="{BASE_URL}public/resources/cursos/{$o.Cur_UrlBanner}" />
          <div class="curso-item-mod {if $o.Mod_IdModCurso==1} mooc {else} lms {/if}">{$o.Modalidad}</div>
          <h4 class="curso-item-title">{$o.Cur_Titulo}</h4>

          {if $o.Mod_IdModCurso==1}
            <br/>
            <div class="curso-item-desc">
              {substr($o.Cur_Descripcion, 0, 100)}...
            </div>
          {else}
            <br/>
            <div class="curso-item-desc">
              {substr($o.Cur_Descripcion, 0, 100)}...
            </div>
            <div class="curso-item-lms-tab">
              <div><strong>Inicio:</strong> {$o.Cur_FechaDesde}</div>
              <div><strong>Vacantes:</strong> {$o.Cur_Vacantes}/{$o.Detalle.Matriculados} <strong>Matriculados</strong></div>
              <div><strong>Docente:</strong> {$o.Detalle.Docente}</div>
            </div>
          {/if}

          <a href="{BASE_URL}elearning/cursos/curso/{$o.Cur_IdCurso}">
            <button class="btn btn-default btn-ficha">Ver ficha</button>
          </a>
          {if $o.Usu_IdUsuario == Session::get("id_usuario")}
          <a href="{BASE_URL}elearning/gestion/matriculados/{$o.Cur_IdCurso}">
            <button class="btn btn-default btn-gestion">Gestión</button>
          </a>
          {/if}
        </div>
      </div>
      {/foreach}
    {else}
    <div class="col-lg-12" style="padding: 10px 0 0 0">
      {if strlen($busqueda) >0 }
        <div>No hay resultados para la busqueda: {$busqueda}</div>
      {else}
        {if strlen($usu_curso) >0 }
          <div>{$usu_curso} aun no te has matriculado en ningun curso</div>
        {else}
          <div>No hay cursos</div>
        {/if}
      {/if}
    </div>
    {/if}
  </div>
<div>
