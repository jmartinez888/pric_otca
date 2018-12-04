{extends 'template.tpl'}
{block 'contenido'}
<input type="text" id="inHiddenCurso" value="{$curso.Cur_IdCurso}" hidden="hidden"> <!-- RODRIGO 20180607 -->
<div class="col col-lg-12">
  <div class="col-lg-12">
    <div class="col-lg-12 referencia-curso-total">
      <a class="referencia-curso" href="{BASE_URL}elearning/cursos/">Cursos</a>  /  {$curso.Cur_Titulo}
    </div>
  </div>
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col col-lg-10" style="margin-top: 20px; padding-left: 0px;">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="panel-body">
          <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
            <div class="col-lg-3 img-curso">
              <img class="w-100" src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$curso.Cur_UrlBanner}" />
              {if $curso.Moa_IdModalidad == 1}
              <div class="col-xs-12 text-center mooc" style="color: white; font-weight: bold; font-size: 18px;">MOOC</div>
              {else}
              <div class="col-xs-12 text-center pres" style="color: white; font-weight: bold; font-size: 18px;">PRESENCIAL</div>
              {/if}
            </div>
            <div class="col-lg-6">
            <br>
            <br>
            <h3 style="text-align: center; font-size: 35px;"><strong>{$curso.Cur_Titulo}</strong></h3>
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
          <div class="col-lg-12">
            <div class="panel panel-default">
              <div class="panel-heading cabecera-titulo">
                <h3 class="panel-title">
                  <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
                  <strong>{$lang->get('elearning_formulario_responder_alumnos_inscritos')}</strong>
                </h3>
              </div>
              <div class="panel-body" style=" margin: 15px 25px">
                <div class="col-lg-12" id="formulario_respuestas_vue">
                  <div class="table-responsive" style="width: 100%">
                    <table class="table" id="tblMisCursos">
                      <thead>
                        <tr>
                          <th>{$lang->get('str_alumnos')}</th>
                          <th>{$lang->get('str_fecha')}</th>
                          <th>{$lang->get('str_operacion')}</th>
                        </tr>
                      </thead>
                      <tbody>
                        {foreach $respuestas as $res}
                          <tr>
                            <td>{$res->usuario->Usu_Nombre} {$res->usuario->Usu_Apellidos}</td>
                            <td>{$res->Fur_CreatedAt}</td>
                            <td>
                              <a href="{$_layoutParams.root}elearning/cursos/respuestas_formulario/{$curso['Cur_IdCurso']}/{$res->Fur_IdFrmUsuRes}" class="btn btn-default  btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_ver_respuestas')}"><i class="glyphicon glyphicon-file"></i></a>
                            </td>
                          </tr>
                        {/foreach}
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>



        </div>
      </div>
    </div>
  </div>
</div>

{/block}

{block 'css'}
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/elearning/views/cursos/css/jp-curso.css">
{/block}