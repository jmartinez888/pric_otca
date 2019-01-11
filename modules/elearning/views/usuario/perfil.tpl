<div class="col-lg-12">
  	{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
	<input hidden="hidden" id="hidden_url" value="{BASE_URL}/elearning/" />
	<input hidden="hidden" id="hidden_base_url" value="{BASE_URL}files/" />
  	<div class="col-lg-10" style="margin-top: 20px">
  		<div class="panel panel-default margin-top-10">
	        <div class="panel-heading">
	          <h3 class="panel-title">
	            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
	            <strong>Actualizar Datos</strong>
	          </h3>
	        </div>
	        <div class="panel-body" style=" margin: 5px 0px 5px 0px">
	        	<form id="frm-actualizar" method="post" action="{BASE_URL}elearning/usuario/_actualizar_perfil">
			        <input hidden="hidden" id="hiddenUsuario" name="id" value="{Session::get('id_usuario')}" />
		        	<div class="col-lg-6" style="position: relative;">
			        	<img src="{BASE_URL}files/elearning/usuarios/perfil/{$usuario.Usu_URLImage}" 
			        	class="img-perfil" id="perfil-img" style="height: 200px" />
			        	<button id="btnCambiarImg" class="btn btn-default">Cambiar</button>
		        	</div>
		        	<div class="col-lg-6">
			        	<label>Grado Académico</label>
			        	<input class="form-control" name="grado" value="{$usuario.Usu_GradoAcademico}" />
		        	</div>
		        	<div class="col-lg-6">
			        	<label>Especialidad</label>
			        	<input class="form-control" name="especialidad"  value="{$usuario.Usu_Especialidad}" />
		        	</div>
		        	<div class="col-lg-6">
			        	<label>Instituión en que labora</label>
			        	<input class="form-control" name="institucion"  value="{$usuario.Usu_InstitucionLaboral}" />
		        	</div>
		        	<div class="col-lg-6">
			        	<label>Cargo</label>
			        	<input class="form-control" name="cargo"  value="{$usuario.Usu_Cargo}" />
		        	</div>
		        	<div class="col-lg-12" style="margin-top: 10px !important">
			        	<label>Perfil Profesional</label>
			        	<textarea class="form-control" rows="10" name="perfil"
			        	 style="resize: none; text-align: justify;">{$usuario.Usu_Perfil}</textarea>
		        	</div>
		        	<div class="col-lg-12" style="margin-top: 10px !important">
			        	<button class="btn btn-success pull-right" id="btnActualizar">
			        		<i class="glyphicon glyphicon-floppy-disk"></i>
				        	Actualizar
				        </button>
		        	</div>
	        	</form>
	        </div>
	    </div>
  	</div>
	{include file='modules/elearning/views/uploader/uploader.tpl'}
</div>