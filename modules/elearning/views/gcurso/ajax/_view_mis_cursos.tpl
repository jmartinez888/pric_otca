{extends 'index_elearning.tpl'}
{block 'css' append}
<style type="text/css">
  .contador{
    color: #393939;
  }

  .clasificacion {
    /*display: inline-block;*/
    /*font-size: 115%;*/
    background: rgba(240,240,240,.8);
    padding: 5px 10px 0px 10px;
    /*position: absolute;*/
    /*top: 0px;*/
    /*right: 0px;*/
    border-radius: 5px;
    margin: 0px;
    /*direction: rtl;*/
    /*unicode-bidi: bidi-override;*/
  }
  .active {
    color: orange;
  }
  .icon-alumnos{
      border-left: 1px solid;
      padding-left: 10px;
      margin-left: 5px;
  }
  .titulo{
      margin-bottom: 8px;
  }

  /*.btn-sm{
    padding: 3px 5px;
  }*/
  .btn-group-sm>.btn, .btn-sm {
      padding: 4px 8px;
      font-size: 16px;
      line-height: unset;
      font-weight: bold;
  }
</style>
{/block}

{block 'subcontenido'}
<div class="col col-lg-12 ">
  <!-- <div class="panel panel-default"> -->
    <!-- <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>MIS CURSOS</strong>
      </h3>
    </div> -->
    <!-- <div class="col-xs-12">
      <h3 class="panel-title text text-center">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>MIS CURSOS</strong>
      </h3>
    </div> -->
    <div class="col-xs-12 panel-body" >
      <div class="col col-lg-12">
        <div class="col-sm-4">
          {if $_acl->permiso("registrar_curso")}
          <button class="btn btn-success" style=" float: left" type="button" id="btn_nuevo_curso">
            <i class="glyphicon glyphicon-book"></i> Registrar Curso
          </button>
          {/if}
        </div>
        <form id="form-buscar" action="gcurso/_view_mis_cursos" type="post">
          <div class="col-sm-offset-3 col-sm-4"><input name="busqueda" class="form-control" placeholder="Busqueda"/></div>
          <div class="col col-sm-1"><button id="btn_buscar" class="btn btn-success"><i class="glyphicon glyphicon-search"></i></button></div>
        </form>
        <div class="col-lg-12"></br></div>
        {if isset($cursos) && count($cursos)}
        <div class="table-responsive" style="width: 100%">
            <table class="table" id="tblMisCursos">
                <tr>
                    <th>Mis Cursos</th>
                    {if $_acl->permiso("editar_curso")} <th>Operaciones</th> {/if}
                </tr>
                {foreach from=$cursos item=c}
                    <tr >
                        <td>
                          <div class="col-xs-2" style="border-right: 1px solid #c1bcbc; "><img class="img-banner ma-w-100 " style="border: 1px solid #c1bcbc;" src="{BASE_URL}files/elearning/cursos/img/portada/{$c.Cur_UrlBanner}" />

                            {if $c.Moa_IdModalidad == 1}
                            <div class="col-xs-12 text-center " style=" background: #EF5350; color: white; font-weight: bold; font-size: 10px;">MOOC</div>
                            {/if}
                            {if $c.Moa_IdModalidad == 2}
                            <div class="col-xs-12 text-center " style="background: #2196F3; color: white; font-weight: bold; font-size: 10px;">LMS</div>
                            {/if}
                          </div>
                          <div class="col-xs-10" {if $_acl->permiso("editar_curso") && $c.Inscrito == 0} style="border-right: 1px solid #c1bcbc;" {/if}>
                              <div class="col col-xs-12 titulo">
                                <a href="{BASE_URL}elearning/cursos/curso/{$c.Cur_IdCurso}" class="text-primary h3" style="text-transform: uppercase;">{$c.Cur_Titulo}</a>
                              </div>
                              <div class="col col-xs-12">
                                <a href="{BASE_URL}elearning/cursos/ficha/{$c.Cur_IdCurso}" class="text-success"><i class="glyphicon glyphicon-user"></i> {$c.Docente} </a>
                              </div>
                              <div class="col col-xs-12">
                                <div class="col-xs-5 clasificacion h5">
                                    <span class="contador">{$c.Valoraciones}&nbsp; </span>
                                    {$foo=1}
                                    {for $foo=1 to 5}
                                        {if $foo <= $c.Valor }
                                            <label><i class="fa fa-star active" ></i></label>
                                        {else}
                                            {if $c.Valor == $foo-0.5}
                                                <label><i class="fa fa-star-half-o active" ></i></label>
                                            {else}
                                                <label><i class="fa fa-star"></i></label>
                                            {/if}
                                        {/if}
                                    {/for}
                                    <i class="fa fa-users icon-alumnos"> {$c.Matriculados} {if $c.Matriculados == 1} Alumno {else} Alumnos {/if} </i>
                                </div>
                              </div>
                          </div>
                        </td>

                          {if $_acl->permiso("editar_curso") && $c.Usu_IdUsuario == Session::get("id_usuario")}
                        <td >
                          <input class="hidden_IdCurso estado" value="{$c.Cur_IdCurso}"/>

                            {if $c.Moa_IdModalidad == 2}
                                <button class="btn btn-sm btn-default btnGestion " data-toggle="tooltip" data-placement="bottom" title="Gestión de Alumnos" ><i class="fa fa-users "></i></button>
                            {else}
                                <button class="btn btn-sm btn-default disabled btnGestion"  data-toggle="tooltip" data-placement="bottom" data-original-title="Gestión de Alumnos" ><i class="fa fa-users "></i></button>
                            {/if}
                            <button class="btn btn-sm btn-default btnAnuncios" data-toggle="tooltip" data-placement="bottom" title="Anuncios de Curso"><i class="glyphicon glyphicon-envelope"></i></button>
                            <button class="btn btn-sm btn-default btnFinalizarReg"  data-toggle="tooltip" data-placement="bottom" title="Editar Curso"><i class="glyphicon glyphicon-pencil"></i></button>
                            {if $c.Cur_Estado == 1 }
                                <button class="btn btn-sm btn-default btnDeshabilitar" data-toggle="tooltip" data-placement="bottom" title="Habilitar Curso"><i class="glyphicon glyphicon-remove" data-toggle="tooltip" data-placement="bottom" title="Deshabilitar Curso" ></i></button>
                            {else}
                                <button class="btn btn-sm btn-default btnHabilitar" data-toggle="tooltip" data-placement="bottom" title="Habilitar Curso"><i class="glyphicon glyphicon-ok" ></i></button>
                            {/if}
                            <button class="btn btn-sm btn-default btnCertificado" data-toggle="tooltip" data-placement="bottom" title="Diseñar Plantilla de Certificado"><i class="glyphicon glyphicon-picture"></i></button>
                            <button class="btn btn-sm btn-default btnExamen" data-toggle="tooltip" data-placement="bottom" title="Gestionar Examenes"><i class="glyphicon glyphicon-file"></i></button>
                            <button class="btn btn-sm btn-default btnEliminar" data-toggle="tooltip" data-placement="bottom" title="Eliminar Curso"><i class="glyphicon glyphicon-trash"></i></button>
                        </td>
                        {/if}
                    </tr>

                {/foreach}
            </table>
        </div>
        {else}
          {if strlen($busqueda) }
            No hay resultados para: {$busqueda}
          {else}
            No tienes cursos
          {/if}
        {/if}
      </div>
    </div>
  <!-- </div> -->
</div>
{/block}

{block 'js' append}
<script type="text/javascript" src="{$_url}gcurso/js/_view_mis_cursos.js"></script>
{/block}
