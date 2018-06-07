<div class="col-lg-12">
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-10" style="margin-top: 20px">
  	<label>Buscar certificado: </label>
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
  	{/if}
  </div>
</div>
