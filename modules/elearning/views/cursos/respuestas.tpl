{extends 'template.tpl'}
{block 'meta'}
<meta name="curso-id" content="{$curso.Cur_IdCurso}">
{/block}
{block 'contenido'}
<input type="text" id="inHiddenCurso" value="{$curso.Cur_IdCurso}" hidden="hidden"> <!-- RODRIGO 20180607 -->
<div class="col col-lg-12">
  <div class="col-lg-12">
    <div class="col-lg-12 referencia-curso-total">
      <a class="referencia-curso" href="{BASE_URL}elearning/cursos/">{$lang->get('str_cursos')}</a>  /  {$curso.Cur_Titulo}
    </div>
  </div>
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col col-lg-10" style="margin-top: 20px; padding-left: 0px;">
    <div class="col-lg-12">
      <div class="panel panel-default">
        <div class="panel-body">
          <div class="col-lg-12" style="padding-left: 0px; padding-right: 0px;">
            <div class="col-lg-3 img-curso">
              <img class="w-100" src="{BASE_URL}files/elearning/cursos/img/portada/{$curso.Cur_UrlBanner}" />
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
              <div class="panel-body" id="pb_respuestas_vue">
                <div class="col-lg-12">
                  <form class="form-inline" role="form" @submit.prevent="onSubmit_filtrar">
                    <div class="form-group">
                      <input type="text" v-model="filter.txt_query" class="form-control" id="" placeholder="{$lang->get('str_alumno')}">
                    </div>
                    <button type="submit" class="btn btn-primary">{$lang->get('str_buscar')}</button>
                  </form>
                </div>
                <div class="col-lg-12">
                    <table class="table wi-100" id="tbl_respuestas" ref="tbl_respuestas">
                      <thead>
                        <tr>
                          <th>{$lang->get('str_alumnos')}</th>
                          <th>{$lang->get('str_fecha')}</th>
                          <th>{$lang->get('str_operacion')}</th>
                        </tr>
                      </thead>
                      <tbody></tbody>
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

{/block}

{block 'css'}
<link rel="stylesheet" type="text/css" href="{BASE_URL}modules/elearning/views/cursos/css/jp-curso.css">
{/block}
{block 'template'}
<template id="tpl_btn_operacion">
    <a href="{$_layoutParams.root}elearning/cursos/respuestas_formulario/{$curso['Cur_IdCurso']}/{literal}{{formulario_respuesta_id}}{/literal}" class="btn btn-default btn-acciones btn-sm" data-toggle="tooltip" data-placement="bottom" title="{$lang->get('str_ver_respuestas')}"><i class="glyphicon glyphicon-file"></i></a>
</template>
{/block}
{block 'js' append}

<script src="{BASE_URL}modules/elearning/views/gestion/js/core/util.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables-build.js"></script>
<script type="text/javascript" src="{BASE_URL}modules/elearning/views/cursos/js/respuestas.js"></script>
{/block}