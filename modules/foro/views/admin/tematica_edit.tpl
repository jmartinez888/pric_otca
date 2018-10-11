{extends 'template.tpl'}
{block 'contenido'}
    <div class="container-fluid" id="tematica_edit_vue">
        {if $mostrar_contenido == false}
            <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
                <h4 style="width: 80%;  margin: 0px auto; text-align: center;">TEMÁTICA NO ENCONTRADA </h4>
            </div>
        {else}
            <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
                <h4 style="width: 80%;  margin: 0px auto; text-align: center;">TEMÁTICA FORO </h4>
            </div>

            <div>

              <!-- Nav tabs -->
              <ul class="nav nav-tabs" role="tablist">
                {foreach $idiomas as $item}
                    {if $item@first}
                        <li role="presentation" class="active"><a href="#{$item->Idi_IdIdioma}" aria-controls="{$item->Idi_IdIdioma}" role="tab" data-toggle="tab">{$item->Idi_Idioma}</a></li>
                    {else}
                        <li role="presentation"><a href="#{$item->Idi_IdIdioma}" aria-controls="{$item->Idi_IdIdioma}" role="tab" data-toggle="tab">{$item->Idi_Idioma}</a></li>
                    {/if}

                {/foreach}
              </ul>

              <!-- Tab panes -->


            </div>
            <div class="panel panel-default">
                <div class="panel-heading ">
                  <h3 class="panel-title"><strong>EDITAR TEMÁTICA</strong></h3>
                </div>
                <div class="panel-body">
                    <form class="form-horizontal" data-toggle="validator"  role="form" @submit.prevent="onSubmit_actualizarTematica" novalidate="true">

                        <div class="tab-content">
                            {foreach $idiomas as $item}
                                {if $item@first}
                                <div role="tabpanel" class="tab-pane active" id="{$item->Idi_IdIdioma}">
                                {else}
                                <div role="tabpanel" class="tab-pane" id="{$item->Idi_IdIdioma}">
                                {/if}
                                        <div class="form-group">
                                            <label class="col-lg-2 control-label" for="nombre_tematica">Nombre : </label>
                                            <div class="col-lg-10">
                                                <input class="form-control" id="nombre_tematica" type="text" name="nombre_tematica" placeholder="Nombre temática {$item->Idi_IdIdioma}" required="" v-model="idiomas.idioma_{$item->Idi_IdIdioma}.tematica">
                                            </div>
                                        </div>

                                         <div class="form-group">
                                            <label class="col-lg-2 control-label" for="nombre_tematica_{$item->Idi_IdIdioma}">Descripcion : </label>
                                            <div class="col-lg-10">

                                                <textarea  rows="2" class="form-control" id="nombre_tematica_{$item->Idi_IdIdioma}"  name="nombre_tematica" placeholder="Descripción temática"  v-model="idiomas.idioma_{$item->Idi_IdIdioma}.descripcion"></textarea>

                                            </div>
                                        </div>

                                </div>
                            {/foreach}
                            <div class="form-group">
                                <label class="col-lg-2 control-label">Estado : </label>
                                <div class="col-lg-10">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" v-model="estado">
                                            Activo
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-lg-offset-2 col-lg-10">
                                <button class="btn btn-success" type="submit" id="bt_guardarRol" name="bt_guardarRol" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; Guardar</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        {/if}
    </div>
{/block}

{block js}
    <script>
        var data_vue = {$data_vue};
    </script>
{/block}