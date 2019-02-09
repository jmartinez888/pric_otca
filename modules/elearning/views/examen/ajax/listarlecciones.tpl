{if isset($lecciones) && count($lecciones)}
<div class="form-group">
    <label class="col-xs-3 control-label" >{$lenguaje["elearning_label_lecc"]}</label>
    <div class="col-xs-9">
        <select class="form-control" id="selectleccion" name="selectleccion">
            <option value="0">{$lenguaje["elearning_label_selec"]}</option>
            {foreach item=ll from=$lecciones}
                <option value="{$ll.Lec_IdLeccion}">{$ll.Lec_Titulo}</option>
            {/foreach}
        </select>
    </div>
</div>  
<div class="form-group">
    <label class="col-xs-3 control-label" >{$lenguaje["elearning_label_procentaje"]}</label>
    <div class="col-xs-9">
        <input data-toggle="tooltip" data-placement="bottom" title="{$lenguaje["elearning_label_mensaje"]} {$porcentaje}" class="form-control" id ="porcentaje" type="number" name="porcentaje" value="" placeholder="Porcentaje" 
        max="{$porcentaje}" min="0" value="0"/>
    </div>
</div>   
<div class="form-group">
    <label class="col-xs-3 control-label" >{$lenguaje["elearning_label_PMx"]}</label>
    <div class="col-xs-9">
        <p><input type="radio" value="20" class="radioalt margin-top-10" name="puntaje" checked="checked" style="margin-top:10px;"/>20</p>
        <p><input type="radio" value="100" class="radioalt margin-top-10" name="puntaje"  style="margin-top:10px;"/>100</p>
    </div>
</div>
<div class="form-group">
    <label class="col-xs-3 control-label" >{$lenguaje["elearning_label_Intentos"]}</label>
    <div class="col-xs-9">
        <select class="form-control" id="intentos" name="intentos">
            <option value="1">1</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="5">5</option>
            <option value="10">10</option>
            <option value="0">{$lenguaje["elearning_label_Ilimitado"]}</option>
        </select>
    </div>
</div>
{else}
<center>{$lenguaje["elearning_label_LeccionNo"]}<center>
{/if}
