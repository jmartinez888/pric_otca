<style>
  .radioalt{
    margin-top: 20px !important;
    margin-left: -10px !important;
  }
</style>
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
{include file='modules/elearning/views/gleccion/menu/lec_titulo.tpl'}
<div class="col-lg-12">
  <div class="panel panel-default margin-top-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Examen</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">

      <form id="frm-actualizar-examen" action="gleccion/_actualizar_examen" method="post">
        <input name="id" value="{$examen.Exa_IdExamen}" hidden="hidden"/>
        <div class="col-lg-3">
          <label class="">Intentos (Por alumno)</label>
          <input name="intentos" type="number" class="form-control" value="{$examen.Exa_Intentos}" />
        </div>
        <div class="col-lg-3">
          <label class="">Porcentaje % (Preguntas Correctas)</label>
          <input name="porcentaje" type="number" class="form-control" value="{$examen.Exa_Porcentaje}" />
        </div>
        <div class="col-lg-3">
          <label class="">Peso en Promedio Final</label>
          <input name="peso" type="number" class="form-control" value="{$examen.Exa_Peso}" />
        </div>
        <div class="col-lg-3">
          <label class="">Nro Preguntas</label>
          <select name="nro_preguntas" class="form-control" value="{$examen.Exa_NroPreguntas}" >
            <option value="4" {if $examen.Exa_NroPreguntas == 4 }selected="selected"{/if}>4 preguntas</option>
            <option value="5" {if $examen.Exa_NroPreguntas == 5 }selected="selected"{/if}>5 preguntas</option>
            <option value="10" {if $examen.Exa_NroPreguntas == 10 }selected="selected"{/if}>10 preguntas</option>
            <option value="20" {if $examen.Exa_NroPreguntas == 20 }selected="selected"{/if}>20 preguntas</option>
          </select>
        </div>
        <div class="col-lg-12 margin-top-10">
          <label class="">Descripción</label>
          <textarea name="descripcion" class="form-control" rows="5">{$examen.Exa_Descripcion}</textarea>
        </div>
        <div class="col-lg-12 margin-top-10">
          <button class="btn btn-success pull-right" id="btn_actualizar">Actualizar</button>
        </div>
      </form>

    </div>
  </div>
</div>

<div class="col-lg-12">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Preguntas</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <div class="col-lg-12">
        {if isset($preguntas) && count($preguntas)>0 }

          <div class="table-responsive" style="width: 100%">
              <table class="table" id="tblMisCursos">
                  <tr>
                      <th>Detalle</th>
                      <th>Operaciones</th>
                  </tr>
                  {foreach from=$preguntas item=p}
                      <tr>
                          <td width="70%">{$p.Pre_Descripcion}</td>
                          <td width="30%">
                            <input class="hidden_IdPregunta estado" value="{$p.Pre_IdPregunta}"/>
                            <input class="hidden_DescripcionPre estado" value="{$p.Pre_Descripcion}"/>
                            <input class="hidden_ValorPre estado" value="{$p.Pre_Valor}"/>
                            <input class="hidden_Alternativas estado" value='{json_encode($p.ALTERNATIVAS)}' />
                            <button class="btnEditarPregunta"><i class="glyphicon glyphicon-pencil"></i></button>
                            {if $p.Pre_Estado == 1 }
                            <button class="btnDeshabilitarPreg"><i class="glyphicon glyphicon-remove"></i></button>
                            {else}
                            <button class="btnHabilitarPreg"><i class="glyphicon glyphicon-ok"></i></button>
                            {/if}
                            <button class="btnEliminarPregunta"><i class="glyphicon glyphicon-trash"></i></button>
                          </td>
                      </tr>
                  {/foreach}
              </table>
          </div>
        {else}
          <div>No tiene ninguna pregunta registrada</div>
        {/if}
        <button class="btn btn-success pull-right" id="btn_agregar_pregunta">Agregar Pregunta</button>
      </div>
    </div>
  </div>
</div>

{if $curso.Mod_IdModCurso == 2}
  {include file='modules/elearning/views/gleccion/menu/lec_calendario.tpl'}
{/if}

<div class="modal fade" id="panelNuevaPregunta" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-xs">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Agregar Pregunta</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body" style="padding: 0px !important">
        <div class="col-lg-12">
          <label class="">Pregunta</label>
          <input placeholder="Pregunta" class="form-control" name="pregunta" id="in_pregunta"/>
        </div>
        <div class="col-lg-9">
          <label class="margin-top-10">Alternativas</label>
        </div>
        <div class="col-lg-3">
          <label class="margin-top-10 pull-right">Correcto</label>
        </div>
        <div class="col-lg-11"><input placeholder="Alternativa 1" class="form-control margin-top-10" name="alt1" id="inPreg1"/></div>
        <div class="col-lg-1"><input type="radio" value="1" class="radioalt margin-top-10" name="valor_preg" checked="checked"/></div>
        <div class="col-lg-11"><input placeholder="Alternativa 2" class="form-control margin-top-10" name="alt1" id="inPreg2"/></div>
        <div class="col-lg-1"><input type="radio" value="2" class="radioalt margin-top-10" name="valor_preg" /></div>
        <div class="col-lg-11"><input placeholder="Alternativa 3" class="form-control margin-top-10" name="alt1" id="inPreg3"/></div>
        <div class="col-lg-1"><input type="radio" value="3" class="radioalt margin-top-10" name="valor_preg" /></div>
        <div class="col-lg-11"><input placeholder="Alternativa 4" class="form-control margin-top-10" name="alt1" id="inPreg4"/></div>
        <div class="col-lg-1"><input type="radio" value="4" class="radioalt margin-top-10" name="valor_preg" /></div>
        <div class="col-lg-11"><input placeholder="Alternativa 5" class="form-control margin-top-10" name="alt1" id="inPreg5"/></div>
        <div class="col-lg-1"><input type="radio" value="5" class="radioalt margin-top-10" name="valor_preg" /></div>
        <div class="col-lg-12" style="margin-bottom: 15px">
          <button class="btn btn-success pull-right margin-top-10" id="btn_registrar_pregunta">Registrar</button>
        </div>
      </div>
    </div>
  </div>
</div>








<div class="modal fade" id="panelModificarPregunta" role="dialog" aria-hidden="true" data-backdrop="static">
  <div class="modal-dialog modal-xs">
    <div class="panel panel-cmacm">
      <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
        <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
        <strong>Modificar Pregunta</strong>
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
      </div>
      <div class="panel-body" style="padding: 0px !important">
        <div class="col-lg-12">
          <label class="">Pregunta</label>
          <input placeholder="Pregunta" name="id" hidden="hidden" id="in_idpregunta_edit"/>
          <input placeholder="Pregunta" class="form-control" name="descripcion" id="in_descpregunta_edit"/>
        </div>
        <div class="col-lg-9">
          <label class="margin-top-10">Alternativas</label>
        </div>
        <div class="col-lg-3">
          <label class="margin-top-10 pull-right">Correcto</label>
        </div>
        <input hidden="hidden" id="inIdAlt1Edit"/>
        <div class="col-lg-11"><input placeholder="Alternativa 1" class="form-control margin-top-10" name="alt1" id="inPreg1Edit"/></div>
        <div class="col-lg-1"><input type="radio" value="1" class="radioalt margin-top-10" name="alt_valor_edit" id="in_rd_valor_1"/></div>
        <input hidden="hidden" id="inIdAlt2Edit"/>
        <div class="col-lg-11"><input placeholder="Alternativa 2" class="form-control margin-top-10" name="alt1" id="inPreg2Edit"/></div>
        <div class="col-lg-1"><input type="radio" value="2" class="radioalt margin-top-10" name="alt_valor_edit" id="in_rd_valor_2"/></div>
        <input hidden="hidden" id="inIdAlt3Edit"/>
        <div class="col-lg-11"><input placeholder="Alternativa 3" class="form-control margin-top-10" name="alt1" id="inPreg3Edit"/></div>
        <div class="col-lg-1"><input type="radio" value="3" class="radioalt margin-top-10" name="alt_valor_edit" id="in_rd_valor_3"/></div>
        <input hidden="hidden" id="inIdAlt4Edit"/>
        <div class="col-lg-11"><input placeholder="Alternativa 4" class="form-control margin-top-10" name="alt1" id="inPreg4Edit"/></div>
        <div class="col-lg-1"><input type="radio" value="4" class="radioalt margin-top-10" name="alt_valor_edit" id="in_rd_valor_4"/></div>
        <input hidden="hidden" id="inIdAlt5Edit"/>
        <div class="col-lg-11"><input placeholder="Alternativa 5" class="form-control margin-top-10" name="alt1" id="inPreg5Edit"/></div>
        <div class="col-lg-1"><input type="radio" value="5" class="radioalt margin-top-10" name="alt_valor_edit" id="in_rd_valor_5"/></div>
        <div class="col-lg-12" style="margin-bottom: 15px">
          <button class="btn btn-success pull-right margin-top-10" id="btn_modificar_pregunta">Actualizar</button>
        </div>

      </div>
    </div>
  </div>
</div>








<script type="text/javascript" src="{$_url}gleccion/js/_view_3.js"></script>
