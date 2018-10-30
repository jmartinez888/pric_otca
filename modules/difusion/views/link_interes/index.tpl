{extends 'difusion_frontend.tpl'}
{block 'css' append}
<style type="text/css">
    span.params-label:nth-child(n+2) {
        margin-left: 2px;
    }

</style>
{/block}
{block 'subcontenido'}
{* <div class="container-fluid"> *}
    <div class="row">
        <div class="col-sm-12">
            <h2 class="titulo">{$titulo}</h2>
            <hr class="cursos-hr-title-foro">
        </div>
    </div>
{* </div> *}
<div class="row" id="vue_container">
    <div class="col-sm-12" style="text-align:right">
        <div id="botones" class="btn-group pull-right">
            <button type="button" @click="onSubmit_export('excel')" id="export_data_excel" name="export_data_excel" class="btn btn-info">EXCEL</button>
            <button type="button" @click="onSubmit_export('csv')"  id="export_data_csv" name="export_data_csv" class="btn btn-info">CSV</button>
            <button type="button" @click="onSubmit_export('pdf')"  id="export_data_pdf" name="export_data_pdf" class="btn btn-info">PDF</button>
        </div>

    </div>
    <div class="col-sm-12" style="margin-top: 8px">
        <div class="row">

            <div class="col-sm-6" >
                    <form @submit.prevent="onSubmit_filtrarTematica" class="pull-left">
                        <div style="display:inline-block;padding-right:2em">
                            <input class="form-control" placeholder="{$lenguaje['str_buscar']}" style="width: 150px; float: left; margin-right: 4px;" v-model="buscar">
                            <button class="btn btn-success" style=" float: left" type="submit" id="buscar"><i class="glyphicon glyphicon-search"></i></button>

                        </div>
                        <!-- <p style="direction: rtl"><a class="btn btn-primary" href="http://local.github/pric_otca/es/acl/index/nuevo_role"><i class="glyphicon glyphicon-plus-sign"></i> Agregar</a> </p> -->
                    </form>
            </div>
            <div class="col-sm-6">
                <a href="{$_layoutParams.root}difusion/{$ruta}/create" class="btn btn-success pull-right" style=" float: left" type="button" id="">{$lenguaje['str_nuevo']}</a>
            </div>
        </div>
    </div>
    <div class="col-sm-12">

        <table class="table" id="tbl_datatable" width="100%">
            <thead>
                <tr>
                    <th class="text-center">{$lenguaje['str_titulo']}</th>
                    <th class="text-center">{$lenguaje['str_descripcion']}</th>
                    <th class="text-center">Url</th>
                    <th class="text-center">{$lenguaje['str_estado']}</th>
                    <th class="text-center" width="200">{$lenguaje['str_opciones']}</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>

</div>

{/block}
{block 'template'}
<template id="">

</template>
<template id="botones_test">
    <a target="_blank" data-toggle="tooltip" data-placement="bottom" class="btn btn-default  btn-sm glyphicon glyphicon-eye-open" title="" href="{literal}{{url}}{/literal}" data-original-title="{$lenguaje['str_ver_elemento']}"></a>
    <button data-toggle="tooltip" data-placement="bottom" data-accion="estado" class="btn btn-default btn-sm glyphicon glyphicon-refresh btn-acciones"  data-estado="{literal}{{estado}}{/literal}" data-id="{literal}{{id}}{/literal}"  data-nombre="{literal}{{nombre}}{/literal}"  title="{$lenguaje['str_cambiar_estado']}"> </button>
    <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-acciones btn-sm glyphicon glyphicon-edit" title="{$lenguaje['str_editar']}" href="{$_layoutParams.root}difusion/link_interes/{literal}{{id}}{/literal}/edit"></a>
    <button data-toggle="tooltip" data-id="{literal}{{id}}{/literal}"  data-accion="eliminar" class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-rol btn-acciones" data-nombre="{literal}{{nombre}}{/literal}" title="{$lenguaje['str_eliminar']}" data-placement="bottom"> </button>
</template>
{/block}
{block 'js' append}
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}//assets/js/datatable_utils.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript">
    {if isset($zone)}
    var zone_datatable = {$zone};
    {else}
    var zone_datatable = 0;
    {/if}
</script>
<script type="text/javascript" src="{$_layoutParams.rutas.js}index.js"></script>
{* <script type="text/javascript" src="{BASE_URL}modules/difusion/views/contenido/js/index.js"></script> *}
{/block}