{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-9" style="margin-bottom: 20px">    
    <div class="col-lg-12">
        <h3>Verificación de Certificados</h3>
        <hr class="cursos-hr">
    </div>
    {if empty($certicado)&&!isset($certicado)}
        <div class="col-lg-12">
            <p>Para verificar un Certificado generado por la Plataforma Elearning del PRIC, ingresa el código de verificación y haz click en "Verificar".</p>

            <div class="form-inline" style="margin-top: 20px">
                <div class="form-group">
                    <label for="txt_codigo">Código de Verificación: </label>
                    <input type="text"placeholder="Ingrese Código" class="form-control" name="palabracertificado" id="txt_codigo">
                </div>            
                <button type="button" class="btn btn-success" id="verificar_certificado">Verificar</button>
            </div>
        </div>
        <div class="col-lg-12" style="margin-top: 30px">
            <h4>¿Dónde encuentro el Código de Verificación?</h4>
            <hr class="cursos-hr">
            <p>
                El Código de verificación de un certificado generado por la Plataforma Elearning del PRIC aparece en la parte inferior céntrica del documento. Haga click en las imágenes a continuación para ver ejemplos:
            </p>
            <div class="row">
                <div class="col-md-5 col-md-offset-3">  
                    <img src="{$_layoutParams.img}ejemplo_certificado.jpg" class="img-responsive" alt="Cinque Terre">
                </div>                
            </div>
        </div>
    {else}
        <div class="col-lg-12">
            {if $certicado!=false}
                <div class="alert alert-success">
                    <p>¡El certificado con código <strong class="h3">{$codigo}</strong> se encuentra registrado!</p>
                </div>    
                <hr class="cursos-hr">
                <div class="bs-callout bs-callout-primary">
                    <h3>Detalle de Certificado</h3>
                    <div class="form-horizontal">
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Codigo:</label>
                            <span class="col-sm-9 descripcion-span">
                               {$certicado.Cer_Codigo}
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Curso:</label>
                            <span class="col-sm-9 descripcion-span">
                                {$certicado.Cur_Titulo}
                            </span>
                        </div>
                       <div class="form-group">
                            <label class="col-sm-3 control-label">Fecha del Curso</label>
                            <span class="col-sm-9 descripcion-span">
                                {$certicado.Cur_FechaDesde} - {$certicado.Cur_FechaHasta}
                            </span>
                        </div>
                           
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Nombre(s):</label>
                            <span class="col-sm-9 descripcion-span">
                               {$certicado.Usu_Nombre}
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Apellidos:</label>
                            <span class="col-sm-9 descripcion-span">
                               {$certicado.Usu_Apellidos}
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">Fecha de Certicado:</label>
                            <span class="col-sm-9 descripcion-span">
                               {$certicado.Cer_FechaReg}
                            </span>
                        </div>
                       

                    </div>
                </div>
            {else}
                <div class="alert alert-warning">
                    <p>¡El certificado con código <strong class="h3">{$codigo}</strong> no se encuentra registrado!</p>
                </div>  
            {/if} 
            <div class="row">                
                <div class="col-lg-12">
                    <hr class="cursos-hr">
                    <a type="button" href="{BASE_URL}elearning/certificado/verificar" class="btn btn-primary pull-right"><i class="glyphicon glyphicon-chevron-left"></i> Volver a Verificar</a>
                </div>  
            </div>


        </div> 
    {/if}

</div>
