<div  class="container-fluid" >
    <div class="row" style="padding-left: 1.3em; padding-bottom: 20px;">
        <h4 style="width: 80%;  margin: 0px auto; text-align: center;">{$lenguaje.roles_label_titulo}</h4>
    </div>
<!--     <div id='gestion_idiomas_rol'> -->
<!--         {if  isset($idiomas) && count($idiomas)}
            <ul class="nav nav-tabs ">
            {foreach from=$idiomas item=idi}
                <li role="presentation" class="{if $datos.Idi_IdIdioma==$idi.Idi_IdIdioma} active {/if}">
                    <a class="idioma_s" id="idioma_{$idi.Idi_IdIdioma}" href="#">{$idi.Idi_Idioma}</a>
                    <input type="hidden" id="hd_idioma_{$idi.Idi_IdIdioma}" value="{$idi.Idi_IdIdioma}" />
                    <input type="hidden" id="idiomaTradu" value="{$datos.Idi_IdIdioma}"/>
                </li>    
            {/foreach}
            </ul>
        {/if} -->
        <div class="panel panel-default">
            <div class="panel-heading ">
                <h3 class="panel-title "><i style="float:right"class="fa fa-ellipsis-v"></i><i class="fa fa-user-secret"></i>&nbsp;&nbsp;<strong>Editar Anuncio</strong></h3>
            </div>
        <div id="nuevo_anuncio" class="panel-body" style="width: 90%; margin: 0px auto">>                    
                        <form class="form-horizontal" id="form1" role="form" data-toggle="validator" method="post" action="" autocomplete="on">
<!--                            <input type="hidden" value="1" name="enviar" />-->                           
                            <div class="form-group">
                                    
                                <label class="col-lg-3 control-label">Titulo : </label>
                                <div class="col-lg-8">
                                    <input class="form-control" id ="titulo" type="text" name="titulo" value="{$datos.Anc_Titulo|default:""}" placeholder="Titulo" required=""/>
                                </div>
                            </div>
                                
                            <div class="form-group">
                                <label class="col-lg-3 control-label" >Descripción : </label>
                                <div class="col-lg-8">
                                    <textarea class="form-control" id ="descripcion" type="text" name="descripcion" placeholder="Descripción" required=""  rows="5">{$datos.Anc_Descripcion|default:""}</textarea>
                                </div>
                            </div>
                                
                            
                             <div class="form-group">
                                <div class="col-xs-6 col-sm-2 col-lg-offset-2 col-lg-2">
                                    <button class="btn btn-success" type="submit" id="bt_editarAnuncio" name="bt_editarAnuncio" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.button_ok}</button>
                                </div>
                            <div class="col-xs-6 col-sm-offset-1 col-sm-2 col-lg-2">
                                <button class="btn btn-danger" type="submit" id="bt_cancelarEditarAnuncio" name="bt_cancelarEditarAnuncio" ><i class="glyphicon glyphicon-remove"> </i>&nbsp; {$lenguaje.button_cancel}</button>
                            </div>
                        </form>
                    </div>        
                </div>
            </div>
        </div>