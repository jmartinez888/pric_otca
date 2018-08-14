<section class="content">
    <div class="row">
        <!--//Contenido Actual-->
        
        <!--Formulario -->
        <div class="col-sm-offset-1 col-sm-10">
            <section class="box box-success box-solid col-md-12" id="eventos-cont all">
                <div class="box-header with-border box-default" style="background-color:#FFFFFF; color:#333351;">
                    <!--<h3 class="titulo-success " style = "text-align: center" >Contactar</h3>-->
                    <h3 class="panel-title" style="font-size: 1.5em;">
                    <strong>CONTACTAR</strong>
                    </h3>
                </div>
                <div style="padding: 20px">
                    <small>
                        Puede enviar un mensaje usando el formulario de contacto de abajo.<br>
                        *** Porfavor colocar en el mensaje datos de la institución donde labora (nombre, país, ciudad, dirección, telefono) ***
                    </small><br><br>
                    <form class=" form-horizontal " data-toggle="validator" id="form2" name="form2" role="form" method="post" action="" autocomplete="on">

                        <div class="form-group">
                            <label class="col-lg-2 control-label">{$lenguaje.label_nombre} : </label>
                            <div class="col-lg-10">
                                <input class="form-control" id ="nombre" type="text" name="nombre"  placeholder="{$lenguaje.label_nombre}" required/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label" >{$lenguaje.label_apellidos} : </label>
                            <div class="col-lg-10">
                                <input class="form-control" id ="apellidos" type="text" pattern="([a-zA-Z][\sa-zA-Z]+)" name="apellidos" value="{$datos.apellidos|default:""}" placeholder="{$lenguaje.label_apellidos}" required=""/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">{$lenguaje.label_correo} : </label>
                            <div class="col-lg-10">
                                <input class="form-control" id="email" type="email" name="email" value="" placeholder="Correo" required="">
                            </div>
                        </div>
                            
                        <div class="form-group">
                            <label class="col-lg-2 control-label">Asunto : </label>
                            <div class="col-lg-10">
                                <input class="form-control" id ="asunto" type="text" name="asunto"  placeholder="Asunto" required/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-lg-2 control-label" >Mensaje : </label>
                            <div class=" col-lg-10">
                                <textarea class="ckeditor col-xs-10 col-sm-12  col-md-10 col-lg-10" cols="60" id="editorMensaje" name="editorMensaje" rows="80" required="required"></textarea>

                            </div>
                        </div>
                        <!-- <div class="form-group">
                            <div class="g-recaptcha col-xs-12 col-sm-6 col-md-6 col-lg-offset-2 col-lg-6" data-sitekey="6LeeuCATAAAAABHrHST6upEwqFPm0ZqnoTOppxpz">
                                
                            </div>
                        </div> -->
                        <div class="form-group">
                            <div class="col-xs-12 col-md-2 col-md-2 col-lg-offset-2 col-lg-2">
                                <button class="col-xs-12 btn btn-success" id="enviarMensaje" name="enviarMensaje" type="submit" ><i class="glyphicon glyphicon-floppy-disk"> </i> Enviar </button>
                            </div>
                        </div>
                    </form>
                </div>
            </section>
        </div>

        <!--//Eventos-->
        
</section>