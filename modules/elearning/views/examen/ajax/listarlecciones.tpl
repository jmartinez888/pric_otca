{if isset($lecciones) && count($lecciones)}
<div class="form-group">
    <label class="col-xs-3 control-label" >Lección: </label>
    <div class="col-xs-9">
        <select class="form-control" id="selectleccion" name="selectleccion">
            <option value="0">Seleccione lección</option>
            {foreach item=ll from=$lecciones}
                <option value="{$ll.Lec_IdLeccion}">{$ll.Lec_Titulo}</option>
            {/foreach}
        </select>
    </div>
</div>  
<div class="form-group">
    <label class="col-xs-3 control-label" >Porcentaje Global: </label>
    <div class="col-xs-9">
        <input data-toggle="tooltip" data-placement="bottom" title="El valor debe ser inferior o igual a {$porcentaje}" class="form-control" id ="porcentaje" type="number" name="porcentaje" value="" placeholder="Porcentaje" 
        max="{$porcentaje}" min="0" value="0"/>
    </div>
</div>   
<div class="form-group">
    <label class="col-xs-3 control-label" >Puntaje Máximo: </label>
    <div class="col-xs-9">
        <p><input type="radio" value="20" class="radioalt margin-top-10" name="puntaje" checked="checked" style="margin-top:10px;"/>20</p>
        <p><input type="radio" value="100" class="radioalt margin-top-10" name="puntaje"  style="margin-top:10px;"/>100</p>
    </div>
</div>
<div class="form-group">
    <label class="col-xs-3 control-label" >Número Máximo de Intentos: </label>
    <div class="col-xs-9">
        <select class="form-control" id="intentos" name="intentos">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="5">5</option>
            <option value="10">10</option>
            <option value="0">Ilimitado</option>
        </select>
    </div>
</div>
{else}
<center>No hay lecciones disponibles<center>
{/if}