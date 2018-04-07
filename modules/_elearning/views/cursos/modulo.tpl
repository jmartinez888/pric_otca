<input value="{BASE_URL}" id="hiddenURL" hidden="hidden" />
<input value="{$modulo.Cur_IdCurso}" id="hiddenCurso" hidden="hidden" />
<div class="row">
    <div class="col-lg-7 tittle-modulo ">
       <h4><strong> Módulo {$modulo["Index"]}: {$modulo["Mod_Titulo"]}</strong></h4>
    </div>
    <div class="col-lg-3 derecha">
        <span>Lección {$leccion["Index"]} de {count($lecciones)}</span>
        {if $leccion["Index"] > 1 }
        <form method="post" action="{BASE_URL}elearning/cursos/_previous_leccion/" style="display: inline-block">
          <input value="{$curso}" name="curso" hidden="hidden"/>
          <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
          <button class="course-students-amount btn btn-danger"> Anterior</button>
        </form>
        {/if}
        {if $leccion["Index"] < {count($lecciones)} }
        <form method="post" action="{BASE_URL}elearning/cursos/_next_leccion/" style="display: inline-block">
          <input value="{$curso}" name="curso" hidden="hidden"/>
          <input value="{$leccion.Lec_IdLeccion}" name="leccion" hidden="hidden"/>
          <button class="course-students-amount btn btn-danger"> Siguiente</button>
        </form>
        {else}
          <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
            <button class="course-students-amount btn btn-danger"> Ir a curso</button>
          </a>
        {/if}
    </div>
    <div class="col-lg-2"></div>
</div>

<div class="row">
  <div class="col-lg-3">
    <a href="{BASE_URL}elearning/cursos/curso/{$curso}">
      <button class="course-students-amount btn btn-danger"> Volver a curso</button>
    </a>
    {include file='modules/elearning/views/cursos/menu/lecciones.tpl'}
  </div>
  <div class="col-lg-7" style="padding-top: 35px;" id="modulo-contenedor">
    <div class="col-lg-12 contenedor" style="padding-bottom: 10px" id="leccion-contenido">
      <div class="col-lg-12"><h4><strong>{$leccion["Lec_Titulo"]}</strong></h4></div>
      {if strlen($leccion["Lec_Descripcion"]) > 0 }
      <div class="col-lg-12">
        <div style="text-align: justify">
        {$leccion["Lec_Descripcion"]}
        </div>
      </div>
      {/if}
      <div class="col-lg-12">
      {if $leccion.Lec_Tipo==1}
        {if isset($html) && count($html) > 0}
          {foreach from=$html item=h}
            <div class="col-lg-12"></br><h5><strong>{$h.CL_Titulo}</strong></h5></div>
            {if strlen($h.CL_Descripcion) > 0 }
            <div class="col-lg-12">
              <div style="text-align: justify">
              {$h.CL_Descripcion}
              </div>
            </div>
            {/if}
          {/foreach}
        {/if}
      {/if}
      {if $leccion["Lec_Tipo"]==2}
        {if isset($html) }
          <br/>
          <div class="video" id="video" >
            <iframe width="100%" height="600" src="{$html.CL_Descripcion}" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen> </iframe>
          </div>
        {/if}
      {/if}
      {if $leccion["Lec_Tipo"]==3 && ($examen["Exa_Intentos"] >= $intentos)}
        <button id="btnExamen" class="btn btn-success"> Iniciar Examen</button>
      {/if}
      </div>
    </div>

    {if $leccion["Lec_Tipo"]==3}
      {include file='modules/elearning/views/cursos/examen.tpl'}
    {/if}

    {if isset($referencias) && count($referencias) > 0 }
    <div class="col-lg-12 contenedor" style="padding-bottom: 10px">
      <div><h4><strong>Referencias</strong></h4></div>
      {foreach from=$referencias item=r}
        <div><strong>{$r.Ref_Titulo}</strong></div>
        <div>{$r.Ref_Descripcion}</div>
      {/foreach}
    <div>
    {/if}
  </div>
  <div class="col-lg-2" style="padding-top: 35px;">
    <div class="panel panel-default">
    <div class="panel-heading">Participantes</div>
    <div class="panel-body">
    <div class="row user-row">
            <div class="col-xs-3 col-sm-2 col-md-1 col-lg-1 ">
              <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
            </div>
            <div class="col-xs-8 col-sm-9 col-md-10 col-lg-10 user-cont">               
                <div class="text-muted name-user">Antonio Saravia Llaja</div>
                <span style="background: rgb(66, 183, 42); border-radius: 50%; display: inline-block; height: 6px; margin-left: 4px; width: 6px;"></span>
            </div>           
        </div>
       <div class="row user-row">
            <div class="col-xs-3 col-sm-2 col-md-1 col-lg-1">
              <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
            </div>
            <div class="col-xs-8 col-sm-9 col-md-10 col-lg-10 user-cont">               
                <div class="text-muted name-user">Rodolfo Cárdenas Vigo</div>
                <span style="background: rgb(66, 183, 42); border-radius: 50%; display: inline-block; height: 6px; margin-left: 4px; width: 6px;"></span>
            </div>           
        </div>
        <div class="row user-row">
            <div class="col-xs-3 col-sm-2 col-md-1 col-lg-1">
              <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
            </div>
            <div class="col-xs-8 col-sm-9 col-md-10 col-lg-10 user-cont">               
                <div class="text-muted name-user">Jhon Charli</div>
                <span style="background: rgb(66, 183, 42); border-radius: 50%; display: inline-block; height: 6px; margin-left: 4px; width: 6px;"></span>
            </div>           
        </div>
        <div class="row user-row">
            <div class="col-xs-3 col-sm-2 col-md-1 col-lg-1">
              <span class="glyphicon glyphicon-user" aria-hidden="true"></span>
            </div>
            <div class="col-xs-8 col-sm-9 col-md-10 col-lg-10 user-cont">               
                <div class="text-muted name-user">Evelin Alana</div>
                <span style="background: rgb(66, 183, 42); border-radius: 50%; display: inline-block; height: 6px; margin-left: 4px; width: 6px;"></span>
            </div>           
        </div>
    </div>
  </div>
  </div>
  <div class="col-lg-1">
  </div>
</div>

<script src="{BASE_URL}public/js/controller.js"></script>
