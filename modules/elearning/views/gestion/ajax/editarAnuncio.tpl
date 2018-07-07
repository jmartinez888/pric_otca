<div class="col-lg-12">
  {include file='modules/elearning/views/cursos/menu/lateral.tpl'}
  <div class="col-lg-10" style="margin-top: 20px">
        <div class="panel panel-default">
            <div class="panel-heading ">
                <h3 class="panel-title "><i style="float:right"class="fa fa-ellipsis-v"></i><i class="fa fa-user-secret"></i>&nbsp;&nbsp;<strong>Editar Anuncio</strong></h3>
            </div>
        <div id="nuevo_anuncio" class="panel-body" style="width: 90%; margin: 0px auto">                    
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
