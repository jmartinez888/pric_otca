<!DOCTYPE html>
<html lang="es">
    <head>
        <title>{$titulo|default:"Sin t&iacute;tulo"}</title>
        <meta charset="utf-8">
        <meta name="google-signin-client_id" content="684672950066-oqa176688bh3tpbftvohouguabu3dpi6.apps.googleusercontent.com">
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="robots" content="noindex">

        <link rel="stylesheet" href="{$_layoutParams.ruta_css}font-awesome.css">
        <link href="{$_layoutParams.ruta_css}bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}bootstrapValidator.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}datepicker.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}bootstrap-select.min.css" rel="stylesheet" type="text/css">

        <!-- <style type="text/css">
            #form1 .selectContainer .form-control-feedback {
                /* Adjust feedback icon position */
                right: -15px;
            }
        </style> -->
        <link rel="shortcut icon" href="{$_layoutParams.ruta_img}favicon.ico" type="image/x-icon" />
        <link href="{$_layoutParams.ruta_css}simple-sidebar.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}jmartinez.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.root_clear}public/css/util.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}AdminLTE.min.css" rel="stylesheet" type="text/css" />
        <link href="{$_layoutParams.ruta_css}customAdminLTE.css" rel="stylesheet" type="text/css" />

        <link href="{$_layoutParams.ruta_css}jsoft.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}jsoft.config.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}jsoft.responsive.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}wwfslider.css" rel="stylesheet" type="text/css" />
        <link href="{$_layoutParams.root_clear}public/css/datetime-picker/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">    <!-- RODRIGO 20180605  -->
        <!-- <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet"> -->

        {if isset($_layoutParams.css) && count($_layoutParams.css)}
            {foreach item=css from=$_layoutParams.css}
                <link href="{$css}" rel="stylesheet" type="text/css" />
            {/foreach}
        {/if}
        <!-- PRIC -->
        <!-- <link rel="icon" href="{$_layoutParams.ruta_img}frontend/lr.png" type="image/x-icon"> -->
        <!-- <link rel="stylesheet" href="css/font-awesome/css/font-awesome.css"> -->
        <!-- <link rel="stylesheet" href="css/jsoft.css"> -->



        <!--RODRIGO-->
        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/jquery-1.11.2.min.js"></script>
        <!-- <script type="text/javascript">
            var jQuery_1_11_2 = $.noConflict(true);
        </script> -->
        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/socket.io/socket.io.js"></script>
        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/socket.io/socket.client.js"></script>
        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/datetime-picker/bootstrap-datetimepicker.js"></script>
        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/datetime-picker/bootstrap-datetimepicker.es.js"></script>
        <!--RODRIGO-->



    </head>

    <body >
        <!-- HEADER PRINCIPAL -->
        <div class="container-fluid back-color-black min-height-32" >
            <div class="row ">
                <!-- <div class="col-md-8 col-md-offset-4 col-sm-10 col-sm-offset-2 col-xs-12  text-align-right"> -->
                <div class="container text-align-right">
                    <nav class="navbar navbar-light padding-0 margin-0 display-inline back-color-black z-i-10" style="min-height: 20px">
                        <div class="navbar-header">
                            <button class="navbar-toggle collapsed" style="color:#fff; box-shadow: 0 0 11px #f5f4f4; padding: 2px 10px 0px; top: 3px; border: 1px solid black; margin: 3px;" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="fa fa-bars" style="font-size: 19px;"></span>
                            </button>
                        </div>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="nav navbar-nav">
                                <li class="nav-item" style="background: #565656;">
                                    <a class="nav-link txt-color-white f-z-14" href="#">Español</a>
                                </li>
                                <li class="nav-item" style="background: #565656;">
                                    <a class="nav-link txt-color-white f-z-14" href="#"> | Portugués</a>
                                </li>
                                <li class="nav-item" style="background: #565656;">
                                    <a class="nav-link txt-color-white f-z-14" href="#"> | Inglés</a>
                                </li>
                                <li class="nav-item">
                                  <a class="nav-link txt-color-white f-z-14" href="#"> | Contácto</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link txt-color-white f-z-14" href="#"> | Acerca de</a>
                                </li>
                                {if Session::get('autenticado')}
                                    <li class="nav-item">
                                        <a class="nav-link txt-color-white f-z-14" href="{$_layoutParams.root}acl"  data-toggle="tooltip" data-placement="bottom" title="Intranet"><i style="font-size:15px" class="glyphicon glyphicon-cog"></i> {$lenguaje.text_intranet}</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link txt-color-white f-z-14" href="{$_layoutParams.root}usuarios/login/cerrar"  data-toggle="tooltip" data-placement="bottom" title="Cerrar Sesi&oacute;n"><i style="font-size:15px" class="glyphicon glyphicon-log-out"></i> {$lenguaje.text_cerrarsession}</a>
                                    </li>
                                {else}
                                    <li class="nav-item">
                                        <a class="nav-link txt-color-white f-z-14" href="#"  data-placement="bottom" class=" form-login" title="Intranet" data-toggle="modal" data-target="#modal-login"> | <i style="font-size:15px" class="glyphicon glyphicon-log-in"></i> Iniciar Sesión</a>
                                    </li>
                                {/if}
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
        </div>
<div class="container-fluid back-color-white" >

        <header class="container">
            <div class="row">
                <div class="col col-md-3 col-sm-2 col-xs-3 padding-10">
                    <img  class="width-250" src="{$_layoutParams.ruta_img}frontend/logo.png" alt="La ORA" title="ORA">
                </div>
                <div class="col col-md-6 col-sm-8 col-xs-6 hidden-xs  texto-header  border-left-1 txt-color-grey padding-l-10">
                    <h2 class="txt-color-black display-block text-bold ">Plataforma Regional de Intercambio de Información y Conocimientos</h2>
                    <img class="margin-t-10 max-width-390" src="{$_layoutParams.ruta_img}frontend/img-banderas.png">
                </div>
                <div class="col col-md-3 col-sm-2 col-xs-3 padding-10 text-align-right">
                    <img src="{$_layoutParams.ruta_img}frontend/logo_otca.png">
                </div>
                <div class="fondo-header-active"></div>
            </div>
        </header>
</div>
        <!-- HEADER PRINCIPAL -->

        <!-- MENU TOP ADMINISTRABLE -->
        <div >
            <div class="row">
                <nav class="col col-md-12 navbar back-color-grey margin-0 padding-10 ">
                    <div class="col container">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="navbar-header">
                            <button type="button" style="float: left;color: black;padding: 5px 10px;box-shadow: 0 0 11px black; border: 1px solid;  margin: 5px; margin-left: 29px;" class="navbar-toggle collapsed"  data-toggle="collapse" data-target="#navbarSupportedContentUp" aria-controls="navbarSupportedContentUp" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="sr-only">Toggle navigation</span>
                                <span class="fa fa-bars" style="font-size: 20px;"></span>
                            </button>
                        </div>
                        {if isset($widgets.top)}
                        <div class="col col-sm-10 col-md-9">
                            {foreach from=$widgets.top item=wd}
                            <div class="col collapse navbar-collapse" id="navbarSupportedContentUp" style="font-size: 15px;">
                                <ul class="nav navbar-nav" >
                                {$wd}
                                </ul>
                            </div>
                            {/foreach}
                        </div>
                        {/if}

                            <div class="buscador">
                                <form style="background: #fff;border: 2px solid #336b78;">
                                    <input type="search" style="border: 0;">
                                    <button type="submit" style="background: transparent;border: 0;color: #22454e;"><i class="fa fa-search" style=""></i></button>
                                </form>
                            </div>

                    </div>
                </nav>
            </div>
        </div>
        <!-- MENU TOP ADMINISTRABLE -->

        <!-- CONTENIDO CENTRAL DE LA PAGINA -->
        <div class="container back-color-white">
            <noscript><p>Para el correcto funcionamiento debe tener el soporte para javascript habilitado</p></noscript>
            {if isset($_error)}
                <div id="_errl" class="alert alert-error ">
                    <a class="close" data-dismiss="alert">x</a>
                    {$_error}
                </div>
            {/if}
            <div id="_mensaje" class="hide">
            </div>
            {if isset($_mensaje)}
                <div id="_msgl" class="alert alert-success">
                    <a class="close" data-dismiss="alert">x</a>
                    {$_mensaje}
                </div>
            {/if}

            {include file=$_contenido}
        </div>
        <!-- CONTENIDO CENTRAL DE LA PAGINA -->

        <!-- FOOTER -->
        <!-- <footer >
            <div class="container " style="float: inherit; padding-left: 0; padding-right: 0;">
                <div class="row" style="margin:0 !important ">
                    <div class="col col-md-8 col-sm-8 col-xs-12" style=" padding-top: 20px; padding-bottom:  20px; background: #4B4B4D; color:  #fff;">
                        <div class="row" style="margin:0 !important ">
                            <div class="col col-md-4 col-sm-6 col-xs-6 " style="text-align: left; padding-left: 10px;">

                                <div class="f-inst margin-l-10 margin-t-10">
                                    <p>FINANCIADO POR:</p>
                                    <img class="width-100"  src="{$_layoutParams.ruta_img}frontend/img-footer-oimt.png" style=" margin-top: 10px; ">

                                </div>
                                <div class="f-inst margin-l-10 margin-t-10">
                                    <p>CON EL APOYO DE:</p>
                                    <img class="width-100"  src="{$_layoutParams.ruta_img}frontend/bg_int.png" style=" margin-top: 10px; ">
                                </div>
                            </div>
                            <div class="col col-md-8 col-sm-6 col-xs-6">
                                <div style="text-align: right; padding-right: .5em">
                                    <p class="f-z-19" >CONTACTO</p>
                                    <p>SHIS - Ql 05. Conjunto 16, casa 21
                                      <br>Lago Sul - Brasília - DF - Brasil
                                      <br>CEP: 71615-160
                                      <br>Teléfono: +55 61 3248-4119
                                      <br>contato@otca.org.br
                                      <br>© Copyright 2018 - OTCA
                                    </p>
                                    <p>SÍGUENOS</p>
                                    <a class="txt-color-white " href="http://www.otca-oficial.info/" target="_blank">http://www.otca-oficial.info/</a> <br>
                                    <a class="ic_sociales" href="https://www.facebook.com/otcaoficial" target="_blank"><img src="{$_layoutParams.ruta_img}frontend/ic_fb.png"></a>
                                    <a class="ic_sociales" href="https://twitter.com/OTCAnews" target="_blank"><img src="{$_layoutParams.ruta_img}frontend/ic_tw.png"></a>
                                    <a class="ic_sociales" href="https://www.youtube.com/user/OTCAvideo/videos?shelf_id=0&amp;sort=dd&amp;view=0" target="_blank"><img src="{$_layoutParams.ruta_img}frontend/ic_yt.png"></a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col col-md-4 col-sm-4 col-xs-12  verde enlaces-footer" style="position:relative">
                        <h3 >Links de Interés</h3>  <a href="#" class="mas_cifras"> +</a>
                        <a class="enlace" href="https://www.cbd.int/" target="_blank">Secretaría del CDB.</a>
                        <a class="enlace" href="http://www.itto.int/es/" target="_blank">La OIMT .</a>
                        <a class="enlace" href="http://tmfo.org/index.html" target="_blank">El Observatorio de Bosques Manejados Tropicales.</a>
                        <a class="enlace" href="https://www.cites.org/" target="_blank">CITES.</a>
                        <a class="enlace" href="http://www.fao.org/forestry/en/" target="_blank">FAO-Bosques.</a>
                        <a class="enlace" href="http://www.un.org/sustainabledevelopment/" target="_blank">Metas de Desarrollo Sostenible .</a>
                    </div>
                </div>
            </div>
        </footer> -->
        <!-- FOOTER -->
        <footer>
    <div class="container-fluid">
        <div class="row">
            <div class="container">
                <div class="row">
                    <div class="col-md-9">
                        <div class="row">
                            <div class="col-md-6">
                                <h5 class="text-bold">FINANCIADO POR:</h5>
                                <div class="display-block margin-t-10">
                                  <a href="#" class="display-inline">
                                      <img class="img-responsive max-height-60" src="{$_layoutParams.ruta_img}frontend/bg_int_itto.png">

                                   </a>

                                </div>
                                <h5 class="text-bold">CON EL APOYO DE:</h5>
                                <div class="display-block margin-t-10">

                                    <a href="#" class="display-inline">
                                      <img class="img-responsive max-height-60" src="{$_layoutParams.ruta_img}frontend/bg_int_gef.png">
                                    </a>
                                </div>
                            </div>
                            <div class="col-md-6 text-align-r">
                                <h5 class="text-bold">CONTACTO</h5>
                                <div class="text-footer">
                                    SHIS - Ql 05. Conjunto 16, casa 21  <br>
                                    Lago Sul - Brasília - DF - Brasil  <br>
                                    CEP: 71615-160 <br>
                                    Teléfono: +55 61 3248-4119  <br>
                                    contato@otca.org.br <br>
                                    © Copyright 2018 - OTCA <br>
                                </div>
                                <h5 class="text-bold">SÍGUENOS</h5>
                                <div class="text-footer">
                                     <a class="display-block" href="http://www.otca-oficial.info/ ">http://www.otca-oficial.info/ </a>
                                     <a class="ic_sociales" href="https://www.facebook.com/otcaoficial" target="_blank"><img class="img-responsive" src="{$_layoutParams.ruta_img}frontend/ic_fb.png"></a>
                                     <a class="ic_sociales" href="https://twitter.com/OTCAnews" target="_blank"><img class="img-responsive" src="{$_layoutParams.ruta_img}frontend/ic_tw.png"></a>
                                     <a class="ic_sociales" href="https://www.youtube.com/user/OTCAvideo/videos?shelf_id=0&amp;sort=dd&amp;view=0" target="_blank"><img class="img-responsive" src="{$_layoutParams.ruta_img}frontend/ic_yt.png"></a>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="footer-enlaces col-md-3">
                        <h5 class="text-bold text-color-white">LINKS DE INTERES</h5>
                        <div class="list-group">
                          <a href="#" class="list-group-item">
                            <h4 class="list-group-item-heading">Secretaría del CDB.</h4>
                            <!-- <p class="list-group-item-text">Breve descripcion del enlace</p> -->
                          </a>
                           <a href="#" class="list-group-item">
                            <h4 class="list-group-item-heading">La OIMT</h4>
                            <!-- <p class="list-group-item-text">Breve descripcion del enlace</p> -->
                          </a>
                           <a href="#" class="list-group-item">
                            <h4 class="list-group-item-heading">El Observatorio de Bosques Manejados Tropicales</h4>
                            <!-- <p class="list-group-item-text">Breve descripcion del enlace</p> -->
                          </a>
                           <a href="#" class="list-group-item">
                            <h4 class="list-group-item-heading">CITES</h4>
                            <!-- <p class="list-group-item-text">Breve descripcion del enlace</p> -->
                          </a>
                           <a href="#" class="list-group-item">
                            <h4 class="list-group-item-heading">FAO-Bosques</h4>
                            <!-- <p class="list-group-item-text">Breve descripcion del enlace</p> -->
                          </a>
                           <a href="#" class="list-group-item">
                            <h4 class="list-group-item-heading">Metas de Desarrollo Sostenible</h4>
                            <!-- <p class="list-group-item-text">Breve descripcion del enlace</p> -->
                          </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</footer>



        <div id="cargando">
            <div class="cargando"></div>
        </div>
        <div id="cargandoBusqueda">
            <div class="cargando"></div>
        </div>

        <!--  Modal login -->
        <div class="modal fade top-space-0" id="modal-login" tabindex="-1" role="dialog">
            <div class="modal-dialog login-dialog">
                <div class="modal-content cursor-pointer" id="mensajeLogeo">
                    <!-- <div class="modal-header">
                          <button type="button" class="close" data-dismiss="#modal-1">CLOSE &times;</button>
                        <h1 class="modal-title" >{$lenguaje["login_intranet"]}</h1>
                    </div> -->

                    <div class="modal-body" >
                        <div class="row">
                            <div class="col-md-12">
                                <div class="panel panel-login">
                                    <div class="panel-heading">
                                        <div class="row">
                                            <div class="col-xs-6">
                                                <a href="#" class="active" id="login-form-link">Iniciar Sesión</a>
                                            </div>
                                            <div class="col-xs-6">
                                                <a href="#" id="register-form-link">Regístrate ahora</a>
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
                                                        <label for="disabledTextInput">Usuario</label>
                                                        <input type="text" name="usuarioLogin" id="usuarioLogin" tabindex="1" class="form-control" placeholder="Usuario" value="" required="">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="disabledTextInput">Contraseña</label>
                                                         <div class="input-group">
                                                          <input type="password" name="passwordLogin" id="passwordLogin" tabindex="2" class="form-control" placeholder="Contraseña" required="" onkeypress="tecla_enter_login(event)">
                                                            <span  class="input-group-addon btn btn-default btn-xs" id="show-pass"><i class="glyphicon glyphicon-eye-open" id="btn_ver_clave"></i></span>
                                                        </div>
                                                    </div>
                                                    <!-- <div class="form-group text-center">
                                                        <input type="checkbox" tabindex="3" class="" name="remember" id="remember">
                                                        <label for="remember"> Recordarme</label>
                                                    </div> -->
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-sm-6 col-sm-offset-3">
                                                                <button type="button" name="logear" id="logear" tabindex="4" class="form-control btn btn-login" >Iniciar Sesión</button>
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
                                                                    <a href="#" tabindex="5" class="forgot-password" id="showRecPass">¿Has olvidado tu contraseña?</a>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
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

                                                <form id="register-form" action="" style="display: none;">
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
                                                        <input type="password" name="confirm-password" id="confirm-password" data-minlength="7" data-match="#passwordRegistrar" data-match-error="*Contraseña no coinciden" tabindex="6" class="form-control" placeholder="Confirmar contraseña">
                                                    </div>
                                                    <div class="form-group">
                                                        <div class="row">
                                                            <div class="col-sm-6 col-sm-offset-3">
                                                                <button type="button" name="registrar-login" id="registrar-login" tabindex="8" class="form-control btn btn-register" value="">Crear cuenta</button>
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
                </div>
            </div>
        </div>
        <!--  Modal end -->

        <!-- <script src="{$_layoutParams.ruta_js}jquery-3.3.1.min.js" type="text/javascript"></script> -->

        <!--script type="text/javascript" src="{$_layoutParams.root_clear}public/js/jquery-1.11.2.min.js"></script-->
        <script language="javascript">
        $(document).ready(function() {
            $(".botonExcel").click(function(event) {
                $("#datos_a_enviar").val( $("<div>").append( $("#Exportar_a_Excel").eq(0).clone()).html());
                $("#FormularioExportacion").submit();
            });
        });
        </script>

        <script type="text/javascript">
            var _root_ = '{$_layoutParams.root_clear}';
            var _root_lang = '{$_layoutParams.root}';
            var _root_archivo_fisico = '{$_layoutParams.root_archivo_fisico}';
            // $('.mitooltip').tooltip();
        </script>
        <!-- <script src="//code.jquery.com/jquery-1.11.2.min.js"></script> -->
        <!-- <script src="{$_layoutParams.ruta_js}jquery-3.2.1.slim.min.js" type="text/javascript"></script> -->
        <!-- <script src="{$_layoutParams.ruta_js}bootstrap.min.js" type="text/javascript"></script> -->
        <!-- Nuevo estilo -->

        <!-- <script src="{$_layoutParams.ruta_js}popper.min.js" type="text/javascript"></script> -->
        <!-- <script type="text/javascript" src="{$_layoutParams.ruta_js}global.js" ></script> -->
        <!-- <script src="{$_layoutParams.ruta_js}bootstrap.min.js" type="text/javascript"></script> -->

        <!-- <script type="text/javascript" src="{$_layoutParams.ruta_js}app.min.js" ></script> -->

        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/util.js"></script>
        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/jquery.slimscroll.min.js"></script>
        <script type="text/javascript" src="{$_layoutParams.ruta_js}bootstrap.min.js" ></script>
        <script type="text/javascript" src="{$_layoutParams.ruta_js}bootstrap-datepicker.js"></script>
        <script type="text/javascript" src="{$_layoutParams.ruta_js}bootstrap-select.min.js"></script>
        <script type="text/javascript" src="{$_layoutParams.ruta_js}bootstrapValidator.js"></script>
        <!--<script type="text/javascript" src="{$_layoutParams.root_clear}public/js/highcharts.js"></script>-->
        <script type="text/javascript" src="{$_layoutParams.root_clear}public/ckeditor/ckeditor.js"></script>

        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/validator.js"></script>
        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/login.js"></script>


        <script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
        <!-- JavaScript -->
        <!-- <script type="text/javascript" src="{$_layoutParams.ruta_js}js.js"></script> -->
        <!-- JavaScript -->


        <!-- <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBM7aMHbWEPvofhwPQuKPnijDmQ0_AAkrI&callback=initMap" async defer></script> -->
        <!-- <script type="text/javascript" src="js/js.js"></script> -->
        <script type="text/javascript">
            $('#myTabsPublicaciones li a,#myTabsAgenda li a,#myTabsEventos li a').click(function (e) {
                  e.preventDefault()
                  $(this).tab('show')
                });
        </script>



        {if isset($_layoutParams.js_plugin) && count($_layoutParams.js_plugin)}
            {foreach item=plg from=$_layoutParams.js_plugin}
                <script src="{$plg}" type="text/javascript" defer></script>
            {/foreach}
        {/if}
        {if isset($_layoutParams.js) && count($_layoutParams.js)}
            {foreach item=js from=$_layoutParams.js}
                <script src="{$js}" type="text/javascript" defer></script>
            {/foreach}
        {/if}
        <!--Buscador-->
        <script type="text/javascript">
            function tecla_enter(evento)
            {
                var iAscii;
                if (evento.keyCode)
                {
                    iAscii = evento.keyCode;
                }
                if (iAscii == 13)
                {
                    buscarPalabra('textBuscar');
                    evento.preventDefault();
                }
            }

            function buscarPalabra(campo) {
                var palabra = $('#'+campo).val();
                if(!palabra)
                {
                    palabra='all';
                }
                document.location.href = '{$_layoutParams.root}index/buscarPalabra/' + palabra
            }
        </script>
        <!--Buscador-->
        <script type="text/javascript">
            $(function() {

                $('#slide-submenu').on('click', function() {
                    $(this).closest('.list-group').fadeOut('slide', function() {
                        $('.mini-submenu').fadeIn();
                    });
                });
            });
        </script>
        <script>
            $('.carousel').carousel();
            $(window).on("scroll", function() {
                if($(window).scrollTop() > 50) {
                    $("header").addClass("active");
                    $(".cont-nav-p").addClass("active-nav");
                } else {
                    //remove the background property so it comes transparent again (defined in your css)
                    $("header").removeClass("active");
                    $(".cont-nav-p").removeClass("active-nav");
                }
            });
        </script>
    </body>
</html>
