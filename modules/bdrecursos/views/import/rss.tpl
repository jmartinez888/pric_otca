<form method="post" class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <h2> Registro de datos desde RSS</h2>
        </div>
        <div class="col-md-3">     
            <div class="panel-group" id="accordion">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <strong>Recurso</strong>
                            <i type="button" class="btn btn-xs btn-info glyphicon glyphicon-search pull-right" title="Agregar Recurso" data-placement="bottom" data-toggle="modal" data-target="#modal-recurso"></i>
                        </h4>
                        <input type="hidden" id="hd_idrecurso" value="{$recurso.Rec_IdRecurso}">
                    </div>               
                    <div class="panel-body">
                        <table class="table table-user-information">
                            <tbody>                           
                                <tr>
                                    <td>Nombre:</td>
                                    <td>{$recurso.Rec_Nombre}</td>
                                </tr>
                                <tr>
                                    <td>Tipo</td>
                                    <td>{$recurso.Tir_Nombre}</td>
                                </tr>
                                <tr>
                                    <td>Estandar</td>
                                    <td>{$recurso.Esr_Nombre}</td>
                                </tr>                                
                                <tr>
                                    <td>Fuente</td>
                                    <td>{$recurso.Rec_Fuente}</td>
                                </tr>
                                <tr>
                                    <td>Origen</td>
                                    <td>{$recurso.Rec_Origen}</td>
                                </tr>
                                <tr>
                                    <td>Registros</td>
                                    <td>{$recurso.Rec_CantidadRegistros}</td>
                                </tr>
                                <tr>
                                    <td>Herramientas donde es utilizado</td>
                                    <td>
                                        {if isset($recurso.herramientas)}
                                            <ul>
                                                {foreach item=herramienta from=$recurso.herramientas}
                                                    <li>
                                                        {$herramienta.Her_Nombre}
                                                    </li>
                                                {/foreach}
                                            </ul>
                                        {/if}
                                    </td>
                                </tr>
                                <tr>
                                    <td>Registro</td>
                                    <td>{$recurso.Rec_FechaRegistro|date_format:"%d/%m/%y"}</td>
                                </tr>
                                <tr>
                                    <td>Modificación</td>
                                    <td>{$recurso.Rec_UltimaModificacion|date_format:"%d/%m/%y"}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h4 class="panel-title">
                        <strong>RSS</strong> 
                    </h4>
                </div>               
                <div class="panel-body">
                    <div class="form-group">
                        <label for="tb_urlws">Url RSS</label>
                        <div class="form-group">
                            {if $tipo_estandar==2}
                                <label class="radio-inline"><input type="radio" name="r_tabla" value="1" checked="">Variable</label>
                                <label class="radio-inline"><input type="radio" name="r_tabla" value="2">Data</label>
                            {else}
                                <input type="hidden" name="r_tabla" value="0"></input>
                            {/if}
                        </div>                            
                        <div class="input-group">                            
                            <input type="url" class="form-control" id="tb_urlrss" name="tb_urlrss"  value="{$urlrss|default}"
                                   placeholder="Introduce url del rss">
                            <span class="input-group-btn">
                                <button class="btn btn-success" type="submit" id="bt_consultar_rss" name="bt_consultar_rss" >Consultar</button>
                            </span>
                            <input type="hidden" id="hd_url_rss" value="{$urlrss|default}">
                        </div>
                    </div>
                    {if isset($funcion)}
                        <div class="form-group">
                            <label for="tb_nombre_ws">Nombre Web Service</label>   
                            <input id="tb_nombre_ws" type="text">
                        </div> 
                        <div class="form-group">
                            <label for="sp_funcion">Función Invocada:</label>   
                            <span id="sp_funcion">dime</span>
                        </div> 
                        <div class="form-group">
                            <label>Parametros</label>   
                            <ul>
                                <li>Li</li>
                            </ul>
                        </div>  
                        <div class="form-group">
                            <label for="tb_fuente_ws">Fuente</label>   
                            <input id="tb_fuente_ws" type="text">
                        </div> 
                        <div class="form-group">
                            <label for="tb_descripcion_ws">Descripción</label>   
                            <input id="tb_descripcion_ws" type="text">
                        </div>                    
                    {/if}
                </div>
            </div>   
            <div id="resultado_ws">
                {if isset($etiquetas)}                    
                    <div class="panel panel-default">
                        <div class="panel-body">                            
                            <div id="listar_estandar">    
                                <form action="../registrar/1" method="post" data-toggle="validator" class="form-horizontal" role="form" id="lista_estandar">
                                    <table class="table">
                                        <thead>
                                          <tr>
                                            <th>Campos del Estandar</th>
                                            <th style="width:1%"></th>
                                            <th style="width:50%">Campos Vinculados</th>        
                                          </tr>
                                        </thead>    
                                        <tbody>
                                            {if isset($fichaEstandar)}
                                                {foreach item=datos from=$fichaEstandar}
                                                    <tr>
                                                        <td>{$datos.Fie_CampoFicha}</td>
                                                        <td>:</td>
                                                        <td>
                                                            <select name="{$datos.Fie_ColumnaTabla}_s" id="{$datos.Fie_ColumnaTabla}_s">
                                                                <option value="s_" selected="selected">Selecionar</option>
                                                                {if isset($s_titulo) && $s_titulo==1}
                                                                    <option value="s_titulo">Título</option>
                                                                {/if}
                                                                {if isset($s_categoria) && $s_categoria==1}
                                                                    <option value="s_categoria">Categoría</option>
                                                                {/if}
                                                                {if isset($s_descripcion) && $s_descripcion==1}
                                                                    <option value="s_descripcion">Descripción</option>
                                                                {/if}
                                                                {if isset($s_contenido) && $s_contenido==1}
                                                                    <option value="s_contenido">Contenido</option>
                                                                {/if}
                                                                {if isset($s_autor) && $s_autor==1}
                                                                    <option value="s_autor">Autor</option>
                                                                {/if}
                                                                {if isset($s_contribuyente) && $s_contribuyente==1}
                                                                    <option value="s_contribuyente">Contribuyente</option>
                                                                {/if}
                                                                {if isset($s_derechos_autor) && $s_derechos_autor==1}
                                                                    <option value="s_derechos_autor">Derechos de autor</option>
                                                                {/if}
                                                                {if isset($s_link) && $s_link==1}
                                                                    <option value="s_link">Link</option>
                                                                {/if}
                                                                {if isset($s_fecha) && $s_fecha==1}
                                                                    <option value="s_fecha">Fecha</option>
                                                                {/if}                                                                         
                                                            </select>
                                                            <input type="text" class="form-control" id="{$datos.Fie_ColumnaTabla}" name="{$datos.Fie_ColumnaTabla}" 
                                                            placeholder="{$datos.Fie_CampoFicha}" >

                                                        </td>
                                                    </tr>              
                                                {/foreach}
                                            {/if}
                                            {if isset($fichaVariable)}
                                                {$i=0}
                                                {foreach item=datos from=$fichaVariable}
                                                    <tr>
                                                        <td>{$datos.$campo_nombre}</td>
                                                        <td>:</td>
                                                        <td>
                                                            <select name="{$datos.$campo_nombre}" id="{$datos.$campo_nombre}" required="">
                                                                <option value="s_" selected="selected">Selecionar</option>
                                                                {if isset($s_titulo) && $s_titulo==1}
                                                                    <option value="s_titulo">Título</option>
                                                                {/if}
                                                                {if isset($s_categoria) && $s_categoria==1}
                                                                    <option value="s_categoria">Categoría</option>
                                                                {/if}
                                                                {if isset($s_descripcion) && $s_descripcion==1}
                                                                    <option value="s_descripcion">Descripción</option>
                                                                {/if}
                                                                {if isset($s_contenido) && $s_contenido==1}
                                                                    <option value="s_contenido">Contenido</option>
                                                                {/if}
                                                                {if isset($s_autor) && $s_autor==1}
                                                                    <option value="s_autor">Autor</option>
                                                                {/if}
                                                                {if isset($s_contribuyente) && $s_contribuyente==1}
                                                                    <option value="s_contribuyente">Contribuyente</option>
                                                                {/if}
                                                                {if isset($s_derechos_autor) && $s_derechos_autor==1}
                                                                    <option value="s_derechos_autor">Derechos de autor</option>
                                                                {/if}
                                                                {if isset($s_link) && $s_link==1}
                                                                    <option value="s_link">Link</option>
                                                                {/if}
                                                                {if isset($s_fecha) && $s_fecha==1}
                                                                    <option value="s_fecha">Fecha</option>
                                                                {/if}     
                                                            </select>
                                                        </td>
                                                    </tr>   
                                                    {$i=$i+1}            
                                                {/foreach}
                                            {/if}
                                        </tbody>
                                            
                                    </table>                                
                                    <div class="form-group">
                                        <center>
                                        <span class="input-group-btn">
                                            <button class="btn btn-success" type="submit" id="bt_registrar_rss" name="bt_registrar_rss" >Registrar Datos</button>
                                        </span>
                                        </center>
                                        <input type="hidden" id="hd_url_rss" value="{$url_rss|default}" name="url_rss">
                                        <input type="hidden" value="{$r_tabla}" name="r_tabla">
                                    </div>
                                </form>
                            </div>            
                        </div>
                    </div>
                {/if}
                {if isset($prueba)}
                    {include file=$prueba}
                {/if}
            </div> 
        </div> 
    </div>
</form>


<!--  Modal login -->
<div class="modal fade top-space-0" id="modal-recurso" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-lg login-dialog">
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
                                        <a href="#" class="active" id="agregar-form-link">Agregar Recurso</a>
                                    </div>
                                    <div class="col-xs-6">
                                        <a href="#" id="buscar-form-link">Buscar Recurso</a>
                                    </div>
                                </div>
                                <hr>
                            </div>
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <form id="agregar-form" action="#" method="post" role="form" style="display: block;">
                                            <input type="hidden" name="url" id="url" value="{$url}">
                                            <input type="hidden" name="hd_login_modulo" id="hd_login_modulo" value="">
                                            <div id="registrar_recursos_dublin">
                                                <div id="myTabContent" class="tab-content">
                                                    <div class="tab-pane active in  form-horizontal" id="tabular">
                                                        <form id="form1" method="post" data-toggle="validator" role="form" autocomplete="on">
                                                            <div class="col-md-offset-3 col-md-6">
                                                                <input type="hidden" id="hd_idrecurso"  name="hd_idrecurso" value="{$recurso.Rec_IdRecurso|default}"/>
                                                                <input type="hidden" id="tipoServicio"  name="tipoServicio" value="{$tipoServicio|default:''}"/>

                                                                <div class="form-group" >
                                                                    <input type="hidden" id="hd_idioma_defecto" name="hd_idioma_defecto" value="{$recurso.Idi_IdIdioma|default}">
                                                                    <label class="control-label col-lg-2">{$lenguaje["label_idioma_bdrecursos"]}</label>
                                                                    {if  isset($idiomas) && count($idiomas)}                
                                                                        <div class="col-lg-10 form-inline">
                                                                            {foreach from=$idiomas item=idi}               
                                                                                <div class="radio">
                                                                                    <label>
                                                                                        <input type="radio" name="rb_idioma" id="rb_idioma" class=" {if isset($recurso)}{$lenguaje["label_idioma-recurso_bdrecursos"]}{/if}" value="{$idi.Idi_IdIdioma}" 
                                                                                               {if isset($recurso) && $recurso.Idi_IdIdioma==$idi.Idi_IdIdioma} 
                                                                                                   checked="checked" 
                                                                                               {elseif !isset($recurso) && isset($idioma) && $idioma==$idi.Idi_IdIdioma} 
                                                                                                   checked="checked"
                                                                                                {/if} 
                                                                                               required>
                                                                                        {$idi.Idi_Idioma}
                                                                                    </label>                       
                                                                                </div>  
                                                                            {/foreach}
                                                                        </div>          
                                                                    {else} 
                                                                        <div class="form-inline col-lg-9">
                                                                            <label class="control-label">{$lenguaje["label_idioma-inexistente_bdrecursos"]} </label>
                                                                        </div>
                                                                    {/if}
                                                                </div>
                                                                <div id="index_nuevo_recurso">
                                                                    <div class="form-group">
                                                                        <label class="col-lg-2 control-label" for="tb_nombre_recurso">{$lenguaje["label_nombre_bdrecursos"]}*</label>
                                                                        <div class="col-lg-10">
                                                                            <input type="text" class="form-control" id="tb_nombre_recurso"  name="tb_nombre_recurso"
                                                                                   placeholder="{$lenguaje["label_place_nombre_bdrecursos"]}" value="" required/>
                                                                        </div>
                                                                    </div> 
                                                                    <div class="form-group">
                                                                        <label  class="col-lg-2 control-label" for="tb_fuente_recurso">{$lenguaje["label_fuente_bdrecursos"]}*</label>
                                                                        <div class="col-lg-10">
                                                                            <input type="text" list="dl_fuente" class="form-control" id="tb_fuente_recurso"  value="" name="tb_fuente_recurso"
                                                                                   placeholder="{$lenguaje["label_place_fuente_bdrecursos"]}"required/>
                                                                            <datalist id="dl_fuente">
                                                                                {foreach item=datos from=$fuente}
                                                                                    <option value='{$datos.Rec_Fuente}'>
                                                                                    {/foreach} 
                                                                            </datalist>
                                                                        </div>
                                                                    </div> 
                                                                    <div class="form-group">
                                                                        <label  class="col-lg-2 control-label" for="tb_origen_recurso">{$lenguaje["label_origen_bdrecursos"]}*</label>
                                                                        <div class="col-lg-10">
                                                                            <input type="text" list="dl_origen" class="form-control" id="tb_origen_recurso" value="" name="tb_origen_recurso"
                                                                                   placeholder="{$lenguaje["label_place_origen_bdrecursos"]}" required/>
                                                                            <datalist id="dl_origen">
                                                                                {foreach item=datos from=$origenrecurso}
                                                                                    <option value='{$datos.Rec_Origen}'> {$datos.Rec_Origen}</option>
                                                                                {/foreach}
                                                                            </datalist>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label class="col-lg-2 control-label" for="sl_estandar_recurso">Estandar*</label>    
                                                                    <div class="col-lg-10">
                                                                        <input type="hidden" id="sl_estandar_recurso" name="sl_estandar_recurso" value="3">
                                                                        <select class="form-control" disabled="" required="">
                                                                            <option value="">{$lenguaje["label_seleccione_estandar_bdrecursos"]}</option>
                                                                            {foreach item=datosEst from=$estandares}
                                                                                <option value='{$datosEst.Esr_IdEstandarRecurso}' {if $datosEst.Esr_IdEstandarRecurso == 3}selected{/if}> {$datosEst.Esr_Nombre}</option>
                                                                            {/foreach}
                                                                        </select>
                                                                    </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <div class="col-lg-offset-2 col-lg-10">
                                                                        <input type="hidden" id="hd_tipo_recurso" name="hd_tipo_recurso" value="1">
                                                                        <button type="submit"  class="btn btn-success" id="bt_registrar" name="bt_registrar"><i class="glyphicon glyphicon-floppy-disk"> </i> {$lenguaje["boton_guardar_bdrecursos"]}</button>
                                                                        
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </form>
                                                    </div>           
                                                </div>
                                            </div>

                                            <!-- <div class="form-group text-center">
                                                <input type="checkbox" tabindex="3" class="" name="remember" id="remember">
                                                <label for="remember"> Recordarme</label>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-sm-6 col-sm-offset-3">
                                                        <button type="button" name="logear" id="logear" tabindex="4" class="form-control btn btn-login" >{$lenguaje["text_iniciarsession"]}</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="row">
                                                    <div class="col-lg-12">
                                                        <div class="text-center">
                                                            <a href="#" tabindex="5" class="forgot-password">¿Has olvidado tu contraseña?</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div> -->
                                        </form>
                                        <form id="buscar-form" action="" style="display: none;">
                                            
                                            <div id="lista_recursos_dublin">
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
                <a href="#" class="btn btn-default" data-dismiss="modal">Cerrar</a>
            </div>
        </div>
    </div>
</div>
<!--  Modal end -->