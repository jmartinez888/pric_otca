{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-sm-10">
    <div class="col-lg-12">
        <div class="col-lg-12">
      <div class=" " style="margin-bottom: 0px !important">
        <div class="text-center text-bold" style="margin-top: 20px; margin-bottom: 20px; color: #267161;">
          <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
            {$titulo}
          </h3>
        </div>
      </div>
    </div>
        <h3>Editar pregunta: Respuesta Única</h3>
        <hr class="cursos-hr">
    </div>
    <div class="col-lg-12">
        <div class="panel-body">
        <form method="POST">
            <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
            <input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">
            <input type="hidden" name="idexamen" id="idexamen" value="{$examen}">
            <label class="col-sm-10">Pregunta</label>
            <label class="col-sm-2">Puntos</label>
            <div class="col-sm-10">
              <input placeholder="Pregunta" class="form-control" name="in_pregunta" id="in_pregunta" value="{$preguntaedit.Pre_Descripcion}"/>
              </div>
              <div class="col-sm-2">
              <input data-toggle="tooltip" data-placement="bottom" title="El valor debe ser inferior o igual a {if $preguntaedit.Pre_Estado == 0}{$puntos_maximo}{else}{$preguntaedit.Pre_Puntos+$puntos_maximo}{/if}" placeholder="Puntos" class="form-control" name="puntos" id="puntos" type="number" min="0" max="{if $preguntaedit.Pre_Estado == 0}{$puntos_maximo}{else}{$preguntaedit.Pre_Puntos+$puntos_maximo}{/if}" value="{$preguntaedit.Pre_Puntos}"/>
               </div>
               <br>
              <input type="hidden" class="form-control" name="contador" id="contador" value="{$nextinput-1}"/>
            <div class="col-sm-10">
              <label class="margin-top-10" style="margin-top:10px;">Alternativas</label>
            </div>
            <div class="col-sm-2">
              <label class="margin-top-10" style="margin-top:10px;">Correcto</label>
            </div>

            <div id="alt">
                <input type="hidden" class="form-control" name="nextinput" id="nextinput" value="{$nextinput}"/>
                {$i=1}
                {foreach item=rl from=$alternativas}
                <div>
                    <div class="col-sm-10"><input placeholder="Alternativa" class="form-control margin-top-10" name="alt{$i}" id="inPreg{$i}" style="margin-top:10px;" value="{$rl.Alt_Etiqueta}" type="text"/></div>
                    <div class="col-sm-1"><input type="radio" value="{$i}" class="radioalt margin-top-10" name="valor_preg" style="margin-top:10px;" {if $preguntaedit.Pre_Valor==$i}checked{/if}/></div>
                    {if $i>2}
                    <div class='col-sm-1'>
                      <a href='javascript:void(0);' data-toggle='tooltip' data-placement='right' title='Eliminar alternativa' class='remove_button btn btn-danger pull-right margin-top-10 '><i class='glyphicon glyphicon-minus'></i></a>
                    </div>
                    {/if}
                </div>
                    {$i=$i+1}
                {/foreach}
            </div>
            <div class="col col-sm-12" style="margin-top: 15px">
                <div class="col-sm-10">
                  <a data-toggle="tooltip" data-placement="bottom" title="Cancelar registro" href="{$_layoutParams.root}elearning/examen/preguntas/{$idcurso}/{$examen}" class="btn btn-danger">Cancelar</a>
                
                  <button data-toggle="tooltip" data-placement="bottom" title="Guardar cambios" class="btn btn-success margin-top-10" name="btn_registrar_pregunta" id="btn_registrar_pregunta">Guardar</button>
                </div>
                <div class="col-sm-2">
                   <a data-toggle="tooltip" data-placement="bottom" title="Agregar alternativa" class="btn btn-primary margin-top-10 glyphicon glyphicon-plus" id="btn_añadir1"></a>
                </div>
            </div>
        </form>
        </div>
    </div>
</div>
                                                                                                                                                                                                                                    