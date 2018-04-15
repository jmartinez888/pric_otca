<style type="text/css">
	.img-perfil{
		width: 250px;
		height: 250px;
		display: inline-block;
		border-radius: 5px;
	}
	.font-inst{
		color: #3c8dbc;
	}
</style>
<div class="col-lg-12">
  	{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  	<div class="col-lg-10" style="margin-top: 20px">
	    <div class="col-lg-12">
	    	<div class="panel panel-default margin-top-10">
		        <div class="panel-heading">
		          <h3 class="panel-title">
		            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
		            <strong>{$curso.Cur_Titulo}: Datos del Docente</strong>
		          </h3>
		        </div>
		        <div class="panel-body" style=" margin: 5px 0px 5px 0px">
		        	<div class="col-lg-4">
		        		<img class="img-perfil" 
		        		src="{BASE_URL}modules/elearning/views/usuario/_contenido/_perfil/{$usuario.Usu_URLImage}">
		        	</div>
		        	<div class="col-lg-8">
						<div class="col-lg-12">
			        		<h4><strong>{$usuario.Usu_Nombre} {$usuario.Usu_Apellidos}</strong></h4>
			        	</div>
			        	<div class="col-lg-12">
			        		<div class="font-inst">{$usuario.Usu_InstitucionLaboral|default: "---"}</div>
			        	</div>
			        	<div class="col-lg-12">
			        		{$usuario.Usu_Cargo|default: "---"}
			        	</div>

			        	<div class="col-lg-12">
			        		<label>Grado Académico</label>
			        		<div>{$usuario.Usu_GradoAcademico|default: "---"}</div>
			        	</div>
			        	<div class="col-lg-12">
			        		<label>Especialidad</label>
			        		<div>{$usuario.Usu_Especialidad|default: "---"}</div>
			        	</div>
		        	</div>

		        	<div class="col-lg-12" style="text-align: justify;">
		        		{$usuario.Usu_Perfil|default: "---"}
		        	</div>

		        	<div class="col-lg-12"></br></div>
		        	{if isset($cursos) && count($cursos)>1}
		        		<div class="col-lg-12">
		        			<label>Otros cursos: </label>
						</div>
		        		{foreach from=$cursos item=c}
			        		{if $c.Cur_IdCurso != $curso.Cur_IdCurso}
			        		<div class="col-lg-6">
			        			<a href="{BASE_URL}elearning/cursos/curso/{$c.Cur_IdCurso}">
			        				<!--button class="btn btn-success"-->
			        				{$c.Cur_Titulo}
			        				<!--/button-->
			        			</a>
					        </div>    
					        {/if}
		        		{/foreach}
		        	{/if}
		        	{if Session::get("autenticado") && $usuario.Usu_IdUsuario == Session::get("id_usuario")}
		        	<div class="col-lg-12">
		        		<a href="{BASE_URL}elearning/usuario/perfil">
			        		<button class="btn btn-success pull-right">
			        			<i class="glyphicon glyphicon-pencil"></i>
			        			Editar Ficha
			        		</button>
		        		</a>
		        	</div>
		        	{/if}
		        </div>
		    </div>
	    </div>
	    <div class="col-lg-12">
	    	<a href="{BASE_URL}elearning/cursos/curso/{$curso.Cur_IdCurso}">
				<button class="btn btn-success pull-right" style="margin-bottom: 10px !important">
					<i class="glyphicon glyphicon-book"></i>
					Volver a curso
				</button>
			</a>
	    </div>
	</div>
</div>