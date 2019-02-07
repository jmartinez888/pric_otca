<div class="col col-xs-12 " style="padding-top: 15px">
    <div class="panel panel-default">
        <div class="panel-heading ">
            <h3 class="panel-title text-center ">&nbsp;&nbsp;<strong class="text-success text-uppercase">Editar Certificado</strong></h3>
        </div>
        <div id="nuevo_anuncio" class="panel-body" >                    
            <form class="form-horizontal" id="form15" role="form" method="post" action="" autocomplete="on" enctype="multipart/form-data">
                <input type="hidden" {if $plantilla.Plc_StyleNombre!="display:none;"} value="{$plantilla.Plc_StyleNombre}" {else} value="position: absolute; top: 248px; left: 150px; transform: translate(0%, 0%); font-size: 30px; z-index: 1000; border: 2px solid black; text-align: center; width: 80%;" {/if} name="estiloAlumno" id="estiloAlumno"/>
                <input type="hidden" {if $plantilla.Plc_StyleCurso!="display:none;"} value="{$plantilla.Plc_StyleCurso}" {else} value="position: absolute; top: 356px; left: 156px; transform: translate(0%, 0%); font-size: 30px; z-index: 1000; border: 2px solid black; text-align: center; width: 80%;" {/if} name="estiloCurso" id="estiloCurso"/>
                <input type="hidden" {if $plantilla.Plc_StyleHora!="display:none;"} value="{$plantilla.Plc_StyleHora}" {else} value="position: absolute; top: 404px; left: 316px; transform: translate(0%, 0%); font-size: 26px; z-index: 1000; border: 2px solid black; text-align: center; width: 5%;" {/if} name="estiloHoras" id="estiloHoras"/>
                <input type="hidden" {if $plantilla.Plc_StyleFecha!="display:none;"} value="{$plantilla.Plc_StyleFecha}" {else} value="position: absolute; top: 562px; left: 741px; transform: translate(0%, 0%); font-size: 22px; z-index: 1000; border: 2px solid black; text-align: center; width: 30%;" {/if} name="estiloFecha" id="estiloFecha"/>     
                <input type="hidden" {if $plantilla.Plc_StyleCodigo!="display:none;"} value="{$plantilla.Plc_StyleCodigo}" {else} value="position: absolute; top: 582px; left: 350px; transform: translate(0%, 0%); font-size: 22px; z-index: 1000; border: 2px solid black; text-align: center; width: 20%;" {/if} name="estiloCodigo" id="estiloCodigo"/>             
                
                <div class="col-xs-12 ">  
                    <div class="form-group">
                        <label class=" col-xs-offset-1 col-xs-2" >
                            <input type="checkbox" name="ckbNombre" id="ckbNombre"  value="first_checkbox" {if $plantilla.Plc_StyleNombre!="display:none;"}checked{/if} > Nombre del Alumno
                        </label>
                        <label class=" col-xs-2" >
                            <input type="checkbox" name="ckbCurso" id="ckbCurso" value="first_checkbox" {if $plantilla.Plc_StyleCurso!="display:none;"}checked{/if}> Nombre del Curso
                        </label>
                        <label class=" col-xs-2" >
                            <input type="checkbox" name="ckbDuracion" id="ckbDuracion" value="first_checkbox" {if $plantilla.Plc_StyleHora!="display:none;"}checked{/if}> Duración del Curso
                        </label>
                        <label class=" col-xs-2" >
                            <input type="checkbox" name="ckbFecha" id="ckbFecha" value="first_checkbox" {if $plantilla.Plc_StyleFecha!="display:none;"}checked{/if}> Fecha
                        </label>
                        <label class=" col-xs-2" >
                            <input type="checkbox" name="ckbCodigo" id="ckbCodigo" value="first_checkboxc" {if $plantilla.Plc_StyleCodigo!="display:none;"}checked{/if}> Codigo certificado
                        </label>
                    </div>  

                    <div class="col col-md-4 col-lg-5">  
                        <div class=" form-group">                              
                            <label class="control-label col-xs-2 col-sm-2 col-md-2" for="img"> Fondo:</label>
                            <div class="col-xs-10 col-sm-10 col-md-10">
                                <input type="file" class="form-control " name="img" id="img" accept="image/*">
                            </div>
                        </div>
                    </div>

                    <div class="col col-md-8 col-lg-7 ">
                        <div class=" form-group">       
                            <label class="control-label col-xs-2 col-sm-2 col-md-2" > Fuente: </label>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                <input type="number" onkeypress="change_tamano(event)" class="form-control " name="tamaño" id="tamaño">
                            </div>
                            <div class="col-xs-2 col-sm-2 col-md-2">
                                <input type="color" class="form-control " name="color" value="#000000" />
                            </div>
                            <label class="control-label col-xs-2 col-sm-2 col-md-2" >Ancho: </label>
                            <div class="col-xs-2 col-sm-2 col-md-2 col-lg-2">
                                <input type="number" onkeypress="change_ancho(event)" class="form-control" name="ancho" id="ancho" value="0"> 
                            </div>
                            <label class="control-label col col-xs-2" style="text-align: left;">%</label>
                        </div>
                    </div>

                     
                </div> 

                <div  class="col-lg-12 col-xs-12 file-preview-zone" style="background: url('{$_layoutParams.root_clear}{$plantilla.Plc_UrlImg}'); background-size: 100%; -moz-background-size: 100%; -o-background-size: 100%; -webkit-background-size: 100%;  -khtml-background-size: 100%; width: 100%; height:21cm; position: relative; border: solid 1px black;" id="cuadro1" ondragenter="return enter_as(event)" ondragover="return over_as(event)" ondragleave="return leave_as(event)" ondrop="return drop_as(event)">
                                  
                    <div class="" style="{$plantilla.Plc_StyleNombre}" id="arrastrable1" draggable="true" ondragstart="start_as(event)" ondragend="end_as(event)"><b>Nombre de Alumno</b><br/></div>

                    <div class="" style="{$plantilla.Plc_StyleCurso}" id="arrastrable2" draggable="true" ondragstart="start_as(event)" ondragend="end_as(event)"><b>Título de Curso</b><br/></div>

                    <div class="" style="{$plantilla.Plc_StyleHora}" id="arrastrable3" draggable="true" ondragstart="start_as(event)" ondragend="end_as(event)"><b>Duración</b><br/></div>

                    <div class="" style="{$plantilla.Plc_StyleFecha}" id="arrastrable4" draggable="true" ondragstart="start_as(event)" ondragend="end_as(event)"><b>Fecha de Curso</b><br/></div>

                    <div class="" {if $plantilla.Plc_StyleCodigo!="display:none;" || !is_null($plantilla.Plc_StyleCodigo) } style="{$plantilla.Plc_StyleCodigo}" {else} style = "position: absolute; top: 582px; left: 350px; transform: translate(0%, 0%); font-size: 22px; z-index: 1000; border: 2px solid black; text-align: center; width: 20%;" {/if} id="arrastrable5" draggable="true" ondragstart="start_as(event)" ondragend="end_as(event)"><b>Codigo Certificado</b><br/></div>
                </div>

                <div class="col col-xs-12">
                    <div id="f" class="panel-footer" > 
                        <div class="form-group">
                            <div class="col-xs-6 col-sm-2 col-lg-3">
                                <button class="btn btn-success" type="submit" id="bt_guardarPlantilla" name="bt_guardarPlantilla" ><i class="glyphicon glyphicon-floppy-disk"> </i>&nbsp; {$lenguaje.el_ce_pl_button_ok}</button>
                            </div>
                            <div class="col-xs-6 col-sm-2 col-lg-3">
                                <button class="btn btn-success" type="submit" id="bt_SeleccionarPlantilla" name="bt_SeleccionarPlantilla" ><i class="glyphicon glyphicon-check"> </i>&nbsp; Establecer como Plantilla</button>
                            </div>
                            <div class="col-xs-6  col-sm-2 col-lg-3">
                                <button class="btn btn-success" type="submit" id="bt_EliminarPlantilla" name="bt_EliminarPlantilla" ><i class="glyphicon glyphicon-trash"> </i>&nbsp; Eliminar</button>
                            </div>
                            <div class="col-xs-6 col-sm-2 col-lg-3">
                                <button class="btn btn-danger" type="submit" id="bt_cancelareditarPlantilla" name="bt_cancelareditarPlantilla" ><i class="glyphicon glyphicon-remove"> </i>&nbsp; {$lenguaje.el_ce_pl_button_cancel}</button>
                            </div>       
                        </div>        
                    </div>
                </div>
            </form>       
        </div>
    </div>

</div>

