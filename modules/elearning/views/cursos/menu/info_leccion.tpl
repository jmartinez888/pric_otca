      <div class="col-lg-12" style="padding-left:0px; padding-right:0px;">
      <div class="">
        <ul class="nav nav-tabs">
            {if strlen($leccion["Lec_Descripcion"]) > 0 }
              <li class="active"><a class="active-tab" data-toggle="tab" href="#inf_curso">{$lang->get('elearning_cursos_informacion_leccion')}</a></li>
            {/if}
            {if isset($materiales) && count($materiales) > 0 }
              <li><a class="active-tab" data-toggle="tab" href="#mat_ditac">{$lang->get('elearning_cursos_material_didactico')}</a></li>
            {/if}
            {if isset($referencias) && count($referencias) > 0 }
              <li><a class="active-tab" data-toggle="tab" href="#ref_mat">{$lang->get('str_referencias')}</a></li>
            {/if}
            {if isset($tareas) && count($tareas) > 0 }
              <li><a class="active-tab" data-toggle="tab" href="#tar_mat">{$lang->get('elearning_cursos_tareas_pendientes')}</a></li>
            {/if}
        </ul>
        {if strlen($leccion["Lec_Descripcion"]) > 0 }
        <div class="panel panel-default panel-body">
          <div class="tab-content">
            {if strlen($leccion["Lec_Descripcion"]) > 0 }
            <div id="inf_curso" class="tab-pane fade in active">
              <div style="text-align: justify">
                {$leccion["Lec_Descripcion"]|default:"-"}
              </div>
            </div>
            {/if}
            {if isset($materiales) && count($materiales) > 0 }
            <div id="mat_ditac" class="tab-pane fade">
              {foreach from=$materiales item=r}
                <div>
                  <a href="{BASE_URL}elearning/clase/download/{$r.Mat_Enlace}">
                    <strong>{$r.Mat_Descripcion}</strong>
                  </a>
                </div>
              {/foreach}
            </div>
            {/if}
            {if isset($referencias) && count($referencias) > 0 }
              <div id="ref_mat" class="tab-pane fade">
                 {foreach from=$referencias item=r}
                  <div><strong>{$r.Ref_Titulo}</strong></div>
                  <div>{$r.Ref_Descripcion}</div>
                {/foreach}
              </div>
            {/if}
            {if isset($tareas) && count($tareas) > 0 }
              {include file='modules/elearning/views/uploader/uploader.tpl'}
              <div id="tar_mat" class="tab-pane fade">
                <div class="col-lg-12">
                  <table class="table table-striped" id="tblMisCursos">
                    <tbody>
                      <tr>
                        <th width="20%"><center>{$lang->get('str_trabajo')}</center></th>
                        <th width="20%"><center>{$lang->get('str_fechas')}</center></th>
                        <th width="30%"><center>{$lang->get('str_detalle')}</center></th>
                        <th width="10%"><center>{$lang->get('str_adjuntos')}</center></th>
                        <th width="10%"><center>{$lang->get('str_estado')}</center></th>
                        <th width="10%"><center>{$lang->get('str_acciones')}</center></th>
                      </tr>
                      {foreach from=$tareas item=r}
                      <tr>
                        <td>{$r.Tra_Titulo}</td>
                        <td>{$lang->get('str_desde')}: {$r.Tra_FechaDesde}<br/>{$lang->get('str_hasta')}: {$r.Tra_FechaHasta}</td>
                        <td>{$r.Tra_Descripcion}</td>
                        <td>
                          {if isset($r.Archivos) && count($r.Archivos)> 0}
                            <center>
                            {foreach from=$r.Archivos item=file}
                              <a href="{BASE_URL}modules/elearning/views/gleccion/_contenido/_trabajos/{$file.Arc_Ruta}" target="_blank">
                                <i class="glyphicon glyphicon-file"></i>
                              </a>
                            {/foreach}
                            </center>
                          {/if}
                        </td>
                        <td>
                          <center>
                          {if $r.Condicion == 0}
                            <div>{strtoupper($lang->get('str_activo'))}</div>
                          {elseif $r.Condicion == 1}
                            <div>{strtoupper($lang->get('elearning_cursos_proximo_a_activarse'))}</div>
                          {elseif $r.Condicion == 2}
                            <div>{strtoupper($lang->get('elearning_cursos_periodo_concluido'))}</div>
                          {/if}
                          </center>
                        </td>
                        <td>
                          <center>
                          {if $r.Condicion == 0}
                            <button class="btn btn-success btnResolverTarea" tag="{$r.Tra_IdTrabajo}" tipo="{$r.Tra_Tipo}">
                              <i class="glyphicon glyphicon-file"></i> {$lang->get('str_resolver')}
                            </button>
                          {else}
                            <div>{strtoupper($lang->get('str_ninguno'))}</div>
                          {/if}
                          </center>
                        </td>
                      </tr>
                      {/foreach}
                    </tbody>
                  </table>
                </div>
              </div>

              <div class="modal fade" id="panelResolverTrabajo" role="dialog" aria-hidden="true" data-backdrop="static">
                <div class="modal-dialog modal-xs">
                  <div class="panel panel-cmacm">
                    <div class="panel-heading" style="background-color: #f5f5f5; color: #333">
                      <span style="height: 20px; width: 20px; margin-right: 5px;" class="glyphicon glyphicon-list-alt"></span>
                      <strong>{$lang->get('elearning_cursos_resolver_tarea')}</strong>
                      <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="margin-top: 0px;">&times;</button>
                    </div>
                    <div class="panel-body">
                      <div class="col-lg-12 margin-top-10"><strong>{$lang->get('str_titulo')}</strong></div>
                      <input id="inIdTarea" hidden="hidden"/>
                      <input id="inTipoTarea" hidden="hidden"/>
                      <input hidden="hidden" id="inIdTrabajo" name="trabajo"/>
                      <div class="col-lg-12">
                        <input class="form-control" name="titulo" id="inResTarTit" autocomplete="off"/>
                      </div>
                      <div class="col-lg-12 margin-top-10"><strong>{$lang->get('str_descripcion')}</strong></div>
                      <div class="col-lg-12">
                        <textarea class="form-control" name="descripcion" id="inResTarDesc" rows="4"
                        maxlength="300"  autocomplete="off"></textarea>
                      </div>
                      <div class="col-lg-12" style="margin-top: 10px;" id="zonaFilesAdjuntos">
                        <label>{$lang->get('str_archivos_adjuntos')}: </label>
                        <div id="divArcAdjTarea"></div>
                        <button class="btn btn-default" id="btnAgregarArchivoTarea">
                          <i class="glyphicon glyphicon-file"></i>
                          {$lang->get('str_adjuntar_archivo')}
                        </button>
                      </div>
                      <div class="col-lg-12 margin-top-10" style="padding-top: 10px">
                        <button class="btn btn-success" id="btn_resolver_tarea"> {$lang->get('str_guardar')}</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            {/if}
          </div>
        </div>
        {/if}
      </div>
    </div>
