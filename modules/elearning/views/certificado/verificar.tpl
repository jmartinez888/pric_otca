{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10" style="margin-bottom: 20px">    
    <div class="col-lg-12">
        <h3>{$lenguaje["elearning_cursos_verificacion_certificados"]}</h3>
        <hr class="cursos-hr">
    </div>
    {if empty($certicado)&&!isset($certicado)}
        <div class="col-lg-12">
            <p>{$lenguaje["elearning_cursos_verificacion_certificados_p"]}</p>

            <div class="form-inline" style="margin-top: 20px">
                <div class="form-group">
                    <label for="txt_codigo">{$lenguaje["elearning_cursos_label_codigo_verificacion"]} </label>
                    <input type="text"placeholder="{$lenguaje["elearning_cursos_ingresecodigo"]}" class="form-control" name="palabracertificado" id="txt_codigo">
                </div>            
                <button type="button" class="btn btn-success" id="verificar_certificado">{$lenguaje["elearning_cursos_verificarboton"]}</button>
            </div>
        </div>
        <div class="col-lg-12" style="margin-top: 30px">
            <h4>{$lenguaje.str_codigo_verificacion}</h4>
            <hr class="cursos-hr">
            <p>
                {$lenguaje.str_descripcion_verificacion}
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
