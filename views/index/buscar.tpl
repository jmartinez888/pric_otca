<div  class="container-fluid" > 
    <div class="col-md-12">
         <h2 class="tit-pagina-principal">{$lenguaje.buscador_titulo}</h2>
     </div>
     <div class="col-lg-12">
        <hr class="cursos-hr">
    </div>   
    <div class="col-sm-2">
        <div class="">
            <h4 class="tipo-registro"><b>{$lenguaje.buscador_titulo_tipo_registro}</b></h4> 
        </div>
        <div class="">        
            
            <div id="TipoRegistros">                
                <ul class="list-group">
                    <a class="underline" {if $tipoRegistro == 1} style="color:#ffffff"  {/if}  href="{$_layoutParams.root}index/buscarPalabra/{$palabra1}/1/{$filtroPais|default:'all'}">
                    <li class="col-lg-12 list-group-item list-shadow lista-registro {if $tipoRegistro == 1} active2  {/if} ">    
                        <div class="col-lg-9 p-rt-lt-0">
                            {$lenguaje.buscador_tipo_registro1}
                        </div>
                        <div class="col-lg-3 p-rt-lt-0">
                            <span class="badge {if $tipoRegistro == 1} badge2 {/if}">{if isset($cantPagina)}{$cantPagina}{/if}</span>
                        </div>
                    </li>
                    </a>

                    <a class="underline" {if $tipoRegistro == 2} style="color:#ffffff"  {/if}  href="{$_layoutParams.root}index/buscarPalabra/{$palabra1}/2/{$filtroPais|default:'all'}">
                    <li class="col-lg-12 list-group-item list-shadow lista-registro {if $tipoRegistro == 2} active2  {/if}">
                        <div class="col-lg-9 p-rt-lt-0">
                            {$lenguaje.buscador_tipo_registro2}
                        </div>
                        <div class="col-lg-3 p-rt-lt-0">
                            <span class="badge {if $tipoRegistro == 2} badge2 {/if}"  >{if isset($cantDublin)}{$cantDublin}{/if}</span>
                        </div>       
                    </li>
                    </a>

                    <a class="underline" {if $tipoRegistro == 3} style="color:#ffffff"  {/if}  href="{$_layoutParams.root}index/buscarPalabra/{$palabra1}/3/{$filtroPais|default:'all'}">
                    <li class="col-lg-12 list-group-item list-shadow lista-registro {if $tipoRegistro == 3} active2  {/if}">
                        <div class="col-lg-9 p-rt-lt-0">
                            {$lenguaje.buscador_tipo_registro3}
                        </div>
                        <div class="col-lg-3 p-rt-lt-0">
                            <span class="badge {if $tipoRegistro == 3} badge2 {/if}"  >{if isset($cantForo)}{$cantForo}{/if}</span>
                        </div>
                    </li>
                    </a>

                    <a class="underline" {if $tipoRegistro == 4} style="color:#ffffff" {/if} href="{$_layoutParams.root}index/buscarPalabra/{$palabra1}/4/{$filtroPais|default:'all'}">
                    <li class="col-lg-12 list-group-item list-shadow lista-registro {if $tipoRegistro == 4} active2  {/if}">
                        <div class="col-lg-9 p-rt-lt-0">
                            {$lenguaje.buscador_tipo_registro4}
                        </div>
                        <div class="col-lg-3 p-rt-lt-0">
                            <span class="badge {if $tipoRegistro == 4} badge2 {/if}"  >{if isset($cantRecurso)}{$cantRecurso}{/if}</span>
                        </div>   
                    </li>
                    </a>
                </ul>                                   
            </div>
        </div>            
    </div>    
    <div class="col-sm-10">
        <div class="">        
            <div class="">
                <h4 class="tipo-registro"><b>{$lenguaje.buscador_listado_titulo}</b></h4> 
            </div>
            <div id="ResulllltadoBusqueda">                
                {if isset($resultadoBusqueda) && count($resultadoBusqueda)}
                    <div class="">
                        <div class="row">
                              <div class="col-md-6 col-md-offset-3" style="margin-top: 15px;">
                                <div class="input-group">                            
                                 <input class="form-control" data-toggle="tooltip" data-placement="bottom" title="Busca en Arquitectura SII, Base de Datos Documentos, Base de Datos Legislacion, Base de Datos Recursos, " type="search" id="textBuscar2" name="textBuscar2" placeholder="{$lenguaje.text_buscador|default:''}" value="{$palabrabuscada|default:''}" onkeypress="tecla_enter2(event)" required="required">               
                                 <span class="input-group-btn">
                                  <button class="btn  btn-success btn-buscador"  type="button" id="btnBuscar" name="btnBuscar" onclick="buscarPalabraGeneral('textBuscar2','filtrotipogeneral','filtropaisgeneral')" value=""><i class="glyphicon glyphicon-search"></i></button>
                                </span>
                               
                              </div><!-- /input-group -->
                            </div>

                            <div class="col-md-6 col-md-offset-3 div-filtro text-center">
                                {if isset($filtroTipo) OR  isset($filtroPais)}
                                <strong> Filtro:</strong> 
                                {/if}
                                {if isset($filtroTipo)}
                                <input type="hidden" id= "filtrotipogeneral" value="{$tipoRegistro|default:'all'}">
                                <a class="badge" style="margin: 3px !important;" href="{$_layoutParams.root}index/buscarPalabra/{$palabrabuscada|default:'all'}/all/{$filtroPais|default:'all'}">
                                 Tipo: {$filtroTipo} <i class="fa fa-times"></i>               
                                </a>
                                {/if}
                                {if isset($filtroPais)}
                                <input type="hidden" id= "filtropaisgeneral" value="{$pais|default:'all'}">
                                <a class="badge" style="margin: 3px !important;" href="{$_layoutParams.root}index/buscarPalabra/{$palabrabuscada|default:'all'}/{$tipoRegistro|default:'all'}/all">
                                 País: {$filtroPais} <i class="fa fa-times"></i>               
                                </a>
                                {/if}
                            </div>

                            <!-- <div class="col-md-12 text-center">
                                {if isset($paises) && count($paises)}
                                    <input type="hidden" id="palabra" value="{$palabra1}"/>
                                    {foreach item=datos from=$paises}
                                        <div style="margin-top:15px; display:inline-block;vertical-align:top;width:60px;text-align:center;margin-right:20px;">
                                            <img class="pais " style="cursor:pointer;width:40px" src="{$_layoutParams.root_clear}public/img/legal/{$datos.Pai_Nombre}.png" 
                                                pais="{$datos.Pai_Nombre}" /><b>{$datos.Pai_Nombre}</b>
                                                <p style="font-size:.8em">({$datos.cantidad|default:0})</p>
                                        </div>
                                    {/foreach}
                               {else}
                                    <p><strong>{$lenguaje["no_registros"]}</strong></p>
                               {/if}             
                            </div> -->
                             {if isset($cantTotal)}
                                <div class="col-md-12" >
                                    <h4>{$lenguaje.buscador_resultado1} <b>{$cantTotal}</b> {$lenguaje.buscador_resultado2} <b>"{$palabra}"</b> .</h4>
                                </div>
                                <div class="col-lg-12">
                                    <hr class="cursos-hr">
                                </div>        
                            {/if}        
                        </div>
                    </div>
                          
                    <div id="ResultadoBusqueda" class="table-responsive" >                          
                        {foreach from=$resultadoBusqueda item=rb}
                            <div style="margin-bottom: 20px; padding-bottom: 10px; border-bottom: 1px solid #ddd;" >
                                <a class="busqueda-link" style="font-size: 18px;" data-toggle="tooltip" data-placement="top" target="_blank" title="{$_layoutParams.root_clear}{$rb[3]}{$rb[0]}" href="{$_layoutParams.root}{$rb[3]}{$rb[0]}"> 
                                    {$rb[1]}
                                </a>  
                                {if $rb[4] == 1}<span style="background-color:#00a65a;color: white;font-weight:  bold;font-size: 11px;" class="badge">{$lenguaje.buscador_tipo_registro1}</span>{/if}
                                {if $rb[4] == 2}<span style="color: white;font-weight:  bold;font-size: 11px;" class="badge">{$lenguaje.buscador_tipo_registro2}</span>{/if}
                                {if $rb[4] == 3}<span style="background-color:#00c0ef;color: white;font-weight:  bold;font-size: 11px;" class="badge">{$lenguaje.buscador_tipo_registro3}</span>{/if}
                                {if $rb[4] == 4}<span style="background-color:#f39c12;color: white;font-weight:  bold;font-size: 11px;" class="badge">{$lenguaje.buscador_tipo_registro4}</span>{/if}                                   
                                    {if $rb[4] == 2} 
                                    <a style="color: #03A51E; line-height: 1.2;" data-toggle="tooltip" data-placement="top" href="{$_layoutParams.root}dublincore/documentos/descargar/{$rb[5]}/{$rb[6]}" target="_blank" title="{$lenguaje["icono_descargar_documentos"]} {$rb[7]}">
                                        <br>
                                        <img style="width: 20px" src="{$_layoutParams.root_clear}public/img/documentos/{$rb[7]}.png"/><b>&nbsp;{$lenguaje["icono_descargar_documentos"]} {$rb[7]}</a></b>
                                    {/if}
                                <div>
                                    <spam>{$rb[2]}  ...</spam>
                                    
                                </div>                                       
                            </div>
                        {/foreach}                              
                        <div class="panel-footer" style="margin-bottom: 15px;">
                            {$paginacion|default:""}
                        </div> 
                    </div>
                    {else} 
			<div class="panel-body">
				{$lenguaje["no_registros"]}
			</div>		
		
                {/if} 
            </div>
        </div>
    </div>    
</div>
    