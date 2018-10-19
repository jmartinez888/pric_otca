{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-lg-10" style="margin-top: 20px">
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
    <div class="col-lg-12" >
        <div class="panel panel-default">
            <div class="panel-heading ">
                <h3 class="panel-title "><i style="float:right" class=" glyphicon glyphicon-option-vertical"></i><i class="glyphicon glyphicon-picture"></i>&nbsp;&nbsp;<strong>Plantilla Certificado</strong></h3>
            </div>
            <div id="nuevo_anuncio" class="panel-body" style="width: 90%; margin: 0px auto"> 
                <div class="form-group">
                    <a target="_blank" class="btn btn-success btn-certificado" style="margin-bottom: 10px" href="{BASE_URL}elearning/certificado/plantilla_certificado/{$idCurso}">
                    <strong><span class="glyphicon glyphicon-plus"></span>&nbsp; Crear Nueva Plantilla</strong>
                    </a>
                    <br>
                </div>
                {if isset($plantillas) && count($plantillas)}
                <label for="img">O Edite una plantilla ya existente:</label>
                <div class="row">
                    <div class="col-lg-12">
                        {$i=1}
                        {foreach item=p from=$plantillas}
                        <a href="{BASE_URL}elearning/certificado/plantilla_certificado_editar/{$p.Plc_IdPlantillaCertificado}">
                          <div class="col-lg-2 " style="cursor:pointer; padding:0px; margin-bottom:10px;">
                            <div class="col-lg-12">
                                <img  style="{if $p.Plc_Seleccionado==1} border: 2px blue solid;{/if} height:80px; " src="{$_layoutParams.root_clear}{$p.Plc_UrlImg}"  style="width:100%; height:auto;">
                            </div>
                            <div class="col-lg-12">
                                <center style="{if $p.Plc_Seleccionado==1} color: red;{/if}">Plantilla {$i}{$i=$i+1}</center>
                            </div>
                          </div>
                        </a>
                        {/foreach}
                    </div>
                </div>
                {/if}
            </div>   
        </div>
    </div>                              
</div>
