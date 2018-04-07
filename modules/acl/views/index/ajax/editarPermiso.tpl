<div  class="container-fluid" 
    <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
        <h4 style="width: 80%;  margin: 0px auto; text-align: center;">{$lenguaje.permisos_label_titulo}</h4>
    </div>    
    <div id="gestion_idiomas_permisos">
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
                <h3 class="panel-title "><i style="float:right"class="fa fa-ellipsis-v"></i><i class="fa fa-user-secret"></i>&nbsp;&nbsp;<strong>{$lenguaje.tabla_opcion_editar_PERMISO}</strong></h3>
            </div>

            <div id="nuevo_rol" class="panel-body" style="width: 90%; margin: 0px auto">
                <form class="form-horizontal"  data-toggle="validator" id="form4" role="form" name="form4" action="" method="post">                    
                    <div class="form-group">
                        <label class="col-lg-2 control-label">{$lenguaje.label_permiso} : </label>
                        <div class="col-lg-10">
                            <input  class="form-control" value="{$datos.Per_Nombre|default:''}" type="text" name="permiso_nombre" id="permiso_nombre" placeholder="{$lenguaje.label_permiso}" required=""  />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">{$lenguaje.label_clave} : </label>
                        <div class="col-lg-10">
                            <input  class="form-control" value="{$datos.Per_Ckey|default:''}" type="text" name="key_" id="key_" placeholder="{$lenguaje.label_clave}" required="" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-2 control-label">{$lenguaje.label_modulo} : </label>
                        <div class="col-lg-8">
                            <div class="col-xs-10 col-sm-6" style="padding: 0px;">
                                <select class="form-control" name="modulo_" id="modulo_">
                                    <option value="0" >{$lenguaje.select_option_seleccione}</option>
                                    {if isset($modulos) && count($modulos)}
                                    {foreach item=m from=$modulos}
                                        <option value="{$m.Mod_IdModulo}" {if $m.Mod_IdModulo == $datos.Mod_IdModulo} selected="" {/if} >{$m.Mod_Nombre}</option>
                                    {/foreach}
                                    {/if}
                                </select>
                            </div>
                            <div class="col-xs-2">
                                <button class="btn btn-success" type="button" id="bt_agregarModulo" name="bt_agregarModulo" data-toggle="tooltip" data-placement="bottom" title="{$lenguaje.label_crear_modulo}"><i class="glyphicon glyphicon-plus-sign"> </i></button>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-6 col-sm-2 col-lg-offset-2 col-lg-2">
                            <button class="btn btn-success" type="submit" id="bt_editarPermiso" name="bt_editarPermiso" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.button_ok}</button>
                        </div>
                        <div class="col-xs-6 col-sm-offset-1 col-sm-2 col-lg-2">
                            <button class="btn btn-danger" type="submit" id="bt_cancelarEditarPermiso" name="bt_cancelarEditarPermiso" ><i class="glyphicon glyphicon-remove"> </i>&nbsp; {$lenguaje.button_cancel}</button>
                        </div>
                    </div><!--                    <button class="btn btn-primary" type="button" id="btGuardarPermiso"  ><i class="glyphicon glyphicon-ok"> </i>  Guardar</button>-->
                </form> 
            </div>    
        </div>                    
    </div>
</div>
