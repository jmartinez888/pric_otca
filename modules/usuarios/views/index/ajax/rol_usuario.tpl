{if isset($_error)}
    <div id="_errl" class="alert alert-error ">
        <a class="close" data-dismiss="alert">x</a>
        {$_error}
    </div>
{/if}
{if isset($_mensaje)}
    <div id="_msgl" class="alert alert-success">
        <a class="close" data-dismiss="alert">x</a>
        {$_mensaje}
    </div>
{/if}
<form class="form-horizontal" id="form1" role="form" data-toggle="validator" method="post" action="" autocomplete="on">
{if isset($datos) && count($datos)}
                    <input type="hidden" value="{$datos.Usu_IdUsuario}" id="idusuario" name="idusuario" />
                    <input type="hidden" value="{$datos.Usu_Usuario}" id="usuario" name="usuario" />
                    <div class="form-group">
                        <label class="col-lg-3 control-label ">
                            <b>{$lenguaje.label_usuario} :</b>
                        </label>
                        <div class="col-lg-3 panel-default" >
                            <strong class="form-control" style="  color: #333; background-color: #f5f5f5;" >
                                <b>{$datos.Usu_Usuario}</b>
                            </strong>
                        </div>
                        {if $_acl->permiso("agregar_usuario")}
                        <div class="col-lg-3">
                            <button type="button" class="btn btn-dropbox" id="btn_editContra" name="btn_editContra"><i class="glyphicon glyphicon-edit"></i>&nbsp;&nbsp;{$lenguaje.editar_contrasena}</button>
                        </div>
                        {/if}
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label">
                            <b>{$lenguaje.label_rol} :</b>
                        </label>
                        <div class="col-lg-6">
                        {if isset($roles) && count($roles)}

                            <select class="form-control js-example-basic-multiple" multiple= "multiple" name="roles[]" id="roles">                        
                                        {for $i=0;$i<count($roles);$i++}
                                            {$Rol_IdRol = $roles[$i]['Rol_IdRol']}
                                            <option value="{$Rol_IdRol}" {foreach from=$rolesUsuario item=ru}{if $ru.Rol_IdRol==$Rol_IdRol}selected{/if}{/foreach}>{$roles[$i]['Rol_Nombre']
                                             }</option>
                                        {/for}
                              </select>

                            <!-- <select class="form-control" name="Rol_IdRol" id="Rol_IdRol" >
                                {foreach item=r from=$roles}
                                    <option  value="{$r.Rol_IdRol|default:0}"  {if $r.Rol_Nombre == 1}selected="selected"{/if}>{$r.Rol_Nombre|default:"select"}</option>
                                {/foreach}            
                            </select> -->
                        {/if}
                        </div>
                        {if $_acl->permiso("agregar_rol")}
                        <div class="col-lg-2">
                            <button type="button" class="btn btn-facebook" id="btn_nuevoRol" name="btn_nuevoRol"><i class="glyphicon glyphicon-plus-sign"></i>&nbsp;&nbsp;{$lenguaje.roles_editar_label_nuevo}</button>
                        </div>
                        {/if}
                    </div>
                        
                    <div class="form-group">
                        <label class="col-lg-3 control-label">{$lenguaje.label_nombre} : </label>
                        <div class="col-lg-8">
                            <input class="form-control" id ="nombre" type="text" pattern="([a-zA-Z][\sa-zA-Z]+)" name="nombre" value="{$datos.Usu_Nombre|default:""}" placeholder="{$lenguaje.label_nombre}" required=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label" >{$lenguaje.label_apellidos} : </label>
                        <div class="col-lg-8">
                            <input class="form-control" id ="apellidos" type="text" pattern="([a-zA-Z][\sa-zA-Z]+)" name="apellidos" value="{$datos.Usu_Apellidos|default:""}" placeholder="{$lenguaje.label_apellidos}" required=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label" >{$lenguaje.label_dni} : </label>
                        <div class="col-lg-8">
                            <input  class="form-control" id ="dni" type="text" pattern="[0-9]+" data-minlength="8" name="dni" value="{$datos.Usu_DocumentoIdentidad|default:""}" placeholder="{$lenguaje.label_dni}" required=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label" >{$lenguaje.label_direccion} : </label>
                        <div class="col-lg-8">
                            <input  class="form-control" id ="direccion" type="text" name="direccion" value="{$datos.Usu_Direccion|default:""}" placeholder="{$lenguaje.label_direccion}" required=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label" >{$lenguaje.label_telefono} : </label>
                        <div class="col-lg-8">
                            <input  class="form-control" id ="telefono" type="text"  pattern="^\+?[0-9][0-9][0-9]?[1-9][\-0-9]+$" name="telefono" value="{$datos.Usu_Telefono|default:""}" placeholder="{$lenguaje.label_telefono}" required=""/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label" >{$lenguaje.label_institucion} : </label>
                        <div class="col-lg-8">
                            <input  class="form-control" id ="institucion" type="text"  name="institucion" value="{$datos.Usu_InstitucionLaboral|default:""}" placeholder="{$lenguaje.label_institucion}" required=""/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-3 control-label">{$lenguaje.label_cargo} : </label>
                        <div class="col-lg-8">
                            <input  class="form-control" id ="cargo" type="text" name="cargo" value="{$datos.Usu_Cargo|default:""}" placeholder="{$lenguaje.label_cargo}" required=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-lg-3 control-label">{$lenguaje.label_correo} : </label>
                        <div class="col-lg-8">
                            <input  class="form-control" id = "email" type="email" name="email" value="{$datos.Usu_Email|default:""}" placeholder="{$lenguaje.label_correo}" required=""/>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-lg-offset-2 col-lg-8">
                        <button class="btn btn-success" id="bt_guardarUsuario" name="bt_guardarUsuario" type="submit" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.button_ok}</button>
                        </div>
                    </div>                
                {/if}                
</form>