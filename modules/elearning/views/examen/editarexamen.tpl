{extends 'template.tpl'}
{block 'contenido'}
{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<input type="hidden" id="IdiomaOriginal" value="{$IdiomaOriginal}"/>

        <div class="col-xs-12 col-sm-12 col-md-9 col-lg-10">
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
                <h3>{$lenguaje["elearning_label_editexam"]}</h3>
                <hr class="cursos-hr">
            </div>
            <div class=" col-xs-12">
                <div id="gestion_idiomas">
                {if isset($curso)}
                    {if  isset($idiomas) && count($idiomas)}
                        <ul class="nav nav-tabs " role="tablist">
                        {foreach from=$idiomas item=idi}
                            <li role="presentation" class="{if $examen.Idi_IdIdioma==$idi.Idi_IdIdioma} active {/if}">
                                <a class="idioma_s" id="idioma_{$idi.Idi_IdIdioma}" href="#" role="tab" data-toggle="tab">{$idi.Idi_Idioma}</a>
                                <input type="hidden" id="hd_idioma_{$idi.Idi_IdIdioma}" value="{$idi.Idi_IdIdioma}" />
                                <input type="hidden" id="idiomaTradu" value="{$curso.Idi_IdIdioma}"/>
                            </li>    
                        {/foreach}
                        </ul>
                    {/if}
                    <div id="replace_contenido">
                        {include 'editarexamen_gestion_idioma.tpl'}
                    </div>
                {/if}
                </div>
            </div>
        </div>
        
    

{/block}

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

