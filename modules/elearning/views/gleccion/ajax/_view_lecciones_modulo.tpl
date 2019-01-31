{extends 'index_elearning.tpl'}
{block 'css' append}
<style type="text/css">
  .div_modulo{
    display: block;
  }
  .div_lecciones{
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
{/block}

{block 'subcontenido'}
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
<input type="hidden" id="IdiomaOriginal" value="{$IdiomaOriginal}"/>

<div id="gestion_idiomas">
{if isset($modulo) && count($modulo)}
    {if  isset($idiomas) && count($idiomas)}
      <div class="col-lg-12">
          <ul class="nav nav-tabs ">
            {foreach from=$idiomas item=idi}
                <li role="presentation" class="{if $modulo.Idi_IdIdioma==$idi.Idi_IdIdioma} active {/if}">
                    <a class="idioma_s" id="idioma_{$idi.Idi_IdIdioma}" href="#">{$idi.Idi_Idioma}</a>
                    <input type="hidden" id="hd_idioma_{$idi.Idi_IdIdioma}" value="{$idi.Idi_IdIdioma}" />
                    <input type="hidden" id="idiomaTradu" value="{$modulo.Idi_IdIdioma}"/>
                </li>    
            {/foreach}
          </ul>
      </div>        
    {/if}

    <!--  Tabs-->
    <div class="col-xs-12" style="padding-top: 15px;">
      <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active" id="item_modulo"><a href="#item" aria-controls="item">{$lenguaje.elearning_cursos_modulos}</a></li>
        <li role="presentation" id="item_lecciones" ><a href="#item" aria-controls="lecciones">{$lenguaje.elearning_cursos_lecciones}</a></li>
      </ul>
    </div>
    <!-- Modulo -->
    <div {if isset($active) && $active == "mod" } class="col-xs-12  div_modulo display-block tab-pane" {else} class="col-xs-12  div_modulo tab-pane" {/if} id="item" role="tabpanel">
      <div class="panel panel-default" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
        <!-- <div class="panel-heading">
          <h3 class="panel-title">
            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
            <strong>{$modulo.Moc_Titulo}</strong>
          </h3>
        </div> -->
        <div class="panel-body">
          <form id="frm-act-modulo" method="post" action="gmodulo/_actualizar_modulo">
              <input hidden="hidden" id="hidden_curso" name="id_curso" value="{$curso.Cur_IdCurso}" />
              <input name="id" id="hidden_modulo" hidden="hidden" value="{$modulo.Moc_IdModuloCurso}" />

              <input hidden="hidden" name="IdiomaOriginal" value="{$modulo.Idi_IdIdioma}" />
              <input hidden="hidden" name="IdiomaOriginal" value="{$IdiomaOriginal}" />

          <div class="col-xs-12"><strong>{$lenguaje.elearning_cursos_titulo}</strong></div>
          <div class="col-xs-12">
            <input class="form-control" name="titulo" value="{$modulo.Moc_Titulo}" />
          </div>
          <div class="col-xs-12 margin-t-10"><strong>{$lenguaje.elearning_cursos_descripcion}</strong></div>
          <div class="col-xs-12">
            <textarea class="form-control" name="descripcion">{$modulo.Moc_Descripcion}</textarea>
          </div>
          <div class="col-xs-12 margin-t-10"><strong>{$lenguaje.elearning_cursos_tiempo_dedicacion}</strong></div>
          <div class="col-xs-12">
            <input class="form-control" name="dedicacion" value="{$modulo.Moc_TiempoDedicacion}" />
          </div>
          </form>
          <div class="col-xs-12 margin-t-10">
            <button id="btn_actualizar_modulo" class="btn btn-success">{$lenguaje.elearning_cursos_actualizar_datos}</button>
          </div>
        </div>
      </div>
    </div>

{/if}
</div>


<!-- Lecciones -->
<div class="col-xs-12 div_lecciones tab-pane" id="lecciones" role="tabpanel">
  <div class="panel panel-default" style="border-top: 0; border-top-left-radius: 0; border-top-right-radius: 0;">
    <!-- <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Lecciones del Módulo</strong>
      </h3>
    </div> -->
    <div class="panel-body" >
      <div class="col-xs-12">
        {if isset($lecciones) && count($lecciones) > 0 }
          <table class="table" id="tblMisCursos">
              <tr>
                  <th>{$lenguaje.elearning_cursos_leccion}</th>
                  <th>{$lenguaje.elearning_cursos_tipo}</th>
                  <th>{$lenguaje.elearning_cursos_descripcion}</th>
                  <th>{$lenguaje.elearning_cursos_operaciones}</th>
              </tr>
              {foreach from=$lecciones item=c}
                  <tr>
                      <td>{$c.Lec_Titulo}</td>
                      <td>{$c.Tipo}</td>
                      <td>{substr($c.Lec_Descripcion, 0, 100)}...</td>
                      <td>
                        <input class="hidden_IdLeccion estado" value="{$c.Lec_IdLeccion}"/>
                        {if $c['Lec_Tipo'] == 10}<!-- encuesta -->
                          <a href="{$_layoutParams.root}elearning/gleccion/encuesta/{$c['Lec_IdLeccion']}" class="btn btn-default btn-sm btnFinalizarReg"><i class="glyphicon glyphicon-pencil"></i></a>
                        {else}
                          <button class="btn btn-default btn-sm btnFinalizarReg"><i class="glyphicon glyphicon-pencil"></i></button>
                        {/if}

                        {if $c.Lec_Estado == 1 }
                        <button class="btn btn-default btn-sm btnDeshabilitar"><i class="glyphicon glyphicon-ok"></i></button>
                        {else}
                        <button class="btn btn-default btn-sm btnHabilitar"><i class="glyphicon glyphicon-remove"></i></button>
                        {/if}
                        <button class="btn btn-default btn-sm btnEliminar"><i class="glyphicon glyphicon-trash"></i></button>
                      </td>
                  </tr>
              {/foreach}
          </table>
        {else}
          <div>{$lenguaje.elearning_cursos_sin_leccion}</div>
        {/if}

        <div class="col-xs-12">
          <button class="btn btn-success pull-right" type="button" id="btn_nueva_leccion">
            <i class="glyphicon glyphicon-book"></i>{$lenguaje.elearning_cursos_new_leccion}</button>
          </br>
        </div>
      </div>
    </div>
  </div>
</div>

<div class="col-xs-12 margin-top-10" style="display: none" id="panelNuevaLeccion">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>{$lenguaje.elearning_cursos_nueva_leccion}</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <form method="post" action="gleccion/_registrar_leccion" id="frm_registro">
        <input hidden="hidden" name="id" value="{$modulo.Moc_IdModuloCurso}" />
        <div class="col-xs-12"><h5><strong>{$lenguaje.elearning_cursos_titulo}</strong></h5></div>
        <div class="col-xs-12">
          <input class="form-control" name="titulo" id="inTitulo" />
        </div>
        <div class="col-xs-12"><h5><strong>{$lenguaje.elearning_cursos_tipo_leccion}</strong></h5></div>

        <div class="col-xs-4">
          <select class="form-control" name="tipo">
            {foreach from=$tipo item=t}
            <option value="{$t.Id}">{$t.Titulo}</option>
            {/foreach}
          </select>
        </div>
        <div class="col-xs-8">{$lenguaje.elearning_cursos_descripcion_leccion}</div>
        <div class="col-xs-12"><h5><strong>{$lenguaje.elearning_cursos_descripcion}</strong></h5></div>
        <div class="col-xs-12">
          <textarea class="form-control" name="descripcion" id="inDescripcion" rows="10"></textarea>
        </div>
        <div class="col-xs-12 margin-t-10"><strong>{$lenguaje.elearning_cursos_tiempo_dedicacion}</strong></div>
        <div class="col-xs-12">
          <input class="form-control" name="dedicacion" />
        </div>
      </form>
      <div class="col-xs-12"></br></div>
      <div class="col-xs-12">
        <button class="btn btn-success" id="btn_guardar_leccion">{$lenguaje.elearning_cursos_mregistrar}</button>
      </div>
    </div>
  </div>
</div>
{/block}

{block 'js' append}
<script type="text/javascript" src="{$_url}gleccion/js/_view_lecciones_modulo.js"></script>
{/block}
