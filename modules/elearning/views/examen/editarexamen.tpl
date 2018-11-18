{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-sm-9 col-md-10">
    <div class="col-xs-12">
      <div class="col-xs-12">
        <div class=" " style="margin-bottom: 0px !important">
          <div class="text-center text-bold" style="margin-top: 20px; margin-bottom: 20px; color: #267161;">
            <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
              {$titulo}
            </h3>
          </div>
        </div>
      </div>
        <h3>Editar Examen</h3>
        <hr class="cursos-hr">
    </div>
    <div class=" col-xs-12">
   <!-- <div style="width: 100%; margin: 0px auto"> -->
        <form class="form-horizontal" autocomplete="on" method="POST">
            <input type="hidden" value="1" name="enviar" />
            <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
            <input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">
           
            <div class="form-group">
                <label class="col-xs-3 control-label">Título: </label>
                <div class="col-xs-9 ">
                    <input class="form-control" id ="titulo" type="text" name="titulo" value="{$examen.Exa_Titulo|default:""}" placeholder="Título"/>
                </div>
            </div>
            <div class="form-group">
                <label class="col-xs-3 control-label" >Módulo: </label>
                <div class="col-xs-9">
                    <select class="form-control" id="selectmodulo" name="selectmodulo">
                        {if isset($modulos) && count($modulos)}
                        <option value="0">Seleccione módulo</option>
                        {foreach item=ll from=$modulos}
                            <option value="{$ll.Moc_IdModuloCurso}" {if $ll.Moc_IdModuloCurso == $examen.Moc_IdModulo} selected="selected" {/if}>{$ll.Moc_Titulo}</option>
                        {/foreach}
                        {/if}
                    </select>
                </div>
            </div>

            <div id="completar">
                {if isset($lecciones) && count($lecciones)}
                <div class="form-group">
                    <label class="col-xs-3 control-label" >Lección: </label>
                    <div class="col-xs-9">
                        <select class="form-control" id="selectleccion" name="selectleccion">
                            {foreach item=ll from=$lecciones}
                                <option value="{$ll.Lec_IdLeccion}" {if $examen.Lec_IdLeccion == $ll.Lec_IdLeccion} selected="selected" {/if}>{$ll.Lec_Titulo}</option>
                            {/foreach}
                        </select>
                    </div>
                </div>  
                <div class="form-group">
                    <label class="col-xs-3 control-label" >Porcentaje Global: </label>
                    <div class="col-xs-9">
                        <input data-toggle="tooltip" data-placement="bottom" title="El valor debe ser inferior o igual a {$porcentaje}" class="form-control" id ="porcentaje" type="number" name="porcentaje" value="{$examen.Exa_Porcentaje|default:'0'}" placeholder="Porcentaje" max="{$porcentaje}" min="0" value="0"/>
                    </div>
                </div>   
                <div class="form-group">
                    <label class="col-xs-3 control-label" >Puntaje Máximo: </label>
                    <div class="col-xs-9">
                        <p class="  margin-t-10"> <input type="radio" value="20" class="radioalt " name="puntaje" checked="checked" />  20</p>
                        <p class=" margin-t-10"> <input type="radio" value="100" class="radioalt " name="puntaje"/>
                         100</p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-xs-3 control-label" >Número Máximo de Intentos: </label>
                    <div class="col-xs-9">
                        <select class="form-control" id="intentos" name="intentos">
                            {if $examen.Lec_IdLeccion == $ll.Lec_IdLeccion} selected="selected" {/if}>{$ll.Lec_Titulo}
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
            </div>
            <div class="form-group">
                <div class="col-xs-offset-2 col-xs-9">
                    <button class="btn btn-success pull-right " id="guardarEdit" name="guardarEdit">Preparar preguntas</button>
                </div>
            </div>
        </form>
    </div>
</div>

<!-- <script type="text/javascript">
    Menu(1);
    RefreshTagUrl();
   $("#btn-guardar-examen").click(function(e){
  e.preventDefault();
  SubmitForm($("#frm_registro"), $(this), function(data, event){
    Mensaje("Exámen registrado con éxito", function(){
      CargarPagina("examen/preguntas", { id: $("#idcurso").val(), idleccion: $("#selectleccion").val()  }, false, false);
    })
  });
});

   $("body").on('change', "#selectmodulo", function () {      
        $("#cargando").show();
    $.post(_root_ + 'elearning/examen/actualizarlecciones',
    {
        id:$("#selectmodulo").val() 
        
    }, function (data) {
        $("#completar").html('');
        $("#cargando").hide();
        $("#completar").html(data);
    });
    });
</script> -->
