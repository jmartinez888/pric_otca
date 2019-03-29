{extends 'template.tpl'}
{block 'css'}
<style type="text/css">
    .tag-url{
        color: #75ACE5;
        display: inline-block;
        cursor: pointer;
    }
</style>
{/block}

{block 'contenido'}
{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-xs-12 col-sm-12 col-md-9 col-lg-10">
    <div class="col-xs-12">
        <div class="col-xs-12">
            <div class=" " style="margin-bottom: 0px !important">
                <div class="text-center text-bold" style="margin-top: 20px; margin-bottom: 20px; color: #267161;">
                {if isset($idLeccion) && $idLeccion > 0}
                    {include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
                {else}
                    <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
                        {$titulo}
                    </h3>
                {/if}
                </div>
            </div>
        </div>
        <h3>{$lang->get('str_examenes')}</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-xs-12">
        <div class="panel-body">
            <div class="row" style="text-align:right">
                <div style="display:inline-block;padding-right:2em">
                    {if isset($idLeccion) && $idLeccion > 0}
                        <input type="hidden" class="estado" id="hidden_modulo" value="{$modulo.Moc_IdModuloCurso}" />
                        <input type="hidden" class="estado" id="hidden_leccion" value="{$idLeccion}" />

                    {/if}
                    <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
                    <input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">
                    <input class="form-control" placeholder="{$lang->get('elearning_cursos_buscar_examen')}" style="width: 300px; float: left; margin: 0px 10px;" name="palabraexamen" id="palabraexamen">
                    <button class="btn btn-success" style=" float: left" type="button" id="buscarexamen"  ><i class="glyphicon glyphicon-search"></i></button>
                </div>
            </div>
            <div id="listarexamens">
                <div class="col-xs-12">
                    <input type="hidden" name="porcentaje" id="porcentaje" value="{$porcentaje|default:'0'}">
                    {if $porcentaje <= 100}
                        {if isset($idLeccion) && $idLeccion > 0}
                            <input type="hidden" class="estado" id="hidden_habilitado" value="{$Exa_Habilitado|default:'0'}" />

                            <a href="{$_layoutParams.root}elearning/gleccion/_view_leccion/{$idcurso}/{$modulo.Moc_IdModuloCurso}/{$idLeccion}" class="btn btn-danger margin-t-10 " id="btn_nuevo" ><i class="glyphicon glyphicon-triangle-left"></i> {$lang->get('str_regresar')}</a>

                            <a href="{$_layoutParams.root}elearning/examen/nuevoexamen/{$idcurso}/{$idLeccion}" class="btn btn-primary margin-t-10 " id="btn_nuevo" > <i class="glyphicon glyphicon-plus"></i> {$lang->get('str_nuevo')}</a>
                        {else}
                         <a href="{$_layoutParams.root}elearning/examen/nuevoexamen/{$idcurso}" class="btn btn-primary margin-t-10 glyphicon glyphicon-plus" id="btn_nuevo" > {$lang->get('str_nuevo')}</a>
                        {/if}
                    {else}
                     <a data-toggle="modal"  data-target="#msj-invalido" class="btn btn-danger margin-t-10 glyphicon glyphicon-plus" data-placement="bottom" > {$lang->get('str_nuevo')}</a>
                    {/if}
                    {if isset($examens) && count($examens)}
                        <div class="table-responsive">
                            <table class="table" style="  margin: 20px auto">
                                <tr >
                                    <th style=" text-align: center">Nº</th>
                                    <th style=" text-align: center">{$lang->get("examen_titulo")}</th>
                                    <th style=" text-align: center">{$lang->get("examen_intentos")}</th>
                                    <th style=" text-align: center">{$lang->get("examen_procentaje")}</th>
                                    <th style=" text-align: center">{$lang->get("examen_estado")}</th>
                                    <th style=" text-align: center">{$lang->get("examen_opciones")}</th>
                                </tr>
                                {foreach item=rl from=$examens}
                                    <tr {if $rl.Row_Estado==0}
                    {if $_acl->permiso("ver_eliminados")}
                        class="btn-danger"
                    {else}
                        hidden {$numeropagina = $numeropagina-1}
                    {/if}
                {/if}>
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
                                        <!-- {if $_acl->permiso("editar_rol")} -->
                                        <td style=" text-align: center">
                                            {if  $rl.Emitido>=0}
                                            <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-examen" title="{$lenguaje.tabla_opcion_cambiar_est}" Exa_Porcentaje = "{$rl.Exa_Porcentaje}"
                                            id_examen="{$rl.Exa_IdExamen}" estado="{$rl.Exa_Estado}"> </a>
                                            {/if}
                                            <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" id="btn-Editar" title="{$lang->get('str_editar')}" href="{$_layoutParams.root}elearning/examen/editarexamen/{$idcurso}/{$rl.Exa_IdExamen}"></a>

                                             <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-question-sign btn-preguntas" title="{$lang->get('str_preguntas')}" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$rl.Exa_IdExamen}"></a>

                                            {if  $rl.Emitido>=0}
                                            <a
                                            {if $rl.Row_Estado==0}
                                                data-toggle="tooltip"
                                                class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-examen" title="{$lenguaje.label_habilitar}"
                                            {else}
                                                data-book-id="{$rl.Pre_Descripcion}"
                                                data-toggle="modal"  data-target="#confirm-delete"
                                                class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-examen" 
                                            {/if}
                                            id_examen="{$rl.Exa_IdExamen}" data-placement="bottom" > </a>
                                            {/if}

                                            {if $rl.Emitido>=1}
                                             <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-folder-open btn-respuestas" title="{$lang->get('str_ver_respuestas')}" href="{$_layoutParams.root}elearning/examen/intentos/{$idcurso}/{$rl.Exa_IdExamen}"></a>
                                            {/if}
                                            <!-- {/if} -->
                                        </td>
                                    </tr>
                                {/foreach}
                            </table>
                        </div>
                        {$paginacionexamens|default:""}
                    {else}
                        {$lang->get('str_no_hay_registros')}
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal " id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">{$lang->get('elearning_preguntas_confirmacioneliminacion')}</h4>
            </div>
            <div class="modal-body">
                <p>{$lang->get('str_eliminar_pregunta')}</p>
                <p>{$lang->get('str_eliminar_continuar')}</p>
                <p>{$lang->get('str_eliminar')}: <strong  class="nombre-es">{strtolower($lang->get('str_examen'))}</strong></p>
                <label id="texto_" name='texto_'></label>
                <!-- <input type='text' class='form-control' name='codigo' id='validate-number' placeholder='Codigo' required> -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{$lang->get('str_cancelar')}</button>
                <a style="cursor:pointer"  data-dismiss="modal" class="btn btn-danger danger eliminar_examen">{$lang->get('str_eliminar')}</a>
            </div>
        </div>
    </div>
</div>

<div class="modal " id="msj-invalido" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">{$lang->get('str_accion_no_disponible')}</h4>
            </div>
            <div class="modal-body">
                <p>{$lang->get('elearning_cursos_examen_alcanzado_desea_crear_mie')}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{$lang->get('str_cancelar')}</button>
                <a style="cursor:pointer"  data-dismiss="modal" class="btn btn-danger danger eliminar_examen">{$lang->get('str_eliminar')}</a>
            </div>
        </div>
    </div>
</div>
{/block}
<!-- <script type="text/javascript">
    Menu(1);
    RefreshTagUrl();
    $("#btn_nuevo").click(function(){
      CargarPagina("examen/nuevoexamen", { id: $("#idcurso").val() }, false, $(this));
    });
    $(".btn-preguntas").click(function(){
    var IdExamen = $(this).parent().find(".hidden_IdExamen").val();
      $("#hidden_IdExamen").val(IdExamen);
          CargarPagina("examen/preguntas", { id: $("#idcurso").val(), idleccion:IdExamen }, false, $(this));
    });
</script> -->
<!-- <script type="text/javascript">
  setTimeout(function(){
    $("#item-lista-curso").click(function(){
        location.href = "{$_layoutParams.root}elearning/gcurso/_view_mis_cursos/"+$("#hidden_curso").val();
    });
    $("#item-ficha-curso").click(function(){
        CargarPagina("gcurso/_view_finalizar_registro", { id: $("#hidden_curso").val() }, false, $(this));
    });
    $("#item-modulos-curso").click(function(){
        CargarPagina("gmodulo/_view_modulos_curso", { id: $("#hidden_curso").val() }, false, $(this));
    });
    $("#item-tareas-curso").click(function(){
        CargarPagina("gmodulo/_view_tareas_curso", { id: $("#hidden_curso").val() }, false, $(this));
    });
     $("#item-examen-curso").click(function(){
        location.href = "{$_layoutParams.root}elearning/examen/examens/"+$("#hidden_curso").val();
    });
  }, 400);
</script> -->
<!-- <script type="text/javascript" src="{$_url}examen/js/index.js"></script>

<script >
  $("#hidden_curso").val("{Session::get('learn_param_curso')}");
</script> -->

