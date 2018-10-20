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
<div class="row" id="difusion_cifras">
    <div class="col-sm-12" style="text-align:right">
        <!-- <form method="POST" @submit.prevent="onSubmit_export"> -->
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
                            <button class="btn btn-success" style=" float: left" type="button" id="buscar"><i class="glyphicon glyphicon-search"></i></button>

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
        <table class="table" id="tbl_difusion" width="100%">
            <thead>
                <tr>
                    <th style="text-align: left">{$lenguaje['str_descripcion']}</th>
                    <th style="text-align: center">{$lenguaje['str_indicador']}</th>
                    <th style="text-align: right;">{$lenguaje['str_latitud']}</th>
                    <th style="text-align: right">{$lenguaje['str_longitud']}</th>
                    <th style="text-align: center">{$lenguaje['str_estado']}</th>
                    <th style="text-align: center" width="200">{$lenguaje['str_opciones']}</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
    <div class="modal fade" id="mod_estado" tabindex="-1" role="dialog" aria-labelledby="mod_estado">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Estado</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" data-toggle="validator"  role="form" @submit.prevent="onSubmit_actualizar_attr" novalidate="true" id="actualizar_attr">
                        <div class="form-group">
                            <label class="col-lg-2 control-label">{$lenguaje['str_idioma']} : </label>
                            <div class="col-lg-10">
                                <div class="checkbox">
                                    <label>
                                        <input type="checkbox" name="rad_estado"   v-model="editar_attr.estado">&nbsp;Estadon&nbsp;
                                    </label>
                                    <label>
                                        <input type="checkbox" name="rad_datos"   v-model="editar_attr.datos">&nbsp;Datos&nbsp;
                                    </label>
                                    <label>
                                        <input type="checkbox" name="rad_evento"   v-model="editar_attr.evento">&nbsp;Evento&nbsp;
                                    </label>
                                    <label>
                                        <input type="checkbox" name="rad_banner"   v-model="editar_attr.banner">&nbsp;Banner&nbsp;
                                    </label>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                    <button type="submit" form="actualizar_attr" class="btn btn-primary">Guardar</button>
                </div>
            </div>
        </div>
    </div>
</div>

{/block}
{block 'template'}
<template id="botones_test">
    <a target="_blank" data-toggle="tooltip" data-placement="bottom" class="btn btn-default  btn-sm glyphicon glyphicon-eye-open" title="" href="{$_layoutParams.root}difusion/contenido/{literal}{{id}}{/literal}" data-original-title="Ver Ficha "></a>
    <button data-toggle="tooltip" data-placement="bottom" data-accion="estado" class="btn btn-default btn-sm glyphicon glyphicon-refresh btn-acciones"  data-estado="{literal}{{estado}}{/literal}" data-id="{literal}{{id}}{/literal}"  data-nombre="{literal}{{nombre}}{/literal}"  title="{$lenguaje['str_cambiar_estado']}"> </button>
    <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-acciones btn-sm glyphicon glyphicon-edit" title="{$lenguaje['str_editar']}" href="{literal} {{url}} {/literal}"></a>
    <button data-toggle="tooltip" data-id="{literal} {{id}} {/literal}"  data-accion="eliminar" class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-rol btn-acciones" data-nombre="{literal}{{nombre}}{/literal}" title="{$lenguaje['str_eliminar']}" data-placement="bottom"> </button>
</template>
{/block}
{block 'js' append}
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
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