{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-xs-12 col-sm-12 col-md-9 col-lg-10" style="margin-top: 20px;">
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
  <div class=" col-lg-12" >
    {if $curso.Moa_IdModalidad == 2}
    <div class="panel panel-default">
      <div class="panel-heading cabecera-titulo">
        <h3 class="panel-title">
          <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
          <strong>ALUMNOS INSCRITOS</strong>
        </h3>
      </div>
      <div class="panel-body" >
        <div class="col-lg-12">
          {if isset($matriculados) && count($matriculados)}
          <div class="table-responsive" style="width: 100%">
              <table class="table" id="tblMisCursos">
                  <tr>
                      <th>Id</th>
                      <th>Alumnos</th>
                      <th>Usuario</th>
                      <th>Matrícula</th>
                      <th>Porcentaje(%)</th>
                      <th>Módulo</th>
                      <th>Lección</th>
                  </tr>
                  {foreach from=$matriculados item=c}
                    <tr>
                        <td>{$c.Usu_IdUsuario}</td>
                        <td>{$c.Usu_Nombre} {$c.Usu_Apellidos}</td>
                        <td>{$c.Usu_Usuario}</td>

                        <td>
                          {if $c.Mat_Valor == 0 }
                          <div class="text-center"><i data-toggle="tooltip" data-placement="right" title="Rechazado" class="text-danger glyphicon glyphicon-remove"></i></div>
                          {else if $c.Mat_Valor == 1 }
                          <div class="text-center" ><i data-toggle="tooltip" data-placement="right" title="Matriculado" class="text-success glyphicon glyphicon-ok"></i> </div>
                          {else}
                            <a type="button" class=" btn btn-success btn-sm  glyphicon glyphicon-ok "  href="{BASE_URL}elearning/gestion/matricular/{$curso.Cur_IdCurso}/{$c.Usu_IdUsuario}/Si" data-toggle="tooltip" data-placement="right" title="Aprobar Matrícula" style="margin: 3px;">
                            </a>
                            <a type="button" class=" btn btn-danger btn-sm  glyphicon glyphicon-remove " href="{BASE_URL}elearning/gestion/matricular/{$curso.Cur_IdCurso}/{$c.Usu_IdUsuario}/No" data-toggle="tooltip" data-placement="right" title="Rechazar Matrícula" style="margin: 3px;">                              
                            </a>
                          {/if}
                        </td>
                        
                        <td>{$c.Porcentaje}%</td>
                        <td>{$c.Moc_Titulo}</td>
                        <td>{$c.Lec_Titulo}</td>
                        
                    </tr>
                  {/foreach}
              </table>
          </div>
          {else}
              No tienes cursos
          {/if}
        </div>
      </div>
    </div>
    {else}
    <div class="panel panel-default">
      <div class="panel-heading cabecera-titulo">
        <h3 class="panel-title">
          <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
          <strong>CURSO MOOC</strong>
        </h3>
      </div>
      <div class="panel-body" style=" margin: 15px 25px">
        <div class="col-lg-12">
          Este es un curso MOOC, no requiere de validación de inscripción
        </div>
      </div>
    </div>
    {/if}
  </div>
</div>
