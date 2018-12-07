{extends 'index_elearning.tpl'}
{block 'css' append}
<style>
  .radioalt{
    margin-top: 20px !important;
    margin-left: -10px !important;
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
<div class="col-lg-12">
  <ul class="nav nav-tabs">
    <li role="presentation" class="active" id="item_titulo"><a href="#">TÍTULO</a></li>
    <li role="presentation" class="" id="item_examen"><a href="#">EXÁMEN</a></li>
  </ul>
</div>
{include file='modules/elearning/views/gleccion/menu/lec_titulo.tpl'}

<!-- <div class="col-xs-12">
  <div class="panel panel-default margin-t-10">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Examen</strong>
      </h3>
    </div>

    <!-- EXAMEN JM -->
    <!-- <div class="panel-body">   -->

        <!-- <div class="row" style="text-align:right">
            <div style="display:inline-block;padding-right:2em">
                <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
                <input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">
                <input class="form-control" placeholder="Buscar examen" style="width: 300px; float: left; margin: 0px 10px;" name="palabraexamen" id="palabraexamen">
                <button class="btn btn-success" style=" float: left" type="button" id="buscarexamen"  ><i class="glyphicon glyphicon-search"></i></button>
            </div>
        </div> --

        <div id="listarexamens">
            <div class="col-xs-12">
                {if isset($porcentaje) && count($porcentaje)  < 1}
                <input type="hidden" name="habilitados" id="habilitados" value="0">

                 <a href="{$_layoutParams.root}elearning/examen/nuevoexamen/{$idcurso}" class="btn btn-primary margin-t-10 fa fa-edit" id="btn_nuevo" > Agregar</a>
                {else}
                <input type="hidden" name="habilitados" id="habilitados" value="{count($porcentaje)}">

                <a data-toggle="modal"  data-target="#msj-invalido" class="btn btn-danger margin-t-10 fa fa-edit" data-placement="bottom" > Agregar</a>
                {/if}
                {if isset($examens) && count($examens)}
                    <div class="table-responsive">
                        <table class="table" style="  margin: 20px auto">
                            <tr>
                                <th style=" text-align: center">Nº</th>
                                <th style=" text-align: center">Título</th>
                                <th style=" text-align: center">Intentos</th>
                                <th style=" text-align: center">Porcentaje</th>
                                <th style=" text-align: center">Estado</th>
                                <th style=" text-align: center">Opciones</th>
                            </tr>
                            {foreach item=rl from=$examens}
                                <tr>
                                    <td style=" text-align: center">{$numeropagina++}</td>
                                    <td style=" text-align: center">{$rl.Exa_Titulo}</td>
                                    <td style=" text-align: center">{$rl.Exa_Intentos}</td>
                                    <td style=" text-align: center">{$rl.Exa_Porcentaje}%</td>
                                    <td style=" text-align: center">
                                    {if $rl.Exa_Estado==0}
                                        <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="{$lenguaje.label_deshabilitado}" style="color: #DD4B39;"></p>
                                    {/if}
                                    {if $rl.Exa_Estado==1}
                                        <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="{$lenguaje.label_habilitado}" style="color: #088A08;"></p>
                                    {/if}
                                    </td>
                                    {if $_acl->permiso("editar_rol")}
                                    <td style=" text-align: center">
                                        {if  $rl.Emitido>=0}
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-examen" title="{$lenguaje.tabla_opcion_cambiar_est}" id_examen="{$rl.Exa_IdExamen}" estado="{$rl.Exa_Estado}"> </a>
                                        {/if}
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" id="btn-Editar" title="Editar" href="{$_layoutParams.root}elearning/examen/editarexamen/{$idcurso}/{$rl.Exa_IdExamen}"></a>

                                         <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-question-sign btn-preguntas" title="Preguntas" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$rl.Exa_IdExamen}"></a>

                                        {if  $rl.Emitido>=0}
                                        <a
                                        {if $rl.Row_Estado==0}
                                            data-toggle="tooltip"
                                            class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-examen" title="{$lenguaje.label_habilitar}"
                                        {else}
                                            data-book-id="{$rl.Pre_Descripcion}"
                                            data-toggle="modal"  data-target="#confirm-delete"
                                            class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-examen" {/if}
                                        id_examen="{$rl.Exa_IdExamen}" data-placement="bottom" > </a>
                                        {/if}
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                        </table>
                    </div>
                    {$paginacionexamens|default:""}
                {else}
                    No hay registros
                {/if}
            </div>
        </div>
        <!-- ultimo -->
        <!-- <div id="listarexamens">
            <div class="col-xs-12">
              <input type="hidden" name="porcentaje" id="porcentaje" value="{$porcentaje}">
              {if $porcentaje < 100}
               <a href="{$_layoutParams.root}elearning/examen/nuevoexamen/{$idcurso}" class="btn btn-primary margin-top-10 glyphicon glyphicon-plus" id="btn_nuevo" > Nuevo</a>
              {else}
               <a data-toggle="modal"  data-target="#msj-invalido" class="btn btn-danger margin-top-10 glyphicon glyphicon-plus" data-placement="bottom" > Nuevo</a>
              {/if}
              {if isset($examens) && count($examens)}
                  <div class="table-responsive">
                      <table class="table" style="  margin: 20px auto">
                          <tr>
                              <th style=" text-align: center">Nº</th>
                              <th style=" text-align: center">Título</th>
                              <th style=" text-align: center">Intentos</th>
                              <th style=" text-align: center">Porcentaje</th>
                              <th style=" text-align: center">Estado</th>
                              <th style=" text-align: center">Opciones</th>
                          </tr>
                          {foreach item=rl from=$examens}
                              <tr>
                                  <td style=" text-align: center">{$numeropagina++}</td>
                                  <td style=" text-align: center">{$rl.Exa_Titulo}</td>
                                  <td style=" text-align: center">{$rl.Exa_Intentos}</td>
                                  <td style=" text-align: center">{$rl.Exa_Porcentaje}%</td>
                                  <td style=" text-align: center">
                                  {if $rl.Exa_Estado==0}
                                      <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="{$lenguaje.label_deshabilitado}" style="color: #DD4B39;"></p>
                                  {/if}
                                  {if $rl.Exa_Estado==1}
                                      <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="{$lenguaje.label_habilitado}" style="color: #088A08;"></p>
                                  {/if}
                                  </td>
                                  {if $_acl->permiso("editar_rol")}
                                  <td style=" text-align: center">
                                      {if  $rl.Emitido>=0}
                                      <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-examen" title="{$lenguaje.tabla_opcion_cambiar_est}" Exa_Porcentaje = "{$rl.Exa_Porcentaje}"
                                      id_examen="{$rl.Exa_IdExamen}" estado="{$rl.Exa_Estado}"> </a>
                                      {/if}
                                      <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" id="btn-Editar" title="Editar" href="{$_layoutParams.root}elearning/examen/editarexamen/{$idcurso}/{$rl.Exa_IdExamen}"></a>

                                       <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-question-sign btn-preguntas" title="Preguntas" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$rl.Exa_IdExamen}"></a>

                                      {if  $rl.Emitido>=0}
                                      <a
                                      {if $rl.Row_Estado==0}
                                          data-toggle="tooltip"
                                          class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-examen" title="{$lenguaje.label_habilitar}"
                                      {else}
                                          data-book-id="{$rl.Pre_Descripcion}"
                                          data-toggle="modal"  data-target="#confirm-delete"
                                          class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-examen" {/if}
                                      id_examen="{$rl.Exa_IdExamen}" data-placement="bottom" > </a>
                                      {/if}
                                      {/if}
                                  </td>
                              </tr>
                          {/foreach}
                      </table>
                  </div>
                  {$paginacionexamens|default:""}
              {else}
                  No hay registros
              {/if}
            </div>
        </div> --

    </div>
  </div>
</div> -->

<!-- <div class="col-xs-12">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>Preguntas</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <div class="col-xs-12">
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
</div> -->

{if $curso.Moa_IdModalidad == 2}
  {include file='modules/elearning/views/gleccion/menu/lec_calendario.tpl'}
{/if}

<div class="modal " id="msj-invalido" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Acción no Disponible</h4>
            </div>
            <div class="modal-body">
                <p>Solo esta permitido tener un examen habilitado por cada leccion, por favor deshabilite todos los examenes relacionado a esta lección par poder agregar un nuevo examen.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Aceptar</button>
            </div>
        </div>
    </div>
</div>
{/block}

{block 'js' append}
<script type="text/javascript" src="{$_url}gleccion/js/_view_3.js"></script>
{/block}
