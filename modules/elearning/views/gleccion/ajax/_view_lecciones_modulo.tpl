{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
<div class="col-lg-12 margin-top-10" id="panelModulos">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>{$modulo.Moc_Titulo}</strong>
      </h3>
    </div>
    <div class="panel-body">
      <form id="frm-act-modulo" method="post" action="gmodulo/_actualizar_modulo">
      <div class="col-lg-12"><strong>Titulo</strong></div>
      <div class="col-lg-12">
        <input name="id" hidden="hidden" value="{$modulo.Moc_IdModuloCurso}" />
        <input class="form-control" name="titulo" value="{$modulo.Moc_Titulo}" />
      </div>
      <div class="col-lg-12  margin-top-10"><strong>Descripcion</strong></div>
      <div class="col-lg-12">
        <textarea class="form-control" name="descripcion">{$modulo.Moc_Descripcion}</textarea>
      </div>
      </form>
      <div class="col-lg-12 margin-top-10">
        <button id="btn_actualizar_modulo" class="btn btn-success">Actualizar Datos</button>
      </div>
    </div>
  </div>
</div>

<div class="col-lg-12 margin-top-10" id="panelModulos">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Lecciones del Módulo</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <div class="col-lg-12">
        {if isset($lecciones) && count($lecciones) > 0 }
          <table class="table" id="tblMisCursos">
              <tr>
                  <th>Leccion</th>
                  <th>Tipo</th>
                  <th>Descripción</th>
                  <th>Operaciones</th>
              </tr>
              {foreach from=$lecciones item=c}
                  <tr>
                      <td>{$c.Lec_Titulo}</td>
                      <td>{$c.Tipo}</td>
                      <td>{substr($c.Lec_Descripcion, 0, 100)}...</td>
                      <td>
                        <input class="hidden_IdLeccion estado" value="{$c.Lec_IdLeccion}"/>
                        <button class="btnFinalizarReg"><i class="glyphicon glyphicon-pencil"></i></button>
                        {if $c.Lec_Estado == 1 }
                        <button class="btnDeshabilitar"><i class="glyphicon glyphicon-remove"></i></button>
                        {else}
                        <button class="btnHabilitar"><i class="glyphicon glyphicon-ok"></i></button>
                        {/if}
                        <button class="btnEliminar"><i class="glyphicon glyphicon-trash"></i></button>
                      </td>
                  </tr>
              {/foreach}
          </table>
        {else}
          <div>Aun no registraste ninguna lección al módulo</div>
        {/if}
        
        <div class="col-lg-12">
          <button class="btn btn-success pull-right" type="button" id="btn_nueva_leccion">
            <i class="glyphicon glyphicon-book"></i> Nueva Lección
          </button>
          </br>
        </div>
      </div>
    </div>
  </div>
</div>




<div class="col-lg-12 margin-top-10" style="display: none" id="panelNuevaLeccion">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>NUEVA LECCIÓN</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <form method="post" action="gleccion/_registrar_leccion" id="frm_registro">
        <input hidden="hidden" name="id" value="{$modulo.Moc_IdModuloCurso}" />
        <div class="col-lg-12"><h5><strong>Titulo</strong></h5></div>
        <div class="col-lg-12">
          <input class="form-control" name="titulo" id="inTitulo" />
        </div>
        <div class="col-lg-12"><h5><strong>Tipo Lección</strong></h5></div>

        <div class="col-lg-4">
          <select class="form-control" name="tipo">
            {foreach from=$tipo item=t}
            <option value="{$t.Id}">{$t.Titulo}</option>
            {/foreach}
          </select>
        </div>
        <div class="col-lg-8">
          Aca se describe la leccion
        </div>
        <div class="col-lg-12"><h5><strong>Descripción</strong></h5></div>
        <div class="col-lg-12">
          <textarea class="form-control" name="descripcion" id="inDescripcion" rows="10"></textarea>
        </div>
      </form>
      <div class="col-lg-12"></br></div>
      <div class="col-lg-12">
        <button class="btn btn-success" id="btn_registrar_modulo">Registrar</button>
      </div>
    </div>
  </div>
</div>

<script type="text/javascript" src="{$_url}gleccion/js/_view_lecciones_modulo.js"></script>
