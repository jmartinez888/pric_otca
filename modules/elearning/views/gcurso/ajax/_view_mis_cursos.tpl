<div class="col-lg-12">
  <button class="btn btn-success" style=" float: left" type="button" id="btn_nuevo_curso">
    <i class="glyphicon glyphicon-book"></i> Registrar Curso
  </button>
</div>

<div class="col-lg-12 margin-top-10">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h3 class="panel-title">
        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
        <strong>MIS CURSOS</strong>
      </h3>
    </div>
    <div class="panel-body" style=" margin: 15px 25px">
      <div class="col-lg-12">
        <div class="col-lg-8"></div>
        <form id="form-buscar" action="gcurso/_view_mis_cursos" type="post">
          <div class="col-lg-3"><input name="busqueda" class="form-control" placeholder="Busqueda"/></div>
          <div class="col-lg-1"><button id="btn_buscar" class="btn btn-success">Buscar</button></div>
        </form>
        <div class="col-lg-12"></br></div>
        {if isset($cursos) && count($cursos)}
        <div class="table-responsive" style="width: 100%">
            <table class="table" id="tblMisCursos">
                <tr>
                    <th>Id</th>
                    <th>Curso</th>
                    <th>Detalle</th>
                    <th>Operaciones</th>
                </tr>
                {foreach from=$cursos item=c}
                    <tr>
                        <td>{$c.Cur_IdCurso}</td>
                        <td>{$c.Cur_Titulo}</td>
                        <td>{$c.Cur_Descripcion}</td>
                        <td>
                          <input class="hidden_IdCurso estado" value="{$c.Cur_IdCurso}"/>
                          <button class="btnGestion"><i class="glyphicon glyphicon-signal"></i></button>
                          <button class="btnAnuncios"><i class="glyphicon glyphicon-eye-open"></i></button>
                          <button class="btnFinalizarReg"><i class="glyphicon glyphicon-pencil"></i></button>
                          {if $c.Cur_Estado == 1 }
                          <button class="btnDeshabilitar"><i class="glyphicon glyphicon-remove"></i></button>
                          {else}
                          <button class="btnHabilitar"><i class="glyphicon glyphicon-ok"></i></button>
                          {/if}
                           <button class="btnCertificado"><i class="glyphicon glyphicon-picture"></i></button>
                          <button class="btnEliminar"><i class="glyphicon glyphicon-trash"></i></button>
                        </td>
                    </tr>
                {/foreach}
            </table>
        </div>
        {else}
          {if strlen($busqueda) }
            No hay resultados para: {$busqueda}
          {else}
            No tienes cursos
          {/if}
        {/if}
      </div>
    </div>
  </div>
</div>


<script type="text/javascript" src="{$_url}gcurso/js/_view_mis_cursos.js"></script>
