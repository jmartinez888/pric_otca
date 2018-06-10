<div class="panel panel-login">
    <div class="panel-heading">
        <div class="row">
            <div class="col-xs-12 col-sm-offset-3 col-sm-6">
                <a href="#" class="active" id="login-form-link">Cambiar Contraseña</a>
            </div>
        </div>
        <hr>
    </div>
    <div class="panel-body">
        <div class="row">
            <div class="col-xs-12 col-sm-offset-3 col-sm-6">
        	{if (isset($modificado) && !empty($modificado)) || !isset($Usu_IdUsuario) }
        		<div class="form-group">
                    <div class="row">
                    	<div class="col-sm-3">
                            <a href="{$_layoutParams.root}" name="btn-cambiar-pass" id="btn-cambiar-pass" tabindex="2" class="form-control btn btn-register" value=""><i class="glyphicon glyphicon-home"></i> Ir a INICIO</a>
                        </div>
                        <div class="col-sm-3 col-sm-offset-3">
                            <a href="#" data-toggle="modal" data-target="#modal-login" name="btn-cambiar-pass" id="btn-cambiar-pass" tabindex="1" class="form-control btn btn-register" value=""><i class="glyphicon glyphicon-log-in"></i> Iniciar Sessión</a>
                        </div>
                    </div>
                </div>
        	{else}
                <form id="login-form" action="#" method="post" role="form" style="display: block;">
                    <input type="hidden" name="Usu_IdUsuario" id="Usu_IdUsuario" value="{$Usu_IdUsuario}">

                    <div class="form-group">
                        <label for="">Contraseña</label>
                        <input type="password" name="passwordCambiar" id="passwordCambiar" data-minlength="6" tabindex="1" class="form-control" placeholder="Contraseña">
                    </div>
                    <div class="form-group">
                        <label for="">Confirmar contraseña</label>
                        <input type="password" name="confirm-password" id="confirm-password" data-minlength="6" data-match="#passwordCambiar" data-match-error="*Contraseña no coinciden" tabindex="2" class="form-control" placeholder="Confirmar contraseña">
                    </div>
                    <div class="form-group">
	                    <div class="row">
	                        <div class="col-sm-6 col-sm-offset-3">
	                            <button type="submit" name="btn-cambiar-pass" id="btn-cambiar-pass" tabindex="3" class="form-control btn btn-success" value=""><i class="glyphicon glyphicon-floppy-disk"></i> Guardar</button>
	                        </div>
	                    </div>
	                </div>
                </form>
            {/if}
            </div>
        </div>
    </div>
</div>