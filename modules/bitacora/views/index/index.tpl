<script id="js_ErroresComunes" type="text/javascript"></script>
<script id="js_PaginaErrores" type="text/javascript"></script>

<!--<script type="text/javascript" src="{$_layoutParams.root}public/js/highcharts.js"></script>-->
<div class="container-fluid" >
    <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
        <h4 style="width: 80%;  margin: 0px auto; text-align: center;">{$lenguaje.bitacora_label_titulo}</h4>
    </div>
<!--    <h3 style="width: 75%; margin: 0px auto">BITACORA : ERRORES MÁS COMUNES DEL SISTEMA INTEGRADO</h3>
    <br>-->
   <div class="panel panel-default">
        <div class="panel-heading jsoftCollap">
            <h3 aria-expanded="false" data-toggle="collapse" href="#collapse3" class="panel-title collapsed">
                <i class="glyphicon glyphicon-equalizer"></i>&nbsp;&nbsp;<strong>{$lenguaje.bitacora_grafico_titulo}</strong><i style="float:right" class="glyphicon glyphicon-option-vertical"></i>
                <input type="hidden" id="titulo1" name="titulo1" value="{$lenguaje.bitacora_grafico_serie1}" />  
                <input type="hidden" id="titulo2" name="titulo2" value="{$lenguaje.bitacora_grafico_serie2}" />  
            </h3>
        </div>
        <div style="height: 0px;" aria-expanded="false" id="collapse3" class="panel-collapse collapse">
            <div class="panel-body">
                <div id="grafica" style=" margin: 15px">
                    <div id="c_ErroresComunes" style="  margin: 20px auto"></div>
                        
                    <div id="c_PaginaErrores" style="  margin: 20px auto"></div>
                </div>
            </div>
        </div>
    </div>
    
    <div style=" margin: 15px auto">
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title">
                     <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;<strong> {$lenguaje.bitacora_buscar_titulo}</strong>
                </h3>
            </div>
            
            <div class="panel-body" style=" margin: 15px 25px ">

                  <form name="form1" class="form-inline" method="post" action="" autocomplete="on">

                    <div class="row"style="text-align: right;padding-right: 2em; margin-top: 10px">
                        
                        <select class="form-control" id="iano" name="iano" style=" margin: 0px 4px 0px 4px" >
                            <option value="todos">{$lenguaje.label_ano}</option>
                            {foreach from=$anoLista item=aL}
                                <option value="{$aL}">{$aL}</option>
                            {/foreach}
                        </select>
                            
                        </select>
                         <select class="form-control" id="imes" name="imes" style=" margin: 0px 4px 0px 4px" >
                            <option value="todos">{$lenguaje.label_mes}</option>
                            <option value="1">{$lenguaje.label_enero}</option>
                            <option value="2">{$lenguaje.label_febrero}</option>
                            <option value="3">{$lenguaje.label_marzo}</option>
                            <option value="4">{$lenguaje.label_abril}</option>
                            <option value="5">{$lenguaje.label_mayo}</option>
                            <option value="6">{$lenguaje.label_junio}</option>
                            <option value="7">{$lenguaje.label_julio}</option>
                            <option value="8">{$lenguaje.label_agosto}</option>
                            <option value="9">{$lenguaje.label_setiembre}</option>
                            <option value="10">{$lenguaje.label_octubre}</option>
                            <option value="11">{$lenguaje.label_noviembre}</option>
                            <option value="12">{$lenguaje.label_diciembre}</option>

                        </select>
                       
<!--                        <button class="btn btn-primary" style=" float: left" type="button" id="buscar"  ><i class="glyphicon glyphicon-search"></i></button>-->
<!--                        <button class="btn btn-primary" type="button" id="btn_buscar"  ><i class="glyphicon glyphicon-search"></i></button> -->
<br />
                    
                    </div>
                </form>
                
                    <br>
                <h4><b>{$lenguaje.bitacora_buscar_tabla_titulo}</b></h4>
                {if $_acl->permiso("exportar_bitacora")}
                <div style="text-align: right;">                    
                    <a class="btn btn-success" data-toggle="tooltip" data-placement="bottom" title="{$lenguaje.label_descargar_datos}" href="{$_layoutParams.root}bitacora/index/descargar_datos"><i class="glyphicon glyphicon-download-alt"> </i> </a>
                </div>
                {/if}
                <div id="divListarBitacoraErrores" style="  margin: 0px auto">
                                        
                </div>
            </div>
        </div>
    </div>
</div>
