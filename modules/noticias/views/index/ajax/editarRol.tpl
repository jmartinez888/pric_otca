<div  class="container-fluid" >
    <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
        <h4 style="width: 80%;  margin: 0px auto; text-align: center;">{$lenguaje.roles_label_titulo}</h4>
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
                <h3 class="panel-title "><i style="float:right"class="fa fa-ellipsis-v"></i><i class="fa fa-user-secret"></i>&nbsp;&nbsp;<strong>{$lenguaje.tabla_opcion_editar_ROL}</strong></h3>
            </div>
            <div id="nuevo_rol" class="panel-body" style="width: 90%; margin: 0px auto">
                <form class="form-horizontal" data-toggle="validator" id="form3" role="form" name="form1" action="" method="post" >
                    <input type="hidden" id="Rol_IdRol" name="Rol_IdRol" value="{$datos.Rol_IdRol}" />
                    <input type="hidden" id="idIdiomaSeleccionado" name="idIdiomaSeleccionado" value="{$datos.Idi_IdIdioma}" />
                    <div class="form-group">
                        <label class="col-lg-2 control-label">{$lenguaje.label_nombre_rol} : </label>
                        <div class="col-lg-10">
                            <input class="form-control"  value="{$datos.Rol_Nombre}" id="Rol_Nombre"  type="text" name="Rol_Nombre" placeholder="{$lenguaje.label_rol}" required="" />
                        </div>
                    </div>
                     <div class="form-group">
                            <label class="col-lg-2 control-label">{$lenguaje.label_clave} (*): </label>
                            <div class="col-lg-10">
                                <input  class="form-control" type="text" name="key_" id="key_" placeholder="{$lenguaje.label_clave}" required="" value="{$datos.Rol_Ckey}"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">{$lenguaje.label_modulo} : </label>
                            <div class="col-lg-4">
                                <select class="form-control" name="modulo_" id="modulo_">
                                    <option value="0" >{$lenguaje.select_option_seleccione}</option>
                                    {if isset($modulos) && count($modulos)}
                                    {foreach item=m from=$modulos}
                                        <option value="{$m.Mod_IdModulo}" {if $m.Mod_IdModulo==$datos.Mod_IdModulo}selected{/if}>{$m.Mod_Nombre}</option>
                                    {/foreach}
                                    {/if}
                                </select>
                            </div>
<!--                             <div class="col-lg-1">
                                <button class="btn btn-success" type="button" id="bt_agregarModulo" name="bt_agregarModulo" data-toggle="tooltip" data-placement="bottom" title="{$lenguaje.label_crear_modulo}"><i class="glyphicon glyphicon-plus-sign"> </i></button>
                            </div> -->
                        </div>
                    <div class="form-group">
                        <div class="col-xs-6 col-sm-2 col-lg-offset-2 col-lg-2">
                            <button class="btn btn-success" type="submit" id="bt_editarRol" name="bt_editarRol" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.button_ok}</button>
                        </div>
                        <div class="col-xs-6 col-sm-offset-1 col-sm-2 col-lg-2">
                            <button class="btn btn-danger" type="submit" id="bt_cancelarEditarRol" name="bt_cancelarEditarRol" ><i class="glyphicon glyphicon-remove"> </i>&nbsp; {$lenguaje.button_cancel}</button>
                        </div>
                    </div>
                </form>
            </div>    
        </div>
    </div>
</div>
