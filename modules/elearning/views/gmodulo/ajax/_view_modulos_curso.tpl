{extends 'index_elearning.tpl'}
{block 'subcontenido'}
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
<div class="col-lg-12">
  <ul class="nav nav-tabs">
    <li role="presentation" class="active" style="font-weight: bold; "><a style="color: #009640;">{$lenguaje.elearning_gcurso_modulos}</a></li>
  </ul>
</div>

<div class="col-lg-12 " id="panelModulos" >
  <div class="panel panel-default" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
    <div class="panel-body padding-t-30" >
      <div class="col-lg-12">
        {if isset($modulos) && count($modulos) > 0 }
          <table class="table" id="tblMisCursos">
              <tr>
                  <th>{$lenguaje.elearning_gcurso_modulo}</th>
                  <th>{$lenguaje.elearning_gcurso_descripcion}</th>
                  <th>{$lenguaje.elearning_gcurso_operaciones}</th>
              </tr>
              {foreach from=$modulos item=c}
                  <tr>
                      <td>{$c.Moc_Titulo}</td>
                      <td>{$c.Moc_Descripcion}</td>
                      <td>
                        <input class="hidden_IdModulo estado" value="{$c.Moc_IdModuloCurso}"/>
                        <button class="btn btn-default btn-sm btnFinalizarReg"><i class="glyphicon glyphicon-pencil"></i></button>
                        {if $c.Moc_Estado == 0 }
                        <button class="btn btn-default btn-sm btnDeshabilitar"><i class="glyphicon glyphicon-remove"></i></button>
                        {else}
                        <button class="btn btn-default btn-sm btnHabilitar"><i class="glyphicon glyphicon-ok"></i></button>
                        {/if}
                        <button class="btn btn-default btn-sm btnEliminar"><i class="glyphicon glyphicon-trash"></i></button>
                      </td>
                  </tr>
              {/foreach}
          </table>
        {else}
          <div>{$lenguaje.elearning_gcurso_sin_modulo}</div>
        {/if}
      </div>
      <div class="col-lg-12">
        <button class="btn btn-success pull-right" type="button" id="btn_nuevo_modulo">
          <i class="glyphicon glyphicon-book"></i> {$lenguaje.elearning_gcurso_new_modulo}
        </button>
      </div>
    </div>
  </div>
</div>

<div class="col-lg-12 margin-top-10" style="display: none" id="panelNuevoModulo">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>{$lenguaje.elearning_gcurso_nuevo_modulo}</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <form method="post" action="gmodulo/_registrar_modulo" id="frm_registro">
        <input hidden="hidden" id="hidden_curso" name="id" value="{$curso.Cur_IdCurso}" />
        <div class="col-lg-12"><h5><strong>{$lenguaje.elearning_gcurso_mtitulo}</strong></h5></div>
        <div class="col-lg-12">
          <input class="form-control" name="titulo" id="inTitulo" />
        </div>
        <div class="col-lg-12"><h5><strong>{$lenguaje.elearning_gcurso_mdescripcion}</strong></h5></div>
        <div class="col-lg-12">
          <textarea class="form-control" name="descripcion" id="inDescripcion" rows="10"></textarea>
        </div>
        <div class="col-xs-12 margin-t-10"><strong>{$lenguaje.elearning_gcurso_tiempo_dedicacion}</strong></div>
        <div class="col-xs-12">
          <input class="form-control" name="dedicacion" />
        </div>
      </form>
      <div class="col-lg-12"></br></div>
      <div class="col-lg-12">
        <button class="btn btn-success" id="btn_registrar_modulo">{$lenguaje.elearning_gcurso_mregistrar}</button>
      </div>
      <div class="col-lg-12"></br></div>
    </div>
  </div>
</div>
{/block}

{block 'js' append}
<!-- <script >
  $("#hidden_curso").val("{Session::get('learn_param_curso')}");
</script> -->
<script type="text/javascript" src="{$_url}gmodulo/js/_view_modulos_curso.js"></script>
{/block}