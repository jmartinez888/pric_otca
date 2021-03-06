{include file='modules/elearning/views/gestion/menu/menu.tpl'}
<div class="col-xs-12 col-sm-12 col-md-9 col-lg-10" style="margin-top: 20px">
{include file='modules/elearning/views/gestion/menu/tag_url.tpl'}
    <div class="col col-xs-12" >
        <div class="panel panel-default">
            <div class="panel-heading ">
                <h3 class="panel-title "><i style="float:right" class="glyphicon-option-vertical"></i><i class="glyphicon glyphicon-picture"></i>&nbsp;&nbsp;<strong>Editar Anuncio</strong></h3>
            </div>
            <div id="nuevo_anuncio" class="panel-body" style="width: 90%; margin: 0px auto">                    
                <form class="form-horizontal" id="form1_" role="form" data-toggle="validator" method="post" action="" autocomplete="on">
                <div class="form-group">                                    
                    <label class="col-sm-2 control-label">Titulo : </label>
                    <div class="col-sm-10">
                        <input class="form-control" id ="titulo" type="text" name="titulo" value="{$datos.Anc_Titulo|default:""}" placeholder="Titulo" required=""/>
                    </div>
                </div>                                
                <div class="form-group">
                    <label class="col-sm-2 control-label" >Descripción : </label>
                    <div class="col-sm-10">
                        <textarea class="form-control" id ="descripcion" type="text" name="descripcion" placeholder="Descripción" required=""  rows="5">{$datos.Anc_Descripcion|default:""}</textarea>
                    </div>
                </div>
                <div class=" col-sm-12 col-md-offset-2 col-md-10 margin-t-10 " > 
                    <blockquote style="margin: 0;">
                        <b style="font-size: 14px">NOTA: Variables utilizables</b>
                        <em> 
                            <h5><strong>|nombre|</strong> = Nombre del alumno.</h5>
                            <h5><strong>|apellidos|</strong> =  Apellidos del alumno.</h5>
                            <h5><strong>|usuario|</strong> = Usuario del alumno.</h5>
                            <h5><strong>|titulo_curso|</strong> = Titulo del Curso</h5>
                        </em>
                    </blockquote> 
                </div>
                <div class="form-group">
                    <div class="col-xs-6 col-sm-2 col-lg-offset-2 col-lg-2">
                        <button class="btn btn-success" type="submit" id="bt_editarAnuncio" name="bt_editarAnuncio" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.button_ok}</button>
                    </div>
                    <div class="col-xs-6 col-sm-offset-1 col-sm-2 col-lg-2">
                        <button class="btn btn-danger" type="submit" id="bt_cancelarEditarAnuncio" name="bt_cancelarEditarAnuncio" ><i class="glyphicon glyphicon-remove"> </i>&nbsp; {$lenguaje.button_cancel}</button>
                    </div>
                </div>        
                </form>
            </div>            
        </div>
    </div>
</div>
