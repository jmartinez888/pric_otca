<div class="panel panel-default">
            <div class="panel-heading ">
                <h3 class="panel-title "><i style="float:right"class="fa fa-ellipsis-v"></i><i class="fa fa-user-secret"></i>&nbsp;&nbsp;<strong>Editar Certificado</strong></h3>
            </div>
        <div id="nuevo_anuncio" class="panel-body" style="width: 90%; margin: 0px auto">                    
                        <form class="form-horizontal" id="form1" role="form" data-toggle="validator" method="post" action="" autocomplete="on" enctype="multipart/form-data">
                            <input type="hidden" value="position: absolute; top: 248px; left: 150px; transform: translate(0%, -50%); font-size: 30px; z-index: 1000; border: 2px solid black; text-align: center; width: 80%;" name="estiloAlumno" id="estiloAlumno"/>
                            <input type="hidden" value="position: absolute; top: 356px; left: 156px; transform: translate(0%, -50%); font-size: 30px; z-index: 1000; border: 2px solid black; text-align: center; width: 80%;" name="estiloCurso" id="estiloCurso"/>
                            <input type="hidden" value="position: absolute; top: 404px; left: 316px; transform: translate(0%, -50%); font-size: 26px; z-index: 1000; border: 2px solid black; text-align: center; width: 5%;" name="estiloHoras" id="estiloHoras"/>
                            <input type="hidden" value="position: absolute; top: 562px; left: 741px; transform: translate(0%, -50%); font-size: 22px; z-index: 1000; border: 2px solid black; text-align: center; width: 30%;" name="estiloFecha" id="estiloFecha"/>               
                            <div class="form-group">
                              <label for="img">Seleccione Background:</label>
                              <input type="file" class="form-control" name="img" id="img" accept="image/*" required>
                              <br>
                             <!--  <label for="img">O Seleccione una plantilla ya existente:</label> -->
                            </div>
                           <!--  {if isset($plantillas) && count($plantillas)}
                            <div class="row">
                            <div class="col-lg-12">
                            <div class="carousel slide media-carousel" id="media">
                            {$i=1}
                            {$j=1}
                            <div class="carousel-inner">
                            {foreach item=p from=$plantillas}
                            {if $j==1}
                            <div class="item {if $i==1}active{/if} ">
                            {/if}
                            <a href="{BASE_URL}elearning/certificado/plantilla_certificado/{$p.Cur_IdCurso}">
                              <div class="col-lg-2 " style="cursor:pointer; padding:0px;">
                                <div class="col-lg-12">
                                    <img  style="{if $p.Plc_Seleccionado==1} border: 2px blue solid;{/if}" src="{$_layoutParams.root_clear}{$p.Plc_UrlImg}"  style="width:100%; height:auto;">
                                </div>
                                <div class="col-lg-12">
                                    <center style="{if $p.Plc_Seleccionado==1} color: red;{/if}">Plantilla {$i}{$i=$i+1}</center>
                                </div>
                              </div>
                            </a>
                            {if $j==6}
                            </div>
                            {/if}
                            {$j=$j+1}
                            {if $j==7}{$j=1}{/if}
                            {/foreach}
                            </div>
                             <a data-slide="prev" href="#media" class="left carousel-control">‹</a>
                             <a data-slide="next" href="#media" class="right carousel-control">›</a>
                            </div>
                            </div>
                            </div>
                            {/if} -->
                            <div class="form-group">
                                <label class="col-lg-3" ><input type="checkbox" name="ckbNombre" id="ckbNombre" value="first_checkbox" checked>Nombre del Alumno</label>
                                <label class="col-lg-3" ><input type="checkbox" name="ckbCurso" id="ckbCurso" value="first_checkbox" checked>Nombre del Curso</label>
                                <label class="col-lg-3" ><input type="checkbox" name="ckbDuracion" id="ckbDuracion" value="first_checkbox" checked>Duración del Curso</label>
                                <label class="col-lg-3" ><input type="checkbox" name="ckbFecha" id="ckbFecha" value="first_checkbox" checked>Fecha</label>
                                
                                 <div class="col-lg-3">
                                <label class="control-label col-lg-1" >A: </label>
                                <div class="col-lg-6">
                                <input type="number" class="form-control " name="tamaño" id="tamaño">
                                </div>
                                <div class="col-lg-4">
                                 <input name="color" class="form-control " type="color" value="#000000" />
                                </div>
                                </div>
                               
                                <div class="col-lg-3">
                                <label class="control-label col-lg-3" >Ancho: </label>
                                <div class="col-lg-9">
                                <input type="number" class="form-control" name="ancho" id="ancho" value="0">
                                </div>
                                </div>
                                
                            </div>               
                    </div>        
                </div>
    <div  class="col-lg-12 col-xs-12 file-preview-zone" style="background: url({if isset($plantilla) && count($plantilla)}{$_layoutParams.root_clear}{$plantilla.Plc_UrlImg}{else}{$_layoutParams.ruta_img}frontend/pric.png){/if}; background-size: 100%; -moz-background-size: 100%; -o-background-size: 100%; -webkit-background-size: 100%;  -khtml-background-size: 100%; max-width: 100%; height:21cm; position: relative;" id="cuadro1" ondragenter="return enter_as(event)" ondragover="return over_as(event)" ondragleave="return leave_as(event)" ondrop="return drop_as(event)">

<!--             " -->

<!--              <div  class="col-lg-12 col-xs-12 file-preview-zone" style="position: relative; display: inline-block; text-align:center" id="cuadro2" ondragenter="return enter(event)" ondragover="return over(event)" ondragleave="return leave(event)" ondrop="return drop(event)"> -->

                <!-- <img src="{$_layoutParams.ruta_img}frontend/pricblanco.png"   style="z-index:-1;" > -->
                              
                <div class="" style="position: absolute; top: 248px; left: 150px; transform: translate(0%, -50%); font-size: 30px; z-index: 1000; border: 2px solid black; text-align: center; width: 80%;" id="arrastrable1" draggable="true" ondragstart="start_as(event)" ondragend="end_as(event)"><b>Nombre</b><br/></div>

                 <div class="" style="position: absolute; top: 356px; left: 156px; transform: translate(0%, -50%); font-size: 30px; z-index: 1000; border: 2px solid black; text-align: center; width: 80%;" id="arrastrable2" draggable="true" ondragstart="start_as(event)" ondragend="end_as(event)"><b>Curso</b><br/></div>

                  <div class="" style="position: absolute; top: 562px; left: 741px; transform: translate(0%, -50%); font-size: 22px; z-index: 1000; border: 2px solid black; text-align: center; width: 30%;" id="arrastrable4" draggable="true" ondragstart="start_as(event)" ondragend="end_as(event)"><b>Fecha</b><br/></div>

                   <div class="" style="position: absolute; top: 404px; left: 316px; transform: translate(0%, -50%); font-size: 26px; z-index: 1000; border: 2px solid black; text-align: center; width: 5%;" id="arrastrable3" draggable="true" ondragstart="start_as(event)" ondragend="end_as(event)"><b>1</b><br/></div>

<!--                 <div class=" col-xs-12  visible-xs" style="position: absolute; top:32%; left: 5%; transform: translate(-0%, -50%); font-size:5vw; "><b>Nombre</b><br/></div> -->

               <!--  <div class=" col-xs-12  visible-xs" style="position: absolute; top:32%; left: 5%; transform: translate(-0%, -50%); font-size:5vw; "><b>Nombre</b><br/></div>

                <div class="col-lg-12 hidden-xs" style="position: absolute; top:45%; left: 5%; transform: translate(-0%, -50%);"><span style="font-size:30px"><b>Curso</b></span><br/></div>

                <div class="col-xs-12  visible-xs" style="position: absolute; top:45%; left: 5%; transform: translate(-0%, -50%);"><span style="font-size:4vw"><b>Curso</b></span><br/></div>

                  <div class="col-lg-12 hidden-xs" style="position: absolute; top:47%; left: 12%; width:88%; transform: translate(0%, 8%)"><p style="font-size:22px">de 40 horas de duración, superando con éxito los módulos de:</p></div>

                    <div class="col-xs-12  visible-xs" style="position: absolute; top:51%; left: 12%; width:88%; transform: translate(0%, 15%)"><span style="font-size:3vw"><b>{$cont=1} {foreach item=m from=$modulo}{$m.Mod_Titulo}.{if $cont!=count($modulo)}, {else}.{/if}{$cont=$cont+1}{/foreach}</b></span><br/></div>

                <div class="col-lg-12 hidden-xs" style="position: absolute; top:68%; left:30%; "><span style="font-size:20px">Fecha</span><br/></div>   

                <div class="col-xs-12  visible-xs" style="position: absolute; top:68%; left:30%; "><span style="font-size:25px">Fecha</span><br/></div>   
                            

                <div class="col-lg-12 col-xs-12" style="position: absolute; bottom:0; left: 5%;"><span style="font-size:13px">Certificación de aprobación online</span><br/><span style="font-size:12px">Código: 00000000000000000</span></div> -->

</div>

<div class="panel panel-default">
          <div id="f" class="panel-body" style="width: 90%; margin: 0px auto">                    
                             <div class="form-group">
                                <div class="col-xs-6 col-sm-2 col-lg-offset-2 col-lg-2">
                                    <button class="btn btn-success" type="submit" id="bt_editarPlantilla" name="bt_editarPlantilla" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.el_ce_pl_button_ok}</button>
                                </div>
                            <div class="col-xs-6 col-sm-offset-1 col-sm-2 col-lg-2">
                                <button class="btn btn-danger" type="submit" id="bt_cancelareditarPlantilla" name="bt_cancelareditarPlantilla" ><i class="glyphicon glyphicon-remove"> </i>&nbsp; {$lenguaje.el_ce_pl_button_cancel}</button>
                            </div>
                        
                    </div>        
                </div>
</form>

<div class="modal " id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">Confirmación de Eliminación</h4>
            </div>
            <div class="modal-body">
                <p>Estás a punto de borrar un item, este procedimiento es irreversible</p>
                <p>¿Deseas Continuar?</p>
                <p>Eliminar: <strong  class="nombre-es">Módulo</strong></p>
                <label id="texto_" name='texto_'></label>
                <!-- <input type='text' class='form-control' name='codigo' id='validate-number' placeholder='Codigo' required> --> 
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
                <a style="cursor:pointer"  data-dismiss="modal" class="btn btn-danger danger eliminar_modulo">Eliminar</a>
            </div>
        </div>
    </div>
</div>

