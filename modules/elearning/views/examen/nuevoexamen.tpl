{include file='modules/elearning/views/cursos/menu/lateral.tpl'}
<div class="col-lg-9">
<div class="col-lg-12">
    <div class="col-lg-12">
  <div class=" " style="margin-bottom: 0px !important">
    <div class="text-center text-bold" style="margin-top: 20px; margin-bottom: 20px; color: #267161;">
      <h3 style="text-transform: uppercase; margin: 0; font-weight: bold;">
        Titulo de Nuevo curso mooc
                </h3>
    </div>
  </div>
</div>
        <h3>Nuevo Examen</h3>
        <hr class="cursos-hr">
    </div>
   <div style="width: 100%; margin: 0px auto">
    <form class="form-horizontal" autocomplete="on" method="POST">
        <input type="hidden" value="1" name="enviar" />
        <input type="hidden" name="idcurso" id="idcurso" value="{$idcurso}">
        <input type="hidden" name="hidden_curso" id="hidden_curso" value="{$idcurso}">
       
        <div class="form-group">
                
            <label class="col-lg-3 control-label">Título: </label>
            <div class="col-lg-9">
                <p><input class="form-control" id ="titulo" type="text" name="titulo" value="{$datos.nombre|default:""}" placeholder="Título"/></p>
            </div>
        </div>

        <div class="form-group">
            <label class="col-lg-3 control-label" >Módulo: </label>
            <div class="col-lg-9">
                <p>
                  <select class="form-control" id="selectmodulo" name="selectmodulo">
                    {if isset($modulos) && count($modulos)}
                    <option value="0">Seleccione módulo</option>
                    {foreach item=ll from=$modulos}
                        <option value="{$ll.Moc_IdModuloCurso}">{$ll.Moc_Titulo}</option>
                    {/foreach}
                    {/if}
                  </select>
                </p>
            </div>
        </div>

        <div id="completar">

        </div>
        <div class="form-group">
            <div class="col-lg-offset-2 col-lg-10">
             <button class="btn btn-success pull-right margin-top-10" id="guardar" name="guardar">Preparar preguntas</button>
            </div>
        </div>
    </form>
</div>
</div>
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

