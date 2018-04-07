<div class="panel panel-default">
    <div class="panel-heading">                       
        <h3 class="panel-title">
            <i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;
            <strong>{$lenguaje["lista_recursos_bdrecursos"]}</strong>  <span class="badge  pull-right">{$control_paginacion}</span></h3>
    </div>
    <div class=" panel-body">
            <div class="col-sm-4 ">
            <div class="input-group">
                <input id="tb_nombre_filter" type="text" class="form-control"  placeholder="{$lenguaje["nombre_bdrecursos"]}" value="{$nombre|default}" />
                <span class="input-group-btn">
                    <button id="bt_buscar_filter" class="btn btn-default" type="button"><span class="glyphicon glyphicon-search"></span></button>
                </span>
            </div>
            </div>
            <div class="col-sm-4 ">
            <select name="sl_fuente_filtro"  class="form-control select-recurso-filter " id="sl_fuente_filtro" >
                <option value="0">{$lenguaje["todas_fuentes_bdrecursos"]}</option>
                {foreach item=datos from=$fuente}
                    <option value='{$datos.Rec_Fuente}' {if isset($sl_fuente) && $sl_fuente==$datos.Rec_Fuente}selected{/if}> {$datos.Rec_Fuente}</option>
                {/foreach}
            </select>
            </div>
            <div class="col-sm-4 ">
            <select name="sl_origen_filtro"  class="form-control select-recurso-filter " id="sl_origen_filtro" >
                <option value="0">{$lenguaje["todos_origenes_bdrecursos"]}</option>
                {foreach item=datos from=$origenrecurso}
                    <option value='{$datos.Rec_Origen}' {if isset($sl_origen) && $sl_origen==$datos.Rec_Origen}selected{/if}> {$datos.Rec_Origen}</option>
                {/foreach}
            </select>
            </div>
    </div>
    {if isset($registros) && count($registros)}
        <div class="table-responsive">
            <table class="table table-hover table-condensed" >
                <thead>
                    <tr>
                        <th>#</th>
                        <th class="col-md-2">{$lenguaje["label_nombre_bdrecursos"]}s</th>
                        <th class="col-md-1">{$lenguaje["label_tipo_bdrecursos"]}</th>
                        <th>{$lenguaje["label_estandar_bdrecursos"]}</th>
                        <th>{$lenguaje["label_fuente_bdrecursos"]}</th>  
                        <th>{$lenguaje["registros_bdrecursos"]}</th> 
                        <th>{$lenguaje["registro_bdrecursos"]}</th>
                        <th style=" text-align: center">{$lenguaje["estado_bdrecursos"]}</th>
                        <th style=" text-align: center">Seleccionar</th>
                    </tr>
                </thead>                                
                <tbody>
                    {foreach item=datos from=$registros}
                        <tr>                       
                            <td>{$numeropagina++}</td>
                            <td class="col-md-2">{$datos.Rec_Nombre}</td>
                            <td class="col-md-1">{$datos.Tir_Nombre}</td>
                            <td>{$datos.Esr_Nombre}</td>
                            <td>{$datos.Rec_Fuente}</td>                  
                            <td>{$datos.Rec_CantidadRegistros}</td> 
                            <td>{$datos.Rec_FechaRegistro|date_format:"%d/%m/%y"}</td>
                            <td style=" text-align: center">                                              
                                {if $datos.Rec_Estado==0}
                                    <i class="glyphicon glyphicon-remove-sign" title="{$lenguaje["desabilitado_bdrecursos"]}" style="color: #DD4B39;"/>
                                {else}
                                    <i class="glyphicon glyphicon-ok-sign" title="{$lenguaje["habilitado_bdrecursos"]}" style="color: #088A08;"/>
                                {/if}
                            </td>
                            <td style=" text-align: center">
                                <a type="button" title="{$lenguaje['ver_bdrecursos']}" class="btn btn-default btn-sm glyphicon glyphicon-ok" href="{$_layoutParams.root}bdrecursos/import/{$tipoServicio}/{$datos.Rec_IdRecurso}" >
                                </a>     
                            </td>
                        </tr>                     
                    {/foreach}
                </tbody>
            </table>
        </div>
        {$paginacion|default:""}    
    {else}
        {$lenguaje["sin_resultados_bdrecursos"]}
    {/if}
</div>