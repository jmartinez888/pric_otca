<div class="modal-body" >
	<div class="row">
		<div class="col-md-12">
			<div class="panel panel-login">
				<div class="panel-heading">
					<div class="row">
						<div class="col-xs-6">
							<a href="#" class="active" id="login-form-link">{$lenguaje['text_iniciarsession']}</a>
						</div>
						<div class="col-xs-6">
							<a href="#" id="register-form-link">{$lenguaje['frontend_modal_registrate']}</a>
						</div>
					</div>
					<hr>
				</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-lg-12">
							<form id="login-form" action="#" method="post" role="form" style="display: block;">
								<input type="hidden" name="url" id="url" value="{$url}">
								<input type="hidden" name="hd_login_modulo" id="hd_login_modulo" value="">
								<div class="form-group">
									<label for="disabledTextInput">{$lenguaje['frontend_modal_usuario']}</label>
									<input type="text" name="usuarioLogin" id="usuarioLogin" tabindex="1" class="form-control" placeholder="{$lenguaje['frontend_modal_usuario']}" value="" required="">
								</div>
								<div class="form-group">
									<label for="disabledTextInput">{$lenguaje['frontend_modal_contrasenia']}</label>
									<div class="input-group">
										<input type="password" name="passwordLogin" id="passwordLogin" tabindex="2" class="form-control" placeholder="{$lenguaje['frontend_modal_contrasenia']}" required="" onkeypress="tecla_enter_login(event)">
										<span  class="input-group-addon btn btn-default btn-xs" id="show-pass"><i class="glyphicon glyphicon-eye-open" id="btn_ver_clave"></i></span>
									</div>
								</div>
								 {if isset($_errorLogin)}
                                <div class="col-xs-12 text-center" >
                                    <label class="text-danger">{$_errorLogin}</label>
                                </div>
                                {/if}
								<!-- <div class="form-group text-center">
									<input type="checkbox" tabindex="3" class="" name="remember" id="remember">
									<label for="remember"> Recordarme</label>
								</div> -->
								<div class="form-group">
									<div class="row">
										<div class="col-sm-6 col-sm-offset-3">
											<button type="button" name="logear" id="logear" tabindex="4" class="form-control btn btn-login" >{$lenguaje['text_iniciarsession']}</button>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-6 col-sm-offset-3">
											<div class="g-signin2" id="signin2"></div>
										</div>
									</div>
								</div>
								<!-- <div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div> -->
								<!-- <div class="g-signin2" data-width="250" data-height="50" data-longtitle="true"> -->
								<div class="form-group">
									<div class="row">
										<div class="col-lg-12">
											<div class="text-center">
												<a href="#" tabindex="5" class="forgot-password" id="showRecPass">{$lenguaje['frontend_modal_olvidecontrasenia']}</a>
											</div>
										</div>
									</div>
								</div>
							</form>
							<div class="form-group hidden" id="divEnvioCorreo">
								<div class="form-group">
									<label for="disabledTextInput">{$lenguaje['frontend_modal_correorecuperacion']}</label>
									<div class="input-group">
										<input type="text" name="emailRecPass" id="emailRecPass" tabindex="7" class="form-control" placeholder="Correo Electronico" required="" >
										<span data-toggle="tooltip" data-placement="right" title="Enviar Correo"  class="input-group-addon btn btn-default btn-xs" id="btnRecPass"><i class="glyphicon glyphicon-envelope"></i></span>
									</div>
								</div>
							</div>
							<div class="form-group hidden" id="divRecuperar">
							</div>							
                            
							<form id="register-form" action="" style="display: none;">
								<div class="form-group">
									<label for="">{$lenguaje['frontend_form_registronombre']}</label>
									<input type="text" name="nombreRegistrar" id="nombreRegistrar" pattern="([a-zA-Z][\sa-zA-Z]+)" tabindex="1" class="form-control" placeholder="{$lenguaje['frontend_form_registronombre']}" value="">
								</div>
								<div class="form-group">
									<label for="">{$lenguaje['frontend_form_registroapellido']}</label>
									<input type="text" name="apellidosRegistrar" id="apellidosRegistrar" pattern="([a-zA-Z][\sa-zA-Z]+)" tabindex="2" class="form-control" placeholder="{$lenguaje['frontend_form_registroapellido']}" value="">
								</div>
								<div class="form-group">
									<label for="">{$lenguaje['frontend_form_registrocorreo']}</label>
									<input type="email" name="emailRegistrar" id="emailRegistrar" tabindex="3" class="form-control" placeholder="{$lenguaje['frontend_form_registrocorreo']}" value="">
								</div>
								<div class="form-group">
									<label for="">{$lenguaje['frontend_modal_usuario']}</label>
									<input type="text" name="usuarioRegistrar" id="usuarioRegistrar" pattern="([_A-z0-9])+" tabindex="4" class="form-control" placeholder="{$lenguaje['frontend_modal_usuario']}" value="">
								</div>
								<div class="form-group">
									<label for="">{$lenguaje['frontend_modal_contrasenia']}</label>
									<input type="password" name="passwordRegistrar" id="passwordRegistrar" data-minlength="6" tabindex="5" class="form-control" placeholder="{$lenguaje['frontend_modal_contrasenia']}">
								</div>
								<div class="form-group">
									<label for="">{$lenguaje['frontend_form_registro_confcontrasenia']}</label>
									<input type="password" name="confirm-password" id="confirm-password" data-minlength="7" data-match="#passwordRegistrar" data-match-error="*Contraseña no coinciden" tabindex="6" class="form-control" placeholder="{$lenguaje['frontend_form_registro_confcontrasenia']}">
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-6 col-sm-offset-3">
											<button type="button" name="registrar-login" id="registrar-login" tabindex="8" class="form-control btn btn-register" value="">{$lenguaje['frontend_form_registrocrear']}</button>
										</div>
									</div>
								</div>
								<div class="form-group">
									<div class="row">
										<div class="col-sm-6 col-sm-offset-3">
											<div id="registrar-gmail"></div>
										</div>
									</div>
								</div>
							</form>
							 {if isset($_errorRegistrar)}
                                <div class="col-xs-12 text-justify" >
                                    <label class="text-danger">{$_errorRegistrar}</label>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="text-center">
                                                <a href="#" tabindex="5" class="forgot-password" id="showRecPass">¿Has olvidado tu contraseña?</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group hidden" id="divEnvioCorreo">
                                    <div class="form-group">
                                        <label for="disabledTextInput">Ingrese su correo electrónico para recuperar contraseña.</label>
                                        <div class="input-group">
                                            <input type="text" name="emailRecPass" id="emailRecPass" tabindex="7" class="form-control" placeholder="Correo Electronico" required="" >
                                              <span data-toggle="tooltip" data-placement="right" title="Enviar Correo"  class="input-group-addon btn btn-default btn-xs" id="btnRecPass"><i class="glyphicon glyphicon-envelope"></i></span>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group hidden" id="divRecuperar">
                                </div>
                            {/if}
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="modal-footer">
	<a href="#" class="btn btn-default" data-dismiss="modal">{$lenguaje["login_intranet_3"]}</a>
</div>