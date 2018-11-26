{extends 'template.tpl'}

{block 'contenido'}
<div id="container_vue" class="hidden">
    <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
        <h4 class="titulo-view">{lenguaje v='idiomas_lenguajes_titulo'}</h4>
    </div>
     <div class="panel panel-default">
                <div class="panel-heading jsoftCollap">
                    <h3 aria-expanded="true" data-toggle="collapse" href="#collapse_registro" class="panel-title collapsed"><i class="glyphicon glyphicon-edit"></i>&nbsp;&nbsp;<strong v-if="edit == false">{lenguaje v='str_nuevo'}</strong><strong v-else>{lenguaje v='str_editar'}</strong></h3>
                </div>
                <div style="height: 0px;" aria-expanded="false" id="collapse_registro" class="panel-collapse collapse">
                    <div id="nuevo_rol" class="panel-body" style="">
                        <div class="col-sm-8">
                            <form class="form-horizontal" data-toggle="validator"  role="form" @submit.prevent="onSubmit_registrar" novalidate="true">

                                <div class="form-group">
                                    <label class="col-lg-2 control-label" for="nombre">{$lenguaje['str_nombre']} : </label>
                                    <div class="col-lg-10">
                                        <input type="text" name="" id="nombre" class="form-control" value="" required="required" v-model="nombre">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-2 control-label" for="descripcion">{$lenguaje['str_descripcion']} : </label>
                                    <div class="col-lg-10">
                                        <textarea name="" id="descripcion" class="form-control" rows="2" v-model="descripcion"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-lg-offset-2 col-lg-10">
                                        <button class="btn btn-success" type="submit" id="bt_guardarRol" name="bt_guardarRol" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje['str_guardar']}</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
    <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;<strong>{lenguaje v='idiomas_lenguajes_lista_ficheros'}</strong>
                    </h3>
                </div>
                <div class="panel-body" style=" margin: 15px">
                    <div class="row" id="vue_container">
                        {* <div class="col-sm-12" style="text-align:right">
                            <div id="botones" class="btn-group pull-right">
                                <button type="button" @click="onSubmit_export('excel')" id="export_data_excel" name="export_data_excel" class="btn btn-info">EXCEL</button>
                                <button type="button" @click="onSubmit_export('csv')"  id="export_data_csv" name="export_data_csv" class="btn btn-info">CSV</button>
                                <button type="button" @click="onSubmit_export('pdf')"  id="export_data_pdf" name="export_data_pdf" class="btn btn-info">PDF</button>
                            </div>

                        </div> *}
                        <div class="col-sm-12" style="margin-top: 8px">
                            <div class="row">

                                <div class="col-sm-6" >
                                        <form @submit.prevent="onSubmit_filtrarDatatable" class="pull-left">
                                            <div style="display:inline-block;padding-right:2em">
                                                <input class="form-control" placeholder="{$lenguaje['str_buscar']}" style="width: 150px; float: left; margin-right: 4px;" v-model="buscar">
                                                <button class="btn btn-success" style=" float: left" type="submit" id="buscar"><i class="glyphicon glyphicon-search"></i></button>

                                            </div>
                                            <!-- <p style="direction: rtl"><a class="btn btn-primary" href="http://local.github/pric_otca/es/acl/index/nuevo_role"><i class="glyphicon glyphicon-plus-sign"></i> Agregar</a> </p> -->
                                        </form>
                                </div>
                                <div class="col-sm-6">
                                    <button @click.prevent="onClick_generateFiles" class="btn btn-success pull-right" style=" float: left" type="button" id="">{lenguaje v='idiomas_lenguajes_generar_fichero_global'}</button>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">

                            <table class="table" id="tbl_datatable" width="100%">
                                <thead>
                                    <tr>
                                        <th class="text-center">{$lenguaje['str_titulo']}</th>
                                        <th class="text-center">{$lenguaje['str_descripcion']}</th>
                                        <th class="text-center">{$lenguaje['str_opciones']}</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>

                    </div>
                </div>
    </div>
</div>
{/block}
{block 'template'}
<template id="botones_opcion">
    <a  data-toggle="tooltip" data-placement="bottom" class="btn btn-default  btn-sm glyphicon glyphicon-list-alt" title="" href="{$_layoutParams.root}idiomas/lenguajes/{literal}{{id}}{/literal}" data-original-title="{$lenguaje['str_ver_elemento']}"></a>
    {* <button data-toggle="tooltip" data-placement="bottom" data-accion="estado" class="btn btn-default btn-sm glyphicon glyphicon-refresh btn-acciones"  data-estado="{literal}{{estado}}{/literal}" data-id="{literal}{{id}}{/literal}"  data-nombre="{literal}{{nombre}}{/literal}"  title="{$lenguaje['str_cambiar_estado']}"> </button> *}
    <a target="_blank" href="{$_layoutParams.root}idiomas/lenguaje/{literal}{{id}}{/literal}?import=sql" data-toggle="tooltip" data-placement="bottom" data-id="{literal}{{id}}{/literal}" data-accion="exportar" class="btn btn-default  btn-sm btn-acciones glyphicon glyphicon-import" title="Importar SQL"></a><a  href="{$_layoutParams.root}idiomas/lenguajes/{literal}{{id}}{/literal}?export=json_export" data-toggle="tooltip" data-placement="bottom" data-id="{literal}{{id}}{/literal}" data-accion="exportar" class="btn btn-default  btn-sm btn-acciones glyphicon glyphicon-export" title="Exportar SQL"></a>
    <button data-toggle="tooltip" data-placement="bottom" data-id="{literal}{{id}}{/literal}" data-accion="editar" class="btn btn-default  btn-sm btn-acciones glyphicon glyphicon-edit" title="{$lenguaje['str_editar']}"></button>
    <button data-toggle="tooltip" data-id="{literal}{{id}}{/literal}"  data-accion="eliminar" class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-rol btn-acciones" data-nombre="{literal}{{nombre}}{/literal}" title="{$lenguaje['str_eliminar']}" data-placement="bottom"> </button>
</template>
{/block}
{block 'js' append}
<script src="{BASE_URL}public/js/axios/dist/axios.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/vuejs/vue.min.js" type="text/javascript"></script>
<script src="{BASE_URL}public/js/moment/moment.js" type="text/javascript"></script>
<script src="{BASE_URL}public/vendors/autosize/autosize.js" type="text/javascript"></script>
<script>moment.locale('{Cookie::lenguaje()}')</script>
<script src="{BASE_URL}public/js/mustache/mustache.min.js" type="text/javascript"></script>
<script src="{BASE_URL|cat:Cookie::lenguaje()}/assets/js/datatables_lang.js" type="text/javascript"></script>
<script type="text/javascript" src="{BASE_URL}public/js/datatable/datatables.min.js"></script>
<script type="text/javascript" src="{$_layoutParams.rutas.js}index.js"></script>
{/block}