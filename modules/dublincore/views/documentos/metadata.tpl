<style>
#raizaMenu {
   padding-top: 10px;
}
@media (min-width: 1200px){
  #raizaMenu {
     margin-left: 8.33333333%;
  }
}
@media(max-width: 991px){
  #raizaMenu ul{
      height: 30px !important;
  }
}
#raizaMenu ul{
   list-style: none;
   width: 100%;
    height: 30px;
      padding: 0px 10px;
}
#raizaMenu li{
   top: 3px;
   margin: 0px 2px;
   float: left;
}
#raizaMenu li .actual{
  color: #444f4a;
}
#raizaMenu a{
   margin: 0px 3px;
   color: #03a506;
}

</style>

<!-- <div id="raizaMenu" clas="col-xs-3 col-sm-3 col-md-2 col-lg-2">
  <ul clas="col-xs-3 col-sm-3 col-md-2 col-lg-2">
    <li>
      <a href="{$_layoutParams.root_clear}">{$lenguaje["label_inicio"]} </a>
    </li>
    <li>/</li>
    <li>
      <a href="{$_layoutParams.root_clear}dublincore/documentos">{$lenguaje["label_h2_titulo_documentos"]} </a>
    </li>
    <li>/</li>
    <li>
      <a class='actual' >{$lenguaje["label_h2_metadata_titulo"]} </a>
    </li>
  </ul>
</div> -->


<div class="container col-lg-12">
    <div class="row-fluid">
    <div class="col-md-12 p-rt-lt-0">
        <center>
            <h2 class="titulo2">
                {$lenguaje["label_h2_metadata_titulo"]}
            </h2>
        </center>
        <div class="col-lg-12 p-rt-lt-0">
            <hr class="cursos-hr">
        </div>
    </div>
    <div class="col-xs-12 col-sm-4 col-md-4 col-lg-4" style="padding-left: 0px; margin-bottom: 15px;">
            <div class="" id="accordion">
                <div class="">
                    <div class="">
                        <h3 class="">
                            {$lenguaje["label_recurso_bdrecursos"]}
                        </h3>
                        <div class="col-lg-12 p-rt-lt-0">
                            <hr class="cursos-hr">
                        </div>
                    </div>
                    <div class="panel-body">
                        <table class="table table-user-information">
                            <tbody>
                                <tr>
                                    <td colspan="2">{$recurso.Rec_Nombre}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["label_tipo_bdrecursos"]}</td>
                                    <td>{$recurso.Tir_Nombre}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["label_estandar_bdrecursos"]}</td>
                                    <td>{$recurso.Esr_Nombre}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["label_fuente_bdrecursos"]}</td>
                                    <td>{$recurso.Rec_Fuente}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["label_origen_bdrecursos"]}</td>
                                    <td>{$recurso.Rec_Origen}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["registros_bdrecursos"]}</td>
                                    <td>{$recurso.Rec_CantidadRegistros}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["herramienta_utilizada_bdrecursos"]}</td>
                                    <td>
                                        {if isset($recurso.herramientas)}
                                            <ul>
                                                {foreach item=herramienta from=$recurso.herramientas}
                                                    <li>
                                                        {$herramienta.Her_Nombre}
                                                    </li>
                                                {/foreach}
                                            </ul>
                                        {/if}
                                    </td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["registro_bdrecursos"]}</td>
                                    <td>{$recurso.Rec_FechaRegistro|date_format:"%d/%m/%y"}</td>
                                </tr>
                                <tr>
                                    <td>{$lenguaje["modificacion_bdrecursos"]}</td>
                                    <td>{$recurso.Rec_UltimaModificacion|date_format:"%d/%m/%y"}</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>


        <div class="col-xs-12 col-sm-8 col-md-offset-0 col-md-9 col-lg-offset-0 col-lg-8" style="border-left: 1px solid #ddd; margin-bottom: 15px; padding-right: 0px;">

        {foreach item=datos from=$detalle}
                    <div class="">
                        <h3 class="">
                            {$lenguaje["detalle_metadata_documentos"]}
                        </h3>
                        <div class="col-lg-12 p-rt-lt-0">
                            <hr class="cursos-hr">
                        </div>
                    </div>
<div class="">
        <div class="panel-body">
        <table class="">
            <tbody>
                    <!-- <tr>
                        <td class="col-md-3" style="vertical-align:middle; text-align:center; background-color: rgb(249, 249, 249);"><b>{$lenguaje["detalle_metadata_documentos"]}</b></td>
                        <td class="col-md-9" style="padding:0;border: 0;">
 -->
                            <table class="table table-user-information" style="margin:0;border:0;">
                                <tbody>
                                       <tr>
                                            <td class="col-md-3" style="border: none;">
                                                <b>{$lenguaje["tabla_campo_titulo"]}</b>
                                                <td style="border: none;">:
                                                    <td class="col-md-9" style="border: none;">{$datos.Dub_Titulo}
                                        <tr>
                                            <td class="col-md-3">
                                                <b>{$lenguaje["tabla_campo_descripcion_documentos"]}</b>
                                                <td >:<td class="col-md-9 text-justify">{$datos.Dub_Descripcion}
                                        <tr>
                                            <td class="col-md-3">
                                                <b>{$lenguaje["autores_metadata_documentos"]}</b>
                                                <td >:
                                                    <td class="col-md-9">{$datos.Aut_Nombre}
                                        <tr>
                                            <td class="col-md-3">
                                                <b>{$lenguaje["palabra_clave_documentos"]}</b>
                                                <td >:
                                                    <td class="col-md-9">{$datos.Dub_PalabraClave}
                                        <tr>
                                            <td class="col-md-3">
                                                <b>{$lenguaje["tema_metadata_documentos"]}</b>
                                                <td >:<td class="col-md-9">{$datos.Ted_Descripcion}
                                        <tr>
                                            <td class="col-md-3">
                                                <b>{$lenguaje["tipo_metadata_documentos"]}</b>
                                                <td >:<td class="col-md-9">{$datos.Tid_Descripcion}

                                        <tr>
                                            <td class="col-md-3">
                                                <b>{$lenguaje["fechadocumentos_metadata_documentos"]}</b>
                                                <td >:
                                                    <td class="col-md-9">{$datos.Dub_FechaDocumento|date_format:"%d/%m/%Y"}
                                        <tr>
                                            <td class="col-md-3">
                                                <b>Fecha Registro Dublincore</b>
                                                <td >:
                                                    <td class="col-md-9">{$datos.Arf_FechaRegistro|date_format:"%d/%m/%Y %H:%M:%S"}
                                        <tr>
                                            <td class="col-md-3">
                                                <b>{$lenguaje["tabla_campo_idiomas_documentos"]}</b>
                                                <td >:<td class="col-md-9">{$datos.Dub_Idioma}
                                        <tr>
                                            <td class="col-md-3">
                                                <b>{$lenguaje["tabla_campo_paises_documentos"]}</b>
                                                <td >:<td class="col-md-9">{$datos.Pai_Nombre}
                                        <tr>
                                            <td class="col-md-3">
                                                <b>{$lenguaje["nombrearchivo_metadata_documentos"]}</b>
                                                <td >:
                                                    <td class="col-md-9">
                                                    {$datos.Arf_PosicionFisica}
                                        <tr>
                                            <td class="col-md-3">
                                                <b>{$lenguaje["formato_metadata_documentos"]}</b>
                                                <td >:
                                                    <td class="col-md-9"><img src="{$_layoutParams.root_clear}public/img/documentos/{$datos.Taf_Descripcion}.png" pais="{$datos.Taf_Descripcion}"/> {$datos.Taf_Descripcion}
                                        <tr>
                                            <td class="col-md-3">
                                                <b>{$lenguaje["linkdescarga_metadata_documentos"]}</b>
                                                <td >:
                                                    <td class="col-md-9"><a href="{$_layoutParams.root_clear}dublincore/documentos/descargar/{$datos.Arf_PosicionFisica}/{$datos.Dub_IdDublinCore}" target="_blank"><span class="ha" style="cursor:pointer" title="{$lenguaje["icono_descargar_documentos"]} {$datos.Taf_Descripcion}"> <button type="button" id="btnBuscar" class="btn btn-success">$lang->get('icono_descargar_documentos')}.</button> </span></a>
                                </tbody>
                            </table>
                        </td>
            </tbody>
        </table>
        </div>
</div>
{/foreach}


        </div>






 </div>

</div>
