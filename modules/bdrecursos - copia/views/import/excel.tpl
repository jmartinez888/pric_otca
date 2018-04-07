<div class="container" style="margin:10px auto;">
    <div class="row">
        <div class="col-md-12">
            <h2 class="tit-pagina-principal" class="titulo-view" align="center">Cargar Archivo</h2>
        </div>        
        <div class="col-md-3">     
            <div class="panel-group" id="accordion">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <strong>{$lenguaje["label_recurso_bdrecursos"]}</strong>
                            <!-- <i type="button" class="btn btn-xs btn-success glyphicon glyphicon-plus " title="Agregar Recurso" data-placement="bottom" data-toggle="modal" data-target="#modal-recurso"></i>&nbsp;&nbsp; -->
                            <i type="button" class="btn btn-xs btn-info glyphicon glyphicon-search pull-right" title="Agregar Recurso" data-placement="bottom" data-toggle="modal" data-target="#modal-recurso"></i>
                        </h4>
                    </div>               
                    <div class="panel-body">
                        <table class="table table-user-information">
                            <tbody>                           
                                <tr>
                                    <td>{$lenguaje["label_nombre_bdrecursos"]}:</td>
                                    <td>{$recurso.Rec_Nombre}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["label_tipo_bdrecursos"]}</td>
                                    <td>{$recurso.Tir_Nombre}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["label_estandar_bdrecursos"]}</td>
                                    <td>{$recurso.Esr_Nombre}</td>
                                </tr>                                
                                <tr>
                                    <td>{$lenguaje["label_fuente_bdrecursos"]}</td>
                                    <td>{$recurso.Rec_Fuente}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["label_origen_bdrecursos"]}</td>
                                    <td>{$recurso.Rec_Origen}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["registros_bdrecursos"]}</td>
                                    <td>{$recurso.Rec_CantidadRegistros}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["herramienta_utilizada_bdrecursos"]}</td>
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
                                    <td>{$lenguaje["registro_bdrecursos"]}</td>
                                    <td>{$recurso.Rec_FechaRegistro|date_format:"%d/%m/%y"}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["modificacion_bdrecursos"]}</td>
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
                <div class="panel-heading"><strong> CARGAR ARCHIVO {if $tipo_estandar==2}- VARIABLES{/if}</strong></div>
                <div class="panel-body">  
                    <div role="tabpanel">
                        <!-- Nav tabs -->
                        <ul class="nav nav-tabs" role="tablist">
                            <li role="presentation" class="active">
                                <a href="#excel" aria-controls="excel" role="tab" data-toggle="tab">Archivo Excel</a>
                            </li>
                            <li role="presentation">
                                <a href="#txt" aria-controls="txt" role="tab" data-toggle="tab">Archivo de Texto</a>
                            </li>    
                        </ul>
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div role="tabpanel" class="tab-pane active" id="excel">
                                <div style="margin:10px auto;" align="center">
                                    <form  action="../excel/registrar" method="post" data-toggle="validator" class="form-horizontal" role="form" enctype="multipart/form-data" id="subir_archivo">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <input type="file" name="archivo" id="archivo">
                                                {if $estandar==3}
                                            </div>
                                            <div class="col-md-12" style="margin:30px auto">    
                                                <input type="hidden" name="archivos[]" id="archivos" multiple="multiple">
                                                {/if}
                                            </div>
                                        </div>
                                        <button type="submit" id="btnEnviar" name="btnEnviar" class="btn btn-success">CARGAR ARCHIVO</button>
                                        <input type="hidden" value="1" name="registrar" />
                                        <input type="hidden" value="0" name="data" />
                                    </form>
                                </div>
                            </div>    
                            <div role="tabpanel" class="tab-pane" id="txt">
                                <div style="margin:10px auto;" align="center">
                                    <form action="../txt/registrar/" method="post" enctype="multipart/form-data" class="form-horizontal" data-toggle="validator" role="form" id="subir_archivo">
                                        <div class="form-group">
                                            <div class="col-md-12">
                                                <input type="file" name="archivo" id="archivo">
                                                {if $estandar==3}
                                                </div>
                                                <div class="col-md-12" style="margin:30px auto">
                                                <input type="file" name="archivos[]" id="archivos" multiple="multiple">
                                                {/if}
                                            </div>
                                        </div>
                                        <div class="row">
                                            <label class="checkbox-inline">
                                                <input type="radio" id="coma" value="," name="separador" checked> Separador Coma
                                            </label>
                                            <label class="checkbox-inline">
                                                <input type="radio" id="tabulacion" name="separador" value="\t"> Separador Tabulacion
                                            </label>
                                        </div>
                                        <div class="row" style="margin:10px auto;">
                                            <button type="submit" id="btnEnviar" class="btn btn-success">Cargar archivo</button>                       
                                        </div>
                                        <input type="hidden" value="0" name="data" />
                                    </form>
                                </div>    
                            </div>    
                      </div>
                    </div>
                </div> 
            </div>
            {if $tipo_estandar==2}  
                <div class="panel panel-default">
                    <div class="panel-heading"><strong> CARGAR ARCHIVO {if $tipo_estandar==2}- DATA{/if}</strong></div>
                    <div class="panel-body">  
                        <div role="tabpanel">
                            <!-- Nav tabs -->
                            <ul class="nav nav-tabs" role="tablist">
                                <li role="presentation" class="active">
                                    <a href="#excel2" aria-controls="excel" role="tab" data-toggle="tab">Archivo Excel</a>
                                </li>
                                <li role="presentation">
                                    <a href="#txt2" aria-controls="txt" role="tab" data-toggle="tab">Archivo de Texto</a>
                                </li>    
                            </ul>
                            <!-- Tab panes -->
                            <div class="tab-content">
                                <div role="tabpanel" class="tab-pane active" id="excel2">
                                    <div style="margin:10px auto;" align="center">
                                        <form  action="../import/registrar/" method="post" data-toggle="validator" class="form-horizontal" role="form" enctype="multipart/form-data" id="subir_archivo">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <input type="file" name="archivo" id="archivo">
                                                        {if $estandar==3}
                                                </div>
                                                <div class="col-md-12" style="margin:30px auto">    
                                                    <input type="file" name="archivos[]" id="archivos" multiple="multiple">
                                                    {/if}
                                                </div>
                                            </div>
                                            <button type="submit" id="btnEnviar" name="btnEnviar2" class="btn btn-success">CARGAR ARCHIVO</button>
                                            <input type="hidden" value="1" name="registrar" />
                                            <input type="hidden" value="1" name="data" />
                                        </form>
                                    </div>
                                </div>    
                                <div role="tabpanel" class="tab-pane" id="txt2">
                                    <div style="margin:10px auto;" align="center">
                                        <form action="../import/registrar/" method="post" enctype="multipart/form-data" class="form-horizontal" data-toggle="validator" role="form" id="subir_archivo">
                                            <div class="form-group">
                                                <div class="col-md-12">
                                                    <input type="file" name="archivo" id="archivo">
                                                    {if $estandar==3}
                                                    </div>
                                                    <div class="col-md-12" style="margin:30px auto">
                                                    <input type="file" name="archivos[]" id="archivos" multiple="multiple">
                                                    {/if}
                                                </div>
                                            </div>
                                            <div class="row">
                                                <label class="checkbox-inline">
                                                    <input type="radio" id="coma" value="," name="separador" checked> Separador Coma
                                                </label>
                                                <label class="checkbox-inline">
                                                    <input type="radio" id="tabulacion" name="separador" value="\t"> Separador Tabulacion
                                                </label>
                                            </div>
                                            <div class="row" style="margin:10px auto;">
                                                <button type="submit" id="btnEnviar" name="btnEnviar2" class="btn btn-success">Cargar archivo</button>
                                            </div>
                                            <input type="hidden" value="1" name="registrar" />
                                            <input type="hidden" value="1" name="data" />
                                        </form>
                                    </div>    
                                </div>    
                          </div>
                        </div>
                    </div> 
                </div>
            {/if}      
        </div>           
    </div>    
</div>

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