{extends file='template.tpl'}
{block "contenido"}
    <div class="container-fluid" id="tematica_vue">
        <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
            <h4 style="width: 80%;  margin: 0px auto; text-align: center;">{$lenguaje.foro_admin_tematica_titulo_registro}</h4>
        </div>
        <div class="panel panel-default">
            <div class="panel-heading jsoftCollap">
                <h3 aria-expanded="true" data-toggle="collapse" href="#collapse3" class="panel-title collapsed"><i style="float:right" class="fa fa-ellipsis-v"></i><i class="fa fa-user-secret"></i>&nbsp;&nbsp;<strong>{$lenguaje['foro_admin_tematica_index_panel_nuevo']}</strong></h3>
            </div>

            <div style="height: 0px;" aria-expanded="false" id="collapse3" class="panel-collapse collapse">
                <div id="nuevo_rol" class="panel-body" style="">
                    <div class="col-sm-8">
                        <form class="form-horizontal" data-toggle="validator"  role="form" @submit.prevent="onSubmit_registrarTematica" novalidate="true">
                            <div class="form-group">
                                <label class="col-lg-2 control-label" >{$lenguaje['str_idioma']} : </label>
                                <div class="col-lg-10">
                                    <div class="checkbox">
                                        {foreach $idiomas as $item}
                                            <label>

                                                {if $item->Idi_IdIdioma == Cookie::lenguaje()}
                                                <input type="radio" name="radio_idioma" value="{$item->Idi_IdIdioma}"  checked="" v-model="idioma_actual">
                                                {else}
                                                <input type="radio" name="radio_idioma" value="{$item->Idi_IdIdioma}" v-model="idioma_actual">
                                                {/if}
                                                {$item->Idi_Idioma}
                                            </label>
                                        {/foreach}

                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label" for="nombre_tematica">{$lenguaje['str_nombre']} : </label>
                                <div class="col-lg-10">
                                    {foreach $idiomas as $item}
                                    <input v-if="idioma_actual == '{$item->Idi_IdIdioma}'" class="form-control" id="nombre_tematica" type="text" name="nombre_tematica" placeholder="{$lenguaje['foro_admin_tematica_index_inp_nombre_ph']}" required="" v-model="idiomas.idioma_{$item->Idi_IdIdioma}.tematica">
                                    {/foreach}
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label" for="descripcion_tematica">{$lenguaje['str_descripcion']} : </label>
                                <div class="col-lg-10">
                                    {foreach $idiomas as $item}
                                    <textarea v-if="idioma_actual == '{$item->Idi_IdIdioma}'" rows="2" class="form-control" id="descripcion_tematica"  name="descripcion_tematica" placeholder="{$lenguaje['foro_admin_tematica_index_inp_descr_ph']}"  v-model="idiomas.idioma_{$item->Idi_IdIdioma}.descripcion"></textarea>
                                    {/foreach}
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-2 control-label">{$lenguaje['str_activo']} : </label>
                                <div class="col-lg-10">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" v-model="estado">
                                            {$lenguaje['str_activo']}
                                        </label>
                                    </div>
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
                <h3 class="panel-title"><i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;<strong>{$lenguaje['foro_admin_tematica_index_panel_buscar']}</strong>
                </h3>
            </div>
            <div class="panel-body" style=" margin: 15px">
                <div class="row" style="text-align:right">
                    <!-- <form method="POST" @submit.prevent="onSubmit_exportTematica"> -->
                        <div class="well-sm col-sm-12">
                            <div id="botones" class="btn-group pull-right">
                                <button type="button" @click="onSubmit_exportTematica('excel')" id="export_data_excel" name="export_data_excel" class="btn btn-info">EXCEL</button>
                                <button type="button" @click="onSubmit_exportTematica('csv')"  id="export_data_csv" name="export_data_csv" class="btn btn-info">CSV</button>
                                <button type="button" @click="onSubmit_exportTematica('pdf')"  id="export_data_pdf" name="export_data_pdf" class="btn btn-info">PDF</button>
                            </div>
                        </div>
                    <!-- </form> -->
                    <form @submit.prevent="onSubmit_filtrarTematica">
                        <div style="display:inline-block;padding-right:2em">
                            <input class="form-control" placeholder="Buscar Rol" style="width: 150px; float: left; margin: 0px 10px;" name="palabraRol" id="palabraRol" v-model="buscar_tematica">
                            <button class="btn btn-success" style=" float: left" type="button" id="buscar"><i class="glyphicon glyphicon-search"></i></button>
                        </div>
                        <!-- <p style="direction: rtl"><a class="btn btn-primary" href="http://local.github/pric_otca/es/acl/index/nuevo_role"><i class="glyphicon glyphicon-plus-sign"></i> Agregar</a> </p> -->
                    </form>
                </div>
                <h4 class="panel-title"> <b>{$lenguaje['foro_admin_tematica_index_table_titulo']}</b></h4>
                <div id="listarRoles">

                    <table class="table" id="tbl_tematica">

                        <thead>
                            <tr>
                                <th>{$lenguaje['foro_admin_tematica_index_table_th_tematica']}</th>
                                <th style=" text-align: center">{$lenguaje['str_descripcion']}</th>
                                <th style=" text-align: left">{$lenguaje['str_estado']}</th>
                                <th style=" text-align: center" width="200">{$lenguaje['str_opciones']}</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="modal " id="mod_eliminar_tematica" tabindex="-1" role="dialog" aria-labelledby="elimina_tematica" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4 class="modal-title" id="elimina_tematica">{$lenguaje['str_eliminar_titulo']}</h4>
                </div>
                <div class="modal-body">
                    <p>{$lenguaje['str_eliminar_pregunta']}</p>
                    <p>{$lenguaje['str_eliminar_continuar']}</p>
                    <p>{$lenguaje['str_eliminar']} : <strong  class="nombre-es">{$lenguaje['str_tematica']}</strong></p>
                    <label id="texto_" name='texto_'>{literal}{{ tematica_nombre }}{/literal}</label>
                    <!-- <input type='text' class='form-control' name='codigo' id='validate-number' placeholder='Codigo' required> -->
                </div>
                <div class="modal-footer">
                    <form @submit.prevent="onSubmit_eliminarTematica" id="frm_eliminar_tematica">
                        <!-- <input type="hidden" name="" v-model="tematica_id"> -->
                        <button type="button" class="btn btn-default" data-dismiss="modal">{$lenguaje['str_cancelar']}</button>
                        <button type="submit" style="cursor:pointer"   class="btn btn-danger danger eliminar_rol">{$lenguaje['str_eliminar']}</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
    </div>
{/block}
{block 'template'}
    <template id="botones_test">
        <button data-toggle="tooltip" data-placement="bottom" data-accion="estado" class="btn btn-default btn-sm glyphicon glyphicon-refresh estado-rol btn-acciones"  data-estado="{literal} {{estado}} {/literal}" data-id="{literal} {{id}} {/literal}"  title="{$lenguaje['str_cambiar_estado']}"> </button>
        <a data-toggle="tooltip" data-placement="bottom" class="btn btn-default btn-acciones btn-sm glyphicon glyphicon-edit" title="{$lenguaje['str_editar']}" href="{literal} {{url}} {/literal}"></a>
        <button data-toggle="tooltip" data-id="{literal} {{id}} {/literal}"  data-accion="eliminar" class="btn btn-default btn-sm  glyphicon glyphicon-trash confirmar-eliminar-rol btn-acciones" data-nombre="{literal} {{nombre}} {/literal}" title="{$lenguaje['str_eliminar']}" data-placement="bottom"> </button>
    </template>
{/block}

{block "js"}
    <script src="{BASE_URL}public/vendors/autosize/autosize.min.js" type="text/javascript"></script>
    <script>
        var data_vue = {$data_vue};
    </script>
{/block}
<!-- {block "template"}
{/block} -->