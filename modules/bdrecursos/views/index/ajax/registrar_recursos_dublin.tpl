<div id="myTabContent" class="tab-content">
    <div class="tab-pane active in  form-horizontal" id="tabular">
        <form id="form1" method="post" data-toggle="validator"role="form" autocomplete="on">
            <div class="container col-md-5">
                <input type="hidden" id="hd_idrecurso"  name="hd_idrecurso"
                       value="{$recurso.Rec_IdRecurso|default}"/>
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
                                   placeholder="{$lenguaje["label_place_nombre_bdrecursos"]}" value="{$recurso.Rec_Nombre|default}" required/>
                        </div>
                    </div> 
                    <div class="form-group">
                        <label  class="col-lg-2 control-label" for="tb_fuente_recurso">{$lenguaje["label_fuente_bdrecursos"]}*</label>
                        <div class="col-lg-10">
                            <input type="text" list="dl_fuente" class="form-control" id="tb_fuente_recurso"  value="{$recurso.Rec_Fuente|default}" name="tb_fuente_recurso"
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
                            <input type="text" list="dl_origen" class="form-control" id="tb_origen_recurso" value="{$recurso.Rec_Origen|default}" name="tb_origen_recurso"
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
                        <select name="sl_estandar_recurso"  class="form-control" id="sl_estandar_recurso"  name="sl_estandar_recurso" {if  isset($recurso)} disabled{/if} required="">
                            <option value="">{$lenguaje["label_seleccione_estandar_bdrecursos"]}</option>
                            {foreach item=datos from=$estandar}
                                <option value='{$datos.Esr_IdEstandarRecurso}' {if isset($recurso)&& $recurso.Esr_IdEstandarRecurso==$datos.Esr_IdEstandarRecurso}selected{/if}> {$datos.Esr_Nombre}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-lg-offset-2 col-lg-10">
                        <input type="hidden" id="hd_tipo_recurso" name="hd_tipo_recurso" value="1">
                        {if isset($recurso)} 
                            <button type="submit"  class="btn btn-success" id="bt_actualizar" name="bt_actualizar"><i class="glyphicon glyphicon-floppy-disk"> </i> {$lenguaje["boton_editar_bdrecursos"]}</button>
                            <a class="btn btn-danger" href="{$_layoutParams.root}bdrecursos"><i class="glyphicon glyphicon-remove-sign"></i> Cancelar</a>
                        {else}
                            <button type="submit"  class="btn btn-success" id="bt_registrar" name="bt_registrar"><i class="glyphicon glyphicon-floppy-disk"> </i> {$lenguaje["boton_guardar_bdrecursos"]}</button>
                        {/if}
                    </div>
                </div>
            </div>
        </form>
    </div>           
</div>