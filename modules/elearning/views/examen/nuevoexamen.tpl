{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10">
<div class="col-lg-12">
        <h3>Nuevo Examen</h3>
        <hr class="cursos-hr">
    </div>
   <div style="width: 100%; margin: 0px auto">
    <form class="form-horizontal" role="form" method="post" action="" autocomplete="on">
        <input type="hidden" value="1" name="enviar" />
       
        <div class="form-group">
                
            <label class="col-lg-3 control-label">Título: </label>
            <div class="col-lg-9">
                <p><input class="form-control" id ="titulo" type="text" name="titulo" value="{$datos.nombre|default:""}" placeholder="Título"/></p>
            </div>
        </div>
            
        <div class="form-group">
            <label class="col-lg-3 control-label" >Porcentaje Global: </label>
            <div class="col-lg-9">
                <p><input class="form-control" id ="porcentaje" type="number" name="porcentaje" value="{$datos.apellidos|default:""}" placeholder="Porcentaje" 
                max="{$porcentaje}" min="0" value="0"/></p>
            </div>
        </div>
            
        <div class="form-group">
            <label class="col-lg-3 control-label" >Puntaje Máximo: </label>
            <div class="col-lg-9">
                <p><input type="radio" value="20" class="radioalt margin-top-10" name="puntaje" checked="checked" style="margin-top:10px;"/>20</p>
                <p><input type="radio" value="100" class="radioalt margin-top-10" name="puntaje"  style="margin-top:10px;"/>100</p>
            </div>
        </div>
            
        <div class="form-group">
            <label class="col-lg-3 control-label" >Número Máximo de Intentos: </label>
            <div class="col-lg-9">
                <p>
                  <select class="form-control" id="intentos" name="intentos">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="5">5</option>
                    <option value="10">10</option>
                    <option value="0">Ilimitado</option>
                  </select>
                </p>
            </div>
        </div>

        <div class="form-group">
            <label class="col-lg-3 control-label" >Aplicar después de: </label>
            <div class="col-lg-9">
                <p>
                  <select class="form-control" id="selectleccion" name="selectleccion">
                    {if isset($lecciones) && count($lecciones)}
                    {foreach item=ll from=$lecciones}
                        <option value="{$ll.Lec_IdLeccion}">{$ll.Lec_Titulo}</option>
                    {/foreach}
                    {/if}
                  </select>
                </p>
            </div>
        </div>
        
        <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">
             <button class="btn btn-success pull-right margin-top-10" name="guardar" id="guardar">Preparar preguntas</button>
            </div>
        </div>
    </form>
</div>
</div>
