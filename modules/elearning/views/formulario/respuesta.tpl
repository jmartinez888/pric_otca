{extends 'index_elearning.tpl'}
{block 'css' append}
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
  padding: 10px !important;
  border: 2px solid #02969b;
  }
  .div_presentacion{
  display: block;
  }
  .div_contenido{
  display: none;
  }
  .div_parametros{
  display: none;
  }
  .display-block{
  display: block;
  }
  .nav-tabs > .active{
  font-weight: bold;
  }
  .nav-tabs > li.active > a{
  color: #009640 !important;
  }
</style>
<style type="text/css" media="screen">
  h2.tag-custom {
    margin-top: 8px;
    margin-bottom: 4px;

  }
  h3.tag-custom {
    margin-top: 4px;
    margin-bottom: 2px;

  }
</style>
<!-- <link href="{$_url}gcurso/css/_view_finalizar_registro.css" rel="stylesheet" type="text/css"/> -->
{/block}
{block 'subcontenido'}
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}

  {if ($formulario == null)}
    <div class="col-lg-12">
      <h3>No posee formulario</h3>
    </div>
  {else}

      <div class="col-lg-12 ">
        <div class="panel panel-default tab-content" role="" style="">
          <div class="panel-body form-horizontal tab-pane active" role="tabpanel"  id="formulario_editar">

            <div id="formulario_editar_vue">
              <div class="col-sm-12">
                <form role="form" >
                  <div class="form-group">
                    <h1>{$lang->get('str_alumno')} : {$alumno->Usu_Nombre} {$alumno->Usu_Apellidos}</h1>
                    <h3 class="text-right">{$respuesta->Fur_CreatedAt}</h3>
                  </div>
                  <hr>
                  <div class="form-group">
                    <h1>{$formulario->Frm_Titulo}</h1>
                    <p>{$formulario->Frm_Descripcion}</p>
                  </div>
                  <hr>
                  {foreach $formulario->preguntas as $pre}
                    <div class="form-group">
                      {if ($pre->Fpr_Tipo == 'titulo_a' || $pre->Fpr_Tipo == 'titulo_b')}
                        {if ($pre->Fpr_Tipo == 'titulo_a')}
                          <h2 class="tag-custom">{$pre->Fpr_Pregunta}</h2>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'titulo_b')}
                          <h3 class="tag-custom">{$pre->Fpr_Pregunta}</h3>
                        {/if}
                        {if (trim($pre->Fpr_Descripcion) != '')}
                          <p>{$pre->Fpr_Descripcion}</p>
                        {/if}
                      {else}

                        <label class="control-label">{$pre->Fpr_Pregunta}</label>
                        {if ($pre->Fpr_Tipo == 'texto')}

                          <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->Fre_Respuesta}</p>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'parrafo')}
                          <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->Fre_Respuesta}</p>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'select')}
                          <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->opcion->Fpo_Opcion}</p>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'radio')}
                          <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->opcion->Fpo_Opcion}</p>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'box')}

                            <ul class="">
                            {foreach $pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes) as $opc}

                                <li>{$opc->Fpo_Opcion}</li>

                            {/foreach}
                            </ul>

                        {/if}
                        {if ($pre->Fpr_Tipo == 'upload')}
                          {if ($pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes) != null)}
                            {$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->format()}
                          {else}
                            <p>{$lang->get('elearning_formulario_responder_fichero_no_encontrado')}</p>
                          {/if}
                        {/if}
                        {if ($pre->Fpr_Tipo == 'fecha')}
                          <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->Fre_Respuesta}</p>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'hora')}
                          <p>{$pre->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->Fre_Respuesta}</p>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'cuadricula')}
                          <table class="table table-bordered table-hover">
                            <tbody>
                                {foreach $pre->hijos as $fil}
                                <tr>
                                  <td><strong>{$fil->Fpr_Pregunta}</strong></td>
                                  <td>{$fil->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes)->opcion->Fpo_Opcion}</td>
                                </tr>
                                {/foreach}
                            </tbody>
                          </table>
                        {/if}
                        {if ($pre->Fpr_Tipo == 'casilla')}
                          <table class="table table-bordered table-hover">
                            <tbody>
                                {foreach $pre->hijos as $fil}
                                <tr>
                                  <td><strong>{$fil->Fpr_Pregunta}</strong></td>
                                  <td>
                                    <ul class="">
                                    {foreach $fil->detalleRespuestaByResUsu($respuesta->Fur_IdFrmUsuRes) as $opc}
                                      <li>{$opc->Fpo_Opcion}</li>
                                    {/foreach}
                                    </ul>
                                  </td>
                                </tr>
                                {/foreach}
                            </tbody>
                          </table>
                        {/if}
                      {/if}
                    </div>
                  {/foreach}
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>



  {/if}

{/block}
{block 'js' append}
<!-- <script >
$("#hidden_curso").val("{Session::get('learn_param_curso')}");
</script> -->
{if ($formulario != null)}
{* <script type="text/javascript">
  var data_frm = {json_encode($formulario->formatToArray())};
</script> *}
{* <script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript" src="{$_layoutParams.rutas.js}formulario.js"></script> *}

{/if}
{/block}