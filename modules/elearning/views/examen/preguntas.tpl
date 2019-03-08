{extends 'template.tpl'}
{block 'contenido'}
{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-xs-12 col-sm-12 col-md-9 col-lg-10">
    <div class="col-lg-12">
        <div class="col-lg-12">
          <div class=" " style="margin-bottom: 0px !important">
            <div class="text-center text-bold" style="margin-top: 20px; margin-bottom: 20px; color: #267161;">
                <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
                <!-- {$titulo} -->
                 {include file='modules/elearning/views/examen/ajax/tag_url.tpl'}
                </h3>
            </div>
          </div>
        </div>
        <h3>{$lenguaje["elearning_preguntas_titulo"]}</h3>
        <hr class="cursos-hr">
        <div class="row">
            <div class="col-sm-2 text-center">
                <a class="nueva_pregunta" _href="{$_layoutParams.root}elearning/examen/registrarRespuestaUnica/{$examen}/{$idcurso}" ><img src="https://campus.chamilo.org/main/img/icons/64/mcua.png" alt="{$lang->get('elearning_preguntas_respU')}" data-toggle="tooltip" data-placement="top" title="{$lenguaje["elearning_preguntas_crearrespuestaunica"]}"></a>
            <label class="text-bold">{$lenguaje["elearning_pregunta_unica"]}</label>
            </div>
            <div class="col-sm-2 text-center">
                <a class="nueva_pregunta" _href="{$_layoutParams.root}elearning/examen/registrarRespuestaMultiple/{$examen}/{$idcurso}" ><img src="https://campus.chamilo.org/main/img/icons/64/mcma.png" alt="{$lang->get('elearning_preguntas_respM')}" data-toggle="tooltip" data-placement="top" title="{$lenguaje["elearning_preguntas_crearrespuestamult"]}"></a>
            <label class="text-bold">{$lenguaje["elearning_pregunta_respm"]}</label>
            </div>
            <div class="col-sm-2 text-center">
                <a class="nueva_pregunta" _href="{$_layoutParams.root}elearning/examen/registrarRespuestaBlanco/{$examen}/{$idcurso}" ><img src="https://campus.chamilo.org/main/img/icons/64/fill_in_blanks.png" alt="{$lang->get('elearning_pregunta_rlleblancos')}" data-toggle="tooltip" data-placement="top" title="{$lenguaje["elearning_preguntas_rellenarblancos"]}"></a>
            <label class="text-bold">{$lenguaje["elearning_pregunta_rlleblancos"]}</label>
            </div>
            <div class="col-sm-2 text-center">
                <a class="nueva_pregunta" _href="{$_layoutParams.root}elearning/examen/registrarRespuestaRelacionar/{$examen}/{$idcurso}" ><img src="https://campus.chamilo.org/main/img/icons/64/matching.png" alt="{$lang->get('elearning_preguntas_relacionar')}" data-toggle="tooltip" data-placement="top" title="{$lenguaje["elearning_preguntas_relacionar"]}"></a>
            <label class="text-bold">{$lenguaje["elearning_preguntas_relacionar"]}</label>
            </div>
            <div class="col-sm-2 text-center">
                <a class="nueva_pregunta" _href="{$_layoutParams.root}elearning/examen/registrarRespuestaAbierta/{$examen}/{$idcurso}" ><img src="https://campus.chamilo.org/main/img/icons/64/open_answer.png" alt="{$lang->get('elearning_preguntas_resA')}" data-toggle="tooltip" data-placement="top" title="{$lenguaje["elearning_preguntas_respabierta"]}"></a>
            <label class="text-bold">{$lenguaje["elearning_preguntas_respuestaabierta"]}</label>
            </div>
            <!-- <div style="display:inline-block;padding-right:2em">
                <a href="{$_layoutParams.root}elearning/examen/registrarRespuestaZonasImagen/{$examen}"><img src="https://campus.chamilo.org/main/img/icons/64/hotspot.png" alt="Zonas de Imagen" title="Zonas de Imagen"></a>
            </div> -->
            <div class="col-sm-2 text-center">
               <!--  <a {if $puntos_maximo>0} href="{$_layoutParams.root}elearning/examen/registrarRespuestaCombinacionExacta/{$examen}/{$idcurso}" {else}
             data-toggle="modal"  data-target="#msj-invalido" data-placement="bottom" 
            {/if}><img src="https://campus.chamilo.org/main/img/icons/64/mcmac.png" alt="Combinación Exacta" data-toggle="tooltip" data-placement="top" title="Crear pregunta con Combinación Exacta"></a> -->
             <a class="nueva_pregunta" _href = "{$_layoutParams.root}elearning/examen/registrarRespuestaCombinacionExacta/{$examen}/{$idcurso}"><img src="https://campus.chamilo.org/main/img/icons/64/mcmac.png" alt="{$lang->get('elearning_preguntas_combinacione')}" data-toggle="tooltip" data-placement="top" title="{$lenguaje["elearning_preguntas_combinacionexacta"]}"></a>
            <label class="text-bold">{$lenguaje["elearning_preguntas_combinacionexacta"]}</label>
            </div>
        </div>
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
            <div class="row" style="text-align:right">
                <div style="display:inline-block;padding-right:2em">
                    <input type="hidden" name="idexamen" id="idexamen" value="{$examen}">
                    <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">          
                    <input class="form-control" placeholder="{$lang->get('elearning_cursos_buscar_pregunta')}" style="width: 300px; float: left; margin: 0px 10px;" name="palabrapregunta" id="palabrapregunta">
                    <button class="btn btn-success" style=" float: left" type="button" id="buscarpregunta"  ><i class="glyphicon glyphicon-search"></i></button>
                </div>
                <a href="{$_layoutParams.root}elearning/examen/editarexamen/{$idcurso}/{$examen}" class="btn btn-danger margin-t-10 col-xs-2" id="btn_nuevo" ><i class="glyphicon glyphicon-triangle-left"></i>{$lenguaje["elearning_preguntas_btnregresar"]}</a>    
            </div>
            <div id="listarpreguntas">
                <input type="hidden" name="puntos" id="puntos" value="{$puntos_maximo}">
                {if isset($preguntas) && count($preguntas)}
                    <div class="table-responsive">
                        <table class="table" style="  margin: 20px auto">
                            <tr>
                                <th style=" text-align: center">Nº</th>
                                <th style=" text-align: center">{$lenguaje["elearning_preguntas_preencabezado"]}</th>
                                <th style=" text-align: center">{$lenguaje["elearning_preguntas_tipoencabezado"]}</th>
                                <th style=" text-align: center">{$lenguaje["elearning_preguntas_puntosencabezado"]}</th>
                                <th style=" text-align: center">{$lenguaje["elearning_preguntas_estadoencabezado"]}</th>
                                <th style=" text-align: center">{$lenguaje["elearning_preguntas_opcionesencabezado"]}</th>
                            </tr>
                            {foreach item=rl from=$preguntas}
                                <tr {if $rl.Row_Estado==0}
                                    {if $_acl->permiso("ver_eliminados")}
                                        class="btn-danger"
                                    {else}
                                        hidden {$numeropagina = $numeropagina-1}
                                    {/if}
                                {/if} >
                                <td style=" text-align: center">{$numeropagina++}</td>
                                <td style=" text-align: center"><p data-toggle="tooltip" data-placement="bottom" title="{$rl.Pre_Descripcion}" >{$rl.Pre_Descripcion|truncate:100:"..."}
                                </p> 
                                </td>
                                <td style=" text-align: center">{if $rl.Pre_Tipo==1}{$lenguaje["elearning_preguntas_respunica"]}{/if}{if $rl.Pre_Tipo==2}{$lenguaje["elearning_preguntas_respmulti"]}{/if}{if $rl.Pre_Tipo==3}{$lenguaje["elearning_preguntas_rellenarblncos"]}{/if}{if $rl.Pre_Tipo==4}{$lenguaje["elearning_preguntas_resprelacionadas"]}{/if}{if $rl.Pre_Tipo==5}{$lenguaje["elearning_preguntas_respabierta"]}{/if}{if $rl.Pre_Tipo==6}{$lenguaje["elearning_preguntas_respzonaimag"]}{/if}{if $rl.Pre_Tipo==7}{$lenguaje["elearning_preguntas_respcombexac"]}{/if}</td>
                                <td style=" text-align: center">{$rl.Pre_Puntos}</td>
                                <td style=" text-align: center"> 
                                    {if $rl.Pre_Estado==0}
                                        <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-remove-sign " title="{$lenguaje.label_deshabilitado}" style="color: #DD4B39;"></p>
                                    {/if}                            
                                    {if $rl.Pre_Estado==1}
                                        <p data-toggle="tooltip" data-placement="bottom" class="glyphicon glyphicon-ok-sign " title="{$lenguaje.label_habilitado}" style="color: #088A08;"></p>
                                    {/if}
                                </td>               
                                    <!-- {if $_acl->permiso("editar_rol")} -->
                                    <td style=" text-align: center">
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-pregunta" title="{$lang->get('str_cambiar_estado')}" id_pregunta="{$rl.Pre_IdPregunta}" Pre_Puntos = "{$rl.Pre_Puntos}" estado="{$rl.Pre_Estado}"> </a>
                                        
                                        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-sm glyphicon glyphicon-edit" title="{$lenguaje["elearning_preguntas_botoneditar"]}" href="{$_layoutParams.root}elearning/examen/{if $rl.Pre_Tipo==1}editarRespuestaUnica{/if}{if $rl.Pre_Tipo==2}editarRespuestaMultiple{/if}{if $rl.Pre_Tipo==3}editarRespuestaBlanco{/if}{if $rl.Pre_Tipo==4}editarRespuestaRelacionar{/if}{if $rl.Pre_Tipo==5}editarRespuestaAbierta{/if}{if $rl.Pre_Tipo==6}editarRespuestaZonasImagen{/if}{if $rl.Pre_Tipo==7}editarRespuestaCombinacionExacta{/if}/{$rl.Pre_IdPregunta}/{$idcurso}"></a>

                                        <a   
                                        {if $rl.Row_Estado==0}
                                            data-toggle="tooltip" 
                                            class="btn btn-default btn-sm  glyphicon glyphicon-ok confirmar-habilitar-pregunta" title="{$lenguaje.label_habilitar}" 
                                        {else}
                                            data-book-id="{$rl.Pre_Descripcion}"
                                            data-toggle="tooltip" data-toggle="modal"  data-target="#confirm-delete" title="{$lang->get('str_eliminar')}"
                                            class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-pregunta" {/if}
                                        id_pregunta="{$rl.Pre_IdPregunta}" data-placement="bottom" > </a>
                                        
                                    </td>
                                    <!-- {/if} -->
                                </tr>
                            {/foreach}
                            <tr>
                                <th style=" text-align: center" colspan="3"></th>
                                <th style=" text-align: center">{$lenguaje["elearning_preguntas_total"]} {$puntos_total}</th>
                                <th style=" text-align: center" colspan="2" ></th>
                            </tr>
                        </table>
                    </div>
                    {$paginacionpreguntas|default:""}
                {else}
                    {$lenguaje["elearning_preguntas_registros"]}
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
                <h4 class="modal-title" id="myModalLabel">{$lenguaje["elearning_preguntas_confirmacioneliminacion"]}</h4>
            </div>
            <div class="modal-body">
                <p>{$lenguaje["elearning_preguntas_eliminaritem"]}</p>
                <p>{$lenguaje["elearning_preguntas_deseascontinuar"]}</p>
                <p>{$lenguaje["elearning_preguntas_eliminar"]} <strong  class="nombre-es">{$lenguaje["elearning_preguntas_pregunta"]}</strong></p>
                <label id="texto_" name='texto_'></label>
                <!-- <input type='text' class='form-control' name='codigo' id='validate-number' placeholder='Codigo' required> --> 
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">{$lenguaje["elearning_preguntas_cancelar"]}</button>
                <a style="cursor:pointer"  data-dismiss="modal" class="btn btn-danger danger eliminar_pregunta">{$lenguaje["elearning_preguntas_btneliminar"]}</a>
            </div>
        </div>
    </div>
</div>

<div class="modal " id="msj-invalido" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">{$lenguaje["elearning_preguntas_accionnodisp"]}</h4>
            </div>
            <div class="modal-body">
                <p>{$lenguaje["elearning_preguntas_textmodal"]}</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary " data-dismiss="modal">{$lenguaje["elearning_preguntas_modalacpet"]}</button>
            </div>
        </div>
    </div>
</div>
{/block}
<!-- <script type="text/javascript">
    Menu(1);
    RefreshTagUrl();
    $("#btn_unica").click(function(){
      CargarPagina("examen/registrarRespuestaUnica", { id: $("#idcurso").val(), idexamen: $("#idexamen").val()}, false, $(this));
    });
</script>
<script type="text/javascript" src="{$_url}examen/js/index.js"></script> -->


