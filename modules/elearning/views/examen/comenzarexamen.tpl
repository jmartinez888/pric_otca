{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-9">
<div class="col-lg-12">
        <h3>Examen</h3>
        <hr class="cursos-hr">
    </div>
   <div style="width: 100%; margin: 0px auto; text-align:center;">
    <form class="" role="form" method="post" action="" autocomplete="on">
        <input type="hidden" value="1" name="enviar" />
       
        <div class="form-group">
                
            <label class="col-lg-12 control-label">Número de intentos: {$intentos[0]} de {$maxintentos}</label>
            <div class="col-lg-12">
            <p></p>
                <p>Al presionar el botón de Comenzar Prueba se contabilizará un intento.</p>
            </div>
        </div>
        
        <div class="form-group">
            <div class="col-lg-12">
             <button class="btn btn-success margin-top-10" name="comenzar" id="comenzar">Comenzar Prueba</button>
            </div>
        </div>
    </form>
</div>
</div>
