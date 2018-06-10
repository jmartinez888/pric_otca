
<div class="container">
    <div class="row">  
        <div class="col-md-offset-2 col-md-4 col-lg-offset-0 col-lg-6 " >  
            <div class="login-panel panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">{$lenguaje.label_welcome|default}</h3>
                </div>
                <div class="panel-body">
                    <form role="form"method="post">
                        <fieldset>
                            <p>{$lenguaje.label_iniciar|default}</p>
                            <div class="form-group">
                                <input class="form-control" type="text" id="usuario" name="usuario" value="{$usuario|default:""}" placeholder="User" required/>

                            </div>
                            <div class="form-group">
                                <input class="form-control" type="password"  id="password" name="password" placeholder="Password" required/>                             
                            </div>   
                            <div class="form-group">
                                <button id="logear"  name="logear" class="btn btn-sm btn-success" type="submit" value="Login" >Login</button>
                            </div>    
                            <!-- Change this to a button or input when using this as a form -->


                        </fieldset>
                    </form>
                </div>
            </div>
        </div>



        <div class="col-md-4 col-lg-6 " >  
            <div class="login-panel panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Crear una Cuenta</h3>
                </div>
                <div class="panel-body">
                    <form id="register-form-pag" action="" >
                        <div class="form-group">
                            <label for="">Nombre(s)</label>
                            <input type="text" name="nombreRegistrar" id="nombreRegistrar" pattern="([a-zA-Z][\sa-zA-Z]+)" tabindex="1" class="form-control" placeholder="Nombre(s)" value="">
                        </div>
                        <div class="form-group">
                            <label for="">Apellidos</label>
                            <input type="text" name="apellidosRegistrar" id="apellidosRegistrar" pattern="([a-zA-Z][\sa-zA-Z]+)" tabindex="2" class="form-control" placeholder="Apellidos" value="">
                        </div>
                        <div class="form-group">
                            <label for="">Correo electrónico</label>
                            <input type="email" name="emailRegistrar" id="emailRegistrar" tabindex="3" class="form-control" placeholder="Correo electrónico" value="">
                        </div>
                        <div class="form-group">
                            <label for="">Usuario</label>
                            <input type="text" name="usuarioRegistrar" id="usuarioRegistrar" pattern="([_A-z0-9])+" tabindex="4" class="form-control" placeholder="Usuario" value="">
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
