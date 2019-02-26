{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10">
<div class="col-lg-12">
        <h3>{$lenguaje["elearning_comenzarexamen_titulo"]}</h3>
        <hr class="cursos-hr">
    </div>
   <div style="width: 100%; margin: 0px auto; text-align:center;">
    <form class="" role="form" method="post" action="" autocomplete="on">
        <input type="hidden" value="1" name="enviar" />
       
        <div class="form-group">
                
            <label class="col-lg-12 control-label">{$lenguaje["elearning_comenzarexamen_intentos"]} {$intentos[0]} de {$maxintentos}</label>
            <div class="col-lg-12">
            <p></p>
                <p>{$lenguaje["elearning_comenzarexamen_text1"]}</p>
            </div>
        </div>
        
        <div class="form-group">
            <div class="col-lg-12">
             <button class="btn btn-success margin-top-10" name="comenzar" id="comenzar">{$lenguaje["elearning_comenzarexamen_bntcomenzar"]}</button>
            </div>
        </div>
    </form>
</div>
</div>
