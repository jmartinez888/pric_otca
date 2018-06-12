<div class="col-lg-12">
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-10" style="margin-top: 20px">
    <div class="col-lg-12">
      <label>Buscar certificado: </label>
    </div>
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
      <div class="col-lg-12" style="margin-top: 20px">
    		<label>Resultado: </label>
    		{foreach from=$resultados item=c}
    			<div class="col-lg-12" style="margin-top: 10px; border-radius: 4px; border: 1px solid gray; position: relative ">
    				<div style="font-size: 16px"><label>Codigo</label>: {$c.Cer_Codigo}</div>
    				<div><label>Curso</label>: {$c.Cur_Titulo}</div>
    				<div><label>Alumno</label>: {$c.Usu_Nombre},  {$c.Usu_Apellidos}</div>
    				<div><label>Fecha emisión</label>: {substr($c.Cer_FechaReg ,0, 10)}</div>
            <button class="btn btn-success" style="position: absolute; top: 30px; right: 20px">Visualizar</button>
    			</div>
    		{/foreach}
      </div>
    {else}
      <div class="col-lg-12" style="margin-top: 50px">
        <center>Ingrese el código de certificado que deseé verificar</center>
      </div>
  	{/if}
  </div>
</div>
