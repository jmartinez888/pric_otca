 <script type="text/javascript">renderButton()</script>
<div class="modal-body" >
    <div class="row">
        <div class="col-md-12">
            <div class="panel panel-login">
                <div class="panel-heading">
                    <div class="row">
                        <div class="col-xs-6">
                            <a href="#" {if isset($_errorLogin)} class="active" {/if} id="login-form-link">Iniciar Sessión</a>
                        </div>
                        <div class="col-xs-6">
                            <a href="#" {if isset($_errorRegistrar)} class="active" {/if} id="register-form-link">Regístrate ahora</a>
                        </div>
                    </div>
                    <hr>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12">
                            <form id="login-form" action="#" method="post" role="form" {if isset($_errorLogin)} style="display: block;" {else} style="display: none;" {/if} >
                                <input type="hidden" name="url" id="url" value="{$url}">
                                <input type="hidden" name="modulo" id="modulo" value="{$modulo|default:''}">
                                <div class="form-group">
                                    <label for="disabledTextInput">Usuario</label>
                                    <input type="text" name="usuarioLogin" id="usuarioLogin" tabindex="1" class="form-control" placeholder="Usuario" value="" required="">
                                </div>
                                <div class="form-group">
                                    <label for="disabledTextInput">Contraseña</label>
                                    <input type="password" name="passwordLogin" id="passwordLogin" tabindex="2" class="form-control" placeholder="Contraseña" required="" onkeypress="tecla_enter_login(event)" >
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
                                          <div class="g-signin2" id="signin2"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6 col-sm-offset-3">
                                            <button type="button" name="logear" id="logear" tabindex="4" class="form-control btn btn-login" >Iniciar Sessión</button>
                                        </div>
                                    </div>
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
                            
                            <form id="register-form" action="#" method="post" role="form" {if isset($_errorRegistrar)} style="display: block;" {else} style="display: none;" {/if} >

                                <div class="form-group">
                                    <label for="">Nombre(s)</label>
                                    <input type="text" name="nombreRegistrar" id="nombreRegistrar" pattern="([a-zA-Z][\sa-zA-Z]+)" tabindex="1" class="form-control" placeholder="Nombre(s)" value="{$nombre|default:''}">
                                </div>
                                <div class="form-group">
                                    <label for="">Apellidos</label>
                                    <input type="text" name="apellidosRegistrar" id="apellidosRegistrar" pattern="([a-zA-Z][\sa-zA-Z]+)" tabindex="2" class="form-control" placeholder="Apellidos" value="{$apellidos|default:''}">
                                </div>
                                <div class="form-group">
                                    <label for="">Correo electrónico</label>
                                    <input type="email" name="emailRegistrar" id="emailRegistrar" tabindex="3" class="form-control" placeholder="Correo electrónico" value="{$email|default:''}">
                                </div>
                                <div class="form-group">
                                    <label for="">Usuario</label>
                                    <input type="text" name="usuarioRegistrar" id="usuarioRegistrar" pattern="([_A-z0-9])+" tabindex="4" class="form-control" placeholder="Usuario" value="{$usuario|default:''}">
                                </div>
                                <div class="form-group">
                                    <label for="">Contraseña</label>
                                    <input type="password" name="passwordRegistrar" id="passwordRegistrar" data-minlength="6" tabindex="5" class="form-control" placeholder="Contraseña">
                                </div>
                                <div class="form-group">
                                    <label for="">Confirmar contraseña</label>
                                    <input type="password" name="confirm-password" id="confirm-password" data-minlength="6" data-match="#contrasena" data-match-error="*Contraseña no coinciden" tabindex="6" class="form-control" placeholder="Confirmar contraseña">
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6 col-sm-offset-3">
                                          <div id="registrar-gmail"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="row">
                                        <div class="col-sm-6 col-sm-offset-3">
                                            <button type="button" name="registrar-login" id="registrar-login" tabindex="7" class="form-control btn btn-register" value="">Crear cuenta</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
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