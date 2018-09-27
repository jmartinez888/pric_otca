<div class="col-lg-12">
  	{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  	<div class="col-lg-10" style="margin-top: 20px">
	    	<div class="panel panel-default">
		        <div class="panel-heading cabecera-titulo">
		          <h3 class="panel-title">
		            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
		            <strong>{$curso.Cur_Titulo}</strong>
		          </h3>
		        </div>
		        <div class="panel-body">
		        	<div class="col-lg-9">
		        		<h2 class="font-docente" style="margin-top: 0px">{$usuario.Usu_Nombre} {$usuario.Usu_Apellidos}</h2>
			        </div>
			        <div class="col-lg-3">
				    	<a href="{BASE_URL}elearning/cursos/curso/{$curso.Cur_IdCurso}">
							<button class="btn btn-group btn-regresar pull-right">
								<i class="glyphicon glyphicon-hand-left"></i>
								Volver al curso
							</button>
						</a>
	    			</div>
		        	<div class="col-lg-4">
		        		<img class="img-perfil" 
		        		src="{BASE_URL}modules/elearning/views/usuario/_contenido/_perfil/{$usuario.Usu_URLImage}">
		        	</div>
		        	<div class="col-lg-8">
			        	<div class="col-lg-12">
			        		<div class="font-inst">{$usuario.Usu_InstitucionLaboral|default: "---"}</div>
			        	</div>
			        	<div class="col-lg-12">
			        		{$usuario.Usu_Cargo|default: "---"}
			        	</div>

			        	<div class="col-lg-12">
			        		<label><i class="glyphicon glyphicon-education"></i>
			        		Grado Académico</label>
			        		<div>{$usuario.Usu_GradoAcademico|default: "---"}</div>
			        	</div>
			        	<div class="col-lg-12">
			        		<label><i class="glyphicon glyphicon-certificate"></i>
			        		Especialidad</label>
			        		<div>{$usuario.Usu_Especialidad|default: "---"}</div>
			        	</div>
		        	</div>

		        	<div class="col-lg-12 perfil">
		        		{$usuario.Usu_Perfil|default: "---"}
		        		<br><br>
		        	</div>

		        	{if isset($cursos) && count($cursos)>1}
		        		<div class="col-lg-12">
		        			<label>Otros cursos: </label>
						</div>
		        		{foreach from=$cursos item=c}
			        		{if $c.Cur_IdCurso != $curso.Cur_IdCurso}
			        		<div class="col-lg-6" style="padding-bottom: 10px">
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
</div>