﻿<!DOCTYPE html>
<html lang="es">
    <head>
        <script type="text/javascript" data-pace-options='{ "ajax": true }' src="{$_layoutParams.root_clear}public/vendors/pace/pace.min.js"></script>
        <title>{$titulo|default:"Sin t&iacute;tulo"}</title>
        <meta charset="utf-8">
        <meta name="google-signin-client_id" content="684672950066-oqa176688bh3tpbftvohouguabu3dpi6.apps.googleusercontent.com">
        <meta content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no' name='viewport'>
        <meta name="robots" content="noindex">
        {block 'meta'}
        {/block}
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
        <link href="{$_layoutParams.ruta_css}AdminLTE.min.css" rel="stylesheet" type="text/css" />
        <link href="{$_layoutParams.ruta_css}customAdminLTE.css" rel="stylesheet" type="text/css" />
        <link href="{$_layoutParams.root_clear}public/css/util.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}jsoft.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}jsoft.config.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}jsoft.responsive.css" rel="stylesheet" type="text/css">
        {* <link href="{$_layoutParams.root_clear}public/vendors/pace/templates/pace-theme-center-circle.tmpl.css" rel="stylesheet" type="text/css"> *}
        <link href="{$_layoutParams.root_clear}public/vendors/pace/themes/blue/pace-theme-minimal.css" rel="stylesheet" type="text/css">
        <link href="{$_layoutParams.ruta_css}wwfslider.css" rel="stylesheet" type="text/css" />
        <link href="{$_layoutParams.root_clear}public/css/datetime-picker/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css">    <!-- RODRIGO 20180605  -->
        <!-- <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet"> -->
        {block 'css'}
        {/block}
        {if isset($_layoutParams.css) && count($_layoutParams.css)}
        {foreach item=css from=$_layoutParams.css}
        <link href="{$css}" rel="stylesheet" type="text/css" />
        {/foreach}
        {/if}
        <!-- PRIC -->
        <!-- <link rel="icon" href="{$_layoutParams.ruta_img}frontend/lr.png" type="image/x-icon"> -->
        <!-- <link rel="stylesheet" href="css/font-awesome/css/font-awesome.css"> -->
        <!-- <link rel="stylesheet" href="css/jsoft.css"> -->
        <script type="text/javascript">
            var _root_ = '{$_layoutParams.root_clear}';
            var _root_lang = '{$_layoutParams.root}';
            var _root_archivo_fisico = '{$_layoutParams.root_archivo_fisico}';
            var _modulo = '{$_layoutParams.modulo}';
            var _controlador = '{$_layoutParams.controlador}';
            var _metodo = '{$_layoutParams.metodo}';
            var locale_set = '{Cookie::lenguaje()}';
            // $('.mitooltip').tooltip();
        </script>
        <!--RODRIGO-->
        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/jquery-1.11.2.min.js"></script>
        <!-- <script type="text/javascript">
        var jQuery_1_11_2 = $.noConflict(true);
        </script> -->

        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/datetime-picker/bootstrap-datetimepicker.js"></script>
        <script type="text/javascript" src="{$_layoutParams.root_clear}public/js/datetime-picker/bootstrap-datetimepicker.es.js"></script>
        <!--RODRIGO-->
    </head>
    <body id="tag-body">
        <!-- HEADER PRINCIPAL -->
        <div class="container-fluid back-color-black min-height-32" >
            <div class="row ">
                <!-- <div class="col-md-8 col-md-offset-4 col-sm-10 col-sm-offset-2 col-xs-12  text-align-right"> -->
                <div class="container text-align-right">
                    <nav class="navbar navbar-light padding-0 margin-0 display-inline back-color-black z-i-10" style="min-height: 20px">
                        <div class="navbar-header">
                            <button class="navbar-toggle collapsed" style="color:#fff; box-shadow: 0 0 11px #f5f4f4; padding: 2px 10px 0px; top: 3px; border: 1px solid black; margin: 3px;" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="sr-only"></span>
                            <span class="fa fa-bars" style="font-size: 19px;"></span>
                            </button>
                        </div>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="nav navbar-nav">
                                {foreach from=\App\Idioma::activos() item=idioma}
                                <li class="nav-item" style="background: #565656;">
                                    <a class="nav-link txt-color-white f-z-14 {if Cookie::lenguaje()==$idioma->Idi_IdIdioma}lang-active{/if}" href="{$_layoutParams.root_clear}index/_loadLang/{$idioma.Idi_IdIdioma}"> {if !$idioma@first}|{/if} {$idioma.Idi_Idioma}</a>
                                </li>
                                {/foreach}
                                <li class="nav-item">
                                    <a class="nav-link txt-color-white f-z-14" href="{$_layoutParams.root}acercade/contacto"> | Contácto</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link txt-color-white f-z-14" href="{$_layoutParams.root}page/item/10"> | {$lenguaje.frontend_text_acercade}</a>
                                </li>
                                {if Session::get('autenticado')}
                                <!-- Perfil User -->
                                <li class="nav-item user user-menu ">
                                    <a href="#" class="nav-link txt-color-white f-z-14 dropdown-toggle" data-toggle="dropdown" aria-expanded="true" style="float: left; padding: 5px 5px 2px;">
                                        {if trim(Session::get('Usu_URLImage')) != ""}
                                       <img src="{$_layoutParams.root_archivo_fisico}usuarios/img/{Session::get('Usu_URLImage')}" class="user-image" alt="User Image">
                                        {else}
                                        <img src="{$_layoutParams.ruta_img}/user2-160x160.jpg" class="user-image" alt="User Image">
                                        {/if}
                                        <!-- <span class="hidden-xs">Alexander</span> -->
                                    </a>
                                    <div class="t_info"></div>
                                    <div class="t_info_s"></div>
                                    <ul class="dropdown-menu info_ul" style="box-shadow: 0 0 11px #222 !important;">
                                        <!-- User image -->
                                        <li class="user-header">
                                            {if trim(Session::get('Usu_URLImage')) != ""}
                                            <img src="{$_layoutParams.root_archivo_fisico}usuarios/img/{Session::get('Usu_URLImage')}" class="img-circle" alt="User Image">
                                            {else}
                                            <img src="{$_layoutParams.ruta_img}/user2-160x160.jpg" class="img-circle" alt="User Image">
                                            {/if}
                                            <a href="{$_layoutParams.root}usuarios/perfil/index/{Session::get('id_usuario')}" data-toggle="tooltip" data-placement="bottom" title="Ver Perfil">
                                                <p>{Session::get('Usu_Nombre')} {Session::get('Usu_Apellidos')}</p>
                                            </a>
                                        </li>
                                        <!-- Menu Body -->
                                        <!--
                                        <li class="user-body">
                                            <div class="row">
                                                <div class="col-xs-4 text-center">
                                                    <a href="#">Followers</a>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <a href="#">Sales</a>
                                                </div>
                                                <div class="col-xs-4 text-center">
                                                    <a href="#">Friends</a>
                                                </div>
                                            </div>
                                        </li>
                                        -->
                                        <!-- Menu Footer-->
                                        <li class="user-footer">
                                            {if $_acl->rolckey('administrador') || $_acl->rolckey('administrador_foro') || $_acl->rolckey('administrador_elearning') || $_acl->rolckey('administrador_usuarios') || $_acl->rolckey('administrador_documentos')}
                                            <div class="pull-left">
                                                <a class="btn btn-default btn-flat" href="{$_layoutParams.root}acl"  data-toggle="tooltip" data-placement="bottom" title="Intranet"><i style="font-size:15px" class="glyphicon glyphicon-cog"></i> {$lenguaje.text_intranet}</a>
                                            </div>
                                            {/if}
                                            <div class="pull-right">
                                                <a class="btn btn-default btn-flat" href="{$_layoutParams.root}usuarios/login/cerrar"  data-toggle="tooltip" data-placement="bottom" title="Cerrar Sesi&oacute;n"><i style="font-size:15px" class="glyphicon glyphicon-log-out"></i> {$lenguaje.frontend_text_cerrarsession}</a>
                                            </div>
                                        </li>
                                    </ul>
                                </li>
                                <!-- Perfil User -->
                                <!-- <li class="nav-item">
                                    <a class="nav-link txt-color-white f-z-14" href="{$_layoutParams.root}acl"  data-toggle="tooltip" data-placement="bottom" title="Intranet"><i style="font-size:15px" class="glyphicon glyphicon-cog"></i> {$lenguaje.text_intranet}</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link txt-color-white f-z-14" href="{$_layoutParams.root}usuarios/login/cerrar"  data-toggle="tooltip" data-placement="bottom" title="Cerrar Sesi&oacute;n"><i style="font-size:15px" class="glyphicon glyphicon-log-out"></i> {$lenguaje.frontend_text_cerrarsession}</a>
                                </li> -->
                                {else}
                                <li class="nav-item">
                                    <a class="nav-link txt-color-white f-z-14" href="#"  data-placement="bottom" class=" form-login" title="Intranet" data-toggle="modal" data-target="#modal-login"> | <i style="font-size:15px" class="glyphicon glyphicon-log-in"></i> {$lenguaje.text_iniciarsession}</a>
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
                    <div class="col-xs-6 col-sm-3 col-md-3 col-lg-3 padding-10">
                        <img  class="width-250" src="{$_layoutParams.ruta_img}frontend/logo.png" alt="EL PRIC" title="PRIC">
                    </div>
                    <div class="col-xs-8 col-sm-6 col-md-6 col-lg-6 hidden-xs  texto-header  txt-color-grey padding-l-10">
                        <h2 class="txt-color-black text-justify display-block text-bold">{$lenguaje.frontend_head_titulo}</h2>
                        <h3 class="sub-title txt-color-black  display-block text-bold pull-right" >{$lenguaje.frontend_head_subtitulo}</h3>
                        <div class=" text-center">
                            <img class="max-width-390" src="{$_layoutParams.ruta_img}frontend/img-banderas.png">
                        </div>

                    </div>
                    <div class="col-xs-6 col-sm-3 col-md-3 col-lg-3 padding-10 text-align-right">
                        <img class="width-250"  src="{$_layoutParams.ruta_img}frontend/logo_otca.png">
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
                    <div class="container">
                        <div class="row">
                            <!-- Brand and toggle get grouped for better mobile display -->
                            <div class="navbar-header  display-inline  pull-left margin-t-10">
                                <button type="button" style="float: left;color: black;padding: 5px 10px;box-shadow: 0 0 11px black; border: 1px solid;  margin: 5px; margin-left: 29px;" class="navbar-toggle collapsed"  data-toggle="collapse" data-target="#navbarSupportedContentUp" aria-controls="navbarSupportedContentUp" aria-expanded="false" aria-label="Toggle navigation">
                                <span class="sr-only"></span>
                                <span class="fa fa-bars" style="font-size: 20px;"></span>
                                </button>
                            </div>
                            <div class="col-xs-10 col-sm-12 col-md-2 col-lg-3 buscador margin-t-10 pull-right buscador" >
                                <form style="background: #fff;border: 2px solid #336b78;float: none !important;" class=" navbar-right form-horizontal " data-toggle="validator" id="form1" role="form" method="post" autocomplete="on">
                                    <div class="col-sm-12 col-md-12 col-xs-12" style="padding: 0px;">
                                        <div class="input-group" style="">
                                          <input type="text" class="" data-placement="bottom"  id="textBuscar" name="textBuscar" placeholder="{$lenguaje.text_buscador|default}" value="{$palabra|default:''}" required="required" onkeypress="tecla_enter(event)" style="width: 100%;border: 0px;padding: 2px 8px;outline: none;">
                                          <span class="input-group-btn">
                                            <button class="btn-default" id="btnBuscar" name="btnBuscar" onclick="buscarPalabra('textBuscar')" type="button" style="font-size: 15px;border: 0px;background: transparent;"><i class="glyphicon glyphicon-search"></i></button>
                                          </span>
                                        </div>
                                    </div>
                                     {* <div class="row col-xs-11 col-sm-11 col-md-11 col-lg-11">
                                         <input style="border: 0;    width: 100%;"  data-placement="bottom"  type="search" id="textBuscar" name="textBuscar" placeholder="{$lenguaje.text_buscador|default}" value="{$palabra|default:''}" required="required" onkeypress="tecla_enter(event)" >
                                     </div>
                                     <div class="col-xs-1 col-sm-1 col-md-1 col-lg-1 pull-right" style="padding-right: 0px;">
                                         <button style="background: transparent;border: 0;color: #22454e;margin-left: -14px;" type="button" id="btnBuscar" name="btnBuscar" onclick="buscarPalabra('textBuscar')" value="" > <i class="glyphicon glyphicon-search"></i></button>
                                    </div> *}
                                     <div class="clearfix"></div>
                                </form>
                            </div>

                            {if isset($widgets.top)}
                            <div class="col col-xs-12 col-sm-12 col-md-10 col-lg-9">
                                {foreach from=$widgets.top item=wd}
                                <div class="col collapse navbar-collapse" id="navbarSupportedContentUp" style="font-size: 15px;">
                                    <ul class="nav navbar-nav" >
                                        {$wd}
                                    </ul>
                                </div>
                                {/foreach}
                            </div>
                            {/if}

                        </div>

                    </div>
                </nav>
            </div>
        </div>
        <!-- MENU TOP ADMINISTRABLE -->
        <!-- CONTENIDO CENTRAL DE LA PAGINA -->
        <div class="container back-color-white">
            <!-- <div class="col-xs-12"> <a class="text-success"> Link Uno / Link Dos / Link Tres </a></div> -->
            <noscript><p>Para el correcto funcionamiento debe tener el soporte para javascript habilitado</p></noscript>
            <div style="position: fixed; top: 3em; z-index: 150">
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
                    {$_mensaje}
                    <a class="close" data-dismiss="alert">x</a>
                </div>
                {/if}
            </div>
            {if $_contenido != ''}
            {include file=$_contenido}
            {/if}
            {block 'contenido'}
            {/block}
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
                                        <h5 class="text-bold">{$lenguaje.frontend_footer_financiado}
                                        </h5>
                                        <div class="display-block margin-t-10">
                                            <a href="#" class="display-inline">
                                                <img class="img-responsive max-height-60" src="{$_layoutParams.ruta_img}frontend/bg_int_itto.png">
                                            </a>
                                        </div>
                                        <h5 class="text-bold">{$lenguaje.frontend_footer_apoyode}</h5>
                                        <div class="display-block margin-t-10">
                                            <a href="#" class="display-inline">
                                                <img class="img-responsive max-height-60" src="{$_layoutParams.ruta_img}frontend/bg_int_gef.png">
                                            </a>
                                        </div>
                                    </div>
                                    <div class="col-md-6 text-align-r">
                                        <h5 class="text-bold">{$lenguaje.frontend_footer_contacto}</h5>
                                        <div class="text-footer">
                                            SHIS - Ql 05. Conjunto 16, casa 21  <br>
                                            Lago Sul - Brasília - DF - Brasil  <br>
                                            CEP: 71615-160 <br>
                                            Teléfono: +55 61 3248-4119  <br>
                                            contato@otca.org.br <br>
                                            © Copyright 2018 - OTCA <br>
                                        </div>
                                        <h5 class="text-bold">{$lenguaje.frontend_footer_siguenos}</h5>
                                        <div class="text-footer">
                                            <a class="display-block" href="http://www.otca-oficial.info/ " target="_blank">http://www.otca-oficial.info/ </a>
                                            <a class="ic_sociales" href="https://www.facebook.com/otcaoficial" target="_blank"><img class="img-responsive" src="{$_layoutParams.ruta_img}frontend/ic_fb.png"></a>
                                            <a class="ic_sociales" href="https://twitter.com/OTCAnews" target="_blank"><img class="img-responsive" src="{$_layoutParams.ruta_img}frontend/ic_tw.png"></a>
                                            <a class="ic_sociales" href="https://www.youtube.com/user/OTCAvideo/videos?shelf_id=0&amp;sort=dd&amp;view=0" target="_blank"><img class="img-responsive" src="{$_layoutParams.ruta_img}frontend/ic_yt.png"></a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="footer-enlaces col-md-3">
                                <h5 class="text-bold text-color-white">{$lenguaje.frontend_footer_links}</h5>
                                <div class="list-group">
                                    {foreach $links_interes as $link}
                                    <a href="{$link->ODli_Url}" class="list-group-item" target="_blank">
                                        <h4 class="list-group-item-heading">{$link->ODli_Titulo}</h4>
                                        <!-- <p class="list-group-item-text">Breve descripcion del enlace</p> -->
                                    </a>
                                    {/foreach}
                                    <a href="{$_layoutParams.root}difusion/link_interes/all" class="list-group-item" target="_blank">
                                        <h4 class="list-group-item-heading text-center">{$lenguaje['str_ver_mas']}</h4>
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
                   {include file='modules/usuarios/views/login/ajax/modal_login.tpl'}
                </div>
            </div>
        </div>
        {block "template"}
        {/block}
        <!--  Modal end -->
        <!-- <script src="{$_layoutParams.ruta_js}jquery-3.3.1.min.js" type="text/javascript"></script> -->
        <!--script type="text/javascript" src="{$_layoutParams.root_clear}public/js/jquery-1.11.2.min.js"></script-->
        <script language="javascript">
        function base_url(url_ref, root = false) {
            return (root ? '{$_layoutParams.root_clear}' : '{$_layoutParams.root}') + url_ref;
        }
        $(document).ready(function() {
        $(".botonExcel").click(function(event) {
        $("#datos_a_enviar").val( $("<div>").append( $("#Exportar_a_Excel").eq(0).clone()).html());
            $("#FormularioExportacion").submit();
            });
            });
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
            <script type="text/javascript" src="{$_layoutParams.ruta_js}jquery.PrintArea.js"></script>
            <script type="text/javascript" src="{$_layoutParams.ruta_js}bootstrap.min.js" ></script>
            <script type="text/javascript" src="{$_layoutParams.ruta_js}app.min.js" ></script>
            <script type="text/javascript" src="{$_layoutParams.ruta_js}bootstrap-datepicker.js"></script>
            <script type="text/javascript" src="{$_layoutParams.ruta_js}bootstrap-select.min.js"></script>
            <script type="text/javascript" src="{$_layoutParams.ruta_js}bootstrapValidator.js"></script>
            <!--<script type="text/javascript" src="{$_layoutParams.root_clear}public/js/highcharts.js"></script>-->
            <script type="text/javascript" src="{$_layoutParams.root_clear}public/ckeditor/ckeditor.js"></script>
            <script type="text/javascript" src="{$_layoutParams.root_clear}public/ckeditor/adapters/jquery.js"></script>
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
            {block "js"}
            {/block}
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