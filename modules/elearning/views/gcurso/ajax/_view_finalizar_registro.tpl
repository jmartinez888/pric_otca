<style>
  .div-detalle{
    border: 1px solid gray;
    border-radius: 5px;
    position: relative;
    padding-top: 10px;
    padding-bottom: 10px;
  }
  .div-detalle .btn-detalle{
    position: absolute;
    top: 10px;
    right: 10px;
  }
  .img-banner{
    padding-bottom: 10px !important;
  }
</style>
<link href="{$_url}gcurso/css/_view_finalizar_registro.css" rel="stylesheet" type="text/css"/>

{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}

<div class="col-lg-12 margin-top-10">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>CURSO</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      {if strlen($curso.Cur_UrlBanner)>0}
        <img class="img-banner" src="{BASE_URL}modules/elearning/views/cursos/img/portada/{$curso.Cur_UrlBanner}" />
      {/if}
      <button id="btn-subir-imagen" class="btn btn-success margin-top-10">Seleccionar Imagen</button>
    </div>
  </div>
</div>

{include file='modules/elearning/views/uploader/uploader.tpl'}

<div class="col-lg-12">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>FICHA DE CURSO</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <form method="post" action="gcurso/_modificar_curso" id="frm_registro">
      <input hidden="hidden" name="id" value="{$curso.Cur_IdCurso}"/>
      <div class="col-lg-12"><h5><strong>Título del Curso</strong></h5></div>
        <div class="col-lg-12">
          <input name="titulo" id="inTitulo" class="form-control" value="{$curso.Cur_Titulo}"/>
        </div>
        <div class="col-lg-12"><h5><strong>Descripción del Curso</strong></h5></div>
        <div class="col-lg-12">
          <textarea class="form-control" id="inDescripcion" name="descripcion" rows="10">{$curso.Cur_Descripcion}</textarea>
        </div>
        <div class="col-lg-12 margin-top-10">
          <strong></strong>
        </div>
        <div class="col-lg-12"><h5><strong>Objetivo General del Curso</strong></h5></div>
        <div class="col-lg-12"><input class="form-control" id="inObjetivo" name="objgeneral" value="{$curso.Cur_ObjetivoGeneral}"/></div>
        <div class="col-lg-12 margin-top-10"><h5><strong>Objetivos Específicos</strong></h5></div>
        <div class="col-lg-12"><div id="divObjetivosEspecificos"></div></div>
        <div class="col-lg-12">
          <input class="estado" id="toggle_NuevoObjetivo" value="0" />
          <button id="btnNuevoObjetivo" class="form-control" style="width: 150px">Agregar objetivo</button>
        </div>
        <div class="col-lg-12 margin-top-10"><h5><strong>Público Objetivo</strong></h5></div>
        <div class="col-lg-12"><input class="form-control" id="inPublico" name="publico" value="{$curso.Cur_PublicoObjetivo}"/></div>
        <div class="col-lg-12 margin-top-10"><h5><strong>N° Vacantes</strong></h5></div>
        <div class="col-lg-12"><input type="number" class="form-control" id="inVacantes" name="vacantes" value="{$curso.Cur_Vacantes}"/></div>
        <div class="col-lg-12 margin-top-10"><h5><strong>Contacto</strong></h5></div>
        <div class="col-lg-12"><input class="form-control" id="inContacto" name="contacto" value="{$curso.Cur_Contacto}"/></div>
        <div class="col-lg-12"><h5><strong>Requisitos Sotftware</strong></h5></div>
        <div class="col-lg-12"><input class="form-control" id="inSoftware" name="software" value="{$curso.Cur_ReqSoftware}"/></div>
        <div class="col-lg-12"><h5><strong>Requisitos Hardware</strong></h5></div>
        <div class="col-lg-12"><input class="form-control" id="inHardware" name="hardware" value="{$curso.Cur_ReqHardware}"/></div>
        <div class="col-lg-12"><h5><strong>Metodología</strong></h5></div>
        <div class="col-lg-12"><input class="form-control" id="inMetodologia" name="metodologia" value="{$curso.Cur_Metodologia}"/></div>
        <div id="divDetallesCursos"></div>
        <div class="col-lg-12">
          <input class="estado" id="toggle_NuevoDetalle" value="0" />
          <button id="btnNuevoDetalle" class="form-control" style="width: 150px">Agregar información</button>
        </div>
        <div class="col-lg-12 margin-top-10" >
          <button class="btn btn-success" style=" float: right" type="button" id="btn_registrar">
            <i class="glyphicon glyphicon-book"></i> Actualizar Información
          </button>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  $("#hidden_curso").val("{Session::get('learn_param_curso')}");
</script>
<script type="text/javascript" src="{$_url}gcurso/js/_view_finalizar_registro.js"></script>
