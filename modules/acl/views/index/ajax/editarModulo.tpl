<div  class="container-fluid" >
    <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
        <h4 style="width: 80%;  margin: 0px auto; text-align: center;">MÓDULOS DEL SISTEMA INTEGRADO</h4>
    </div>
    <div id='gestion_idiomas_rol'>
        {if  isset($idiomas) && count($idiomas)}
            <ul class="nav nav-tabs ">
            {foreach from=$idiomas item=idi}
                <li role="presentation" class="{if $datos.Idi_IdIdioma==$idi.Idi_IdIdioma} active {/if}">
                    <a class="idioma_s" id="idioma_{$idi.Idi_IdIdioma}" href="#">{$idi.Idi_Idioma}</a>
                    <input type="hidden" id="hd_idioma_{$idi.Idi_IdIdioma}" value="{$idi.Idi_IdIdioma}" />
                    <input type="hidden" id="idiomaTradu" value="{$datos.Idi_IdIdioma}"/>
                </li>    
            {/foreach}
            </ul>
        {/if}
        <div class="panel panel-default">
            <div class="panel-heading ">
                <h3 class="panel-title "><i style="float:right"class="fa fa-ellipsis-v"></i><i class="fa fa-user-secret"></i>&nbsp;&nbsp;<strong>Editar Módulo</strong></h3>
            </div>
            <div id="nuevo_rol" class="panel-body" style="width: 90%; margin: 0px auto">
                <form class="form-horizontal" data-toggle="validator" id="form3" role="form" name="form1" action="" method="post" >
                    <input type="hidden" id="Mod_IdModulo" name="Mod_IdModulo" value="{$datos.Mod_IdModulo}" />
                    <input type="hidden" id="idIdiomaSeleccionado" name="idIdiomaSeleccionado" value="{$datos.Idi_IdIdioma}" />
                    <div class="form-group">
                            <label class="col-lg-2 control-label">Módulo (*): </label>
                            <div class="col-lg-10">
                                <input  class="form-control" type="text" name="modulo_" id="modulo_" placeholder="Nombre de Módulo" required="" value="{$datos.Mod_Nombre}" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">Código (*): </label>
                            <div class="col-lg-10">
                                <input  class="form-control" type="text" name="codigo_" id="codigo_" placeholder="Código" required="" value="{$datos.Mod_Codigo}" />
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">Descripción (*): </label>
                            <div class="col-lg-10">
                                <input  class="form-control" type="text" name="descripcion_" id="descripcion_" placeholder="Descripción" required="" value="{$datos.Mod_Descripcion}" />
                            </div>
                        </div>
                    <div class="form-group">
                        <div class="col-xs-6 col-sm-2 col-lg-offset-2 col-lg-2">
                            <button class="btn btn-success" type="submit" id="bt_editarmodulo" name="bt_editarmodulo" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.button_ok}</button>
                        </div>
                        <div class="col-xs-6 col-sm-offset-1 col-sm-2 col-lg-2">
                            <button class="btn btn-danger" type="submit" id="bt_cancelarEditarmodulo" name="bt_cancelarEditarmodulo" ><i class="glyphicon glyphicon-remove"> </i>&nbsp; {$lenguaje.button_cancel}</button>
                        </div>
                    </div>
                </form>
            </div>    
        </div>
    </div>
</div>