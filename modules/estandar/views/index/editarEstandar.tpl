<div  class="container-fluid" >
    <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
        <h4 class="titulo-view">{$lang->get('titulo_estandar')}</h4>
    </div>
    {if $_acl->permiso("agregar_estandar") && isset($tablaGenerada) && $tablaGenerada == 1}
    <div class="panel panel-default">
        <div class="panel-heading jsoftCollap">
            <h3 aria-expanded="false" data-toggle="collapse" href="#collapse3" class="panel-title collapsed text-uppercase"><i style="float:right"class="fa fa-ellipsis-v"></i><i class="glyphicon glyphicon-inbox  "></i>&nbsp;&nbsp;<strong>{$lang->get('estandar_nuevo_campo')}</strong></h3>
        </div>        
        <div style="height: 0px;" aria-expanded="false" id="collapse3" class="panel-collapse collapse">
            <div class="panel-body">
                <div id="nuevoRegistro">
                    <div style="width: 90%; margin: 0px auto">
                        <form class="form-horizontal" id="form1" name="form1" role="form" data-toggle="validator" method="post" autocomplete="on">
                            <div class="form-group" >
                                <label class="col-lg-3 control-label">{$lenguaje.label_idioma} : </label>
                                {if  isset($idiomas) && count($idiomas)}              
                                    <div class="form-inline col-lg-9"> 
                                        {foreach from=$idiomas item=idi}
                                            {if  isset($datosEstandar) && count($datosEstandar)}
                                                {if $datosEstandar.Idi_IdIdioma==$idi.Idi_IdIdioma} <input type="hidden" value="{$idi.Idi_Idioma}" id="idiomaRadio" name="idiomaRadio"> {/if}
                                                <div class="radio">
                                                    <label>
                                                        <input disabled="true" type="radio"  value="{$idi.Idi_IdIdioma}" 
                                                            {if $datosEstandar.Idi_IdIdioma==$idi.Idi_IdIdioma} checked="checked" {/if} required>
                                                        {$idi.Idi_Idioma}
                                                    </label>                                        
                                                </div>   
                                            {else}
                                                <div class="radio">
                                                    <label>
                                                        <input type="radio"  name="idiomaRadio" id="idiomaRadio" value="{$idi.Idi_IdIdioma}"  
                                                            {if isset($idiomaUrl) && $idiomaUrl == $idi.Idi_IdIdioma } checked="checked" {/if} required>
                                                        {$idi.Idi_Idioma} 
                                                    </label>                                        
                                                </div>
                                            {/if}
                                        {/foreach}
                                    </div>              
                                {/if}
                            </div>                            
                            <div class="form-group">                                    
                                <label class="col-lg-3 control-label">{$lang->get('estandar_nombre_campo')}: </label>
                                <div class="col-lg-9">
                                    <input class="form-control" id ="nombre" name='nombre' data-error="* {$lang->get('estandar_valida_campo_nombre')}" type="text" pattern="([A-Z][\sa-no-z]+[a-z])" value="{$datos.nombre|default:""}" placeholder="{$lenguaje.label_nombre}" required=""/>
                                    <span class="help-block with-errors"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 control-label" >{$lang->get('estandar_tipo_campo')} : </label>
                                <div class="col-lg-3">
                                    <select class="form-control" name="Fie_TipoDatoCampo" id="Fie_TipoDatoCampo" data-error="* {$lang->get('estandar_campo_obligatorio')}" required="">
                                        <option  value="" >-- {$lang->get('str_seleccionar')} --</option>
                                        <option  value="Decimal" >{$lang->get('str_decimal')}</option>
                                        <option  value="Entero" >{$lang->get('str_entero_number')}</option>
                                        <option  value="Latitud" >{$lang->get('str_latitud')}</option>
                                        <option  value="Longitud" >{$lang->get('str_longitud')}</option>    
                                        <option  value="Texto" >{$lang->get('str_texto')}</option>
                                    </select>
                                    <span class="help-block with-errors"></span>
                                </div>
                                <div class="form-group-sm">
                                    <label class="col-lg-3 control-label" >{$lang->get('str_tamanho')} : </label>
                                    <div class="col-lg-3">
                                        <input class="form-control" id ="Fie_TamanoColumna" name='Fie_TamanoColumna' disabled="disabled" type="text" pattern="(([1-9])?[0-9]+)" value="{$datos.nombre|default:""}" placeholder="{$lang->get('str_tamanho')}" required=""/>
                                        <span class="help-block with-errors"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">                                    
                                <label class="col-lg-3 control-label">{$lang->get('estandar_campo_obligatorio')} : </label>
                                <div class="col-lg-3">
                                    <select class="form-control" name="Fie_ColumnaObligatorio" id="Fie_ColumnaObligatorio" data-error="* {$lang->get('estandar_campo_obligatorio')}" required="">
                                        <option  value="" >-- {$lang->get('str_seleccionar')} --</option>
                                        <option  value="1" >{$lang->get('str_si')}</option>
                                        <option  value="0" >{$lang->get('str_no')}</option>
                                    </select>
                                    <span class="help-block with-errors"></span>
                                </div>
                                <label class="col-lg-3 control-label">{$lang->get('estandar_requiere_traduccion')} : </label>
                                <div class="col-lg-3">
                                    <select class="form-control" name="Fie_ColumnaTraduccion" id="Fie_ColumnaTraduccion" data-error="* {$lang->get('estandar_campo_obligatorio')}" required="">
                                        <option  value="" >-- {$lang->get('str_seleccionar')} --</option>
                                        <option  value="1" >{$lang->get('str_si')}</option>
                                        <option  value="0" >{$lang->get('str_no')}</option>
                                    </select>
                                    <span class="help-block with-errors"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-offset-2 col-lg-8">
                                <button class="btn btn-success" id="bt_guardarFicha" name="bt_guardarFicha" type="submit" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.button_ok}</button>
                                </div>
                            </div>
                        </form>
                    </div>        
                </div>
            </div>
        </div>
    </div>
    {/if}
    <div style=" margin: 15px auto">
        <div class="panel panel-default">
            <div class="panel-heading">
                <form  id="form2" role="form" method="post" action="" autocomplete="on">
                    <h3 class="panel-title">
                        <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;<strong class="text-uppsercase">{$lang->get('estandar_buscar_campo')} </strong>
                        {if isset($tablaGenerada) && $tablaGenerada == 1}
                            <button class="btn btn-xs btn-danger pull-right text-uppercase" id="bt_generarTabla" name="bt_generarTabla" type="submit" ><i class="glyphicon glyphicon-tasks " ></i>&nbsp; {$lang->get('estandar_procesar_estandar')}</button>                        
                        {/if}
                    </h3>     
                </form>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-md-12 ">
                        <div class="col-md-4 pull-right">
                            <div class="input-group">
                                {if isset($datos) && count($datos)}
                                    <input type="hidden" id="idEstandarRecurso" name="idEstandarRecurso" value="{$datos[0]['Esr_IdEstandarRecurso']}" />
                                {/if}
                                <input id="palabraCampo" type="text" class="form-control"  placeholder="{$lang->get('estandar_buscar_campo')}" name="palabraCampo"/>                   
                                <span class="input-group-btn">
                                    <button id="buscarCampo" class="btn btn-success" type="button">
                                        <span class="glyphicon glyphicon-search"></span>
                                    </button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div style="margin: 15px 25px">
                    <h4 class="panel-title"> <b>{$lang->get('tiutlo_lista_estandar')}</b></h4>
                    <div id="listaregistrosFichas">
                        {if isset($datos) && count($datos)}
                            <div class="table-responsive" >
                                <table class="table" style=" text-align: center">
                                    <tr>
                                        <th style=" text-align: center">{$lenguaje.label_n}</th>
                                        <th style=" text-align: center">{$lang->get('estandar_nombre_campo')}</th>
                                        <th style=" text-align: center">{$lang->get('label_nombre_tabla')}</th>                                        
                                        <th style=" text-align: center">{$lang->get('estandar_nombre_columna')}</th>
                                        <th style=" text-align: center">{$lang->get('estandar_tipo_campo')}</th>
                                        <th style=" text-align: center">{$lang->get('str_tamanho')}</th>
                                        {if $_acl->permiso("agregar_estandar") && isset($tablaGenerada) && $tablaGenerada == 1}
                                        <th style=" text-align: center">{$lenguaje.label_opciones}</th>
                                        {/if}
                                    </tr>
                                    {foreach from=$datos item=us}
                                        <tr>
                                            <td>{$numeropagina++}</td>
                                            <td>{$us.Fie_CampoFicha}</td>
                                            <td>{$us.Fie_NombreTabla}</td>                                            
                                            <td>{$us.Fie_ColumnaTabla}</td>
                                            <td>{$us.Fie_TipoDatoCampo}</td>
                                            <td>{$us.Fie_TamanoColumna}</td>
                                            {if $_acl->permiso("agregar_estandar") && isset($tablaGenerada) && $tablaGenerada == 1}
                                            <td >
                                                <a class="btn btn-default btn-sm glyphicon glyphicon-pencil" title="{$lenguaje.tabla_opcion_editar}" href="{$_layoutParams.root}estandar/index/editarFicha/{$us.Esr_IdEstandarRecurso}/{$us.Fie_IdFichaEstandar}"></a>
                                                <a class="btn btn-default btn-sm glyphicon glyphicon-trash estado-ficha" ficha="{$us.Fie_IdFichaEstandar}" title="{$lenguaje.tabla_opcion_cambiar_est}" > </a>
                                            </td>
                                            {/if}
                                        </tr>
                                    {/foreach}
                                </table>
                            </div>          
                            <div class="panel-footer">
                                {$paginacion|default:""}
                            </div>
                        {else}
                            {$lenguaje.no_registros}
                        {/if}                          
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>