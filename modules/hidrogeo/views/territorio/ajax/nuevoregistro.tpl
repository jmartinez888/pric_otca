<div style="width: 90%; margin: 0px auto">                        
    <form class="form-horizontal" id="form1" role="form" data-toggle="validator" method="post" action="" autocomplete="on">
        <!--                            <input type="hidden" value="1" name="enviar" />-->   
        <div class="form-group">                                 
            <label class="col-lg-3 control-label">{$lenguaje.label_pais_nuevo} : </label>
            <div class="col-lg-8">
                {if  isset($paises)}
                    <select class="form-control" id="selPais" name="selPais" required="">
                        <option value="">{$lenguaje.label_seleccion_nuevo}</option>
                        {foreach from=$paises item=p}
                            <option value="{$p.Pai_IdPais}" {if isset($sl_pais) && $sl_pais==$p.Pai_IdPais}selected{/if}>{$p.Pai_Nombre}</option>    
                        {/foreach}
                    </select>
                {/if}
            </div>
        </div>

        <div class="form-group">                                 
            <label class="col-lg-3 control-label">{$lenguaje.label_denominacion_nuevo} : </label>
            <div class="col-lg-8">
                {if  isset($denominaciones)}
                    <select class="form-control" id="selDenominacion" name="selDenominacion" required="">
                        <option value="">{$lenguaje.label_seleccion_nuevo}</option>
                        {foreach from=$denominaciones item=d}
                            <option value="{$d.Det_IdDenomTerrit}" {if isset($sl_denominacion) && $sl_denominacion==$d.Det_IdDenomTerrit}selected{/if}>{$d.Det_Nombre}</option>    
                        {/foreach}
                    </select>
                {/if}
            </div>
        </div>
        <div class="form-group">
            <label class="col-lg-3 control-label">{$lenguaje.label_nombre_nuevo} : </label>
            <div class="col-lg-8">
                <input class="form-control" id ="nombre" type="text"  name="nombre" value="" placeholder="{$lenguaje.label_nombre}" required=""/>
            </div>
        </div>
        <div class="form-group">
            <label class="col-lg-3 control-label">{$lenguaje.label_siglas_nuevo} : </label>
            <div class="col-lg-8">
                <input class="form-control" id ="siglas" type="text"  name="siglas" value="" placeholder="{$lenguaje.label_siglas_nuevo}"/>
            </div>
        </div>
        <div class="form-group">                                 
            <label class="col-lg-3 control-label">{$lenguaje.label_estado_nuevo} : </label>
            <div class="col-lg-8">
                <select class="form-control" id="selEstado" name="selEstado" >
                    <option value="0">Inactivo</option>
                    <option value="1">Activo</option>
                </select>

            </div>
        </div>
        <div class="form-group">
            <div class="col-lg-offset-2 col-lg-8">
                <button class="btn btn-success" id="bt_guardar" name="bt_guardar" type="submit" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.button_ok}</button>
            </div>
        </div>
    </form>
</div>  