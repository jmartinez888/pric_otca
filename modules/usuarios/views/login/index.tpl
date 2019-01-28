
<div class="container">
    <div class="row">  
        <div class="margin-t-10 col-md-offset-2 col-md-4 col-lg-offset-0 col-lg-6 " >  
            <div class="login-panel panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><strong>{$lenguaje['text_iniciarsession']}</strong></h3>
                </div>
                <div class="panel-body">
                    <form role="form"method="post">
                        <fieldset>
                            <label>{$lenguaje.label_iniciar|default}</label>
                            <div class="form-group">
                                <input class="form-control" type="text" id="usuario" name="usuario" value="{$usuario|default:""}" placeholder="{$lenguaje['frontend_modal_usuario']}" required/>

                            </div>
                            <div class="form-group">
                                <input class="form-control" type="password"  id="password" name="password" placeholder="{$lenguaje['frontend_modal_contrasenia']}" required/>                             
                            </div>   
                            <div class="form-group text-right">
                                <button id="logear"  name="logear" class="btn btn-sm btn-success" type="submit" value="Login" >Login</button>
                            </div>    
                            <!-- Change this to a button or input when using this as a form -->


                        </fieldset>
                    </form>
                </div>
            </div>
        </div>



        <div class="margin-t-10 col-md-4 col-lg-6 " >  
            <div class="login-panel panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><strong>{$lenguaje['frontend_modal_registrate']}</strong></h3>
                </div>
                <div class="panel-body">
                    <form id="register-form-pag" action="" >
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
                            <input type="password" name="confirm-password" id="confirm-password" data-minlength="6" data-match="#contrasena" data-match-error="*Contraseña no coinciden" tabindex="5" class="form-control" placeholder="{$lenguaje['frontend_form_registro_confcontrasenia']}">
                        </div>
                        <div class="form-group">
                            <div class="row">
                                <div class="col-sm-3 pull-right text-right">
                                    <button type="button" name="registrar-login" id="registrar-login" tabindex="7" class="btn btn-sm btn-success" value="">Crear cuenta</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>



    </div>
</div>
