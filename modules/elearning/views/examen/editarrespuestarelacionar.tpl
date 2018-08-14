{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-10">
<div class="col-lg-12">
    <div class="col-lg-12">
  <div class=" " style="margin-bottom: 0px !important">
    <div class="text-center text-bold" style="margin-bottom: 20px; color: #267161;">
      <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
        Titulo de Nuevo curso mooc
                </h3>
    </div>
  </div>
</div>
        <h3>Editar pregunta: Respuesta Relacionada</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form method="POST">
           <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
            <input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">
            <input type="hidden" name="idexamen" id="idexamen" value="{$examen}">
            <label class="col-lg-9">Pregunta</label>
              <label class="col-lg-3">Puntos</label>
              <div class="col-lg-9">
              <input placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta" value="{$preguntaedit.Pre_Descripcion}"/>
              </div>
               <div class="col-lg-3">
              <input placeholder="Puntos" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{if $puntos_maximo>$preguntaedit.Pre_Puntos}{$puntos_maximo}{else}{$preguntaedit.Pre_Puntos+$puntos_maximo}{/if}" value="{$preguntaedit.Pre_Puntos}"/>
               </div>
                            <br>
              <input type="hidden" class="form-control" name="contador" id="contador" value="{$nextinput-1}"/>            

            <div id="alt" class="col-lg-12" style="margin-top:10px;">
                <label class="">Respuestas</label>
                <br>
                <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="{$nextinput}"/>
                {$i=1}
                {for $j=0; $j<count($alternativas); $j=$j+2}
                <div>
                    <label class="" style="margin-top:10px;">Enunciado:</label>
                    <input placeholder="Enunciado" class="form-control" name="enu{$i}" id="enu{$i}" value="{$alternativas[$j]['Alt_Etiqueta']}"/>
                    <label class="">Corresponde a:</label>
                    <input placeholder="Respuesta relacionada" class="form-control" name="rpta{$i}" id="rpta{$i}" value="{$alternativas[$j+1]['Alt_Etiqueta']}"/>

                    {if $j>2}
                      <a href='javascript:void(0);' class='remove_button btn btn-danger pull-right margin-top-10 ' title='Remove field'><i class='glyphicon glyphicon-minus'></i></a>
                      {/if}
                </div>
                {$i=$i+1}
                {/for}
            </div>
                <div class="col-lg-12" style="margin-top: 15px">
                   <a href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">Cancelar</a>
                   <button class="btn btn-success pull-right margin-top-10" name="btn_registrar_pregunta" id="btn_registrar_pregunta">Editar</button>
                   <a class="btn btn-primary pull-right margin-top-10 glyphicon glyphicon-plus" id="btn_añadir4"></a>
                </div>
        </form>
        </div>
    </div>
</div>