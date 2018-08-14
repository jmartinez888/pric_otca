

<div class="col-lg-12">
  {include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-9" style="margin-top: 20px">
    {if $curso.Moa_IdModalidad == 2}
    <div class="panel panel-default">
      <div class="panel-heading cabecera-titulo">
        <h3 class="panel-title">
          <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
          <strong>ALUMNOS INSCRITOS</strong>
        </h3>
      </div>
      <div class="panel-body" style=" margin: 15px 25px">
        <div class="col-lg-12">
          {if isset($matriculados) && count($matriculados)}
          <div class="table-responsive" style="width: 100%">
              <table class="table" id="tblMisCursos">
                  <tr>
                      <th>Id</th>
                      <th>Alumnos</th>
                      <th>Usuario</th>
                      <th>Operaciones</th>
                  </tr>
                  {foreach from=$matriculados item=c}
                    <tr>
                        <td>{$c.Usu_IdUsuario}</td>
                        <td>{$c.Usu_Nombre} {$c.Usu_Apellidos}</td>
                        <td>{$c.Usu_Usuario}</td>
                        <td>
                          {if $c.Mat_Valor == 0 }
                          <div><i class="glyphicon glyphicon-remove"></i> Rechazado</div>
                          {else if $c.Mat_Valor == 1 }
                          <div><i class="glyphicon glyphicon-ok"></i> Matriculado</div>
                          {else}
                            <a href="{BASE_URL}elearning/gestion/matricular/{$curso.Cur_IdCurso}/{$c.Usu_IdUsuario}/Si">
                              <button class="btnHabilitar"><i class="glyphicon glyphicon-ok"></i> Aprobar matricula</button>
                            </a>
                            <a href="{BASE_URL}elearning/gestion/matricular/{$curso.Cur_IdCurso}/{$c.Usu_IdUsuario}/No">
                              <button class="btnHabilitar"><i class="glyphicon glyphicon-remove"></i> Rechazar matricula</button>
                            </a>
                          {/if}
                        </td>
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
