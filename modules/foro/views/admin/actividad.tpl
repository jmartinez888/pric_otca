<div  class="container" >   
    <h3 class="titulo-view">Actividades de Webinar</h3>
    <div class="row">
        <div class="col-md-3">
            <div class="panel-group" id="accordion">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <strong>Webinar</strong>
                        </h4>
                    </div>               
                    <div class="panel-body">
                        <table class="table table-user-information">
                            <tbody>                           
                                <tr>
                                    <td>Nombre:</td>
                                    <td>{$foro.For_Titulo}</td>     
                                </tr>                                
                                <tr>
                                    <td>Autor</td>
                                    <td>{$foro.Usu_Usuario}</td>
                                </tr>                                 
                                <tr>
                                    <td>Miembros</td>
                                    <td>{$foro.For_NParticipantes}</td>
                                </tr>                                
                                <tr>
                                    <td>Comentarios</td>
                                    <td>{$foro.For_NComentarios}</td>
                                </tr>
                                <tr>
                                    <td>Fecha Creacion</td>
                                    <td>{$foro.For_FechaCreacion}</td>
                                </tr>
                                <tr>
                                    <td>Fecha Cierre</td>
                                    <td>{$foro.For_FechaCierre}</td>
                                </tr>
                                <tr>
                                    <td>Fecha Actualizacion</td>
                                    <td>{$foro.For_Update}</td>
                                </tr>


                            </tbody>
                        </table>
                    </div>
                </div>
            </div>             
        </div>

        <div class="col-md-9 text-center"> 
            <div id="calendar" class="col-centered">
            </div>          
        </div> 

    </div>
</div>
<script>
 defaultDateCalendar='{$foro.For_FechaCreacion|date_format:"%Y-%m-%d"}';
 eventos=JSON.parse('{$foro.For_Actividades}');
</script>
<!-- Modal -->
<div class="modal fade" id="ModalAdd" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form class="form-horizontal" method="POST">
                
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel_add">Agregar Actividad</h4>
                    <h4 class="modal-title" id="myModalLabel_edit" style="display: none">Modificar Actividad</h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="title" class="col-sm-2 control-label">Titulo</label>
                        <div class="col-sm-10">
                            <input type="text" name="tb_titulo" class="form-control" id="tb_titulo" placeholder="Titulo" required="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="color" class="col-sm-2 control-label">Resumen</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" id="tb_resumen" name="tb_resumen"  placeholder="Resumen" required></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="start" class="col-sm-2 control-label">Fecha Inicial</label>
                        <div class="col-sm-10">                           
                            <div id="start_date_div" class="input-group">
                                <span class="input-group-btn">
                                    <button class="bt_start_time btn btn-default" type="button" title="Reiniciar ">
                                        <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                        <span class="sr-only">Calendario</span>
                                    </button>
                                </span>                                           
                                <input id="start_time" class="form-control" name="start_time" type="text" value="" readonly>                            
                            </div>
                        </div>


                    </div>
                    <div class="form-group">
                        <label for="end" class="col-sm-2 control-label">Fecha Final</label>
                        <div class="col-sm-10">
                            <div  class="input-group">
                                <span class="input-group-btn">
                                    <button class="bt_end_time btn btn-default" type="button" title="Reiniciar ">
                                        <span class="glyphicon glyphicon-calendar" aria-hidden="true"></span>
                                        <span class="sr-only">Calendario</span>
                                    </button>
                                </span>                                           
                                <input id="end_time" class="form-control" name="end_time" type="text" value="" readonly>                                
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-info" data-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary" name="bt_guardar" id="bt_guardar">Guardar</button>
                    <button type="submit" class="btn btn-danger" name="bt_eliminar" id="bt_eliminar" style="display: none">Eiminar</button>                    
                    <button type="submit" class="btn btn-primary" name="bt_editar" id="bt_editar"  style="display: none">Editar</button>
                </div>
                <input type="hidden" name="hd_id_actividad" id="hd_id_actividad" value="">
            </form>
        </div>
    </div>
</div>

