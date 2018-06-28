<div class="col-lg-12">
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-10" style="margin-top: 20px">


     <div class="panel-body" style=" margin: 15px">
             <div class="row" style="text-align:right">
                <div style="display:inline-block;padding-right:2em">
                    <input class="form-control" placeholder="Buscar Certificado" style="width: 150px; float: left; margin: 0px 10px;" name="palabracertificado" id="palabracertificado">
                    <button class="btn btn-success" style=" float: left" type="button" id="buscarcertificado"  ><i class="glyphicon glyphicon-search"></i></button>
                </div>
            </div>
            <div id="listarcertificados">
                {if isset($certificados) && count($certificados)}
                <div class="table-responsive">
                    <table class="table" style="  margin: 20px auto">
                        <tr>
                            <th style=" text-align: center">Nº</th>
                            <th style=" text-align: center">Código</th>
                            <th style=" text-align: center">Curso</th>
                            <th style=" text-align: center">Fecha</th>
                            {if $_acl->permiso("editar_rol")}
                            <th style=" text-align: center">Opciones</th>
                            {/if}
                        </tr>
                        {foreach item=rl from=$certificados}
                            <tr>
                                <td style=" text-align: center">{$numeropagina++}</td>
                                <td style=" text-align: center">{$rl.Cer_Codigo}</td>
                                <td style=" text-align: center">{$rl.Cur_Titulo}</td>
                                <td style=" text-align: center">{$rl.Cer_FechaReg}</td>
                                {if $_acl->permiso("editar_rol")}
                                <td style=" text-align: center">
                                    <a target="_blank" class="btn btn-success btn-certificado" style="margin-bottom: 10px" href="{BASE_URL}elearning/cursos/obtenerCertificado/{$rl.Cer_IdCertificado}">
                        <strong><span class="glyphicon glyphicon-list-alt"></span> &nbsp;Visualizar</strong>
                      </a>
                                </td>
                                {/if}
                            </tr>
                        {/foreach}
                    </table>
                </div>
                    {$paginacioncertificados|default:""}
                {else}
                    No hay registros
                {/if}                
            </div>
        </div>

  	<!-- <label>Buscar certificado: </label>
  	<form method="post" action="#">
  		<div class="col-lg-8">
  			<input class="form-control" type="text" name="certificado">
  		</div>
  		<div class="col-lg-2">
  			<button style="width: 100%" class="btn btn-success">Buscar</button>
  		</div>  	
  		<div class="col-lg-2">
  			<a style="width: 100%" class="btn btn-info" href="{BASE_URL}elearning/certificado/menu">Limpiar</a>
  		</div>  		
  	</form>

  	{if count($resultados)>0}

  		<label>Resultado: </label>

  		{foreach from=$resultados item=c}
  			<div class="col-lg-12" style="margin-top: 10px; border-radius: 4px; border: 1px solid gray">
  				<div><label>Codigo</label>: {$c.Cer_Codigo}</div>
  				<div><label>Curso</label>: {$c.Cur_Titulo}</div>
  				<div><label>Alumno</label>: {$c.Usu_Nombre},  {$c.Usu_Apellidos}</div>
  				<div><label>Fecha emisión</label>: {$c.Cer_FechaReg}</div>
  			</div>
  		{/foreach}
  	{/if} -->
  </div>
</div>
